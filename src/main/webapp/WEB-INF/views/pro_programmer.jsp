<%@ taglib prefix="pro" uri="http://www.springframework.org/tags" %>
<%@page isELIgnored="false" pageEncoding="utf-8"%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>ProGrammer--To Be an Artist</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- all css here -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/slicknav.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/swiper.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/zoomslider.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/typography.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/default-css.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive.css">
    <!-- modernizr css -->
    <script src="<%=request.getContextPath()%>/assets/js/vendor/modernizr-2.8.3.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- all css here -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/slicknav.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/swiper.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/zoomslider.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/typography.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/default-css.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive.css">
    <!-- modernizr css -->
    <script src="<%=request.getContextPath()%>/assets/js/vendor/modernizr-2.8.3.min.js"></script>
</head>


<body>
<!--[if lt IE 8]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->
<!-- preloader area start -->
<!---<div id="preloader">
	<div class="loader"></div>
</div>--->
<!-- prealoader area end -->
<!-- header area start -->
<header>
    <div class="header-area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-3">
                    <div class="logo">
                        <a href="<pro:url value="/"/>">
                            <img src="<%=request.getContextPath()%>/assets/images/icon/logo.png" alt="logo">
                        </a>
                    </div>
                </div>
                <div class="col-lg-9 d-none d-lg-block">
                    <div class="main-menu">
                        <nav id="nav_mobile_menu">
                            <ul id="navigation">
                                <li>
                                    <a   href="<pro:url value="/"/>">Home</a>
                                </li>
                                <li class="active">
                                    <a   href="<pro:url value="/programmer"/>">Programmer</a>
                                </li>
                                <li>
                                    <a   href="<pro:url value="/musician"/>">Musician</a>
                                </li>
                                <li>
                                    <a   href="<pro:url value="/gallery"/>">Gallery</a>
                                </li>
                                <li>
                                    <a href="#blog">blog</a>
                                </li>
                                <li>
                                    <a href="#contact">Contact Us</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-12 d-block d-lg-none">
                    <div id="mobile_menu"></div>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- header area end -->

<!-- feature blog area start -->
<section class="feature-blog bg_dark ptb--100" id="blog">
    <div class="container">
        <div class="msc-title section-title">
            <span>Read</span>
            <h2>our Syntactic introduction</h2>
        </div>
        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="single-blog">
                    <div class="blog-content">
                        <h2><a href="#">
                            This script language supports four operations of integers, supports variables, and some basic control statements.
                            <br>You don't need to use <em>int i = 0</em>, but <em>i = 0</em>. We default that it's an int type and we don't accept other types.
                            <br>Like java, semicolons are used at the end of sentences in this language; however, semicolons can also be omitted if they happen to change lines at the end of sentences
                        </a></h2>
                    </div>
                    <div class="blog-thumb">
                        <img src="<%=request.getContextPath()%>/assets/images/icon/logo.png" alt="">
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="single-blog">
                    <div class="blog-content">
                        <h2>
                            <a href="<pro:url value="/musician"/>">Here are some key words. And the special key word is rhy, which means a beat of a music.</a>
                        </h2>
                    </div>
                    <div class="blog-thumb">
                        <img src="<%=request.getContextPath()%>/assets/images/slider/syntax.png" alt="">
                        <a href="<pro:url value="/musician"/>" class="read-more">Practice Now
                            <i class="fa fa-long-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="single-blog">
                    <div class="blog-content">
                        <h2>
                            <a href="<pro:url value="/gallery"/>">Here are some fragments. To see more code, please click here.</a>
                        </h2>
                    </div>
                    <div class="blog-thumb">
                        <img src="<%=request.getContextPath()%>/assets/images/slider/grammer.png" alt="">
                        <a href="<pro:url value="/gallery"/>" class="read-more">Read More
                            <i class="fa fa-long-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- feature blog area end -->
<!-- jquery latest version -->
<script src="<%=request.getContextPath()%>/assets/js/vendor/jquery-2.2.4.min.js"></script>
<!-- bootstrap 4 js -->
<script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>
<!-- others plugins -->
<script src="<%=request.getContextPath()%>/assets/js/jquery.slicknav.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/counterup.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/waypoints.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/imagesloaded.pkgd.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/isotope.pkgd.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.magnific-popup.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/countdown.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/swiper.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/plugins.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.zoomslider.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.firefly.js"></script>
<!-- google map -->
<!---<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBO_5h890WNShs_YLGivCBfs2U89qXR-7Y&callback=initMap"></script>--->
<script src="<%=request.getContextPath()%>/assets/js/scripts.js"></script>
</body>

</html>
