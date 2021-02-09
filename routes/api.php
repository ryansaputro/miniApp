<?php
/**
 * @author ryan saputro
 * @email ryansaputro52@gmail.com
 * @create date 2020-10-01 13:24:39
 * @modify date 2020-10-01 13:24:39
 * @desc handle url to request
 */

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

//auth
Route::prefix('v1')->group(function () {
    Route::prefix('auth')->group(function () {
        Route::get('checkUser', 'HomeController@checkUser');

        // Below mention routes are public, user can access those without any restriction.
        // Create New User
        Route::post('register', 'AuthController@register');
        // Login User
        Route::post('login', 'AuthController@login');
        // Below mention routes are available only for the authenticated users.
        // // Refresh the JWT Token
        Route::get('refresh', 'AuthController@refresh');
        
        Route::middleware(['auth:api', 'jwt.verify'])->group(function () {
            Route::get('users', 'UserController@getAuthenticatedUser');
            // Get user info
            Route::get('user', 'AuthController@user');
            // Logout user from application
            Route::post('logout', 'AuthController@logout');

                    

        });

    });

    //utk update password pengguna aplikasi
    Route::post('/update-password','AuthController@updatePassword');

    //post 
    Route::prefix('post')->group(function() {
        Route::get('/','PostController@index');
        Route::post('/create','PostController@store');
        Route::post('/like','PostController@like');
        Route::post('/delete','PostController@deleteData');
        Route::post('/comment','PostController@comment');
        Route::post('/updatekomentar','PostController@updatekomentar');
        Route::post('/deleteComment','PostController@deleteComment');
        Route::get('/{url_post?}','PostController@getPost');
    });
    
});

