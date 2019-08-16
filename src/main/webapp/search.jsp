<%--
  Created by IntelliJ IDEA.
  User: 陈芬
  Date: 2019/8/13
  Time: 8:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>搜索结果</title>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css"/>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/search.css"/>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="js/search.js"></script>
    <script src="js/script.js"></script>

    <script>

    </script>
</head>
<body>
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
        </div>
    </div>
</section><!-- End Top Header Bar -->

<section class="search-title">
    <div class="">
        <div class="search-top">
            <form action="" method="post" onsubmit="return searchSubmit()">
                <input hidden name="type" value="0">
                <div class="searchinput">
                    <input type="search" class="search" name="title" id="searchText" autocomplete="off"
                           value="<s:property value="jsonObject.data.title"/>"/>
                    <button type="submit" class="button"> 搜索</button>
                    <div class="col-sm-12" style="text-align: center">
                    </div>
                    <ul class="searchul">
                        <li>动漫</li>
                        <li>植物</li>
                        <li>美食</li>
                        <li>电器</li>
                    </ul>
                </div>
                <div class="col-sm-12">
                    <div class="search-body col-sm-6">
                        <span class="searchspan">价格区间：</span>
                        <input type="text" name="price1" class="pricepart" id="lowprice" value=""/> ——
                        <input type="text" name="price2" class="pricepart" id="highprice" value=""/>
                    </div>
                    <div class="col-sm-6 select">
                        <div class="select-box">
                            <span id="select">选择类型</span>
                            <ul class="ul">

                            </ul>
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</section>
<section class="products section bg-gray" style="padding: 0px;">
    <div class="container" style="width: 1325px;">
        <div class="row">
            <div class="title text-center">
                <h2>商品列表</h2>
            </div>
        </div>
        <div class="row" id="goodsList">
            <script>
                console.log(1);
            </script>
            <s:set var="flag" value="0"/>
            <s:iterator value="jsonObject.data.GoodsList" var="goods" status="st">
                <script type="text/javascript">
                    console.log("${goods.gid}");
                </script>
                <s:if test="st.index % 6 == 0">
                    <div class="row">
                    <s:set var="flag" value="1"/>
                </s:if>
                <div class="col-md-2">
                    <div class="product-item">
                        <div class="product-thumb"><img class="img-responsive"
                                                        src="${goods.imgPath.split(',')[0]}"
                                                        alt="product-img"
                                                        style="height: 197.1px">
                            <div class="preview-meta">
                                <ul>
                                    <li><span data-toggle="modal" data-target="#product-modal"
                                              onclick="toGoods('${goods.gid}/>')"><i
                                            class="tf-ion-ios-search-strong"></i></span></li>
                                    <li><a href="javascript:void(0)"
                                           onclick="addFavorite('${goods.gid}')"><i
                                            class="tf-ion-ios-heart"></i></a></li>
                                    <li><a href="javascript:void(0)"
                                           onclick="addCart(${goods.gid}')"><i
                                            class="tf-ion-android-cart"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="product-content"><h4><a
                                href="toGoods.action?gid=${goods.gid}">${goods.name}</a>
                        </h4>
                            <p class="price">$${goods.price}</p></div>
                    </div>
                </div>
                <s:if test="st.index % 6 == 5">
                    </div>
                    <s:set var="flag" value="0"/>
                </s:if>
            </s:iterator>
            <s:if test="flag == 1">
        </div>
        </s:if>
    </div>
    </div>
</section>
<div style="text-align: center;">
    <ul class="pagination">
        <li>
            <a href="javascript:void(0)" onclick="turnSearch(0)">首页</a>
        </li>
        <s:if test="jsonObject.data.page > 0">
            <li>
                <a href="javascript:void(0)" onclick="turnSearch('${jsonObject.data.page - 1} ')">&laquo;</a>
            </li>
        </s:if>
        <s:iterator begin="1" end="jsonObject.data.totalPage" var="i" status="st">
            <li>
                <a href="javascript:void(0)" ${st.index == jsonObject.data.page ? "style=\"pointer-events: none;\"" : ""}
                   onclick="turnSearch(${st.index})">${st.count}</a>
            </li>
        </s:iterator>
        <s:if test="jsonObject.data.page < jsonObject.data.totalPage - 1">
            <li>
                <a href="javascript:void(0)" onclick="turnSearch('${jsonObject.data.page + 1} ')">&raquo;</a>
            </li>
        </s:if>
        <li>
            <a href="javascript:void(0)" onclick="turnSearch(${jsonObject.data.totalPage - 1})">末页</a>
        </li>
    </ul>
</div>
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
</body>
</html>
