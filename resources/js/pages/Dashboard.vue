<template>
  <div class="content">
    <div class="container">
    <div class="row">
      <div class="container-fluid card" v-if="$auth.check()">
      <form @submit.prevent="addData()">
      <div class="loader" v-if="loading"></div>
        <div class="row mb-3">
          <div class="col-md-12">
            <div class="form-group">
              <label>Apa yang anda pikirkan :</label>
              <textarea class="form-control" v-model="form.posting"></textarea>
            </div>
          </div>
          <div class="col-md-6">
            <div v-if="!form.foto">
              <input type="file" accept="image/*" @change="onFileChange">
            </div>
            <div v-else>
              <img :src="form.foto" />
              <button class="btn btn-danger btn-sm" @click="removeImage">Hapus Foto</button>
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

      <!-- list posting -->
      <div class="col-md-12" v-for="(data, index) in post" :key="index" :id="data.url_post">
        <div class="panel panel-default">
            <div class="panel-body">
               <section class="post-heading">
                    <div class="row">
                        <div class="col-md-11">
                            <div class="media">
                              <div class="media-left">
                                <a href="#">
                                  <img v-if="data.foto != ''" class="media-object photo-profile" :src="'/images/user/' + data.foto"  width="40" height="40" alt="...">
                                  <img v-else class="media-object photo-profile" src="http://0.gravatar.com/avatar/38d618563e55e6082adf4c8f8c13f3e4?s=40&d=mm&r=g"  width="40" height="40" alt="...">
                                  
                                </a>
                              </div>
                              <div class="media-body">
                                <a href="#" class="anchor-username"><h4 class="media-heading">{{data.nama_depan}}</h4></a> 
                                <a href="#" class="anchor-time">{{data.datetime}}</a>
                              </div>
                            </div>
                        </div>
                         <div class="col-md-1">
                             <a href="#"><i class="glyphicon glyphicon-chevron-down"></i></a>
                         </div>
                    </div>             
               </section>
               <section class="post-body">
                   <div v-if="data.image != ''" class="image-post"  v-bind:style="{ 'background-image': 'url(/images/posting/' + data.image+')' }" >
                   </div>
                   <p>{{data.post_content}}</p>
               </section>
               <section class="post-footer">
                   <hr>
                   <div class="post-footer-option container">
                        <ul class="list-unstyled">
                            <li><a :href="'#'+data.url_post" v-bind:class="active[data.id] == true ? 'aktif' : '' " @click="suka(data.id)" v-if="$auth.check()">{{totalLike[data.id]}} <i class="fa fa-heart-o" aria-hidden="true"></i> Suka</a></li>
                            <li><a href="#" @click="komentar(data.url_post)" v-if="$auth.check()"><i class="fa fa-comments" aria-hidden="true"></i>{{totalComment[data.id]}} Komentar</a></li>
                            <li><a :href="'#'+data.url_post" @click="hapus(data.id)" v-if="id_user == data.created_by"><i class="fa fa-trash" aria-hidden="true"></i> Hapus</a></li>
                        </ul>
                   </div>
               </section>
            </div>
        </div>   
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
    width:30px;  
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
          posting:'',
          foto:''
        },
        post:[],
        active:[],
        totalLike:[],
        totalComment:[],
        id_user:'',
        image:''
      }
    },
    created() {
        this.loadData();
        
        if(JSON.parse(localStorage.getItem('userData'))){
          this.id_user = JSON.parse(localStorage.getItem('userData')).id;
        }

        this.image = JSON.parse(localStorage.getItem('userData')).foto;
    },
    methods: {
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
            .post("post/create", {
              posting: this.form.posting,
              foto: this.form.foto,
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
            .get("post")
            .then(response => {
              if(response.status == 200){
                this.post = response.data.data;
                var aktif = this.active;

                $.each(response.data.like, function(k,v){
                  if(v == '1'){
                    aktif[k] = true;
                  }else{
                    aktif[k] = false;
                  }
                });

                this.totalLike = response.data.totallike;
                this.totalComment = response.data.totalcomment;
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
        komentar(url) {
          this.$router.push("/post/"+url);
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