<?php

namespace App\Http\Middleware;

use App\Models\ExamSchedule;
use Closure;
use Illuminate\Support\Facades\Auth;

class AuthenticateExamSchedule
{
    protected $redirectTo = '/exams';

    public function handle($request, Closure $next)
    {
        if (Auth::guard('web')->check() ) {
            return $next($request);
        }

        return redirect('/login-page');
    }
}
