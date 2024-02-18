<?php

namespace App\Http\Controllers;

use App\Models\Result;
use App\Models\TypingTestQuestion;
use DateTime;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class TypingTestController extends Controller
{
    public function index()
    {
        $text = TypingTestQuestion::inRandomOrder()->first();

        return view('exam.typing-test-page', compact('text'));
    }

    /**
     * @throws Exception
     */
    public function check(Request $request)
    {
        $scheduledExam = \auth()->user();
        $originalText = $request->input('original_text');
        $typedText = $request->input('typed_text');
        $originalWords = str_word_count($originalText, 1);
        $typedWords = str_word_count($typedText, 1);
        $correctWords = 0;

        $startTime = new \DateTime($request->input('start_time'));
        $submissionTime = new \DateTime();

        // Calculate time difference in seconds
        $timeDifference = $submissionTime->getTimestamp() - $startTime->getTimestamp();

        $minLength = min(count($originalWords), count($typedWords));

        for ($i = 0; $i < $minLength; $i++) {
            if ($typedWords[$i] === $originalWords[$i]) {
                $correctWords++;
            }
        }

        $wpm = round(($correctWords / ($timeDifference / 60)),2);
        $accuracy=round(($correctWords/count($originalWords))*100,2);
        $resultDetails = [
            'wpm' => $wpm,
            'accuracy' => $accuracy,
        ];
        $result = Result::create([
            'bpid' => $scheduledExam->bpid,



            'exam_id' => $scheduledExam->examConfiguration->exam_id,
            'exam_config_id' => $scheduledExam->examConfiguration->id,
            'result_details'=>$resultDetails
        ]);
        $scheduledExam->update(['status' => 'completed']);
        $scheduledExam->update(['submission_time' => now()]);
        return view('exam.result-page', compact('result'));
    }
}
