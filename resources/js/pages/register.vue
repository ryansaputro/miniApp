<template>
  <div class="container">
    <div class="row justify-content-md-center">
      <div class="col-6">
        <div class="card card-default">
          <div class="card-header">Register</div>
          <div class="card-body">
            <div class="alert alert-danger" v-if="has_error && !success">
                <p v-if="error == 'registration_validation_error'">Validation Errors.</p>
                <p v-else>Error, can not register at the moment. If the problem persists, please contact an administrator.</p>
            </div>

            <form autocomplete="off" @submit.prevent="register" v-if="!success" method="post">
                <div class="form-group" v-bind:class="{ 'has-error': has_error && errors.nama_depan }">
                    <label for="nama_depan">Nama Depan</label>
                    <input type="text" id="nama_depan" class="form-control" placeholder="Nama Depan" v-model="form.nama_depan">
                    <span class="help-block" v-if="has_error && errors.nama_depan">{{ errors.nama_depan }}</span>
                </div>
                <div class="form-group" v-bind:class="{ 'has-error': has_error && errors.nama_depan }">
                    <label for="nama_belakang">Nama Belakang</label>
                    <input type="text" id="nama_belakang" class="form-control" placeholder="Nama Belakang" v-model="form.nama_belakang">
                    <span class="help-block" v-if="has_error && errors.nama_belakang">{{ errors.nama_belakang }}</span>
                </div>
                <div class="form-group" v-bind:class="{ 'has-error': has_error && errors.nama_depan }">
                    <label for="no_telp">No Telp</label>
                    <input type="text" id="no_telp" class="form-control" placeholder="No Telp" v-model="form.no_telp">
                    <span class="help-block" v-if="has_error && errors.no_telp">{{ errors.no_telp }}</span>
                </div>
                <div class="form-group" v-bind:class="{ 'has-error': has_error && errors.email }">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" class="form-control" placeholder="user@example.com" v-model="form.email">
                    <span class="help-block" v-if="has_error && errors.email">{{ errors.email }}</span>
                </div>
                <div class="form-group" v-bind:class="{ 'has-error': has_error && errors.password }">
                    <label for="password">Password</label>
                    <input type="password" id="password" class="form-control" v-model="form.password">
                    <span class="help-block" v-if="has_error && errors.password">{{ errors.password }}</span>
                </div>
                <div class="form-group" v-bind:class="{ 'has-error': has_error && errors.password }">
                    <label for="password_confirmation">Password confirmation</label>
                    <input type="password" id="password_confirmation" class="form-control" v-model="form.password_confirmation">
                </div>
                <div class="form-group">
                  <label>Foto</label>
                    <div v-if="!form.foto">
                      <input type="file" @change="onFileChange">
                    </div>
                    <div v-else>
                      <img :src="form.foto" />
                      <button class="btn btn-danger btn-sm" @click="removeImage">Hapus Foto</button>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        form:{
          nama_depan:'',
          nama_belakang:'',
          no_telp:'',
          email:'',
          password:'',
          password_confirmation:'',
          foto:''
        },
        has_error: false,
        error: '',
        errors: {},
        success: false,
        loading:false
      }
    },
    methods: {
      onFileChange(e) {
            var files = e.target.files || e.dataTransfer.files;
            if (!files.length)
              return;
            this.createImage(files[0]);
      },
      createImage(file) {
            var image = new Image();
            var reader = new FileReader();
            var vm = this;

            reader.onload = (e) => {
              vm.form.foto = e.target.result;
              console.log(vm.foto)
            };
            reader.readAsDataURL(file);
      },
      removeImage: function (e) {
            this.form.foto = '';
      },
      register() {
        this.loading =  true;
        var app = this.form
        this.$auth.register({
          data: {
            nama_depan: app.nama_depan,
            nama_belakang: app.nama_belakang,
            no_telp: app.no_telp,
            email: app.email,
            password: app.password,
            password_confirmation: app.password_confirmation,
            foto: app.foto,
            password_confirmation: app.password_confirmation
          },
          success: function () {
            this.loading =  false
            app.success = true
            this.$router.push({name: 'login', params: {successRegistrationRedirect: true}})
          },
          error: function (res) {
            // console.log(res.response.data.errors)
            app.has_error = true
            app.error = res.response.data.error
            app.errors = res.response.data.errors || {}
          }
        })
      }
    }
  }
</script>