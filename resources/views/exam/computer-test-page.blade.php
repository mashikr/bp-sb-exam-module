{{--@extends('layouts.app')--}}

{{--@section('content')--}}
{{--    <h1> computer test page </h1>--}}
{{--    @dd($questionSet->questions);--}}

{{--@endsection--}}


@extends('layouts.app')

@section('content')
    @php
        $questions=$questionSet->questions;

    @endphp

    <style>

        h2 {
            font-size: 28px;
            color: #4caf50;
            margin: 30px 0;
        }


        #question-options label {
            user-select: none;
        }

        .short-answer-textarea {
            height: 100px;
            resize: vertical;
        }
        .true-false-answer:focus {
           outline: none;
        }
    </style>



    <form id="testForm" action="{{url('/exam/computer-test/submit-test')}}" method="post">
        @csrf

        <div class="container-xxl py-3 mb-5">

            <div class="container">

                <div id="globalTimer" class="text-center"
                     style="font-size: 18px; color: #e74c3c; margin-top: 20px;"></div>
                <hr>
                <!-- Navigation Buttons Section -->
                <div class="navigation-buttons text-center mb-4">
                    @foreach ($questions as $question)
                        <button type="button"
                                class="btn btn-outline-primary rounded-circle question-nav-btn"
                                data-question-index="{{ $loop->index }}">
                            {{ $loop->index + 1 }}
                        </button>
                    @endforeach
                </div>
                @foreach ($questions as $question)

                    <div class="questions" data-question-index="{{ $loop->index }}">

                        <div class=" question card card-body" id="question-body">
                            <div class=" bg-white">

                                <div class="d-flex flex-row align-items-center question-title bg-light p-3 justify-content-between">


                                    <h5><span class="text-primary me-2">Question <span
                                                id="question-no">{{$loop->index+1}}</span>.</span>
                                    </h5>
