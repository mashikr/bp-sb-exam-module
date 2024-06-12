<?php

namespace App\Http\Controllers;

use App\Models\BasicComputerTestQuestion;
use App\Models\TypingTestQuestion;
use Illuminate\Http\Request;

class BasicComputerTestController extends Controller
{
    public function index($scheduledExam)
    {

        $questionSet = $scheduledExam->examConfiguration->questionSet;
        $numOfMCQQuestions = $questionSet->num_of_mcq;
        $numOfTrueFalseQuestions = $questionSet->num_of_true_false;
        $numOfTypingTestQuestions=$questionSet->num_of_true_false;

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

        return view('exam.basic-computer-test-page',compact('questionSet','scheduledExam','mcqQuestions','trueFalseQuestions','typingTestQuestions'));
    }
}
