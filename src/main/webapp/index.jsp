<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: 一别半笙
  Date: 2019/8/6
  Time: 14:21
  To change this template use File | Settings | File Templates.
  添加主界面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>

    <!-- Themefisher Icon font -->
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <!-- bootstrap.min css -->
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css"/>

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="css/style.css">

</head>
<body id="body">

<!-- Start Top Header Bar -->
<section class="top-header">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-xs-12 col-sm-4">
                <div class="contact-number">
                    <i class="tf-ion-ios-telephone"></i>
                    <span>0129- 12323-1213123</span>
                </div>
            </div>
            <div class="col-md-4 col-xs-12 col-sm-4">
                <!-- Site Logo -->
                <div class="logo text-center">
                    <a href="${pageContext.request.contextPath}/">
                        <!-- replace logo here -->
                        <svg width="320px" height="40px" viewBox="-55 0 320 30" version="1.1"
                             xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink">
                            <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" font-size="30"
                               font-family="AustinBold, Austin"
                               font-weight="bold">
                                <g id="Group" transform="translate(-99.000000, -297.000000)" fill="#000000">
                                    <text id="AVIATO">
                                        <tspan x="89.94" y="325">Hand To Hand</tspan>
                                    </text>
                                </g>
                            </g>
                        </svg>
                    </a>
                </div>
            </div>
            <div class="col-md-4 col-xs-12 col-sm-4">
                <!-- Cart -->
                <ul class="top-menu text-right list-inline">

                    <!-- Search -->
                    <li class="search " onclick="toSearch();">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i
                                class="tf-ion-ios-search-strong"></i>搜索
                        </a>
                    </li>
                    <!-- / Search -->
                    <!-- usermenu -->
                    <s:if test="#session.loginUser != null">
                        <li class="dropdown dropdown-slide">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                               data-delay="350" role="button"
                               aria-haspopup="true" aria-expanded="false"><s:property
                                    value="#session.loginUser.nickname"/> &nbsp;
                                <span class="tf-ion-ios-arrow-down"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="toUserDetails.action">个人中心</a></li>
                                <s:if test="#session.loginUser.auth != 0">
                                <li><a href="toadmin.action">后台管理</a></li>
                                </s:if>
                                <li><a href="toMyissue">我发布的</a></li>
                                <li><a href="tofavorite.action">收藏夹</a></li>
                                <li><a href="#">联系我们</a></li>
                                <li><a href="exit.action">退出</a></li>
                            </ul>

                        </li>
                        <!-- / usernemu -->
                    </s:if>
                    <s:else>
                        <!-- login -->
                        <li>
                            <a href="tologin.action" class="">{ 登录</a>
                        </li>
                        <!-- / login -->
                        |
                        <!-- register -->
                        <li class="dropdown dropdown-slide">
                            <a href="toregister.action" class="dropdown-toggle">注册 }</a>
                        </li>
                        <!-- / register -->
                    </s:else>

                </ul><!-- / .nav .navbar-nav .navbar-right -->
            </div>
        </div>
    </div>
</section><!-- End Top Header Bar -->


<!-- Main Menu Section -->
<section class="menu">
    <nav class="navbar navigation">
        <div class="container">
            <div class="navbar-header">
                <h2 class="menu-title">Main Menu</h2>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                        aria-expanded="false"
                        aria-controls="navbar">

                </button>

            </div><!-- / .navbar-header -->

            <!-- Navbar Links -->
            <div id="navbar" class="navbar-collapse collapse text-center">
                <ul class="nav navbar-nav">

                    <!-- Home -->
                    <li class="dropdown " style="border-bottom: 2px solid red;">
                        <a href="${pageContext.request.contextPath}/">我要购买</a>
                    </li><!-- / Home -->


                    <!-- Elements -->
                    <li>
                        <a href="toIssue.action">我要发布</a>
                    </li><!-- / Elements -->
                    <!-- Elements -->
                    <li>
                        <a href="toorderbuyer">已购买<span class="buy_span">0</span></a>

                    </li><!-- / Elements -->
                    <!-- Pages -->
                    <li>
                        <a href="toorderseller">已卖出<span class="sell_span">0</span></a>

                    </li><!-- / Pages -->


                    <li class="dropdown cart-nav dropdown-slide" onclick="toCart();">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i
                                class="tf-ion-android-cart"></i>购物车</a>
                        <div class="dropdown-menu cart-dropdown">

                            <div class="cart-summary">
                                <span>总金额</span>
                                <span class="total-price">$0</span>
                            </div>
                            <ul class="text-center cart-buttons">
                                <li><a href="javascript:void(0)" class="btn btn-small createOrderButton">结算</a></li>
                                <li><a href="javascript:void(0)" class="btn btn-small btn-solid-border clearItem">清空</a>
                                </li>
                            </ul>
                        </div>

                    </li>


                </ul><!-- / .nav .navbar-nav -->

            </div>
            <!--/.navbar-collapse -->
        </div><!-- / .container -->
    </nav>
