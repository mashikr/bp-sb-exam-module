@extends('layouts.app')
@section('content')
    <!-- Service Start -->
    <div class="container-xxl py-4">
        <div class="container">
            <!-- progress -->
            <div class="card">
                <div class="card-body bg-light ">
                    <div class="row">
                        <div class="col-md-6 text-start mb-2 mb-md-0">
                            <strong>All Exams</strong>
                        </div>

                    </div>
                </div>
            </div>
            <br>


            <div class="row d-flex justify-content-center my-5">
                @foreach($examSchedules as $schedule)
            @php
                    $scheduledExam=$schedule->examConfiguration;

            @endphp
                    <div class="col-lg-4 col-sm-6 wow fadeInUp mt-3 mt-sm-0" data-wow-delay="0.3s">
                        <div class="service-item text-center border">
                            <div class="p-4">
                                <img src="{{asset('assets/image/iq-test.jpg')}}" alt="" width="100%" class="border">
                                <h5 class="p-4">{{$scheduledExam->exam->exam_name}}</h5>

                                <div class="d-grid mt-2">
                                    <a href="{{url('/exam/'.$scheduledExam->id)}}" class="text-dark btn btn-outline-primary">See details</a>
                                </div>
                            </div>
                        </div>
                    </div>
                @endforeach



            </div>
        </div>
    </div>
@endsection
<!-- Service End -->

