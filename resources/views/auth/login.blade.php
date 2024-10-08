@extends('layouts.app')

@section('content')
    <section class="h-100" style="background-color: #e9ecef;">
        <div class="container-fluid h-100">
            <div class="row h-100 d-flex justify-content-center align-items-center">
                <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                    <div class="card shadow-lg" style="border-radius: 1rem;">
                        <div class="card-body p-5">
                            @if(session('errorMessage'))
                                <div class="alert alert-danger">
                                    {{ session('errorMessage') }}
                                </div>
                            @endif
                            @if(request()->query('examEnded'))
                                <div class="alert alert-danger">
                                    The exam has ended.
                                </div>
                            @endif

                            <h3 class="mb-4 text-center font-weight-bold" style="color: #007bff;">PLEASE LOGIN</h3>

                            <form action="{{ url('/login') }}" method="post">
                                @csrf
                                <div class="form-outline mb-4">
                                    <label for="bpid" class="form-label">BP ID:</label>
                                    <input type="text" class="form-control" name="bpid" id="bpid" placeholder="Enter your BPID" required>
                                </div>

                                <div class="form-outline mb-4">
                                    <label for="password" class="form-label">Exam Pin:</label>
                                    <input type="password" class="form-control" name="password" id="password" placeholder="Enter your exam Pin" required>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-success">Login</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white text-center py-3">
        <div class="container">
            <p class="mb-0">&copy; {{ date('Y') }} Nstu Developer Team. All Rights Reserved.</p>
        </div>
    </footer>

    <style>
        /* Custom styles to ensure proper spacing and fit */
        html, body {
            height: 100%; /* Make sure body and html take full height */
            margin: 0; /* Remove default margin */
        }

        .container-fluid {
            height: 100%; /* Make container take full height */
        }

        .card {
            border: none; /* Remove card border */
        }

        .alert {
            margin-bottom: 20px; /* Add margin to alerts */
        }

        h3 {
            font-size: 1.8rem; /* Increase heading size */
        }

        .form-control {
            height: calc(2.5em + .75rem + 2px); /* Increase input height */
        }
    </style>
@endsection
