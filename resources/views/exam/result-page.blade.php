<!-- result.blade.php -->

@extends('layouts.app')

@section('content')

    <style>
        .result-details {
            background-color: #e9ecef; /* Light background color for the result details section */
            padding: 10px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 23px;
            width: 50%;

        }

        .result-label {
            font-weight: bold;
            color: #495057;
        }

        .correct-answer {
            color: #28a745;
        }

        .wrong-answer {
            color: #dc3545;
        }
    </style>

    <div class="card w-100 w-lg-80 mx-auto p-2 m-2 rounded" style="border-radius: 15px;" id="result-div">
        <div class="card-body text-center">
            <!-- <i class="fas fa-check-circle fa-5x text-success"></i> -->
            <i class="fas fa-award fa-5x text-warning"></i>
            <h2 class="p-4 text-success">Test Successful!!</h2>

            <br>
            @isset($result)
            @if($result->exam->type=='mcq')
                <div class="result-details mx-auto my-3">
                    <h3 class="text-success">Your Score:<span >{{ $result->obtained_marks }}</span></h3>
                    <p class="result-label">Total Questions: <span class="result-value">{{ $result->total_marks }}</span></p>

                    <p class="result-label">Attempted Questions: <span class="result-value">{{ count(json_decode($result->result_details, true)['selected_answers']) }}</span></p>

                    <p class="result-label">Correct Answers: <span class="correct-answer">{{ $result->obtained_marks }}</span></p>

                    <p class="result-label">Wrong Answers: <span class="wrong-answer">{{ count(json_decode($result->result_details, true)['selected_answers']) - $result->obtained_marks }}</span></p>



                </div>


            @endif
            @endisset

            <a href="#" class="p-3 btn btn-success rounded-pill"><i class="fas fa-file-download"></i> সার্টিফিকেট ডাউনলোড করতে এখানে ক্লিক করুন</a>

        </div>
    </div>




@endsection
