<?php

namespace App\Http\Controllers;

use App\Models\Result;
use App\Models\TypingTestQuestion;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class TypingTestController extends Controller
{
    public function index()
    {
        $text = TypingTestQuestion::inRandomOrder()->first(); // Get a random text from the database
        return view('exam.typing-test-page', compact('text'));
    }

    public function check(Request $request)
    {
        $scheduledExam=\auth()->user();
       $correctWords=$request->input('correct_words');
$totalWords=$request->input('total_words');
       $passMark=$scheduledExam->examConfiguration->pass_mark;

        $result = Result::create([
            'bpid' => $scheduledExam->bpid,
            'total_marks' => $totalWords,
            'obtained_marks' => $correctWords,
            'status' => $correctWords >= $passMark ? 'passed' : 'failed',
            'exam_id' => $scheduledExam->examConfiguration->exam_id,
            'exam_config_id' => $scheduledExam->examConfiguration->id,
        ]);
        $scheduledExam->update(['status'=>'completed']);
        $scheduledExam->update(['submission_time' => now()]);
        return view('exam.result-page', compact('result'));
    }
}
