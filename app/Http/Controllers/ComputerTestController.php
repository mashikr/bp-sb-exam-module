<?php

namespace App\Http\Controllers;

use App\Models\ComputerTestHistory;
use App\Models\ComputerTestQuestion;
use Illuminate\Http\Request;

class ComputerTestController extends Controller
{
    public function index($scheduledExam)
    {

        $questionSet = $scheduledExam->examConfiguration->questionSet;
        return view('exam.computer-test-page',compact('questionSet','scheduledExam'));
    }

    public function submitTest(Request $request){
        $scheduledExam = \auth()->user();

        foreach ($request->input('answer') as $questionId => $givenAnswer) {
            $marks=0;
            $question = ComputerTestQuestion::where('question_id', $questionId)->first();

            if ($question) {
                $correctAnswer = $question->correct_answer;

                if ($question->question_type === 'true_false' || $question->question_type === 'mcq') {
                    if ($givenAnswer == $correctAnswer) {
                        $marks = $question->marks;
                    }
                }
                // Use the ::create method to create a new record
                ComputerTestHistory::create([
                    'exam_schedule_id' => $scheduledExam->id,
                    'question_id' => $questionId,
                    'given_answer' => $givenAnswer,
                    'marks' => $marks,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
        $scheduledExam->update(['status'=>'completed']);
        $scheduledExam->update(['submission_time' => now()]);
        return view('exam.result-page');
    }
}
