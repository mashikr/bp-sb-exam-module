@extends('layouts.app')
@section('content')
    <style>
        #timer {
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



        #typedText,
        #originalText{
            font-size: 25px;

        }

        .correct-letter {
            font-weight: bold;
            color: darkgreen;
        }

        .incorrect-letter {
            font-weight: bold;
           color: darkred;
        }
    </style>
    <div class="container mt-3">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Typing Test</h3>

                    </div>
                    <div id="timer" class="mt-3 text-center"></div>
                    <form id="testForm" action="{{url('/typing-test/check')}}" method="post">
                        @csrf
                        <div class="card-body py-2 px-4">

                            <input type="hidden" name="start_time" id="start_time">
                            <input type="hidden" name="original_text" value="{{ $text->content }}">
                            <div class="form-group mb-3">
                                <label class="mb-2" id="originalTextLabel">Original Text</label>
                                <p id="originalText" class="text-muted mb-0">{{ $text->content }}</p>
                            </div>
                            <div class="form-group mb-4">
                                <label for="typedText" class="mb-2" id="typedTextLabel">Type Here</label>
                                <textarea class="form-control" id="typedText" rows="4"
                                          name="typed_text" placeholder="Start typing here..."></textarea>
                            </div>
                            <div class="text-center">
                                <button class="btn btn-success btn-lg" id="submitButton">Submit</button>
                            </div>


                            <div id="result" class="mt-4"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            let startTime = new Date();
            $('#start_time').val(startTime.toISOString());
            let endTime;

            // Function to highlight letters based on correctness
            function highlightLetters() {
                const typedText = $('#typedText').val().trim();
                const originalText = $('#originalText').text().trim();

                let highlightedText = '';

                for (let i = 0; i < originalText.length; i++) {
                    let letter = originalText[i];

                    if (i < typedText.length) {
                        if (typedText[i] === letter) {
                            letter = `<span class="correct-letter">${letter}</span>`;
                        } else {
                            letter = `<span class="incorrect-letter">${letter}</span>`;
                        }
                    }

                    highlightedText += letter;
                }

                $('#originalText').html(highlightedText);
            }

            // Attach event listener for typing
            $('#typedText').on('input', function () {
                highlightLetters();
            });

            // Submit button click event
            $('#submitButton').on('click', function () {
                submitTypingTest();
            });

            function startTimer(duration) {
                endTime = new Date(startTime.getTime() + duration * 1000);

                const timerInterval = setInterval(() => {
                    const now = new Date();
                    const timeRemaining = Math.max(0, Math.ceil((endTime - now) / 1000));

                    $('#timer').text(formatTime(timeRemaining));

                    if (timeRemaining === 0) {
                        clearInterval(timerInterval);
                        $('#typedText').prop('readonly', true);
                        $('#submitButton').prop('disabled', true);
                        submitTypingTest();
                    }
                }, 1000);
            }

            function formatTime(seconds) {
                const minutes = Math.floor(seconds / 60);
                const remainingSeconds = seconds % 60;

                return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
            }

            function submitTypingTest() {
                const correctLetters = $('#originalText').find('.correct-letter').length;
                highlightLetters();

                // let totalWords = $('#originalText').text().trim().length;
                // $('#total-words').val(totalWords);

                $('#testForm').submit();
            }

            // Set the duration of the typing test in seconds
            const testDuration = {{$text->time_in_seconds}};
            startTimer(testDuration);
        });
    </script>
@endsection
