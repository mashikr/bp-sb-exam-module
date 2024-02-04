
<!-- member-test.blade.php -->

@extends('layouts.app')

@section('content')

    <style>
        h2 {
            font-size: 28px;
            color: #4caf50;
            margin: 30px 0;
        }

        .timer {
            font-size: 28px;
            font-weight: bolder;
            color: #3490dc;
        }

        .timer-container {
            margin-top: 10px;
        }
    </style>





    <form id="testForm" action="{{ url('/exam/submit-test') }}" method="post">
        @csrf
        {{--        <input type="hidden" name="exam_id" value="{{$examId}}">--}}

        <div class="container-xxl py-3 mb-5">

            <div class="container">


                <div id="globalTimer" class="text-center" style="font-size: 18px; color: #e74c3c; margin-top: 20px;"></div>

                <hr>

                @foreach ($assignedQuestions as $question)


                    <div class="questions" data-question-index="{{ $loop->index }}">

                        <div class=" question card card-body" id="question-body">
                            <div class=" bg-white">

                                <div class="d-flex flex-row align-items-center question-title bg-light p-3">


                                    <h5><span class="text-primary me-2">Question <span id="question-no">{{$loop->index+1}}</span>.</span> <span class="ml-2" id="question-title">{{ $question->question }}</span></h5>


                                </div>
                                <div class="d-flex justify-content-between">
                                    <div class="mx-3" id="question-options">

                                        @for ($i = 1; $i <= 6; $i++)
                                            @if (!is_null($question["option$i"]))

                                                <div class="p-2 mb-1" id="option"><input type="radio" name="answer[{{ $question->question_id }}]" value="{{ $i}}" class="answer-option"> <span>{{ $question["option$i"] }} </span></div>


                                            @endif
                                        @endfor

                                    </div>

                                </div>
                            </div>
                            <div class="timer-container text-center">
                                <div class="timer" data-seconds={{$question->time_in_seconds}}></div>
                            </div>

                            <div class="d-flex justify-content-end mt-5">

                                <div>
                                    <!-- Display "Next" button for all questions except the last one -->
                                    @if (!$loop->last)
                                        <button type="button" class="next-question btn btn-primary rounded-pill" style="display: none;">Next <i class="fas fa-arrow-right"></i></button>
                                    @endif

                                    <!-- Display "Submit" button for the last question after selecting a radio option -->
                                    @if ($loop->last)
                                        <button type="submit" class="submit-test btn btn-success rounded-pill" style="display: none;">Submit Test <i class="fas fa-arrow-right"></i></button>
                                    @endif

                                </div>
                            </div>
                        </div>










                    </div>
                @endforeach
            </div>
        </div>
    </form>
    @php
        $examConfiguration = $scheduledExam->examConfiguration;

    @endphp

    <script>
        $(document).ready(function () {
            let examEndTime = new Date("{{ $examConfiguration->date }} {{ $examConfiguration->end_time }}").getTime();
            console.log(examEndTime);

            let endTimeIntervalId;


            let questions = $('.questions');
            console.log(questions);
            let currentQuestionIndex = 0;
            let intervalId;

            // Hide all questions except the first one
            questions.slice(1).hide();

            $('.answer-option').on('change', function () {
                // Show the "Next" button when an answer is selected
                questions.eq(currentQuestionIndex).find('.next-question').show();

                // If it's the last question and an answer is selected, show the "Submit Test" button
                if (currentQuestionIndex === questions.length - 1) {
                    $('.submit-test').show();
                }
            });

            $('.next-question').on('click', function () {
                clearInterval(intervalId); // Clear the previous timer

                showNextQuestion();
            });

            function showNextQuestion() {
                let currentQuestion = questions.eq(currentQuestionIndex);
                let nextQuestion = questions.eq(currentQuestionIndex + 1);

                // Validate answer (add your validation logic here)

                // Hide the current question and show the next one
                currentQuestion.hide();
                nextQuestion.show();

                // Update the current question index
                currentQuestionIndex++;

                // Hide the "Next" button for the last question
                if (currentQuestionIndex === questions.length - 1) {
                    $('.next-question').hide();
                }

                // Start the timer for the next question
                startTimer(nextQuestion.find('.timer'));
            }

            function startTimer(timerElement) {
                let seconds = timerElement.data('seconds');
                intervalId = setInterval(function () {
                    timerElement.text(seconds + 's');

                    if (seconds <= 0) {
                        clearInterval(intervalId);

                        // If it's the last question, submit the form
                        if (currentQuestionIndex === questions.length - 1) {
                            submitForm();
                        } else {
                            showNextQuestion();
                        }
                    }

                    seconds--;
                }, 1000);
            }

            function submitForm() {
                $('#testForm').submit();
            }

            // Start the timer for the first question
            startTimer($('.timer').first());
// Function to check and submit the form when the end_time arrives
            function checkEndTime() {
                let currentTime = new Date().getTime();
                let endTime = new Date(examEndTime).getTime();

                if (currentTime >= endTime) {
                    // If the current time is greater than or equal to the end time, submit the form
                    clearInterval(endTimeIntervalId); // Clear the interval
                    submitForm();
                } else {
                    // Calculate and display the remaining time
                    let remainingTime = Math.ceil((endTime - currentTime) / 1000); // in seconds
                    displayRemainingTime(remainingTime);
                }
            }
            endTimeIntervalId = setInterval(checkEndTime, 1000);

            // Function to display the remaining time
            function displayRemainingTime(remainingTime) {
                let hours = Math.floor(remainingTime / 3600);
                let minutes = Math.floor((remainingTime % 3600) / 60);
                let seconds = remainingTime % 60;

                $('#globalTimer').text('Exam will end in: ' + hours + 'h '+ minutes + 'm ' + seconds + 's');
            }

        });
    </script>
@endsection
