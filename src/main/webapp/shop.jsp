<%--
  Created by IntelliJ IDEA.
  User: 陈芬
  Date: 2019/8/8
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css"/>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css"/>
    <link rel="stylesheet" type="text/css" href="css/myIssue.css"/>
    <script src="jquery-1.11.3/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="jquery-1.11.3/jquery.js"></script>
    <script src="plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="js/script.js"></script>
    <script src="js/cart.js"></script>

    <script type="text/javascript">
        function submit(gid, obj){
            let data = {"gid":gid};
            $.ajax({
                url: "addfavorite",
                type: "post",
                data: data,
                success: function (data) {
                    if("delete" === data.trim()) {
                        $(obj).html("<i class=\"fa fa-heart-o\" aria-hidden=\"true\"></i>");
                    } else {
                        $(obj).html("<span class=\"glyphicon glyphicon-heart\" style=\"color:#C40000;\"></span>");
                    }
                }
            });
        }
        $(function () {
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
        });
        function toSearch() {
            location.href="search.action?type=0";
        }
    </script>
</head>
<body>
<title>店内搜索页-<s:property value="user.nickname"/>-HandToHand</title>
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
                <div class="logo text-center">
                    <a href="${pageContext.request.contextPath}/">
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
                <ul class="top-menu text-right list-inline">
                    <li class="dropdown cart-nav dropdown-slide">
                        <a href="toCart.action" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i
                                class="tf-ion-android-cart"></i>购物车</a>
                        <div class="dropdown-menu cart-dropdown">
                            <div class="cart-summary">
                                <span>总金额</span>
                                <span class="total-price">$0</span>
                            </div>
                            <ul class="text-center cart-buttons">
                                <li><a href="javascript:void(0)" class="btn btn-small createOrderButton">结算</a></li>
                                <li><a href="javascript:void(0)" class="btn btn-small btn-solid-border clearItem">清空</a></li>
                            </ul>
                        </div>
                    </li>
                    <!-- Search -->
                    <li class="search " onclick="toSearch();">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i
                                class="tf-ion-ios-search-strong"></i>搜索
                        </a>
                    </li>
                    <!-- / Search -->
                </ul>
            </div>
        </div>
    </div>
</section>
<section class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <h1 class="page-name">
                        <s:property value="user.nickname"/>
                        <a href="towebsocket?uid=<s:property value="user.uid"/>"><img src="images/wangwang.png" title="联系卖家"></a>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                        <li class="active" style="cursor: pointer;"><a href="toUserDetails?uid=${user.uid}">查看基本信息</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>
<section>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <ol class="breadcrumb">
                        <li><a href="#">综合排序</a></li>
<%--                        <li class="active"><a>新品<i class="fa fa-arrow-down"></i></a></li>--%>
<%--                        <li><a>价格<i class="fa fa-arrow-down"></i></a></li>--%>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="products section">
    <div class="container">
        <div class="row">
            <div class="tab-content">
                <div id="onShelf" class="tab-pane fade in active">
                    <div id="product-div">
                        <s:iterator value="goodsList" var="goods">
                            <s:if test="#goods.status==0">
                                <s:set var="flag" value="true"/>
                                <figure>
                                    <img src="${goods.imgPath.split(",")[0]}"/>
                                    <div class="hide-div">
                                        <figcaption>
                                            <a href="toGoods?gid=${goods.gid}">
                                                <h5 style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden;font-size: 12px;"
                                                    title="${goods.name}">
                                                        ${goods.name}
                                                </h5>
                                            </a>
                                        </figcaption>
                                        <div>
                                            <div class="price" style="display: inline">
                                                ￥${goods.price}
                                            </div>
                                            <div style="display: inline;float: right;">
                                            <span style="font-size: 16px;">
                                                <a href="javascript:void(0);" onclick="submit('${goods.gid}',this)">
                                                    <s:iterator value="favoriteList" var="fa" status="count">
                                                        <s:if test="flag">
                                                            <s:if test="#goods.gid==#fa.gid">
                                                                <span class="glyphicon glyphicon-heart" style="color:#C40000;"></span>
                                                                <s:set var="flag" value="false"/>
                                                            </s:if>
                                                        </s:if>
                                                        <s:if test="flag">
                                                            <s:if test="#count.index==favoriteList.size()-1">
                                                                <i class="fa fa-heart-o" aria-hidden="true"></i>
                                                            </s:if>
                                                        </s:if>
                                                    </s:iterator>
                                                </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </figure>
                            </s:if>
                        </s:iterator>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<div style="text-align: center;">
    <ul class="pagination">
        <s:if test="pageCode>1">
            <li>
                <a href="toshop?pageCode=1&uid=${uid}">首页</a>
            </li>
            <li>
                <a href="toshop?pageCode=${pageCode-1}&uid=${uid}">&laquo;</a>
            </li>
        </s:if>
        <s:iterator var="i" begin="1" end="totalPage">
            <s:if test="#i==pageCode">
                <li class="active">
            </s:if>
            <s:else>
                <li>
            </s:else>
            <a href="toshop?pageCode=${i}&uid=${uid}">${i}</a>
            </li>
        </s:iterator>
        <s:if test="pageCode<totalPage">
            <li>
                <a href="toshop?pageCode=${pageCode+1}&uid=${uid}">&raquo;</a>
            </li>
            <li>
                <a href="toshop?pageCode=${totalPage}&uid=${uid}">末页</a>
            </li>
        </s:if>
    </ul>
</div>
<footer class="footer section text-center" style="margin-top: 5%;">
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
                <p class="copyright-text">Copyright &copy; 2019.Company name All rights reserved.<a target="_blank"
                                                                                                    href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
                </p>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
