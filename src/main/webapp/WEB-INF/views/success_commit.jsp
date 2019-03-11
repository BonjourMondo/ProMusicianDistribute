<!doctype html>
<%@page isELIgnored="false" pageEncoding="utf-8"%>
<%@ taglib prefix="pro" uri="http://www.springframework.org/tags" %>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Commition Success</title>
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
                                <li>
                                    <a   href="<pro:url value="/programmer"/>">Programmer</a>
                                </li>
                                <li>
                                    <a   href="<pro:url value="/musician"/>">Musician</a>
                                </li>
                                <li>
                                    <a   href="<pro:url value="/gallery"/>">Gallery</a>
                                </li>
                                <li>
                                    <a   href="#blog">blog</a>
                                </li>
                                <li>
                                    <a   href="#contact">Contact Us</a>
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
<!-- facts area start -->
<div class="facts-area bg_dark ptb--100">
    <div class="container">
        <div class="msc-title section-title">
            <span>yeah</span>
            <h2>Commition Success</h2>
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="fact-item">
                    <h3 class="counter">30</h3>
                    <p>Awards</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="fact-item">
                    <h3 class="counter">153</h3>
                    <p>Live Show</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="fact-item">
                    <h3 class="counter">21</h3>
                    <p>Releases</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="fact-item">
                    <h3 class="counter">946</h3>
                    <p>Fans</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- facts area end -->
<!-- gallery area start -->
<section class="gallery-area bg_black pt--100 pb--60" id="gallery">
    <div class="container">
        <h3 class="d-none">gallery</h3>
        <div class="gallery-masonary row" id="container">
            <div class="glry-item col-md-4">
                <a class="expand-img" href="<%=request.getContextPath()%>/assets/images/gallery/gallery-img1.jpg">
                    <img src="<%=request.getContextPath()%>/assets/images/gallery/gallery-img1.jpg" alt="image">
                </a>
            </div>
            <div class="glry-item col-md-4">
                <a class="expand-img" href="<%=request.getContextPath()%>/assets/images/gallery/gallery-img2.jpg">
                    <img src="<%=request.getContextPath()%>/assets/images/gallery/gallery-img2.jpg" alt="image">
                </a>
            </div>
            <div class="glry-item col-md-4">
                <a class="expand-img" href="<%=request.getContextPath()%>/assets/images/gallery/gallery-img3.jpg">
                    <img src="<%=request.getContextPath()%>/assets/images/gallery/gallery-img3.jpg" alt="image">
                </a>
            </div>
            <div class="glry-item col-md-4">
                <a class="expand-img" href="<%=request.getContextPath()%>/assets/images/gallery/gallery-img4.jpg">
                    <img src="<%=request.getContextPath()%>/assets/images/gallery/gallery-img4.jpg" alt="image">
                </a>
            </div>
            <div class="glry-item col-md-4">
                <a class="expand-img" href="<%=request.getContextPath()%>/assets/images/gallery/gallery-img4.jpg">
                    <img src="<%=request.getContextPath()%>/assets/images/gallery/gallery-img5.jpg" alt="image">
                </a>
            </div>
        </div>
    </div>
</section>
<!-- gallery area end -->
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
