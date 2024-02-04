@extends('layouts.app')
@section('content')

<section class="" style="background-color: #508bfc;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100 mb-5">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card shadow-2-strong" style="border-radius: 0.5rem;">
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

                        <h3 class="mb-5 text-center">PLEASE LOGIN</h3>

                        <form action="{{url('/login')}}" method="post">
                            @csrf
                            <div class="form-outline mb-4">
                                <label for="bpid" class="form-label">BP ID:</label>
                                <input type="text" class="form-control" name="bpid" id="bpid"  placeholder="Enter your BPID" required>
                            </div>

                            <div class="form-outline mb-4 ">
                                <label for="mobile" class="form-label">Exam Pin:</label>
                                <input type="password" class="form-control" name="password" id="password"  placeholder="Enter your exam Pin" required>
                            </div>

                            <div class="d-grid">
                                <button type="submit"  class="btn btn-success"  >Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

@endsection
