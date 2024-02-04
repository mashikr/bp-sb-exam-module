<?php

namespace App\Http\Controllers;

use App\Models\ExamSchedule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;


class AuthController extends Controller
{



    public function showLoginPage(){
        return view('auth.login');
    }
    public function login(Request $request)
    {
        $credentials = $request->only('bpid', 'password');


        $users = ExamSchedule::where('bpid', $credentials['bpid'])->get();

        foreach ($users as $user) {

            if ($user->password == $credentials['password']) {
                Auth::guard('web')->login($user);

                $user->update(['login_time' => now()]);

                return redirect()->intended('/');
            }
        }

        return redirect('/login-page')->with('errorMessage', 'Invalid credentials. Please check your bpid and password.');
    }

    public function logout(Request $request)

    {
        Auth::logout();
        $queryParams = $request->query();

        if (isset($queryParams['examEnded'])) {
            return redirect('/login-page')->with('errorMessage', 'The exam has ended. ');
        }

        return redirect('/login-page')->with('errorMessage', 'You have been logged out.');


    }

}
