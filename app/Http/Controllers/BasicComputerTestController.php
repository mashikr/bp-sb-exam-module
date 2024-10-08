<?php

namespace App\Http\Controllers;

use App\Models\BasicComputerTestQuestion;
use App\Models\ExamSchedule;
use App\Models\TypingTestQuestion;
use App\Models\BasicComputerTestResult;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class BasicComputerTestController extends Controller
{
    public function index($scheduledExam)
    {

        $questionSet = $scheduledExam->examConfiguration->questionSet;
        $numOfMCQQuestions = $questionSet->num_of_mcq;
        $numOfTrueFalseQuestions = $questionSet->num_of_true_false;
        $numOfTypingTestQuestions = $questionSet->num_of_true_false;

        // Fetch random MCQ questions from the database
        $mcqQuestions = BasicComputerTestQuestion::where('question_type', 'mcq')
            ->inRandomOrder()
            ->limit($numOfMCQQuestions)
            ->get();

        // Fetch random true/false questions from the database
        $trueFalseQuestions = BasicComputerTestQuestion::where('question_type', 'true_false')
            ->inRandomOrder()
            ->limit($numOfTrueFalseQuestions)
            ->get();

        // Fetch random Typing test questions from the database
        $typingTestQuestions = TypingTestQuestion::inRandomOrder()
            ->limit($numOfTypingTestQuestions)
            ->get();

        return view('exam.basic-computer-test-page', compact('questionSet', 'scheduledExam', 'mcqQuestions', 'trueFalseQuestions', 'typingTestQuestions'));
    }


    public function submitTest(Request $request)

    {
        $scheduledExam = \auth()->user();

        // Calculate MCQ and True/False scores
        $mcqScore = 0;
        $trueFalseScore = 0;
        $typingTestScore = 0;
        $defaultTypingTestScore = 10;

        // Get all MCQ questions
        $mcqQuestions = BasicComputerTestQuestion::whereIn('question_id', array_keys($request->input('answer', [])))->get();
        foreach ($mcqQuestions as $question) {
            $correctOption = $question->correct_answer;
            $selectedOption = $request->input('answer')[$question->question_id];
            if ($selectedOption == $correctOption) {
                $mcqScore += 1;
            }
        }

        // Get all True/False questions
        $trueFalseQuestions = BasicComputerTestQuestion::whereIn('question_id', array_keys($request->input('true_false_answer', [])))->get();
        foreach ($trueFalseQuestions as $question) {
            $correctAnswer = $question->correct_answer;
            $selectedAnswer = $request->input('true_false_answer')[$question->question_id];
            if ($selectedAnswer == $correctAnswer) {
                $trueFalseScore += 1;
            }
        }

        // Calculate Typing Test Score based on correctly typed words
        foreach ($request->input('typed_text', []) as $questionId => $typedText) {
            $typingTestQuestion = TypingTestQuestion::find($questionId);
            $originalText = $typingTestQuestion->content;

            // Split the texts into arrays of words
            $originalWords = explode(' ', $originalText);
            $typedWords = explode(' ', $typedText);

            // Count correctly typed words
            $correctlyTypedWords = 0;
            foreach ($originalWords as $index => $originalWord) {
                if (isset($typedWords[$index]) && $typedWords[$index] === $originalWord) {
                    $correctlyTypedWords += 1;
                }
            }

            $originalWordCount = count($originalWords);

            // Calculate score based on the formula: (correctly typed words / original words) * default score
            $typingTestScore += ($correctlyTypedWords / $originalWordCount) * $defaultTypingTestScore;
        }

        $totalScore = $mcqScore + $trueFalseScore + $typingTestScore;

        // Prepare the result data
        $resultData = [];

        foreach ($request->input('answer', []) as $questionId => $selectedOption) {
            $resultData['mcq'][$questionId] = $selectedOption;
        }

        foreach ($request->input('true_false_answer', []) as $questionId => $selectedAnswer) {
            $resultData['true_false'][$questionId] = $selectedAnswer;
        }

        foreach ($request->input('typed_text', []) as $questionId => $typedText) {
            $resultData['typing_test'][$questionId] = $typedText;
        }

        // Store the results
        $result = BasicComputerTestResult::create([
            'exam_schedule_id' => $scheduledExam->id,
            'mcq_score' => $mcqScore,
            'true_false_score' => $trueFalseScore,
            'typing_test_score'=>$typingTestScore,
            'total_score' => $totalScore,

            'result_data' => $resultData,
        ]);

        // Update scheduled exam status and submission time
        $scheduledExam->update(['status' => 'completed']);
        $scheduledExam->update(['submission_time' => now()]);

        return redirect()->route('basic-computer-test.result', $scheduledExam->id);
    }

    // Method to show the results
    public function showResult($examScheduleId)
    {
        $examSchedule = ExamSchedule::with(['examConfiguration.exam', 'member'])->findOrFail($examScheduleId);
        $result = BasicComputerTestResult::where('exam_schedule_id', $examScheduleId)->first();;

        $mcqQuestions = BasicComputerTestQuestion::whereIn('question_id', array_keys($result->result_data['mcq'] ?? []))->get();
        $trueFalseQuestions = BasicComputerTestQuestion::whereIn('question_id', array_keys($result->result_data['true_false'] ?? []))->get();
        $typingTestQuestions = TypingTestQuestion::whereIn('question_id', array_keys($result->result_data['typing_test'] ?? []))->get();


        return view('exam.basic-computer-test-result', compact('result', 'mcqQuestions', 'trueFalseQuestions', 'typingTestQuestions','examSchedule'));
    }
}
