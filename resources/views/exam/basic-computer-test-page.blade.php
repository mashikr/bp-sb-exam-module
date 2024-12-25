@extends('layouts.app')

@section('content')

<style>
.previous-part,
.next-part {
    font-size: 18px;
    padding: 8px 20px;
    background-color: #1e285e;
    color: #ffffff;
    outline: none;
    border: none;

}

.previous-part:hover,
.next-part:hover {
    background-color: #007bff;

}

.previous-part:focus,
.next-part:focus {
    outline: none;
}

.timer {
    font-weight: bold;
    color: darkgreen;
    font-size: 1.4rem;
}

#originalTextLabel,
#typedTextLabel {
    font-size: 28px;
    font-weight: bold;
    color: #04476f;
}



.typed-text,
.original-text {
    font-size: 25px;

}
</style>

<form id="basicTestForm"
      action="{{url('/exam/basic-computer-test/submit')}}"
      method="post">
    @csrf

    <div class="container-xxl py-3 mb-5">
        <div class="container">
            <div id="globalTimer"
                 class="text-center"
                 style="font-size: 18px; color: #e74c3c; margin-top: 20px;"></div>
            <!-- MCQ Part -->
            <div id="mcqPart"
                 class="test-part">
                <h2 class="text-center">Part A: Multiple Choice Questions</h2>
                <div class="container-xl py-3 mb-5">
                    <!-- Navigation Buttons -->
                    <div id="mcq-navigation" class="d-flex justify-content-center mb-3">
                        @foreach ($mcqQuestions as $question)
                            <button type="button"
                                    class="btn btn-outline-primary  rounded-circle mx-1 question-nav-btn"
                                    data-question-index="{{ $loop->index }}">
                                {{ $loop->index + 1 }}
                            </button>
                        @endforeach
                    </div>
                    <div class="container ">

                        <hr>
                        @php
                        $counter = 0;
                        @endphp

                        @foreach ($mcqQuestions as $question)

                        <div class="questions"
                             data-question-index="{{ $loop->index }}">

                            <div class=" question card card-body"
                                 id="question-body">
                                <div class=" bg-white">

                                    <div class="d-flex flex-row align-items-center question-title bg-light p-3">


                                        <h5><span class="text-primary me-2">Question <span
                                                      id="question-no">{{$loop->index+1}}</span>.</span> <span
                                                  class="ml-2"
                                                  id="question-title">{{ $question->question_content }}</span>
                                        </h5>


                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div class="mx-3"
                                             id="question-options">

                                            @for ($i = 1; $i <= 6;$i++)
                                               @if(!is_null($question["option$i"]))
                                               @php
                                               $counter++;
                                               //Incremen counter
                                               $optionId="option_".$loop->index . "_" . $counter;
                                                @endphp
                                                <div class="p-2 mb-1">
                                                    <input type="radio"
                                                           id="{{ $optionId }}"
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
                                    @if($loop->index !== 0)
                                    <button type="button"
                                            class="previous-question btn btn-primary rounded-pill mx-2">
                                        <i class="fas fa-arrow-left"></i> Previous
                                    </button>
                                    @endif

                                    <!-- Display "Next" button for all questions except the last one -->
                                    @if (!$loop->last)
                                    <button type="button"
                                            class="next-question btn btn-primary rounded-pill mx-2">
                                        Next <i class="fas fa-arrow-right"></i>
                                    </button>
                                    @endif

                                    {{-- <!-- Display "Submit" button for the last question after selecting a radio option -->--}}
                                    {{-- @if ($loop->last)--}}
                                    {{-- <button type="submit" class="submit-test btn btn-success rounded-pill mx-2" >--}}
                                    {{-- Submit Test <i class="fas fa-arrow-right"></i>--}}
                                    {{-- </button>--}}
                                    {{-- @endif--}}
                                </div>

                            </div>


                        </div>
                        @endforeach
                    </div>
                </div>
                <div class="d-flex justify-content-between mt-3 px-4">

                    <button type="button"
                            class="next-part btn btn-primary rounded-pill">Move to Part B <i
                           class="fas fa-arrow-right"></i></button>
                </div>
            </div>

            <!-- True/False Part -->
            <div id="trueFalsePart"
                 class="test-part"
                 style="display: none;">
                <h2 class="text-center">Part B: True/False</h2>
                <div class="container-xl py-3 mb-5">
                    <div class="d-flex justify-content-center mb-3" id="trueFalseNav">
                        @foreach ($trueFalseQuestions as $question)
                            <button type="button"
                                    class="btn btn-outline-primary rounded-circle mx-1 true-false-nav-btn"
                                    data-question-index="{{ $loop->index }}">
                                {{ $loop->index + 1 }}
                            </button>
                        @endforeach
                    </div>

                    <div class="container">


                        <hr>

                        @foreach ($trueFalseQuestions as $question)

                        <div class="true-false-questions"
                             data-question-index="{{ $loop->index }}">

                            <div class=" card card-body"
                                 id="question-body">
                                <div class=" bg-white">

                                    <div
                                         class="d-flex flex-row align-items-center question-title bg-light p-3 justify-content-between">


                                        <h5><span class="text-primary me-2">Question <span
                                                      id="question-no">{{$loop->index+1}}</span>.</span>
                                        </h5>


                                    </div>
                                    <div class="container p-2">
                                        {!! $question->question_content !!}
                                    </div>
                                </div>
                            </div>

                            <div class="mt-3 row card m-1 py-3">
                                <label style="font-size: 20px;"
                                       class="mb-2"
                                       for="true-false_answer{{ $question->question_id }}">Answer </label>
                                <select id="true-false_answer{{ $question->question_id }}"
                                        data-question-index="{{ $loop->index }}"
                                name="true_false_answer[{{ $question->question_id }}]"
                                class="col-md-4 btn btn-primary ms-2 true-false-answer">
                                <option value="" selected disabled>Select true or false</option>
                                <option value="true">True</option>
                                <option value="false">False</option>
                                </select>

                            </div>
                            <div class="d-flex justify-content-end mt-5">


                                @if ($loop->index !== 0)
                                <button type="button"
                                        class="previous-true-false-question btn btn-primary rounded-pill mx-2">
                                    <i class="fas fa-arrow-left"></i> Previous
                                </button>
                                @endif
                                <!-- Display "Next" button for all questions except the last one -->
                                @if (!$loop->last)
                                <button type="button"
                                        class="next-true-false-question btn btn-primary rounded-pill">Next <i
                                       class="fas fa-arrow-right"></i></button>
                                @endif



                            </div>

                        </div>
                        @endforeach
                    </div>
                </div>
                <div class="d-flex justify-content-between mt-3 px-4">
                    <button type="button"
                            class="previous-part btn btn-primary rounded-pill">Move to Part A <i
                           class="fas fa-arrow-left"></i></button>
                    <button type="button"
                            class="next-part btn btn-primary rounded-pill">Move to Part C <i
                           class="fas fa-arrow-right"></i></button>
                </div>
            </div>

            <!-- Typing Test Part -->
               <!-- Typing Test Part -->
               <div id="typingTestPart"
                 class="test-part"
                 style="display: none;">
                <h2 class="text-center">Part C: Typing Test</h2>
                <div class="container-xl py-3 mb-5">
                    <div class="container">
                        <hr>
                        <div class="typing-test-question-container">
                            @foreach($typingTestQuestions as $index => $typingTestQuestion)
                            <div class="typing-test-question container mt-3"
                                 data-question-index="{{ $index }}">
                                <div class="row justify-content-center">
                                    <div class="col-md-10">
                                        <div class="card shadow">
                                            <div class="d-flex flex-row align-items-center question-title bg-light p-3">
                                                <h5><span class="text-primary me-2 text-center">Question
                                                        {{ $loop->index + 1 }}</span></h5>
                                            </div>
                                            <div id="timer{{ $index }}"
                                                 class="mt-3 text-center timer"
                                                 data-time="{{ $typingTestQuestion->time_in_seconds }}"></div>
                                            <div class="card-body py-2 px-4">
                                                <input type="hidden"
                                                       name="start_time"
                                                       id="start_time">
                                                <input type="hidden"
                                                       name="original_text"
                                                       value="{{ $typingTestQuestion->content }}">
                                                <div class="form-group mb-3">
                                                    <label class="mb-2"
                                                           id="originalTextLabel">Original Text</label>
                                                    <p id="originalText{{$index}}"
                                                       class="text-muted mb-0 original-text">
                                                        {{ $typingTestQuestion->content }}
                                                    </p>
                                                </div>
                                                <div class="form-group mb-4">
                                                    <label for="typedText"
                                                           class="mb-2 typed-text"
                                                           id="typedTextLabel">Type Here</label>
                                                    <textarea class="form-control"
                                                              id="typedText{{$index}}"
                                                              rows="4"
                                                              name="typed_text[{{ $typingTestQuestion->question_id }}]"
                                                              placeholder="Start typing here..."></textarea>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-end mb-4 p-4">
                                                @if (!$loop->last)
                                                <button type="button"
                                                        class="next-typing-test-question btn btn-primary rounded-pill mx-2">Next
                                                        <i class="fas fa-arrow-right"></i></button>
                                                @endif
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            @endforeach
                        </div>
                        <div class="d-flex justify-content-between mt-3 px-4">
                            <button type="button"
                                    class="previous-part btn btn-primary rounded-pill">Move to Part B <i
                                   class="fas fa-arrow-left"></i></button>
                            <button type="submit"
                                    class="btn btn-success rounded-pill">Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
