@extends('layouts.app')
@section('content')
    <style>
        :root {
            --smaller: .75;
        }
        .container {
            color: #333;
            margin: 0 auto;
            text-align: center;
        }

        h1 {
            font-weight: normal;
            letter-spacing: .125rem;
            text-transform: uppercase;
        }

        li {
            display: inline-block;
            font-size: 1.5em;
            list-style-type: none;
            padding: 1em;
            text-transform: uppercase;
        }

        li span {
            display: block;
            font-size: 4.5rem;
        }

        .exam-details {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .exam-details p {
            margin: 0;
        }
        @media all and (max-width: 768px) {
            h1 {
                font-size: calc(1.5rem * var(--smaller));
            }

            li {
                font-size: calc(1.125rem * var(--smaller));
            }

            li span {
                font-size: calc(3.375rem * var(--smaller));
            }
        }
    </style>
    <div class="container-xxl py-4">

        <div class="container">
            <!-- progress -->
            <div class="card">
                <div class="card-body bg-light ">
                    <div class="row">
                        <div class="col-md-12 text-center mb-2 mb-md-0 d-flex flex-column justify-content-center align-items-center">
                            <h1 id="headline">{{ $scheduledExam->examConfiguration->exam->exam_name }}</h1>
                            <div class="exam-details">

                                <p class="lead">Total Questions: {{ $scheduledExam->examConfiguration->total_questions }}</p>
                            </div>
                            <div id="countdown">
                                <h2 id="countdownLabel">Exam will start in: </h2>
                                <ul>
                                    <li><span id="days"></span>days</li>
                                    <li><span id="hours"></span>Hours</li>
                                    <li><span id="minutes"></span>Minutes</li>
                                    <li><span id="seconds"></span>Seconds</li>
                                </ul>
                            </div>
                            <div class="d-grid mt-2">
                                <a id="startExamButton" style="font-size: 28px;display: none" href="{{url('/exam/test-page/')}}" class="text-dark btn btn-outline-primary text-lg-center ">Take Test</a>
                                <a id="examCompletedButton" style="font-size: 28px;display: none" href="#" class="text-dark btn btn-outline-success text-lg-center ">Exam Completed</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @php
        $examConfiguration = $scheduledExam->examConfiguration;
    @endphp

    <script>
        $(document).ready(function () {
let examStatus="{{$scheduledExam->status}}";
            let examStartTime = new Date("{{ $examConfiguration->date }} {{ $examConfiguration->start_time }}").getTime();
            let examEndTime = new Date("{{ $examConfiguration->date }} {{ $examConfiguration->end_time }}").getTime();

            // Update the timer every second
            let timerInterval = setInterval(updateTimer, 1000);

            function updateTimer() {

                let now = new Date().getTime();
                let timeRemaining;

                if (now < examStartTime) {
                    timeRemaining = examStartTime - now;
                    $("#countdownLabel").html("Exam will start in:");
                } else if (now <= examEndTime) {
                    timeRemaining = examEndTime - now;

                    $("#countdownLabel").html("Exam wil end in:");
                    if(examStatus=='not started'){
                        $("#startExamButton").show();
                    }
                    else{
                        $("#examCompletedButton").show();
                    }


                } else {
                    // Exam has ended
                    $("#countdown").hide();
                    $("#countdownLabel").html("Exam has ended");
                    clearInterval(timerInterval);



                    $.ajax({
                        url: '{{ url('/logout') }}',
                        data: { examEnded: true },
                        method: 'GET',
                        success: function() {
                            window.location.href = '{{ url('/login-page?examEnded=true') }}';
                        },
                    });

                    return;
                }

                let days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
                let hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                let minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
                let seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

                $("#days").html(days);
                $("#hours").html(hours);
                $("#minutes").html(minutes);
                $("#seconds").html(seconds);


            }

            // Initial call to start the timer
            updateTimer();
        });
    </script>
@endsection
