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
        $resultDetails = []; // Array to store question IDs and selected answers

        // Iterate over each submitted answer
        foreach ($submittedAnswers as $questionId => $selectedAnswer) {
            $correctAnswer = McqQuestion::where('question_id', $questionId)->first()->correct_option;

            // Check if the selected answer is correct
            if ($selectedAnswer == $correctAnswer) {
                $correctAnswersCount++;
            }

            // Store question ID and selected answer in result_details array
            $resultDetails[$questionId] = $selectedAnswer;
        }

        // Create a result record
        $result = Result::create([
            'bpid' => $scheduledExam->bpid,
            'total_marks' => $totalQuestions,
            'obtained_marks' => $correctAnswersCount,
            'status' => $correctAnswersCount >= $passMark ? 'passed' : 'failed',
            'exam_id' => $examConfiguration->exam_id,
            'exam_config_id' => $examConfiguration->id,
            'result_details' => json_encode(["selected_answers" => $resultDetails]), // Wrap result details in an associative array
        ]);

        // Update scheduled exam status and submission time
        $scheduledExam->update(['status' => 'completed']);
        $scheduledExam->update(['submission_time' => now()]);

        return view('exam.result-page', compact('result'));
    }


}
