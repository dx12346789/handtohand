<%--
  Created by IntelliJ IDEA.
  User: 糖糖正
  Date: 2019/8/8
  Time: 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>我的发布</title>
    <!-- Mobile Specific Meta-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css"/>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script src="jquery-1.11.3/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="jquery-1.11.3/jquery.js"></script>

    <!--主-->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css" />

    <link rel="stylesheet" type="text/css" href="css/myIssue.css"/>
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
                        <svg width="320px" height="40px" viewBox="-55 0 320 30" version="1.1" xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink">
                            <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" font-size="30" font-family="AustinBold, Austin"
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
                    <li class="dropdown cart-nav dropdown-slide">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i class="tf-ion-android-cart"></i>购物车</a>
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

                    </li><!-- / Cart -->

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

<section class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <h1 class="page-name">我的发布</h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                        <li class="active">我的发布</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="products section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#onShelf">上架中 ${onShelf}</a>
                        </li>
                        <li>
                            <a data-toggle="tab" href="#removeShelf">已下架 ${removeShelf}</a>
                        </li>
                        <li>
                            <div class="toIssue-div">
                                <a href="toIssue.action">
                                    <i class="fa fa-plus-circle"></i>
                                    <span>去发布</span>
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="tab-content">
                    <div id="onShelf" class="tab-pane fade in active">
                        <div id="product-div">
                            <s:if test="goodsOnList.size()>0">
                           <s:iterator value="goodsOnList" var="goods">
                               <figure>
                                   <a href="toCheckUpGoods?gid=${goods.gid}">
                                        <img src="${goods.imgPath.split(",")[0]}"/>
                                        <div class="hide-div">
                                            <figcaption>
                                                <h5>${goods.name}</h5>
                                            </figcaption>
                                            <div>
                                                <div class="price">
                                                    ￥${goods.price}
                                                </div>
                                            </div>
                                        </div>
                                   </a>
                                <div class="preview-meta">
                                    <ul>
                                        <li>
                                            <a href="toUpdateGoods.action?gid=${goods.gid}"><i class="fa fa-pencil-square-o"></i></a>
                                        </li>
                                        <li>
                                            <a  data-toggle="modal" data-target="#upOrdown${goods.gid}" href="###"><i class="fa fa-level-down"></i></a>
                                        </li>
                                        <li>
                                            <a data-toggle="modal" data-target="#delete${goods.gid}" href="#"><i class="fa fa-trash-o"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </figure>
                           </s:iterator>
                            </s:if>
                            <s:else>
                            <div id="productParamterPart-img">
                                <img src="images\no.jpg" style="width: 280px;height:224px;margin-left:417px;margin-top:28px;"/>
                                <span>暂无商品，去<a href="toIssue.action" style="color: orange;">发布商品</a>吧</span>
                            </div>
                            </s:else>
                        </div>
                    </div>
                    <div id="removeShelf" class="tab-pane fade">
                        <div id="product-div-2">
                            <s:if test="goodsDownList.size()>0">
                            <s:iterator value="goodsDownList" var="goods">
                            <figure>
                                <a href="toCheckUpGoods?gid=${goods.gid}">
                                    <img src="${goods.imgPath.split(",")[0]}"/>
                                    <div class="hide-div">
                                        <figcaption>
                                            <h5>${goods.name}</h5>
                                        </figcaption>
                                        <div>
                                            <div class="price">
                                                ￥${goods.price}
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <div class="preview-meta">
                                    <ul>
                                        <li>
                                            <a href="#" data-toggle="modal" data-target="#No${goods.gid}">
                                                <i class="fa fa-pencil-square-o" ></i>
                                            </a>
                                        </li>
                                        <li>
                                            <a data-toggle="modal" data-target="#upOrdown${goods.gid}" href="###"><i class="fa fa-level-up"></i></a>
                                        </li>
                                        <li>
                                            <a data-toggle="modal" data-target="#delete${goods.gid}" href="#"><i class="fa fa-trash-o"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </figure>
                            </s:iterator>
                            </s:if>
                            <s:else>
                            <div id="productParamterPart-img">
                                <img src="images\no.jpg" style="width: 280px;height:224px;margin-left:417px;margin-top:28px;"/>
                                <span>暂无商品，去看看其他的吧~</span>
                            </div>
                            </s:else>
                        </div>
                    </div>
                    <!-- 模态框/ -->
                    <s:iterator value="goodsList" var="goods">
                    <%--商品上下架--%>
                    <div class="modal fade" id="upOrdown${goods.gid}" style="padding-top:180px;">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <!-- 模态框头部 -->
                                <div class="modal-header">
                                    <h5 class="modal-title">
                                        <s:if test="#goods.status==0">
                                            是否下架此商品
                                        </s:if>
                                        <s:elseif test="#goods.status==2">
                                            是否上架此商品
                                        </s:elseif>
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal"
                                            style="width: 10px;height: 20px;position: relative;margin-top: -20px;background-color:white;">
                                        &times;
                                    </button>
                                </div>

                                <!-- 模态框主体 -->
                                <div class="modal-body" style="text-align: center;">
                                    <i class="fa fa-crosshairs" style="color: #A94442;"></i>${goods.name}
                                </div>

                                <!-- 模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                    <div class="conf">
                                        <a href="toAmendGoodsStatus?gid=${goods.gid}&status=${goods.status}">确定</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%-- 商品删除 --%>
                    <div class="modal fade" id="delete${goods.gid}" style="padding-top:180px;">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <!-- 模态框头部 -->
                                <div class="modal-header">
                                    <h5 class="modal-title">
                                        <s:if test="#goods.status==0">
                                            是否删除此商品
                                        </s:if>
                                        <s:elseif test="#goods.status==2">
                                            是否彻底删除此商品
                                        </s:elseif>
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal"
                                            style="width: 10px;height: 20px;position: relative;margin-top: -20px;background-color:white;">
                                        &times;
                                    </button>
                                </div>

                                <!-- 模态框主体 -->
                                <div class="modal-body" style="text-align: center;">
                                    <i class="fa fa-crosshairs" style="color: #A94442;"></i>${goods.name}
                                </div>

                                <!-- 模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                    <div class="conf">
                                        <a href="toDeleteGoods?gid=${goods.gid}">确定</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%-- 商品修改 --%>
                    <div class="modal fade" id="No${goods.gid}" style="padding-top:180px;">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <!-- 模态框头部 -->
                                <div class="modal-header">
                                    <h5 class="modal-title"></h5>
                                    <button type="button" class="close" data-dismiss="modal"
                                            style="width: 10px;height: 3px;position: relative;margin-top: -10px;background-color:white;">
                                        &times;
                                    </button>
                                </div>

                                <!-- 模态框主体 -->
                                <div class="modal-body" style="text-align: center;">
                                    <i class="fa fa-crosshairs" style="color: #A94442;"></i>已下架
                                </div>

                                <!-- 模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">返回</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    </s:iterator>
                    <!-- 模态框 -->
                </div>
            </div>
        </div>
    </div>
</section>
<div style="text-align: center;">
    <ul class="pagination">
        <s:if test="pageCode>1">
            <li>
                <a href="toMyissue?pageCode=1">首页</a>
            </li>
            <li>
                <a href="toMyissue?pageCode=${pageCode-1}">&laquo;</a>
            </li>
        </s:if>
        <s:iterator var="i" begin="1" end="totalPage">
            <s:if test="#i==pageCode">
                <li class="active">
            </s:if>
            <s:else>
                <li>
            </s:else>
            <a href="toMyissue?pageCode=${i}">${i}</a>
            </li>
        </s:iterator>
        <s:if test="pageCode<totalPage">
            <li>
                <a href="toMyissue?pageCode=${pageCode+1}">&raquo;</a>
            </li>
            <li>
                <a href="toMyissue?pageCode=${totalPage}">末页</a>
            </li>
        </s:if>
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
                <p class="copyright-text">Copyright &copy; 2019.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a></p>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
