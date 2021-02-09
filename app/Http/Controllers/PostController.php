<?php
/**
 * @author ryan saputro
 * @email ryansaputro52@gmail.com
 * @create date 2020-10-01 13:26:03
 * @modify date 2020-10-01 13:26:03
 * @desc handle master data karyawan
 */

namespace App\Http\Controllers;

use Illuminate\Http\Request;

// import file model Person
use App\User;
use App\Posting;
use App\PostingLike;
use App\PostingComment;
use Illuminate\Support\Facades\Auth;
use Ixudra\Curl\Facades\Curl;
use DB;
use File;
use Carbon\Carbon;
use Intervention\Image\ImageManagerStatic as Image;

class PostController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->path = public_path('images/posting');;
        $this->dimensions = ['245', '300', '500'];
    }

     // mengambil semua data
    public function index(Request $request)
    {
        $data = DB::table('posting')
                ->select('posting.id', 'created_by', 'posting.post_content', 'posting.url_post', 'posting.datetime', 'posting.image', 'users.nama_depan', 'users.foto')
                ->join('users', 'users.id', '=', 'created_by')
                ->orderBy('posting.id', 'DESC')
                ->get();
        
        if(Auth::user() != null){
            $like = DB::table('posting_like')
                ->select('status', 'id_post')
                ->where('id_user', Auth::user()->id)
                ->pluck('status', 'id_post')
                ->toArray();

            $totallike = DB::table('posting_like')
                ->select('status', 'id_post', DB::raw('COUNT(id) AS jml'))
                ->where('status', '1')
                ->groupBy('id_post')
                ->pluck('jml', 'id_post')
                ->toArray();

            $totalcomment = DB::table('posting_comment')
                ->select('status', 'id_post', DB::raw('COUNT(id) AS jml'))
                ->where('status', '1')
                ->groupBy('id_post')
                ->pluck('jml', 'id_post')
                ->toArray();
        }else{
            $like = array("xx" => "xx");
            $totallike = array("xx" => "xx");
            $totalcomment = array("xx" => "xx");
        }
        
        return response()->json(['status' => 'success', 'data' => $data, 'like' => $like, 'totallike' => $totallike, 'totalcomment' => $totalcomment], 200);
    }

    // menambah data
    public function store(Request $request)
    {
        $path = $this->path; //. '/' . date('Y') . '/' . date('m');
        if (!File::isDirectory($path)) {$folder = File::makeDirectory($path, 0777, true);}
        if (!File::isDirectory($this->path)) {File::makeDirectory($this->path, 0777, true);}

        //validate the data before processing
        $rules = [
            "posting" => "required|string",
        ];

        $customMessages = [
            'required' => 'Isian :attribute tidak boleh kosong.',
            'numeric' => 'Isian :attribute harus berupa angka.',
            'digits_between' => 'Isian :attribute harus berupa angka dengan minimal 10 karakter dan maksimal 15.',
            'kode_pos.digits' => 'Isian :attribute harus berupa angka dengan 5 karakter.',
            'no_ktp.digits' => 'Isian :attribute harus berupa angka dengan 16 karakter.',
            'size' => 'Isian :attribute harus 3 karakter.'
        ];

        $this->validate($request, $rules, $customMessages);
        
        DB::beginTransaction();
        try {
            
            if($request->foto != null){
                //proses simpan foto
                $img = $request->foto;  // your base64 encoded
                $imageName = strtoupper(str_replace(' ', '_',preg_replace('/\s+/', '-', $request->posting)));
                $image_parts = explode(";base64,", $img);
                $image_type_aux = explode("image/", $image_parts[0]);
                $image_type = $image_type_aux[1];

                $imagesave = Image::make($img)->save($path . '/' . strtoupper(str_replace(' ', '_',preg_replace('/\s+/', '-', $request->posting))).".".$image_type);
                foreach ($this->dimensions as $row) {
                    $canvas = Image::canvas($row, $row);
                    $resizeImage = Image::make($img)->resize($row, $row, function ($constraint) {
                        $constraint->aspectRatio();
                    });
    
                    if (!File::isDirectory($path . '/' . $row)) {
                        File::makeDirectory($path . '/' . $row);
                    }
    
                    $canvas->insert($resizeImage, 'center');
                    $canvas->save($path . '/' . $row . '/' . strtoupper(str_replace(' ', '_',preg_replace('/\s+/', '-', $request->posting))).".".$image_type);
                }
                if($imagesave){
    
                    //proses simpan data
                    $data = Posting::create([
                        'post_content'  => $request->posting,
                        'url_post' => preg_replace('/\s+/', '-', $request->posting),
                        'datetime' => date('Y-m-d H:i:s'),
                        'image' => $imageName.'.'.$image_type,
                        'created_by' => Auth::user()->id
                    ]);
                }
            }else{
                    //proses simpan data
                $data = Posting::create([
                    'post_content'  => $request->posting,
                    'url_post' => preg_replace('/\s+/', '_', $request->posting),
                    'datetime' => date('Y-m-d H:i:s'),
                    'created_by' => Auth::user()->id
                ]);

            }

        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }

    // mengubah data
    public function update($id, Request $request)
    {
        //definiskan path sesuai dengan global variable
        $path = $this->path;

        //cek jika folder belum ada maka akan menjalankan fungsi ini untuk membuat folder
        if (!File::isDirectory($path)) {$folder = File::makeDirectory($path, 0777, true);}
        if (!File::isDirectory($this->path)) {File::makeDirectory($this->path, 0777, true);}

        //get data dari ID yg di passing
        $data = DB::table('users')
            ->select('nik_pegawai', 'nik_ktp', 'id_divisi', 'id_jabatan', 'nama_lengkap', 'gol_darah', 'no_telp', 'email', 'id_epc_tag', 'foto', 'tgl_masuk', 'tgl_habis_kontrak', 'status_pegawai', 'masa_kerja', 'id_cabang', 'rt', 'rw', 'kelurahan', 'kecamatan', 'kota', 'provinsi', 'kode_pos', 'alamat')
            ->join('users_status_pegawai', 'users_status_pegawai.id_karyawan', '=', 'users.id')
            ->leftJoin('users_alamat', 'users_alamat.id_karyawan', '=', 'users.id')
            ->where('users.id', $id)
            ->first(); 

        $rules = [
            "nik_pegawai" => "required|string|unique:users,nik_pegawai,".$data->nik_pegawai.',nik_pegawai',
            "nik_ktp" => "required|numeric|digits_between:15,17|unique:users,nik_ktp,".$data->nik_ktp.',nik_ktp',
            "nama_lengkap" => "required|string",
            "no_telp" => "required|numeric|digits_between:10,15",
            "email" => "required|email:rfc,dns",
            "id_epc_tag" => "required|string",
            "provinsi" => "required|numeric",
            "kota" => "required|numeric",
            "kecamatan" => "required|numeric",
            "kelurahan" => "required|numeric",
            "kode_pos" => "required|numeric|digits:5",
            "rt" => "required|string|size:3",
            "rw" => "required|string|size:3",
            "alamat" => "required|string",
            "gol_darah" => "required|string",
            "divisi" => "required|",
            "foto" => "required|",
        ];

        $customMessages = [
            'required' => 'Isian :attribute tidak boleh kosong.',
            'numeric' => 'Isian :attribute harus berupa angka.',
            'digits_between' => 'Isian :attribute harus berupa angka dengan minimal 10 karakter dan maksimal 15.',
            'digits' => 'Isian :attribute harus berupa angka dengan 5 karakter.',
            'size' => 'Isian :attribute harus 3 karakter.',
            'unique' => ':attribute tidak unik atau sudah dipakai.'
        ];

        $this->validate($request, $rules, $customMessages);

        $kelurahan = (int)$request->kelurahan;

        DB::beginTransaction();
        try {

            //cek jika ada foto maka lakukan proses ini
            if($data->foto != ""){

                //cek jika gambar ada di folder images/karyawan maka akan di lakukan proses penghapusan
                if(file_exists($path . '/' . $data->foto)){
                    //delete file exist
                    unlink($path . '/' . $data->foto);
                }
            }

                //jika foto diset maka proses ini akan dijalankan
                if($request->foto !== '/images/karyawan/'.$data->foto || $data->foto == ''){

                    //proses simpan foto
                    $img = $request->foto;  // your base64 encoded
                    $imageName = strtoupper(str_replace(' ', '_',$request->nama_lengkap));
                    $image_parts = explode(";base64,", $img);
                    $image_type_aux = explode("image/", $image_parts[0]);
                    $image_type = $image_type_aux[1];
                    $image_base64 = base64_decode($image_parts[1]);
                    $file = $path.'/' . $imageName . '.'.$image_type;
                    file_put_contents($file, $image_base64);
                    $data = User::where('id', $id)->update(['foto' => $imageName . '.'.$image_type]);
                }

                //proses simpan data
                $data = User::where('id', $id)->update([
                    'nik_pegawai'  => $request->nik_pegawai,
                    'nik_ktp' => $request->nik_ktp,
                    'id_divisi' => $request->divisi,
                    'id_jabatan' => $request->jabatan,
                    'nama_lengkap' => $request->nama_lengkap,
                    'gol_darah' => $request->gol_darah,
                    'no_telp' => $request->no_telp,
                    'email' => $request->email,
                    'id_epc_tag' => $request->id_epc_tag,
                ]);



                $data2 = UserStatusPegawai::updateOrCreate([
                    'id_karyawan' => $id],[
                    'tgl_masuk' => $request->tgl_masuk,
                    'tgl_habis_kontrak' => $request->tgl_akhir_kontrak,
                    'status_pegawai' => $request->status_karyawan,
                    'masa_kerja' => '-',
                    'id_cabang' => $request->kantor
                ]);

                $data3 = UserAlamat::updateOrCreate([
                    'id_karyawan' => $id],[
                    'rt' => $request->rt,
                    'rw' => $request->rw,
                    'kelurahan' => $kelurahan,
                    'kecamatan' => $request->kecamatan,
                    'kota' => $request->kota,
                    'provinsi' => $request->provinsi,
                    'kode_pos' => $request->kode_pos,
                    'alamat' => $request->alamat
                ]);
            

        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }

    // menghapus data
    public function deleteData(Request $request)
    {
        //path utk foto 
        $path = $this->path;

        DB::beginTransaction();
        try {

            //get data posting 
            $posting = Posting::where('id', $request->id);

            $data = $posting->first();

            if($data->image != ''){

                //cek jika gambar ada di folder images/posting maka akan di lakukan proses penghapusan
                if(file_exists($path . '/' . $data->image)){
                    //delete file exist
                    unlink($path . '/' . $data->image);
                }
    
                if(file_exists($path . '/245/' . $data->image)){
                    //delete file exist
                    unlink($path . '/245/' . $data->image);
                }
    
                if(file_exists($path . '/300/' . $data->image)){
                    //delete file exist
                    unlink($path . '/300/' . $data->image);
                }
    
                if(file_exists($path . '/500/' . $data->image)){
                    //delete file exist
                    unlink($path . '/500/' . $data->image);
                }
            }

            //delete posting dari table user
            $posting->delete(); 

        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }

    // like data
    public function like(Request $request)
    {

        DB::beginTransaction();
        try {

            $like = PostingLike::updateOrCreate([
                'id_post' => $request->id,
                'id_user' => Auth::user()->id],[
                'datetime' => date('Y-m-d H:i:s'),
                'status' => DB::raw('IF(status = "1", "0", "1" )')
            ]);


        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }

    // like data
    public function comment(Request $request)
    {

        DB::beginTransaction();
        try {
            $data = DB::table('posting')->where('url_post', $request->post)->first();
            $comment = PostingComment::create([
                'id_post' => $data->id,
                'id_user' => Auth::user()->id,
                'comment' => $request->posting,
                'datetime' => date('Y-m-d H:i:s'),
                'status' => DB::raw('IF(status = "1", "0", "1" )')
            ]);


        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }

    // like data
    public function updatekomentar(Request $request)
    {
        DB::beginTransaction();
        try {
            $data = DB::table('posting')->where('url_post', $request->post)->first();
            $comment = PostingComment::where('id_post', $data->id)->where('id', $request->id)->update([
                'id_post' => $data->id,
                'id_user' => Auth::user()->id,
                'comment' => $request->posting,
                'datetime' => date('Y-m-d H:i:s'),
            ]);


        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }

    public function deleteComment(Request $request){
        DB::beginTransaction();
        try {
            $comment = PostingComment::where('id', $request->id)->delete();
        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
    }


    public function getPost($url_post) 
    {
        $data = DB::table('posting')
                ->select('posting.id', 'created_by', 'posting.post_content', 'posting.url_post', 'posting.datetime', 'posting.image', 'users.nama_depan', 'users.foto')
                ->join('users', 'users.id', '=', 'created_by')
                ->orderBy('posting.id', 'DESC')
                ->where('url_post', $url_post)
                ->first();
        
        $comment = DB::table('posting_comment')
                ->select('users.nama_depan', 'posting_comment.*', 'users.foto')
                ->join('users', 'users.id', '=', 'posting_comment.id_user')
                ->where('id_post', $data->id)
                ->orderBy('posting_comment.id', 'DESC')
                ->get();
        
        if(Auth::user() != null){
            $like = DB::table('posting_like')
                ->select('status', 'id_post')
                ->where('id_user', Auth::user()->id)
                ->where('id_post', $data->id)
                ->pluck('status', 'id_post')
                ->toArray();

            $totallike = DB::table('posting_like')
                ->select('status', 'id_post', DB::raw('COUNT(id) AS jml'))
                ->where('status', '1')
                ->where('id_post', $data->id)
                ->groupBy('id_post')
                ->pluck('jml', 'id_post')
                ->toArray();

            $totalcomment = DB::table('posting_comment')
                ->select('status', 'id_post', DB::raw('COUNT(id) AS jml'))
                ->where('status', '1')
                ->groupBy('id_post')
                ->pluck('jml', 'id_post')
                ->toArray();

        }else{
            $like = array("xx" => "xx");
            $totallike = array("xx" => "xx");
            $totalcomment = array("xx" => "xx");
        }


        return response()->json(['status' => 'success', 'data' => $data, 'komentar' => $comment, 'like' => $like, 'totallike' => $totallike, 'totalcomment' => $totalcomment], 200);
    }

}
