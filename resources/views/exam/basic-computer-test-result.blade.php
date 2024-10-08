@extends('layouts.app')

@section('content')
    <style>
    /* Print styles */
    @media print {
    button {
    display: none; /* Hide buttons when printing */
    }
    nav, .navbar { /* Adjust this selector to match your navbar class or ID */
    display: none; /* Hide the navigation bar when printing */
    }
    }

    .correct-answer {
        color: green;
        font-weight: bold;
    }

    .incorrect-answer {
        color: red;
        font-weight: bold;
        text-decoration: underline;
    }
    </style>
    <div class="container">
        <h2 class="text-center mb-4">Test Results</h2>
        <!-- Exam Details -->
        <div class="text-center mb-4">
            <h4 class="text-uppercase">{{ $examSchedule->examConfiguration->exam->exam_name  }}</h4>
            <p><strong>Member Name:</strong> {{ $examSchedule->member->name_bn }} (BPID: {{ $examSchedule->member->bpid }})</p>
            <p><strong>Exam Date:</strong> {{ \Carbon\Carbon::parse($examSchedule->examConfiguration->exam->date)->format('F j, Y') ?? 'Exam Date' }}</p>
        </div>


        <!-- Print and Download Buttons -->
        <div class="text-center mb-4">
            <button class="btn btn-primary me-2" onclick="window.print()">Print Results</button>
            <button class="btn btn-secondary" id="downloadBtn">Download Results</button>
        </div>

        <div class="row">
            <div class="col-md-12">
                <!-- MCQ Results -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>MCQ Results</h4>
                    </div>
                    <div class="card-body">
                        <p class="text-success font-weight-bold">Score: {{ $result->mcq_score }} / {{ $mcqQuestions->count() }}</p>
                        <p class="text-danger font-weight-bold">Total Wrong Answers: {{ $mcqQuestions->count() - $result->mcq_score }}</p>
                    </div>
                </div>

                <!-- True/False Results -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>True/False Results</h4>
                    </div>
                    <div class="card-body">
                        <p class="text-success font-weight-bold">Score: {{ $result->true_false_score }} / {{ $trueFalseQuestions->count() }}</p>
                        <p class="text-danger font-weight-bold">Total Wrong Answers: {{ $trueFalseQuestions->count() - $result->true_false_score }}</p>
                    </div>
                </div>

                <!-- Typing Test Results -->
                <div class="card">
                    <div class="card-header">
                        <h4>Typing Test Results</h4>
                    </div>
                    <div class="card-body">
                        @foreach($typingTestQuestions as $index => $typingTestQuestion)
                            <div class="mb-4">
                                <h5>Question {{ $index + 1 }}</h5>
                                <div class="border p-3 mb-2 bg-light">
                                    <p><strong>Original Text:</strong></p>
                                    <p id="originalText{{ $index }}" class="text-muted mb-0" style="font-size: 1.2rem;">{{ $typingTestQuestion->content }}</p>
                                </div>
                                <div class="border p-3 bg-white">
                                    <p><strong>Typed Text:</strong></p>
                                    <p id="typedText{{ $index }}" class="text-muted mb-0" style="font-size: 1.2rem;"></p>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
    </div>

@endsection


<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Include DOMPurify -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.3.1/purify.min.js"></script>
<!-- Include jsPDF -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<!-- Include html2canvas -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>


<script>
    $(document).ready(function() {
        // Iterate through each question index
        @foreach($typingTestQuestions as $index => $typingTestQuestion)
        // Wrap in an IIFE to create a new scope for each iteration
        (function(index) {
            let typedText = '{{ addslashes($result->result_data['typing_test'][$typingTestQuestion->question_id] ?? '') }}';
            processTypingTestQuestion(index, typedText);
        })({{ $index }});
        @endforeach

        function processTypingTestQuestion(index, typedText) {
            let originalText = $('#originalText' + index).text().trim();
            let originalWords = originalText.split(' ');
            let typedWords = typedText.trim().split(' ');
            let highlightedText = '';

            for (let i = 0; i < originalWords.length; i++) {
                if (i < typedWords.length) {
                    if (typedWords[i] === originalWords[i]) {
                        highlightedText += '<span class="correct-answer">' + typedWords[i] + '</span>'; // Highlight correct typed words
                    } else {
                        highlightedText += '<span class="incorrect-answer">' + typedWords[i] + '</span>'; // Highlight incorrect typed words
                    }
                } else {
                    highlightedText += '<span class="incorrect-answer">' + originalWords[i] + '</span>'; // Extra words not typed
                }
                highlightedText += ' ';
            }

            $('#typedText' + index).html(highlightedText.trim()); // Populate the paragraph with highlighted typed text
        }

        // Download button functionality
        $('#downloadBtn').on('click', function() {
            const { jsPDF } = window.jspdf; // Access jsPDF
            const doc = new jsPDF();
            const resultsContent = $('.container').html(); // Get the results HTML content

            // Sanitize the HTML content
            const sanitizedContent = DOMPurify.sanitize(resultsContent);

            doc.html(sanitizedContent, {
                callback: function(doc) {
                    doc.save('basic_computer_test_result.pdf'); // Download the PDF
                },
                x: 10,
                y: 10
            });
        });
    });
</script>
