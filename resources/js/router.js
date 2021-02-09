import VueRouter from 'vue-router'
const Register = () => import('./pages/Register');
const Login = () => import('./pages/login');
import NotFound from './components/404'
import Beranda from './pages/Dashboard'
import Komentar from './pages/Komentar'
import gantiPassword from './components/gantiPassword'


// Routes
const routes = [
    {
        path: '/ganti-password',
        name: 'gantiPassword',
        component: gantiPassword,
        meta: {
            auth: true,
            menus: 'read-404'
        }
    },
    {
        path: '/404',
        name: 'NotFound',
        component: NotFound,
        meta: {
            auth: true,
            menus: 'read-404'
        }
    },
    {
        path: '/register',
        name: 'register',
        component: Register,
        meta: {
            auth: false
        }
    },
    {
        path: '/login',
        name: 'login',
        component: Login,
        meta: {
            auth: false
        }
    },
    // USER ROUTES
    {
        path: '/',
        name: 'beranda',
        component: Beranda,
    },

    {
        path: '/post/:id',
        name: 'status',
        component: Komentar,
    },


]
const router = new VueRouter({
    history: true,
    mode: 'history',
    routes,
    linkActiveClass: "active"
})

router.beforeEach((to, from, next) => {
    // if (to.name !== 'login' && to.meta.auth == null) {
    //     if (to.name == 'display') {
            next();

    //     } else {
    //         next({ name: 'beranda' })

    //     }
    // }

    // else {
    //     if (to.fullPath == '/beranda' && from.fullPath == '/login') {
    //         next();
    //         if (!localStorage.getItem('firstLoad')) {
    //             localStorage['firstLoad'] = true;
    //             window.location.reload();
    //         } else {
    //             localStorage.removeItem('firstLoad');
    //         }
    //     } else {
    //         if (localStorage.auth_stay_signed_in === 'true') {
    //             var menusRole = to.meta.menus;
    //             console.log(menusRole)
    //             // console.log()
    //             // if (jQuery.inArray(menusRole, JSON.parse(localStorage.user)) !== -1) {
    //                 next();
    //             // window.location.reload();
    //             // } else {
    //             //     next({ name: 'NotFound' });
    //             // }

    //         } else {
    //             next();
    //         }

    //     }

    // }
})



export default router