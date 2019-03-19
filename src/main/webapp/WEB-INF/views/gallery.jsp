<!doctype html>
<%@page isELIgnored="false" pageEncoding="utf-8"%>
<%@ taglib prefix="pro" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Gallery--See the colorful world</title>
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
    <style>
        .h-hover:hover{

            color: #ffcb2a;
            background-color: #ffcb2a;

        }
    </style>
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
                                <li class="active">
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
<!-- trainer area start -->
<section class="trainer-area bg_black ptb--100" id="trainers">
    <div class="container">
        <div class="msc-title section-title">
            <span>Meet</span>
            <h2>Our Production</h2>
        </div>
        <div class="row">
            <script>
                function activator(v) {
                    if (v.className.indexOf('active') == -1) {
                        v.classList.add("active");
                    }else{
                        v.classList.remove("active");
                    }
                }
                function mouseover(v) {
                    v.classList.add("active");
                }
                function mouseout(v) {
                    v.classList.remove("active");
                }
            </script>
<c:forEach var="music"   items="${gallery}"   varStatus="status"  >
            <div class="col-lg-3 col-md-3" style="margin-top: 10px">
                <div class="single-trainer trainer_s_three">
                    <div class="thumb" style="width: 300px; height: 400px">
                        <img  src="${music.img_url}" alt="image" onclick=window.open('<pro:url value="/visitor?path=${music.file_url}"/>') >
                    </div>
                    <div class="content" style="height: 200px;width: 300px" >
                        <h4 class="h-hover" onclick=window.open('<pro:url value="/visitor?id=${music.id}"/>') style="display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 1;overflow: hidden; margin-right:20px">${music.title}</h4>
                        <p class="h-hover" onclick=window.open('<pro:url value="/visitor?id=${music.id}"/>') style="display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 3;overflow: hidden; margin-right:20px">${music.description}</p>
                        <ul class="social">
                            <li>
                                <a href="javascript:void(0)" onclick="activator(this)">
                                    <i class="fa fa-facebook">ollow</i> <i style="font-size: 10px;margin-left: 20px">LeesangHyuk</i>
                                </a>
                            </li>
                            <br>
                            <li>
                                <a href="javascript:void(0)" style="margin-left: 150px;font-size: 10px">
                                     ${music.datetime}
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
</c:forEach>

        </div>
    </div>
</section>
<!-- trainer area end -->

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
