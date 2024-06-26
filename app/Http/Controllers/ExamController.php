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

    private IqTestController $iqTestController;
    private TypingTestController $typingTestController;
    private ComputerTestController $computerTestController;
    private BasicComputerTestController $basicComputerTestController;

    public function __construct(IqTestController $iqTestController, TypingTestController $typingTestController,ComputerTestController $computerTestController,BasicComputerTestController $basicComputerTestController)
    {
        $this->iqTestController = $iqTestController;
        $this->typingTestController = $typingTestController;
        $this->computerTestController=$computerTestController;
        $this->basicComputerTestController=$basicComputerTestController;

    }

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
        $examType = $scheduledExam->examConfiguration->exam->type;
        if ($examType === 'mcq') {
            return $this->iqTestController->index($scheduledExam);
        }
        elseif ($examType === 'advanced_computer_test'){
           return $this->computerTestController->index($scheduledExam);
        }
        elseif ($examType==='basic_computer_test'){
            return $this->basicComputerTestController->index($scheduledExam);
        }


    }


}