<h5>Total Marks : <span>{{$question->marks}}</span></h5>

                                </div>
                                <div class="container p-2">
                                    {!! $question->question_content  !!}
                                </div>
                                @if($question->question_type==='mcq')

                                    <div class="d-flex justify-content-between">
                                        <div class="mx-3" id="question-options">

                                            @for ($i = 1; $i <= 4; $i++)
                                                @if (!is_null($question["option$i"]))

                                                    <div class="p-2 mb-1" id="option"><input type="radio"
                                                                                             id="option{{$i}}"
                                                                                             name="answer[{{ $question->question_id }}]"
                                                                                             value="{{ $i}}"
                                                                                             class="answer-option">
                                                        <label
                                                            for="option{{$i}}">{{ $question["option$i"] }}</label></div>

                                                @endif
                                            @endfor

                                        </div>

                                    </div>
                                @endif


                            </div>


                        </div>
                        @if($question->question_type==='descriptive')
                            <div class="mt-3"><label for="summernote" style="font-size: 20px;" class="mb-2">Answer</label>
                                <textarea name="answer[{{ $question->question_id }}]" class="form-control "
                                          id="summernote" rows="2" ></textarea>
                            </div>
                        @endif

                        @if ($question->question_type === 'short_question')
                            <div class="mt-3">
                                <label for="answer{{ $question->question_id }}" style="font-size: 20px;" class="mb-2">Short Answer</label>
                                <textarea name="answer[{{ $question->question_id }}]" class="form-control short-answer-textarea"
                                          id="answer{{ $question->question_id }}" rows="2" ></textarea>
                            </div>
                        @endif
                        @if($question->question_type === 'true_false')
                            <div class="mt-3 row card m-1 py-3" >
                            <label  style="font-size: 20px;" class="mb-2" for="true-false_answer{{ $question->question_id }}">Answer </label>
                            <select id="true-false_answer{{ $question->question_id }}" name="answer[{{ $question->question_id }}]" class="col-md-4  btn btn-primary ms-2 true-false-answer" >
                                <option value="" selected disabled>Select true or false</option>
                                <option value="true">True</option>
                                <option value="false">False</option>
                            </select>
                            </div>
                        @endif
                        <div class="d-flex justify-content-end mt-5">

                            <div>
                                <!-- Display "Next" button for all questions except the last one -->
                                @if (!$loop->last)
                                    <button type="button" class="next-question btn btn-primary rounded-pill"
                                    >Next <i class="fas fa-arrow-right"></i></button>
                                @endif

                                <!-- Display "Submit" button for the last question after selecting a radio option -->
                                @if ($loop->last)
                                    <button type="submit" class="submit-test btn btn-success rounded-pill"
                                            style="display: none">Submit
                                        Test <i class="fas fa-arrow-right"></i>
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
        <!-- jQuery -->
    <!-- Bootstrap 4 -->
    <script src="{{asset('plugins/bootstrap/js/bootstrap.bundle.min.js')}}"></script>
    <!-- Summernote -->


    <!-- Summernote -->

    <script>
        $(document).ready(function () {


            let examEndTime = new Date("{{ $examConfiguration->date }} {{ $examConfiguration->end_time }}").getTime();
            console.log(examEndTime);

            let endTimeIntervalId;


            let questions = $('.questions');
            let navButtons = $('.question-nav-btn');
            let currentQuestionIndex = 0;

            // Hide all questions except the first one
            questions.hide();
            questions.eq(0).show(); // Show the first question only

            // Navigation button click logic
            navButtons.on('click', function () {
                let questionIndex = $(this).data('question-index');
                navigateToQuestion(questionIndex);
            });

            function navigateToQuestion(index) {
                // Hide all questions, show the selected one
                questions.hide();
                questions.eq(index).show();
                currentQuestionIndex = index;

                // Update navigation button styles
                updateNavButtonStyles();
            }


            function updateNavButtonStyles() {
                navButtons.removeClass('btn-primary btn-success').addClass('btn-outline-primary');

                // Highlight the current question's button
                navButtons.eq(currentQuestionIndex).addClass('btn-primary');

                // Mark answered questions' buttons as green
                let allAnswered = true; // Track if all questions are answered
                questions.each(function () {
                    let questionIndex = $(this).data('question-index');
                    if (checkIfAnswered($(this))) {
                        navButtons.eq(questionIndex).removeClass('btn-primary btn-outline-primary').addClass('btn-success');
                    } else {
                        allAnswered = false;
                    }
                });

                // Show the submit button if all questions are answered and on the last question
                if (allAnswered && currentQuestionIndex === questions.length - 1) {
                    $('.submit-test').show(); // Display the submit button
                } else {
                    $('.submit-test').hide(); // Hide it otherwise
                }
            }


            function checkIfAnswered(questionElement) {
                // Check for answered MCQs (radio buttons)
                if (questionElement.find('.answer-option:checked').length > 0) {
                    return true;
                }

                // Check for descriptive or short answers (textareas)
                if (questionElement.find('textarea').filter(function () {
                    return $(this).val().trim() !== '';
                }).length > 0) {
                    return true;
                }

                // Check for True/False (dropdowns)
                if (questionElement.find('.true-false-answer').filter(function () {
                    return $(this).val() !== null && $(this).val().trim() !== '';
                }).length > 0) {
                    return true;
                }

                return false;
            }

            // Detect when an answer is provided
            $(document).on('change input', '.answer-option, .true-false-answer, textarea', function () {
                updateNavButtonStyles();
            });




// Function to check and submit the form when the end_time arrives
            function checkEndTime() {
                let currentTime = new Date().getTime();
                let endTime = new Date(examEndTime).getTime();

                if (currentTime >= endTime) {
                    // If the current time is greater than or equal to the end time, submit the form
                    clearInterval(endTimeIntervalId); // Clear the interval
                    // submitForm();
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

            $(function() {
                // Summernote
                $('#summernote').summernote({
                    height: 110,
                    toolbar: [
                        ['style', ['bold', 'italic', 'underline', 'clear']],
                        ['font', ['superscript', 'subscript']],
                        ['fontsize', ['fontsize']],
                        ['color', ['forecolor', 'backcolor']],
                        ['para', ['ul', 'ol', 'paragraph']],
                        ['insert', ['picture']],
                        ['headings', ['style', 'paragraph', 'heading']],
                    ]
                });


            })

        });
    </script>
@endsection
