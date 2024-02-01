<?php

namespace App\Http\Controllers;

use App\Models\Exam;
use App\Models\ExamConfiguration;
use App\Models\ExamSchedule;
use App\Models\McqQuestion;
use App\Models\Member;
use App\Models\Question;
use App\Models\Result;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class ExamController extends Controller
{
//    public function showAllExams()
//    {
//
//            $user = \auth()->user();
//       $bpid=$user->bpid;
//
//        $examSchedules = ExamSchedule::where('bpid', $bpid)->get();
//
//        return view('exam.index', compact('examSchedules'));
//    }

    public function showExamPage()
    {

        $scheduledExam = auth()->user();
        $examConfiguration = $scheduledExam->examConfiguration;

        // Check if the current time is greater than or equal to the exam end time
        $currentTime = now();
        $examEndTime = $examConfiguration->date . ' ' . $examConfiguration->end_time;
        $examEndTime = new DateTime($examEndTime);

        if ($currentTime >= $examEndTime) {
            return redirect('/logout?examEnded=true');
        }



        return view('exam.exam-details-page', ['scheduledExam' => $scheduledExam]);
    }


    public function showTestPage()
    {
        $scheduledExam = \auth()->user();
        $totalQuestions = $scheduledExam->examConfiguration->total_questions;

        $assignedQuestions = McqQuestion::inRandomOrder()
            ->limit($totalQuestions)
            ->get();

        // Pass the $assignedQuestions and $member to your view
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

        $result['bpid'] = $scheduledExam->bpid;
        $result['total_marks'] = $totalQuestions;
        $result['obtained_marks'] = $correctAnswersCount;
        $result['status'] = $correctAnswersCount >= $passMark ? "passed" : "failed";
        $result['exam_id'] = $examConfiguration->exam_id;
        $result['exam_config_id'] = $examConfiguration->id;
        $result['exam_schedule_id']=$scheduledExam->id;
        Result::insert($result);
       $scheduledExam->update(['status'=>'completed']);
        return view('exam.result-page', compact('result'));
    }


}
