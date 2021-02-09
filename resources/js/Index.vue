<template>
    <!-- <div id="main" v-if="isMobile === false"> -->
    <div id="main">
        <div id="header">
          <div>
            <!-- <Mobile></Mobile> -->
            <!-- <Sidebar></Sidebar> -->
            <div v-if="$auth.check()">
              <template>
                <sidebar-menu :menu="menu" />
              </template>
            </div>
          </div>
            <!-- PAGE CONTAINER-->
          <div>
            <div class="page-container">
              <div v-if="$auth.check()">
                <div class="upper-sidebar">
                  <img class="logo" v-if="$auth.check() && image == ''"  src="https://i.stack.imgur.com/l60Hf.png">
                  <img class="logo" v-else-if="$auth.check()" :src="'/images/user/' + image ">
                  <strong v-if="$auth.check()" class="text-center text-uppercase nama-login">{{nama}}</strong>
                </div>
              </div>
                  <Menu></Menu>
                <div id="content" class="main-content">
                    <div v-cloak>
                        <div class="main-content">
                            <div class="section__content section__content--p30">
                                <div class="container-fluid">
                                    <router-view></router-view>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
              </div>
            </div>
        </div>
        <div class="sidebar-footer"></div>
    </div>
</template>
<style>
/* .sidebar-footer {
  display: block;
}

.footer {
  display:block;
} */
.nama-login{
    position: absolute;
    top: 132px;
    left: 85px;
    background: green;
    color: #fff;
    padding: 10px;
    border-radius: 15px;
}
</style>
<script>
  import Menu from './components/Menu.vue'
  import Sidebar from './components/Sidebar.vue'
  import Mobile from './components/Mobile.vue'
  import { SidebarMenu } from 'vue-sidebar-menu'
  import { isMobile } from 'mobile-device-detect';

  export default {
    data() {
      return {
        menu: [],
        isMobile:isMobile ? true : false,
        image:'',
        nama:''

      }
    },
    components: {
      Menu,
      SidebarMenu,
      Mobile
    },
    created() {
      
      if(localStorage.auth_stay_signed_in === 'true'){
        this.menu = JSON.parse(localStorage.getItem('role'));
      }else{
        this.menu = [{"href":"\/login","title":"Login","icon":"fa fa-bell"}];
      }
        this.image = JSON.parse(localStorage.getItem('userData')).foto;
        this.nama = JSON.parse(localStorage.getItem('userData')).nama_depan;
    },
    computed: {
        currentRouteName() {
            return this.$route.name;
        },
        storageToken() {
            return localStorage.role
        }
        
    },
    methods: {
    },
    mounted(){
        // Clear the browser cache data in localStorage when closing the browser window
        // window.onbeforeunload = function (e) {
            // var storage = window.localStorage;
            // storage.clear()
        // }
    }

  
  }
</script>