@php
$examConfiguration = $scheduledExam->examConfiguration;

@endphp



<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    let currentPart = 0;
    const parts = $('.test-part');

    // Show the first part initially
    showPart(currentPart);

    // Function to show a specific part
    function showPart(index) {
        parts.hide(); // Hide all parts
        $(parts[index]).show(); // Show the selected part
        if (index === 2) {
            // Start the timer for the first typing test question
            let firstQuestion = $('.typing-test-question:first');
            let duration = firstQuestion.find('.timer').data('time');
            startTimer(firstQuestion.index(), duration);
        }


    }

    // Handle next button click
    $('.next-part').click(function() {
        currentPart++;
        showPart(currentPart);


    });

    // Handle previous button click
    $('.previous-part').click(function() {
        currentPart--;
        showPart(currentPart);
    });


    ///golbal timer //////////


    let examEndTime = new Date("{{ $examConfiguration->date }} {{ $examConfiguration->end_time }}").getTime();
    console.log(examEndTime);

    let endTimeIntervalId;

    function submitForm() {
        $('#basicTestForm').submit();
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

    ///MCQ question part
    let questions = $('.questions');
    let currentQuestionIndex = 0;

    // Initially hide all questions except the first one
    questions.hide();
    questions.first().show();

    // Navigation for numbered buttons
    $('.question-nav-btn').on('click', function () {
        let questionIndex = $(this).data('question-index');
        showQuestion(questionIndex);
    });

    // Show a specific question
    function showQuestion(index) {
        questions.hide(); // Hide all questions
        questions.eq(index).show(); // Show the selected question
        currentQuestionIndex = index; // Update the current question index
    }

    // Next and Previous buttons
    $('.next-question').on('click', function () {
        if (currentQuestionIndex < questions.length - 1) {
            showQuestion(currentQuestionIndex + 1);
        }
    });

    $('.previous-question').on('click', function () {
        if (currentQuestionIndex > 0) {
            showQuestion(currentQuestionIndex - 1);
        }
    });

    // Handle question answer selection
    $('.answer-option').on('change', function() {
        let questionIndex = $(this).closest('.questions').data('question-index');
        // Highlight the corresponding navigation button as green
        $('.question-nav-btn').eq(questionIndex).removeClass('btn-outline-primary').addClass('btn-success');
    });

    /////True false questions//////

    // Variable to track the current True/False question index
    let currentTrueFalseIndex = 0;
    let answeredQuestions = []; // Array to keep track of answered questions

// Show the first True/False question initially
    $('.true-false-questions').hide();
    $('.true-false-questions').eq(currentTrueFalseIndex).show();

// Update navigation button highlighting
    function highlightNavButton(index) {
        $('.true-false-nav-btn').removeClass('btn-primary').addClass('btn-outline-primary');

        // If the question is answered, add the 'btn-success' class (green)
        if (answeredQuestions[index]) {
            $('.true-false-nav-btn').eq(index).removeClass('btn-outline-primary').addClass('btn-success');
        } else {
            $('.true-false-nav-btn').eq(index).removeClass('btn-success').addClass('btn-outline-primary');
        }
    }

// Highlight the first button initially
    highlightNavButton(currentTrueFalseIndex);

// Function to show a specific True/False question
    function showTrueFalseQuestion(index) {
        $('.true-false-questions').hide();
        $('.true-false-questions').eq(index).show();
        currentTrueFalseIndex = index;
        highlightNavButton(index);
    }

// Handle navigation button clicks
    $('.true-false-nav-btn').click(function () {
        const questionIndex = $(this).data('question-index');
        showTrueFalseQuestion(questionIndex);
    });

// Handle next button click for True/False questions
    $('.next-true-false-question').click(function () {
        if (currentTrueFalseIndex < $('.true-false-questions').length - 1) {
            showTrueFalseQuestion(currentTrueFalseIndex + 1);
        }
    });

// Handle previous button click for True/False questions
    $('.previous-true-false-question').click(function () {
        if (currentTrueFalseIndex > 0) {
            showTrueFalseQuestion(currentTrueFalseIndex - 1);
        }
    });

// Handle the answering of a True/False question
    $('.true-false-answer').change(function() {
        const questionIndex = $(this).data('question-index');

        // Mark the question as answered
        answeredQuestions[questionIndex] = true;

        // Highlight the button for this question as green (answered)
        highlightNavButton(questionIndex);
    });


    ///// Typing Test Questions




    // Hide all typing test questions except the first one
    $('.typing-test-question').not(':first').hide();

    // Function to start the timer for a typing test question
    function startTimer(index, duration) {
        let timerElement = $('#timer' + index);

        let minutes, seconds;

        let intervalId = setInterval(function() {
            minutes = parseInt(duration / 60, 10);
            seconds = parseInt(duration % 60, 10);

            // Display the remaining time
            timerElement.text('Time Remaining: ' + minutes + 'm ' + seconds + 's');

            if (--duration < 0) {
                // If the timer reaches 0, clear the interval and disable the textarea
                clearInterval(intervalId);
                disableTextarea(index);
            }
        }, 1000);
    }

    // Function to disable the textarea for a typing test question
    function disableTextarea(index) {
        $('#typedText' + index).prop('readonly', true);
    }

    // Function to show the next typing test question
    function showNextTypingTestQuestion() {
        let currentQuestion = $('.typing-test-question:visible');
        let nextQuestion = currentQuestion.next('.typing-test-question');

        // Stop the timer for the current question
        clearInterval(currentQuestion.data('intervalId'));

        // Hide the current question and show the next one
        currentQuestion.hide();
        nextQuestion.show();

        // Start the timer for the next question
        let duration = nextQuestion.find('.timer').data('time');
        startTimer(nextQuestion.index(), duration);
    }



    // Handle next button click for typing test questions
    $('.next-typing-test-question').click(function() {
        showNextTypingTestQuestion();
    });


    function highlightCurrentWord(index) {
        // Get the original text of the current question
        let originalText = $('#originalText' + index).text().trim();
        // Get the typed text from the textarea
        let typedText = $('#typedText' + index).val().trim();
        // Split both texts into arrays of words
        let originalWords = originalText.split(' ');
        let typedWords = typedText.split(' ');

        // Initialize variables for storing HTML content
        let highlightedText = '';

        // Iterate through each word in the original text
        for (let i = 0; i < originalWords.length; i++) {
            // Check if the word is being typed
            if (i < typedWords.length) {
                // If the word being typed matches the original word, highlight it in green
                if (typedWords[i] === originalWords[i]) {
                    highlightedText += '<span style="color: green; font-weight: bold">' + originalWords[i] +
                        '</span>';
                } else {
                    // If the word being typed does not match the original word, highlight it in red
                    highlightedText += '<span style="color: red; font-weight: bold">' + originalWords[i] +
                        '</span>';
                }
            } else {
                // If there are no more typed words, just append the original word
                highlightedText += originalWords[i];
            }
            // Add a space between words
            highlightedText += ' ';
        }

        // Update the original text with the highlighted version
        $('#originalText' + index).html(highlightedText);

        // Get the index of the current word being typed
        let currentWordIndex = typedWords.length - 1;

        // Highlight the current word in blue
        $('#originalText' + index + ' span').eq(currentWordIndex).css('color', 'blue');
        $('#originalText' + index + ' span').eq(currentWordIndex).css('fontWeight', 'bold');
    }

    // Attach keyup event handler to the textarea
    $('textarea').on('keyup', function() {
        // Get the index of the current typing test question
        let index = $(this).closest('.typing-test-question').index();
        // Highlight the current word
        highlightCurrentWord(index);
    });

    // Prevent copying of the original text
    $('.original-text').on('copy', function(e) {
        e.preventDefault();
    });


});
</script>
@endsection
