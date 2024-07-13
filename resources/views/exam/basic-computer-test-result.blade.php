@extends('layouts.app')

@section('content')
<style>
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
                            <p><strong>Original Text:</strong></p>
                            <p id="originalText{{ $index }}" class="text-muted mb-0 original-text">{{ $typingTestQuestion->content }}</p>
                            <p><strong>Typed Text:</strong></p>
                            <p id="typedText{{ $index }}" class="text-muted mb-0">{{ $result->result_data['typing_test'][$typingTestQuestion->question_id] }}</p>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</div>

@endsection

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(document).ready(function() {
        @foreach($typingTestQuestions as $index => $typingTestQuestion)
            processTypingTestQuestion({{ $index }});
        @endforeach

        function processTypingTestQuestion(index) {
            let originalText = $('#originalText' + index).text().trim();
            let typedText = $('#typedText' + index).text().trim();
            let originalWords = originalText.split(' ');
            let typedWords = typedText.split(' ');
            let highlightedText = '';

            for (let i = 0; i < originalWords.length; i++) {
                if (i < typedWords.length) {
                    if (typedWords[i] === originalWords[i]) {
                        highlightedText += '<span class="correct-answer">' + originalWords[i] + '</span>';
                    } else {
                        highlightedText += '<span class="incorrect-answer">' + originalWords[i] + '</span>';
                    }
                } else {
                    highlightedText += '<span class="incorrect-answer">' + originalWords[i] + '</span>';
                }
                highlightedText += ' ';
            }
            $('#typedText' + index).html(highlightedText.trim());
        }
    });
</script>
