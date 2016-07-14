<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/

Route::get('/', function()
{
	return View::make('hello');
});

Route::get('/authtest', array('before' => 'auth.basic', function()
{
    return View::make('hello');
}));

Route::group(array('prefix' => 'api/v1'), function()
{
    Route::resource('auth', 'AuthController');
});

Route::group(array('prefix' => 'api/v1', 'before' => 'auth.basic'), function()
{
    Route::get('task/current', [
        'as' => 'task_current', 'uses' => 'TaskController@current'
    ]);
    Route::get('task/csv', [
        'as' => 'task_csv', 'uses' => 'TaskController@download_csv'
    ]);
    Route::resource('task', 'TaskController');
});

