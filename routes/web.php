<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ComputerTestController;
use App\Http\Controllers\ExamController;
use App\Http\Controllers\IqTestController;
use App\Http\Controllers\TypingTestController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/
Route::get('/login-page', [AuthController::class, 'showLoginPage']);
Route::post('/login', [AuthController::class, 'login']);


Route::middleware(['auth'])->group(function () {


    Route::get('/', [ExamController::class, 'showExamPage']);

    Route::get('/exam/test-page/', [ExamController::class, 'showTestPage']);

//    Route::get('/exam/{exam_id}',[ExamController::class,'showExamPage']);
//    Route::get('/exam/assign-questions/{exam}',[ExamController::class,'assignQuestionsToMembers']);
    //Typing Test
    Route::get('/typing-test', [TypingTestController::class, 'index']);
    Route::post('/typing-test/check', [TypingTestController::class, 'check']);

    Route::post('/exam/submit-test', [IqTestController::class, 'submitTest']);
    Route::get('/logout', [AuthController::class, 'logout']);

    //computer test

    Route::post('/exam/computer-test/submit-test',[ComputerTestController::class,'submitTest']);

    //Basic Computer Test


});
