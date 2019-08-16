<%--
  Created by IntelliJ IDEA.
  User: 陈芬
  Date: 2019/8/7
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>收藏夹</title>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css"/>
    <link rel="stylesheet" href="css/favorite.css"/>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="js/script.js"></script>
    <script type="text/javascript" src="js/favorite.js"></script>
    <script type="text/javascript" src="js/cart.js"></script>
    <script type="text/javascript">
        function submit(gid) {
            window.location.href = "deletefavorite?gid=" + gid;
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
                    <!-- Search -->
                    <li class="search " onclick="toSearch();">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i
                                class="tf-ion-ios-search-strong"></i>搜索
                        </a>
                    </li>
                    <!-- / Search -->
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
                </ul><!-- / .nav .navbar-nav .navbar-right -->
            </div>
        </div>
    </div>
</section>
<section class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <h1 class="page-name">我的收藏</h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                        <li class="active">我的收藏</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="simpleSearchOutDiv"></div>
<div class="favorite">
    <div class="favorite_title">
        <ul class="nav nav-tabs">
            <li class="active all_goods">
                <a>全部宝贝 <span style="color: #f40;">${num}</span> </a>
            </li>
            <li class="dimmed_goods">
                <a>失效宝贝</a>
            </li>
            <li class="management" style="display: none">
                <img selectit="false" class="selectAllItem" src="images/cartNotSelected.png" onclick="allItemClick(this);">
                <span>全选</span>
                <a style="display: inline;cursor: pointer;" onclick="batchdeletel();"><span class="glyphicon glyphicon-trash"></span>删除</a>
            </li>
            <button class="batchManagement">批量管理</button>
        </ul>
    </div>
    <s:if test="goodsList.size()>0">
    <s:iterator value="goodsList" var="goods">
        <figure onmouseenter="mouseIn(this)" onmouseleave="mouseLeave(this)" class="figure1">
            <div class="img">
                <img src="${goods.imgPath.split(",")[0]}"/>
            </div>
            <a href="toGoods?gid=${goods.gid}">
                <figcaption style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden;font-size: 12px;">
                    <span title="${goods.name}">${goods.name}</span>
                </figcaption>
                <div class="info">
                    <span class="price">
                        <s:if test="#goods.status==2">
                            <strong>已下架</strong>
                        </s:if>
                        <s:else>
                            ￥<strong>${goods.price}</strong>
                        </s:else>
					</span>
                </div>
            </a>
            <div class="type" style="display: none;">
                <span class="glyphicon glyphicon-trash" gid="${goods.gid}"title="删除宝贝" style="top:3px;" onclick="deletel(this);"></span>
            </div>
            <div class="selOne" style="display: none">
                <img selectit="false" class="cartProductItemIfSelected" src="images/cartNotSelected.png" onclick="goodsTRClick(this)" gid="${goods.gid}"/>
            </div>
            <div class="shop" style="display: none;"><a href="toshop.action?uid=${goods.uid}">进入店铺</a></div>
        </figure>
        <s:if test="#goods.status==2">
            <figure onmouseenter="mouseIn(this)" onmouseleave="mouseLeave(this)" class="figure2" style="display: none;">
                <div class="img">
                    <img src="${goods.imgPath.split(",")[0]}"/>
                </div>
                <a href="toGoods?gid=${goods.gid}">
                    <figcaption style="white-space: nowrap;text-overflow:ellipsis;overflow: hidden;font-size: 12px;">
                        <span title="${goods.name}">${goods.name}</span>
                    </figcaption>
                    <div class="info">
                    <span class="price">
                        <s:if test="#goods.status==1"><strong>已删除</strong></s:if>
                        <s:else> <strong>已下架</strong></s:else>
					</span>
                    </div>
                </a>
                <div class="type" style="display: none;">
                <span class="glyphicon glyphicon-trash" title="删除宝贝" style="top:3px;" onclick="submit('${goods.gid}')"></span>
                </div>
                <div class="selOne">
                    <input type="checkbox" name="selone" value="${goods.gid}">
                </div>
                <div class="shop" style="display: none;"><a>进入店铺</a></div>
            </figure>
        </s:if>
    </s:iterator>
</div>
<div style="text-align: center;">
    <ul class="pagination">
        <s:if test="pageCode>1">
        <li>
            <a href="tofavorite?pageCode=1">首页</a>
        </li>
        <li>
            <a href="tofavorite?pageCode=${pageCode-1}">&laquo;</a>
        </li>
        </s:if>
        <s:iterator var="i" begin="1" end="totalPage">
            <s:if test="#i==pageCode">
            <li class="active">
            </s:if>
            <s:else>
            <li>
            </s:else>
               <a href="tofavorite?pageCode=${i}">${i}</a>
            </li>
        </s:iterator>
        <s:if test="pageCode<totalPage">
        <li>
            <a href="tofavorite?pageCode=${pageCode+1}">&raquo;</a>
        </li>
        <li>
            <a href="tofavorite?pageCode=${totalPage}">末页</a>
        </li>
        </s:if>
    </ul>
</div>
</s:if>
<s:else>
    <div id="productParamterPart-img">
        <img src="images\no.jpg" style="width: 280px;height:224px;margin-top:28px;"/>
        <span>暂无商品，去<a href="toIssue.action" style="color: orange;">主页</a>看看吧</span>
    </div>
</s:else>
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
                <p class="copyright-text">Copyright &copy; 2019.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
                </p>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
