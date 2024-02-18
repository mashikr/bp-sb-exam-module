<?php

namespace App\Http\Controllers;

use App\Models\McqQuestion;
use App\Models\Result;
use Illuminate\Http\Request;

class IqTestController extends Controller
{
    public function index($scheduledExam)
    {


        $totalQuestions = $scheduledExam->examConfiguration->total_questions;


        $assignedQuestions = McqQuestion::inRandomOrder()
            ->limit($totalQuestions)
            ->get();


        return view('exam.iq-test-page', compact('assignedQuestions', 'scheduledExam'));
}
    public function submitTest(Request $request)
    {
        $scheduledExam = \auth()->user();
        $examConfiguration = $scheduledExam->examConfiguration;
        $totalQuestions = $examConfiguration->total_questions;
        $passMark = $examConfiguration->pass_mark;
        $submittedAnswers = $request->input('answer', []);

        $correctAnswersCount = 0;

        // Iterate over each submitted answer
        foreach ($submittedAnswers as $questionId => $selectedAnswer) {

            $correctAnswer = McqQuestion::where('question_id', $questionId)->first()->correct_option;


            if ($selectedAnswer == $correctAnswer) {
                $correctAnswersCount++;
            }
        }

        $result = Result::create([
            'bpid' => $scheduledExam->bpid,
            'total_marks' => $totalQuestions,
            'obtained_marks' => $correctAnswersCount,
            'status' => $correctAnswersCount >= $passMark ? 'passed' : 'failed',
            'exam_id' => $examConfiguration->exam_id,
            'exam_config_id' => $examConfiguration->id,
        ]);
        $scheduledExam->update(['status'=>'completed']);
        $scheduledExam->update(['submission_time' => now()]);
        return view('exam.result-page', compact('result'));
    }
}
