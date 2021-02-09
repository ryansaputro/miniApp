<template>
  <div class="content">
    <div class="container">
    <div class="row">
      <!-- list posting -->
      <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
               <section class="post-heading">
                    <div class="row">
                        <div class="col-md-11">
                            <div class="media">
                              <div class="media-left">
                                <a href="#">
                                  <img v-if="form.foto != ''" class="media-object photo-profile" :src="'/images/user/' + form.foto"  width="40" height="40" alt="...">
                                  <img v-else class="media-object photo-profile" src="http://0.gravatar.com/avatar/38d618563e55e6082adf4c8f8c13f3e4?s=40&d=mm&r=g"  width="40" height="40" alt="...">

                                  <!-- <img class="media-object photo-profile" src="http://0.gravatar.com/avatar/38d618563e55e6082adf4c8f8c13f3e4?s=40&d=mm&r=g" width="40" height="40" alt="..."> -->
                                </a>
                              </div>
                              <div class="media-body">
                                <a href="#" class="anchor-username"><h4 class="media-heading">{{form.user}}</h4></a> 
                                <a href="#" class="anchor-time">{{form.datetime}}</a>
                              </div>
                            </div>
                        </div>
                         <div class="col-md-1">
                             <a href="#"><i class="glyphicon glyphicon-chevron-down"></i></a>
                         </div>
                    </div>             
               </section>
               <section class="post-body">
                    <div v-if="form.image != ''" class="image-post"  v-bind:style="{ 'background-image': 'url(/images/posting/' + form.image+')' }" >
                    </div>

                   <p>{{form.post_content}}</p>
               </section>
               <section class="post-footer">
                   <hr>
                   <div class="post-footer-option container">
                        <ul class="list-unstyled">
                            <li><a :href="'#'+form.url_post" v-bind:class="active[form.id] == true ? 'aktif' : '' " @click="suka(form.id)" v-if="$auth.check()">{{totalLike[form.id]}} <i class="fa fa-heart-o" aria-hidden="true"></i> Suka</a></li>
                            <li><a href="#" @click="cekKomentar"><i class="fa fa-comments" aria-hidden="true"></i> {{totalcomment[form.id]}} Komentar</a></li>
                            <!-- <li><a :href="'#'+form.url_post" @click="hapus(form.id)" v-if="id_user == form.created_by"><i class="fa fa-trash" aria-hidden="true"></i> Hapus</a></li> -->
                        </ul>
                   </div>
               </section>
            </div>
        </div>   
      </div>
      <div v-for="(dt, index) in allKomentar" :key="index" class="col-md-12">
        <section class="post-heading">
            <div class="row">
                <div class="col-md-11">
                    <div class="media">
                      <div class="media-left">
                        <a href="#">
                            <img v-if="dt.foto != ''" class="media-object photo-profile" :src="'/images/user/' + dt.foto"  width="40" height="40" alt="...">
                            <img v-else class="media-object photo-profile" src="http://0.gravatar.com/avatar/38d618563e55e6082adf4c8f8c13f3e4?s=40&d=mm&r=g"  width="40" height="40" alt="...">

                          <!-- <img class="media-object photo-profile" src="http://0.gravatar.com/avatar/38d618563e55e6082adf4c8f8c13f3e4?s=40&d=mm&r=g" width="40" height="40" alt="..."> -->
                        </a>
                      </div>
                      <div class="media-body">
                        <a href="#" class="anchor-username"><h4 class="media-heading">{{dt.nama_depan}}</h4></a> 
                        <a href="#" class="anchor-time">{{dt.datetime}}</a>
                      </div>
                    </div>
                </div>
                  <div class="col-md-1">
                      <a href="#"><i class="glyphicon glyphicon-chevron-down"></i></a>
                  </div>
            </div>             
        </section>

        <section class="post-body">
            <p>{{dt.comment}}
              <button type="button" class="btn btn-sm btn-primary" @click="editKomentar(dt.comment, dt.id)" v-if="id_user == dt.id_user"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</button>
              <button v-if="dt.id_user == id_user" class="btn btn-danger btn-sm" type="button" @click="hapusComment(dt.id)">Hapus</button>
            </p>
        </section>
      </div>

      <div class="container-fluid card" v-if="$auth.check() && komentar==true">
      <form @submit.prevent="addData()">
      <div class="loader" v-if="loading"></div>
        <div class="row mt-3 mb-3">
          <div class="col-md-12">
            <div class="form-group">
              <textarea class="form-control" v-model="form.posting"></textarea>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <button class="btn btn-primary pull-right" type="submit">Kirim</button>
            </div>
          </div>
        </div>
        </form>
      </div>
      
    </div>

  </div>
  </div>
