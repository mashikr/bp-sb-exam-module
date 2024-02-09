@extends('layouts.app')
@section('content')
    <style>
        #timer {
            font-weight: bold;
            color: #333;
            font-size: 1.2rem;
        }

        #originalTextLabel,
        #typedTextLabel {
            font-weight: bold;
            color: #04476f;
        }

        .highlight-correct {
            background-color: #c3e6cb; /* Light green background */
        }

        .highlight-incorrect {
            background-color: #f5c6cb; /* Light red background */
        }

    </style>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Typing Test</h3>
                    </div>
                    <form id="testForm" action="{{url('/typing-test/check')}}" method="post">
                        @csrf
                    <div class="card-body p-4">
                        <input type="hidden" name="correct_words" id="correct-words">
                        <input type="hidden" name="total_words" id="total-words">
                        <div class="form-group mb-4">
                            <label  class="mb-2" id="originalTextLabel">Original Text</label>
                            <p id="originalText" class="text-muted mb-0">{{ $text->content }}</p>
                        </div>
                        <div class="form-group mb-4">
                            <label for="typedText" class="mb-2" id="typedTextLabel">Type Here</label>
                            <textarea class="form-control" id="typedText" rows="4" name="typed_text" placeholder="Start typing here..."></textarea>
                        </div>
                        <div class="text-center">
                            <button class="btn btn-success btn-lg" id="submitButton">Submit</button>
                        </div>

                        <div id="timer" class="mt-3 text-center"></div>
                        <div id="result" class="mt-4"></div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function() {
            let startTime = new Date();
            let endTime;


            // Function to highlight words based on correctness
            function highlightWords() {
                const typedText = $('#typedText').val().trim();
                const originalText = $('#originalText').text().trim();

                const typedWords = typedText.split(/\s+/); // Split by spaces
                const originalWords = originalText.split(/\s+/);

                let highlightedText = '';

                for (let i = 0; i < originalWords.length; i++) {
                    let word = originalWords[i];

                    if (i < typedWords.length) {
                        if(typedWords[i] !== undefined){

                            // Word has been completed
                            if (  typedWords[i] === word) {

                                word = `<span class="highlight-correct">${word}</span>`;

                            } else {

                                word = `<span class="highlight-incorrect">${word}</span>`;
                            }
                        }

                    }

                    highlightedText += word + ' ';
                }

                $('#originalText').html(highlightedText);
            }

            // Attach event listener for typing
            $('#typedText').on('keydown', function(event) {
                const keyPressed = event.key;

                if (keyPressed === ' ' || keyPressed === 'Enter') {

                    highlightWords();
                }


            });
            // Submit button click event
            $('#submitButton').on('click', function() {
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

                const correctWords = $('#originalText').find('.highlight-correct').length;
                highlightWords();
                $('#correct-words').val(correctWords);
                let  totalWords = $('#originalText').text().trim().split(/\s+/).length;
                $('#total-words').val(totalWords);

                $('#testForm').submit();



            }

            // Set the duration of the typing test in seconds
            const testDuration = 60;
            startTimer(testDuration);
        });
    </script>
@endsection
