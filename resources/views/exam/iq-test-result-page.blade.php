<!-- result.blade.php -->

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


        .result-table {
            width: 50%;
            margin: 0 auto 20px;
            border-collapse: collapse;
        }

        .result-table th, .result-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        .result-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .status-pass {
            color: green;
            font-weight: bold;
        }

        .status-fail {
            color: red;
            font-weight: bold;
        }
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
    <div class="container-fluid p-5">
        <h2 class="text-center mb-4 mt-5">Test Results</h2>

        <!-- Exam Details -->
        <div class="text-center mb-4">
            <h4 class="text-uppercase">{{ $examSchedule->examConfiguration->exam->exam_name }}</h4>
            <p><strong>Member Name:</strong> {{ $examSchedule->member->name_bn }} (BPID: {{ $examSchedule->member->bpid }})</p>
            <p><strong>Exam Date:</strong> {{ \Carbon\Carbon::parse($examSchedule->examConfiguration->exam->date)->format('F j, Y') ?? 'Exam Date' }}</p>
        </div>

        <!-- Result Summary Table -->
        <table class="result-table">
            <thead>
            <tr>
                <th>Total Marks</th>
                <th>Obtained Marks</th>
                <th>Pass Mark</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>{{ $result->total_marks }}</td>
                <td>{{ $result->obtained_marks }}</td>
                <td>{{$examSchedule->examConfiguration->pass_mark}}</td>
                <td class="{{ $result->status == 'passed' ? 'status-pass' : 'status-fail' }}">
                    {{ ucfirst($result->status) }}
                </td>
            </tr>
            </tbody>
        </table>

        <!-- Print and Download Buttons -->
        <div class="text-center mb-4">
            <button class="btn btn-primary me-2" onclick="window.print()">Print Results</button>
{{--            <button class="btn btn-secondary" id="downloadBtn">Download Results</button>--}}
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
        // Download button functionality
        // $('#downloadBtn').on('click', function() {
        //     const { jsPDF } = window.jspdf; // Access jsPDF
        //     const doc = new jsPDF();
        //     const resultsContent = $('.container').html(); // Get the results HTML content
        //
        //     // Sanitize the HTML content
        //     const sanitizedContent = DOMPurify.sanitize(resultsContent);
        //
        //     doc.html(sanitizedContent, {
        //         callback: function(doc) {
        //             doc.save('basic_computer_test_result.pdf'); // Download the PDF
        //         },
        //         x: 10,
        //         y: 10
        //     });
        // });
    });
</script>

