<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Auth;
use Validator;
use App\User;
use App\Role;
use JWTAuth;
use Session;
use DB;
use File;
use Carbon\Carbon;
use Intervention\Image\ImageManagerStatic as Image;

class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function __construct()
    {
        $this->path = public_path('images/user');;
        $this->dimensions = ['245', '300', '500'];
    }

    public function register(Request $request)
    {

        $v = Validator::make($request->all(), [
            'nama_depan' => 'required|min:3',
            'nama_belakang' => 'required|min:3',
            'no_telp' => 'required|',
            'foto' => 'required|',
            'email' => 'required|email|unique:users',
            'password'  => 'required|min:3|confirmed',
        ]);
        if ($v->fails())
        {
            return response()->json([
                'status' => 'error',
                'errors' => $v->errors()
            ], 422);
        }

        DB::beginTransaction();
        try {
            
            $path = $this->path; //. '/' . date('Y') . '/' . date('m');
            if (!File::isDirectory($path)) {$folder = File::makeDirectory($path, 0777, true);}
            if (!File::isDirectory($this->path)) {File::makeDirectory($this->path, 0777, true);}

            if($request->foto != null){
                    //proses simpan foto
                    $img = $request->foto;  // your base64 encoded
                    $imageName = strtoupper(str_replace(' ', '_',preg_replace('/\s+/', '-', $request->nama_depan)));
                    $image_parts = explode(";base64,", $img);
                    $image_type_aux = explode("image/", $image_parts[0]);
                    $image_type = $image_type_aux[1];

                    $imagesave = Image::make($img)->save($path . '/' . strtoupper(str_replace(' ', '_',preg_replace('/\s+/', '-', $request->nama_depan))).".".$image_type);
                    foreach ($this->dimensions as $row) {
                        $canvas = Image::canvas($row, $row);
                        $resizeImage = Image::make($img)->resize($row, $row, function ($constraint) {
                            $constraint->aspectRatio();
                        });
        
                        if (!File::isDirectory($path . '/' . $row)) {
                            File::makeDirectory($path . '/' . $row);
                        }
        
                        $canvas->insert($resizeImage, 'center');
                        $canvas->save($path . '/' . $row . '/' . strtoupper(str_replace(' ', '_',preg_replace('/\s+/', '-', $request->nama_depan))).".".$image_type);
                    }
                    if($imagesave){
        
                        //proses simpan data
                        $data = User::create([
                            'nama_depan'  => $request->nama_depan,
                            'nama_belakang'  => $request->nama_belakang,
                            'no_telp'  => $request->no_telp,
                            'email'  => $request->email,
                            'password'  => bcrypt($request->password),
                            'foto' => $imageName.'.'.$image_type,
                        ]);

                        $roles = DB::table('model_has_roles')->insert(['role_id' => '1', 'model_type' => 'App\User', 'model_id' =>$data->id]);
                    }
                }
        } catch (\Illuminate\Database\QueryException $ex) {
            //throw $th;
            DB::rollback();
            return response()->json(['status' => 'failed', 'message' => $ex->getMessage()], 500);
        }
        DB::commit();
        return response()->json(['status' => 'success'], 200);
        
    }

    /**
     * Register a new user
     */
    public function updatePassword(Request $request)
    {
        $v = Validator::make($request->all(), [
            'password'  => 'required|min:3|confirmed',
        ]);
        if ($v->fails())
        {
            return response()->json([
                'status' => 'error',
                'errors' => $v->errors()
            ], 422);
        }
        $id = Auth::user()->id;
        $user = User::find($id)->update([
            'password' => bcrypt($request->password)
        ]);
        return response()->json(['status' => 'success'], 200);
    }
    /**
     * Login user and return a token
     */
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');
        //checking data
        $usercek = User::where('email', $request->email)->value('id');
        $cek = DB::table('model_has_roles')->where('model_id', $usercek)->count();

        //cek jika user tidak terdaftar maka akan memproses proses ini
        if($cek == 0){
            return response([
                    'status' => 'errory',
                    'error' => 'invalid.credentials',
                    'msg' => 'Invalid Credentials.'
                ], 401);
        }
        $credentials = $request->only('email', 'password');
        if ( ! $token = $this->guard()->attempt($credentials)) {
        // if ( ! $token = JWTAuth::attempt($credentials)) {
                return response([
                    'status' => 'errors',
                    'error' => 'invalid.credentials',
                    'msg' => 'Invalid Credentials.'
                ], 401);
        }
        return response([
                'status' => 'success',
                'token' => $token,
                'usercek' => $usercek
        ],200)
            ->header('Authorization', $token);
    }
    /**
     * Logout User
     */
    public function logout()
    {
        $this->guard()->logout();
        return response()->json([
            'status' => 'success',
            'msg' => 'Logged out Successfully.'
        ], 200);
    }
    /**
     * Get authenticated user
     */
    public function user(Request $request)
    {
        $user = User::where('id',Auth::user()->id)->first();
        $permission = DB::table('role_has_permissions')
                ->select('permissions.name')
                ->join('permissions', 'permissions.id', '=', 'role_has_permissions.permission_id')
                ->join('roles', 'roles.id', '=', 'role_has_permissions.role_id')
                ->join('model_has_roles', 'model_has_roles.role_id', '=', 'roles.id')
                ->where('model_id', $user->id)
                ->pluck('name')->toArray();

        $role = DB::table('model_has_roles')->select('role_id')->where('model_id', $user->id)->value('role_id');
        $data = DB::table('role_has_menus')->where('id_role', $role)->value('menus');
        $data = json_decode($data);
        // $setSession = Session::put($user);
        return response()->json([
            'status' => 'success',
            'data' => json_encode($permission, true),
            'role' => json_encode($data, true),
            'user' => json_encode($user, true),
        ]);
    }


    public function getAuthenticatedUser()
    {
            try {

                    if (! $user = JWTAuth::parseToken()->authenticate()) {
                            return response()->json(['user_not_found'], 404);
                    }

            } catch (Tymon\JWTAuth\Exceptions\TokenExpiredException $e) {

                    return response()->json(['token_expired'], $e->getStatusCode());

            } catch (Tymon\JWTAuth\Exceptions\TokenInvalidException $e) {

                    return response()->json(['token_invalid'], $e->getStatusCode());

            } catch (Tymon\JWTAuth\Exceptions\JWTException $e) {

                    return response()->json(['token_absent'], $e->getStatusCode());

            }

            return response()->json(compact('user'));
    }
    
    /**
     * Refresh JWT token
     */
    public function refresh()
    {
        // dd(JWTAuth::getToken());
        // JWTAuth::removeToken('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvYXBpXC92MVwvYXV0aFwvcmVmcmVzaCIsImlhdCI6MTYwMDE0NDgyMCwiZXhwIjoxNjAwMTQ4NDk3LCJuYmYiOjE2MDAxNDQ4OTcsImp0aSI6Ik5IdFpBemRGMmdpcDZTTlciLCJzdWIiOjUsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.2oNTodzSiUmg7hhSiyacXJgn9JYYiek3tnXK_d5odLs')
        if ($token = $this->guard()->refresh()) {
            return response()
                ->json(['status' => 'successs'], 200)
                ->header('Authorization', $token);
        }
        return response()->json(['error' => 'refresh_token_error'], 401);
    }
    /**
     * Return auth guard
     */
    private function guard()
    {
        return Auth::guard();
    }
}