</template>
<style>
  .aktif{color:blue !important;}
  .image-post{
    background-size: contain;
    min-height:300px;
    background-position: center;
    background-repeat: no-repeat;
  }
  img {
    width: 50%;
    margin: auto;
    display: block;
    margin-bottom: 10px;
  }
/*-- Content Style --*/
.post-footer-option li{
    float:left;
    margin-right:50px;
    padding-bottom:15px;
}

.post-footer-option li a{
    color:#AFB4BD;
    font-weight:500;
    font-size:1.3rem;
}

.photo-profile{
    border:1px solid #DDD;    
}

.anchor-username h4{
    font-weight:bold;    
}

.anchor-time{
    color:#ADB2BB;
    font-size:1.2rem;
}

.post-footer-comment-wrapper{
    background-color:#F6F7F8;
}</style>
<script>
  import axios from 'axios'
  export default {
    data() {
      return {
        loading: false,
        form: {
          post_content:'',
          datetime:'',
          image:'',
          foto:'',
          user:'',
          id:'',
          created_by:'',
          url_post:'',
        },
        post:[],
        active:[],
        totalLike:[],
        totalcomment:[],
        allKomentar:[],
        id_user:'',
        komentar:false
      }
    },
    created() {
        this.loadData();
        
        if(JSON.parse(localStorage.getItem('userData'))){
          this.id_user = JSON.parse(localStorage.getItem('userData')).id;
        }
    },
    methods: {
        hapusComment(id) {
          this.loading = true
          axios
            .post("post/deleteComment", {
              id: id
            })
            .then(response => {
              if(response.status == 200){
                this.$swal.fire({
                  position: 'top-end',
                  icon: 'success',
                  title: 'Hapus sukses',
                  showConfirmButton: false,
                  timer: 1500
                });

                this.loadData();
              }
            })
            .catch(errors => {
                // console.log(errors);
                // this.$swal('Failed', 'You failed Created this file', 'error');
                if (errors.response) {
                    var data = '';
                    $.each(errors.response.data.errors, function(k,v){
                      data += v[0]+"\n";
                    });
                    this.$swal('Gagal', data, 'error');
                  // client received an error response (5xx, 4xx)
                } else if (errors.request) {
                    console.log(errors.request);
                    console.log("request never left")
                  // client never received a response, or request never left
                } else {
                  console.log("lainnya")
                }
            }).finally(() => {
                this.loading =  false
            });

        },
        editKomentar(val,id) {
          this.$swal.fire({
            title: 'Edit Komentar',
            input: 'text',
            inputValue:val,
            inputAttributes: {
              autocapitalize: 'off',
            },
            showCancelButton: true,
            confirmButtonText: 'perbarui',
            showLoaderOnConfirm: true,
          }).then((result) => {
            console.log(result.value)
            if (result.isConfirmed) {
              axios.post(`/post/updatekomentar`,{
                posting: result.value,
                post: this.$route.params.id,
                id: id
              }).then(response => {
                this.loadData();
              })
              
            }
          })
        },
        cekKomentar() {
          this.komentar == false ? this.komentar = true : this.komentar = false;
        },
        onFileChange(e) {
              var files = e.target.files || e.dataTransfer.files;
              if (!files.length)
                return;
              this.createImage(files[0]);
        },
        createImage(file) {
              var reader = new FileReader();
              var vm = this;

              reader.onload = (e) => {
                vm.form.foto = e.target.result;
              };
              reader.readAsDataURL(file);
        },
        removeImage: function (e) {
              this.form.foto = '';
        },
        addData() {
          // post data ke api menggunakan axios
          this.loading = true
          axios
            .post("post/comment", {
              posting: this.form.posting,
              foto: this.form.foto,
              post: this.$route.params.id
            })
            .then(response => {
              if(response.status == 200){
                this.$swal.fire({
                  position: 'top-end',
                  icon: 'success',
                  title: 'Post sukses',
                  showConfirmButton: false,
                  timer: 1500
                });

                this.form.posting = '';
                this.form.foto = '';
                this.loadData();
              }
            })
            .catch(errors => {
                // console.log(errors);
                // this.$swal('Failed', 'You failed Created this file', 'error');
                if (errors.response) {
                    var data = '';
                    $.each(errors.response.data.errors, function(k,v){
                      data += v[0]+"\n";
                    });
                    this.$swal('Gagal', data, 'error');
                  // client received an error response (5xx, 4xx)
                } else if (errors.request) {
                    console.log(errors.request);
                    console.log("request never left")
                  // client never received a response, or request never left
                } else {
                  console.log("lainnya")
                }
            }).finally(() => {
                this.loading =  false
            });
        },
        loadData() {
          this.loading = true
          axios
            .get("post/"+this.$route.params.id)
            .then(response => {
              if(response.status == 200){

                this.form.post_content = response.data.data.post_content;
                this.form.datetime = response.data.data.datetime;
                this.form.image = response.data.data.image;
                this.form.user = response.data.data.nama_depan;
                this.form.id = response.data.data.id;
                this.form.created_by = response.data.data.created_by;
                this.form.url_post = response.data.data.url_post;
                this.form.foto = response.data.data.foto;

                this.allKomentar = response.data.komentar;
                this.totalLike = response.data.totallike;
                this.totalcomment = response.data.totalcomment;
                var aktif = this.active;

                $.each(response.data.like, function(k,v){
                  if(v == '1'){
                    aktif[k] = true;
                  }else{
                    aktif[k] = false;
                  }
                });

                // this.totalLike = response.data.totallike;
              }
            })
            .catch(errors => {
                // console.log(errors);
                // this.$swal('Failed', 'You failed Created this file', 'error');
                if (errors.response) {
                    var data = '';
                    $.each(errors.response.data.errors, function(k,v){
                      data += v[0]+"\n";
                    });
                    this.$swal('Gagal', data, 'error');
                  // client received an error response (5xx, 4xx)
                } else if (errors.request) {
                    console.log(errors.request);
                    console.log("request never left")
                  // client never received a response, or request never left
                } else {
                  console.log("lainnya")
                }
            }).finally(() => {
                this.loading =  false
            });

        },
        suka(id) {
          // post data ke api menggunakan axios
          this.loading = true
          axios
            .post("post/like", {
              id: id,
            })
            .then(response => {
              if(response.status == 200){
                this.active[id] = true;
                this.loadData();
              }
            })
            .catch(errors => {
                // console.log(errors);
                // this.$swal('Failed', 'You failed Created this file', 'error');
                if (errors.response) {
                    var data = '';
                    $.each(errors.response.data.errors, function(k,v){
                      data += v[0]+"\n";
                    });
                    this.$swal('Gagal', data, 'error');
                  // client received an error response (5xx, 4xx)
                } else if (errors.request) {
                    console.log(errors.request);
                    console.log("request never left")
                  // client never received a response, or request never left
                } else {
                  console.log("lainnya")
                }
            }).finally(() => {
                this.loading =  false
            });

        },
        hapus(id){
          // post data ke api menggunakan axios
          this.loading = true
          axios
            .post("post/delete", {
              id: id,
            })
            .then(response => {
              if(response.status == 200){
                this.$swal.fire({
                  position: 'top-end',
                  icon: 'success',
                  title: 'Hapus sukses',
                  showConfirmButton: false,
                  timer: 1500
                });

                this.loadData();
              }
            })
            .catch(errors => {
                // console.log(errors);
                // this.$swal('Failed', 'You failed Created this file', 'error');
                if (errors.response) {
                    var data = '';
                    $.each(errors.response.data.errors, function(k,v){
                      data += v[0]+"\n";
                    });
                    this.$swal('Gagal', data, 'error');
                  // client received an error response (5xx, 4xx)
                } else if (errors.request) {
                    console.log(errors.request);
                    console.log("request never left")
                  // client never received a response, or request never left
                } else {
                  console.log("lainnya")
                }
            }).finally(() => {
                this.loading =  false
            });

        }

    }
  }
</script>