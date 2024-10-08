@extends('layouts.app') <!-- Extend your main layout -->

@section('content')
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center font-weight-bold bg-primary text-white" style="font-size: 1.5rem; padding: 1rem;">
                    Test Submission Confirmation
                </div>
                <div class="card-body text-center">
                    <h3 class="mb-4 font-weight-bold">Your answers have been successfully submitted!</h3>
                    <p class="lead mb-3">Thank you for completing the advanced computer test.</p>
                    <p class="h5 mb-3">Your answers will be reviewed by the examiner.</p>
                    <p class="h5 mb-4">You will be notified of your results soon.</p>
                </div>
            </div>
        </div>
    </div>
@endsection
