<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AuthenticateMember
{

    public function handle(Request $request, Closure $next)
    {

        if(Auth::guard()->check()){
            return $next($request);
        }
       return redirect('/login-page');
    }
}
