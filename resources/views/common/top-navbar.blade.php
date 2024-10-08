
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top px-0 py-2">
    <a href="#" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <img style="height: 85px;width: 85px" src="{{asset("assets/image/police-logo.jpg")}}" alt="Logo" id="logo_main">
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-3">
            @if(auth()->user())<a href="{{url('/logout')}}" class="btn btn-danger py-4 px-lg-5 d-none d-lg-block ms-3">Logout<i class="fa fa-arrow-right ms-4"></i></a>
            @endif


        </div>

    </div>
</nav>
<!-- Navbar End -->
