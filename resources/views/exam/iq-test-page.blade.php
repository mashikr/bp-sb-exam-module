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

        #question-options label {
            user-select: none;
        }
        .answered {
            background-color: #4caf50;
            color: #ffffff;
        }

    </style>





    <form id="testForm" action="{{ url('/exam/submit-test') }}" method="post">
        @csrf
        {{--        <input type="hidden" name="exam_id" value="{{$examId}}">--}}

        <div class="container-xxl py-3 mb-5">

            <div class="container ">
                <div class="question-navigation mt-5 d-flex justify-content-center align-items-center ">
                    @foreach ($assignedQuestions as $question)
                        <button type="button" class="navigate-to-question btn btn-outline-primary me-2 rounded-pill"
                                data-question-index="{{ $loop->index }}">{{ $loop->index + 1 }}</button>
                    @endforeach
                </div>


                <div id="globalTimer" class="text-center"
                     style="font-size: 18px; color: #e74c3c; margin-top: 20px;"></div>

                <hr>
                @php
                    $counter = 0; // Initialize counter variable
                @endphp

                @foreach ($assignedQuestions as $question)

                    <div class="questions" data-question-index="{{ $loop->index }}">

                        <div class=" question card card-body" id="question-body">
                            <div class=" bg-white">

                                <div class="d-flex flex-row align-items-center question-title bg-light p-3">


                                    <h5><span class="text-primary me-2">Question <span
                                                id="question-no">{{$loop->index+1}}</span>.</span> <span class="ml-2"
                                                                                                         id="question-title">{{ $question->question }}</span>
                                    </h5>


                                </div>
                                <div class="d-flex justify-content-between">
                                    <div class="mx-3" id="question-options">

                                        @for ($i = 1; $i <= 6; $i++)
                                            @if (!is_null($question["option$i"]))
                                                @php
                                                    $counter++; // Increment counter
                                                    $optionId = "option_" . $loop->index . "_" . $counter; // Generate unique ID for option
                                                @endphp
                                                <div class="p-2 mb-1" >
                                                    <input type="radio" id="{{ $optionId }}"
                                                           name="answer[{{ $question->question_id }}]"
                                                           value="{{ $i }}"
                                                           class="answer-option">
                                                    <label for="{{ $optionId }}">{{ $question["option$i"] }}</label>
                                                </div>
                                            @endif
                                        @endfor



                                    </div>

                                </div>
                            </div>



                            <div class="d-flex justify-content-center mt-5">

                                    <!-- Display "Previous" button for all questions except the first one -->
                                    @if ($loop->index !== 0)
                                        <button type="button" class="previous-question btn btn-primary rounded-pill mx-2">
                                            <i class="fas fa-arrow-left"></i> Previous
                                        </button>
                                    @endif

                                    <!-- Display "Next" button for all questions except the last one -->
                                    @if (!$loop->last)
                                        <button type="button" class="next-question btn btn-primary rounded-pill mx-2">
                                            Next <i class="fas fa-arrow-right"></i>
                                        </button>
                                    @endif

                                    <!-- Display "Submit" button for the last question after selecting a radio option -->
                                    @if ($loop->last)
                                        <button type="submit" class="submit-test btn btn-success rounded-pill mx-2" >
                                            Submit Test <i class="fas fa-arrow-right"></i>
                                        </button>
                                    @endif
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


            // Hide all questions except the first one
            questions.slice(1).hide();



            $('.next-question').on('click', function () {


                showNextQuestion();
            });

            function showNextQuestion() {
                let nextQuestion = questions.eq(currentQuestionIndex + 1);
                $('.questions').hide();
                nextQuestion.show();

                // Update the current question index
                currentQuestionIndex++;



            }

            $('.previous-question').on('click', function () {
                showPreviousQuestion();
            });

            function showPreviousQuestion() {
                let previousQuestion = questions.eq(currentQuestionIndex - 1);

                questions.hide();
                previousQuestion.show();

                // Update the current question index
                currentQuestionIndex--;

            }

            $(document).ready(function () {
                // Add event listener to navigation buttons
                $('.navigate-to-question').on('click', function () {
                    let questionIndex = $(this).data('question-index');
                    currentQuestionIndex=questionIndex;
                    showQuestion(questionIndex);
                });

                // Function to show a specific question
                function showQuestion(questionIndex) {
                    $('.questions').hide(); // Hide all questions
                    $('.questions[data-question-index="' + questionIndex + '"]').show(); // Show the selected question
                }
            });



            function submitForm() {
                $('#testForm').submit();
            }



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

                $('#globalTimer').text('Exam will end in: ' + hours + 'h ' + minutes + 'm ' + seconds + 's');
            }


            // Keep track of answered questions
            let answeredQuestions = [];

// Function to handle radio button change event
            $('.answer-option').on('change', function () {
                let questionIndex = $(this).closest('.questions').data('question-index');
                if (!answeredQuestions.includes(questionIndex)) {
                    answeredQuestions.push(questionIndex);
                }
                updateNavigationButtons();
            });

// Function to update navigation buttons based on answered questions
            function updateNavigationButtons() {
                $('.navigate-to-question').each(function () {
                    let questionIndex = $(this).data('question-index');
                    if (answeredQuestions.includes(questionIndex)) {
                        $(this).addClass('answered');
                    } else {
                        $(this).removeClass('answered');
                    }
                });
            }


        });
    </script>
@endsection