</section>


<div class="home-slider" style="height: 70%">
    <div>
        <div class="slider-item dark-bg" style="background-image:url('images/slider/slider-1.jpg');">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="slide-inner text-left">
                            <h1>Welcome to "Hand To Hand"</h1>
                            <!-- 		<a href="" class="btn btn-main">Buy Now</a> -->
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div>
        <div class="slider-item white-bg" style="background-image:url('images/slider/slider-2.jpg')">
            <div class="container">
                <div class="slide-inner text-center">
                    <h1>Welcome to "Hand To Hand"</h1>
                    <!-- 	<a href="" class="btn btn-main">Buy Now</a> -->
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="slider-item dark-bg"
             style="background-image:url('images/slider/slider-3.jpg'); background-position:50%;background-repeat:no-repeat;">
            <div class="container">
                <div class="slide-inner text-left">
                    <h1>Welcome to "Hand To Hand"</h1>
                    <!-- 		<a href="" class="btn btn-main">Buy Now</a> -->
                </div>
            </div>
        </div>
    </div>
</div>


<section class="products section bg-gray" style="padding: 0px;">
    <div class="container" style="width: 1325px;">
        <div class="row">
            <div class="title text-center">
                <h2>商品列表</h2>
            </div>
        </div>
        <div class="row" style="margin:0 5%;" id="goodsList">
        </div>
    </div>
</section>

<!--
Start Call To Action
==================================== -->


<footer class="footer section text-center">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <ul class="social-media">
                    <li>
                        <a href="">
                            <i class="tf-ion-social-facebook"></i>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <i class="tf-ion-social-instagram"></i>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <i class="tf-ion-social-twitter"></i>
                        </a>
                    </li>
                    <li>
                        <a href="">
                            <i class="tf-ion-social-pinterest"></i>
                        </a>
                    </li>
                </ul>
                <ul class="footer-menu">
                    <li>
                        <a href="">CONTACT</a>
                    </li>
                    <li>
                        <a href="">SHIPPING</a>
                    </li>
                    <li>
                        <a href="">TERMS OF SERVICE</a>
                    </li>
                    <li>
                        <a href="">PRIVACY POLICY</a>
                    </li>
                </ul>

            </div>
        </div>
    </div>
</footer>


<!-- Main jQuery -->
<script src="jquery-1.11.3/jquery.min.js"></script>
<!-- Bootstrap 3.1 -->
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>

<!-- Slick Carousel -->
<script src="plugins/slick-carousel/slick/slick.min.js"></script>


<!-- Main Js File -->
<script src="js/script.js"></script>
<script src="js/cart.js"></script>
<script type="text/javascript">
    $(function () {
        var uid = "<s:property value="#session.loginUser.uid"/>";
        console.log(uid);
        $.ajax({
            url: "getCartInfo",
            type: "post",
            data: {"uid": uid},
            success: function (data) {
                $(".media").each(function () {
                    $(this).remove();
                });
                console.log(data);
                var messages = data.data.goods;
                console.log(messages);
                console.log($(".cart-dropdown"));
                if (data.status === "200") {
                    for (message of messages) {
                        var result = createItem(message);
                        console.log(result);
                        $(".cart-dropdown").prepend($(result));
                    }
                    getTotalPrice();
                }
            }
        });
    });
    $(function () {
        $.ajax({
            url: "toindex.action",
            type: "post",
            success: function (data) {
                console.log(data);
                var i = 0;
                for (goods of data) {
                    var html = createGoods(goods);
                    if(i % 6 === 0){
                        $("#goodsList").append("<div class=\"row\"> </div>");
                    }
                    $("#goodsList").children(":last").append($(html));
                    i++;
                }
            }

        })
    });
    function toSearch() {
        location.href="search.action?type=0";
    }
    $(function () {
        var uid = "<s:property value="#session.loginUser.uid"/>";
        $.ajax({
            url: "getSellNumber",
            type: "post",
            data: {"uid":uid},
            success: function(data){
                $(".sell_span").text(data);
            }
        });
        $.ajax({
            url: "getBuyNumber",
            type: "post",
            data: {"uid":uid},
            success: function(data){
                $(".buy_span").text(data);
            }
        });
    });
    function  getCartInfo() {
        var uid = "<s:property value="#session.loginUser.uid"/>";
        console.log(uid);
        $.ajax({
            url: "getCartInfo",
            type: "post",
            data: {"uid":uid},
            success: function (data) {
                $(".media").each(function () {
                    $(this).remove();
                });
                console.log(data);
                var messages = data.data.goods;
                console.log(messages);
                console.log($(".cart-dropdown"));
                if (data.status === "200"){
                    for (message of messages) {
                        var result = createItem(message);
                        console.log(result);
                        $(".cart-dropdown").prepend($(result));
                    }
                    getTotalPrice();
                }
            }
        });
    }
</script>
</body>
</html>
