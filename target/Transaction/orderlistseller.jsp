<%--
  Created by IntelliJ IDEA.
  User: 一别半笙
  Date: 2019/8/10
  Time: 21:21
  To change this template use File | Settings | File Templates.
  我的购买（订单详情界面）
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
    <title>我卖出的</title>
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/orderlistpayer.css"/>
    <script src="jquery-1.11.3/jquery.min.js"></script>
    <script src="js/step.js"></script>
    <script src="js/search.js"></script>
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="js/cart.js"></script>
    <script type="text/javascript">
        function toSearch() {
            location.href = "search.action?type=0";
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
                    <li class="dropdown dropdown-slide">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                           data-delay="350" role="button"
                           aria-haspopup="true" aria-expanded="false"><s:property
                                value="#session.loginUser.nickname"/>&nbsp;<span
                                class="tf-ion-ios-arrow-down"></span></a>
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
                    <li>
                        <a href="${pageContext.request.contextPath}/">我要购买</a>
                    </li><!-- / Home -->


                    <!-- Elements -->
                    <li>
                        <a href="toIssue">我要发布</a>
                    </li><!-- / Elements -->
                    <!-- Elements -->
                    <li>
                        <a href="toorderbuyer">已购买<span class="buy_span">0</span></a>

                    </li><!-- / Elements -->
                    <!-- Pages -->
                    <li style="border-bottom: 2px solid red;">
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

<section class="orderbody">
    <s:iterator value="jsonObject.data" var="json">
        <div class="single">
            <div class="single-top">
                <div class="col-sm-2 imgsize" style="margin-top: 12px;">
                    <img src="<s:property value="goodsimg"/>" style="height: 100px; object-fit:cover "/>
                </div>
                <div class="col-sm-8">
                    <h2><s:property value="goodsname"/></h2>
                    <h3>数量X<s:property value="goodscount"/></h3>
                    <s:if test="orderstatus==0">
                        <h4><i class="fa fa-clock-o" aria-hidden="true"></i> &nbsp;待发货</h4>
                    </s:if>
                    <s:elseif test="orderstatus==1">
                        <h4><i class="fa fa-clock-o" aria-hidden="true"></i> &nbsp;宝贝已在路上</h4>
                    </s:elseif>
                    <s:else>
                        <h4><i class="fa fa-clock-o" aria-hidden="true"></i> &nbsp;交易完成</h4>
                    </s:else>

                </div>
                <div class="col-sm-2">
                    <h3 class="price">￥<s:property value="goodspricetotal"/></h3>
                </div>
            </div>
            <div class="single-footer">
                <div class="col-sm-6">
                    <a href="towebsocket.action?uid=<s:property value="buyerid"/>"><i class="fa fa-commenting-o fa-lg"
                                                                                      aria-hidden="true"></i>&nbsp;联系买家</a>
                </div>
                <div class="col-sm-6 " style="text-align: right;">
                    <s:if test="orderstatus==0">
                        <button class="text-button" data-toggle="modal" data-target="#send"
                                onclick="send('<s:property value="orderid"/>')">我要发货
                        </button>
                        <a href="" onclick="initStep(2)" data-toggle="modal" data-target="#orderinfo">
                            <button class="text-button" onclick="orderinfo('<s:property value="goodsimg"/>','<s:property
                                    value="goodsname"/>','<s:property value="goodscount"/>',
                                    '<s:property value="goodspricetotal"/>','<s:property value="buyer"/>','<s:property
                                    value="ordernum"/>','<s:property value="sellernum"/>','<s:date name="paytime"
                                                                                                   format="yyyy-MM-dd"/>')">
                                查看详情
                            </button>
                        </a>
                    </s:if>
                    <s:elseif test="orderstatus==1">

                        <button class="text-button" type="submit" style="background-color: white;color: black">已发货
                        </button>

                        <a href="" onclick="initStep(3)" data-toggle="modal" data-target="#orderinfo">
                            <button class="text-button" onclick="orderinfo('<s:property value="goodsimg"/>','<s:property
                                    value="goodsname"/>','<s:property value="goodscount"/>',
                                    '<s:property value="goodspricetotal"/>','<s:property value="buyer"/>','<s:property
                                    value="ordernum"/>','<s:property value="sellernum"/>','<s:date name="paytime"
                                                                                                   format="yyyy-MM-dd"/>')">
                                查看详情
                            </button>
                        </a>
                    </s:elseif>
                    <s:elseif test="orderstatus==2">
                        <a href="" data-toggle="modal" data-target="#discuss">
                            <button class="text-button" style="background-color: white;color: black">已签收</button>
                        </a>
                        <a href="" onclick="initStep(4)" data-toggle="modal" data-target="#orderinfo">
                            <button class="text-button" onclick="orderinfo('<s:property value="goodsimg"/>','<s:property
                                    value="goodsname"/>','<s:property value="goodscount"/>',
                                    '<s:property value="goodspricetotal"/>','<s:property value="buyer"/>','<s:property
                                    value="ordernum"/>','<s:property value="sellernum"/>','<s:date name="paytime"
                                                                                                   format="yyyy-MM-dd"/>')">
                                查看详情
                            </button>
                        </a>
                    </s:elseif>
                    <s:else>
                        <a href="" data-toggle="modal" data-target="#discuss">
                            <button class="text-button" style="background-color: white;color: black">交易完成</button>
                        </a>
                        <a href="" onclick="initStep(6)" data-toggle="modal" data-target="#orderinfo">
                            <button class="text-button" onclick="orderinfo('<s:property value="goodsimg"/>','<s:property
                                    value="goodsname"/>','<s:property value="goodscount"/>',
                                    '<s:property value="goodspricetotal"/>','<s:property value="buyer"/>','<s:property
                                    value="ordernum"/>','<s:property value="sellernum"/>','<s:date name="paytime"
                                                                                                   format="yyyy-MM-dd"/>')">
                                查看详情
                            </button>
                        </a>
                    </s:else>
                </div>
            </div>
        </div>
    </s:iterator>
</section>

<!-- 模态框查看详情 -->
<div class="modal fade" id="orderinfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span class="mod_title">订单详情</span>
            </div>
            <div class="modal-body">
                <div class="steps"></div>
                <div id="order-money" class="money">
                    26.00<span>元</span>
                    <p>钱款在支付宝担保账户</p>
                </div>

                <div class="order-single">
                    <div class="col-sm-3">
                        <img id="orderimg" src="images/project.jpg" style="height: 55px; object-fit:cover ">
                    </div>
                    <div class="col-sm-9">
                        <p id="order-title" class="order-title">商品名称</p>
                        <p id="order-count" class="order-numbet">数量X</p>
                    </div>

                </div>
                <div class="order-info">
                    <div class="col-sm-4" style="text-align: left;">
                        买家昵称:
                    </div>
                    <div id="order-seller" class="col-sm-8" style=" text-align: right;color: #999999;">
                        你说说你
                    </div>
                    <div class="col-sm-4" style="text-align: left;">
                        订单编号:
                    </div>
                    <div id="order-num" class="col-sm-8" style=" text-align: right;color: #999999;">
                        1231247676347
                    </div>
                    <div class="col-sm-4" style="text-align: left;">
                        交易流水号:
                    </div>
                    <div id="order-paynum" class="col-sm-8" style=" text-align: right;color: #999999;">
                        12348786667123
                    </div>
                    <%--                    <div class="col-sm-4" style="text-align: left;">--%>
                    <%--                        交易时间:--%>
                    <%--                    </div>--%>
                    <%--                    <div id="order-paytime" class="col-sm-8" style=" text-align: right;color: #999999;">--%>
                    <%--                        2009-8-5 22:21:34--%>
                    <%--                    </div>--%>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="submit_button" data-dismiss="modal">关闭</button>

            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- /查看详情 -->
<!-- 模态框评论 -->
<div class="modal fade" id="send" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span class="mod_title">发货</span>
            </div>
            <form action="send" method="post">

                <input id="orderid" type="hidden" name="orderid" value=""/>
                <div class="modal-body">
                    请输入物流单号：<input type="text" name="sendnum" value="" class="sendclass" style="width: 100%;"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="submit_button" data-dismiss="modal">取消</button>
                    <button type="submit" class="submit_button">
                        确定
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- /评论 -->
<script type="text/javascript">

    var send = function (orderid) {

        $("#orderid").val(orderid);
    }

    function initStep(index) {
        console.log("1")
        xaingq();
        $(".steps").empty();
        $(".steps").step({
            stepNames: ['拍下', '付款', '发货', '收货', '评价', '完成'],
            initStep: index
        })
    };
    var orderinfo = function (img, name, count, price, seller, ordernum, paynum, paytime) {
        console.log(img);
        console.log(name);
        console.log(count);
        console.log(price);
        console.log(seller);
        console.log(ordernum);
        console.log(paynum);
        console.log(paytime);


        $("#orderimg").attr("src", img);
        $("#order-title").html(name);
        $("#order-count").html("数量X" + count);
        $("#order-money").html(price);
        $("#order-seller").html(seller);
        $("#order-num").html(ordernum);
        $("#order-paynum").html(paynum);

    }
</script>

<script>
    /* $(function () {
    initStep();
  }); */


    function previousStep() {
        $(".steps").step("previous");
    }

    function nextStep() {
        $(".steps").step("next");
    }

    function gotoStep(step) {
        $(".steps").step("goto", step)
    }

    $(function () {
        var uid = "<s:property value="#session.loginUser.uid"/>"
        $.ajax({
            url: "getSellNumber",
            type: "post",
            data: {"uid": uid},
            success: function (data) {
                $(".sell_span").text(data);
            }
        });
        $.ajax({
            url: "getBuyNumber",
            type: "post",
            data: {"uid": uid},
            success: function (data) {
                $(".buy_span").text(data);
            }
        });
    });

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
</script>
</body>
</html>
