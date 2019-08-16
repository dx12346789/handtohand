<%--
  Created by IntelliJ IDEA.
  User: 糖糖正
  Date: 2019/8/9
  Time: 9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css"/>
    <link rel="stylesheet" href="css/goods.css"/>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery-1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="js/detail.js"></script>
    <script src="plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="js/script.js"></script>
    <script type="text/javascript" src="js/cart.js"></script>
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
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<title><s:property value="goods.name"/></title>
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
                             xmlns="http://www.w3.org/2000/svg">
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
</section>
<div class="productPageDiv">
    <div class="imgAndInfo">
        <div class="imgInimgAndInfo">
            <s:iterator value="goods.imgPath.split(',')" var="img" status="st">
            <s:if test="#st.first">
            <img src="${img}" class="bigImg"/>
            <div class="smallImageDiv">
                </s:if>
                <img src="${img}" bigImageURL="${img}" class="smallImage"/>
                </s:iterator>
            </div>
            <div class="img4load hidden"></div>
        </div>
        <div class="infoInimgAndInfo">
            <div class="productTitle"><s:property value="goods.name"/></div>
            <div class="productPrice">
                <div class="productPriceDiv">
                    <div class="promotionDiv">
                        <span class="promotionPriceDesc">价格 </span>
                        <span class="promotionPriceYuan">¥</span>
                        <span class="promotionPrice"><s:property value="goods.price"/> </span>
                    </div>
                </div>
            </div>
            <div class="productSaleAndReviewNumber">
                <div>累计评价 <span class="redColor boldWord"> ${count}</span></div>
                <div>类别：
                    <span class="redColor boldWord">
                        <a href=""><s:property value="category.name"/></a>
                    </span>
                </div>
            </div>

        </div>
    </div>
    <div class="productNumber" style="margin-top:-35px;color:#999999;">
        <span style="margin-left:20px">数量</span>
        <span>
                    <span class="productNumberSettingSpan">
                        <input class="productNumberSetting" type="text" value="${goods.count}" disabled style="width:43px;height:32px;background: white;display: inline-block;border: 1px solid #999;">
                    </span>
                    <span class="arrow">
                        <a href="#nowhere" class="increaseNumber">
                            <span class="updown"><img src="images/increase.png"></span>
                        </a>
                        <span class="updownMiddle"> </span>
                        <a href="#nowhere" class="decreaseNumber">
                            <span class="updown"><img src="images/decrease.png"></span>
                        </a>
                    </span>件
                </span>
        <span>库存<span class="total"><s:property value="goods.count"/></span>件</span>
    </div>
    <div class="serviceCommitment">
        <span class="serviceCommitmentDesc" style="margin-left:20px;color:#999999">服务承诺</span>
        <span class="serviceCommitmentLink">
            <a href="#nowhere">正品保障</a>
                    <a href="#nowhere">极速退款</a>
                    <a href="#nowhere">赠运费险</a>
                    <a href="#nowhere">七天无理由退换</a>
        </span>
    </div>
    <div class="buyDiv">
        <s:if test="goods.status==0">
        <a class="buyLink" href="toUpdateGoods.action?gid=${goods.gid}">
            <button class="buyButton"><i class="fa fa-pencil-square-o"></i> 编辑商品</button>
        </a>
        </s:if>
        <s:if test="goods.status==2">
            <a data-toggle="modal" data-target="#delete${goods.gid}" class="buyLink" href="##">
                <button class="buyButton"><i class="fa fa-trash-o"></i> 删除</button>
            </a>
        </s:if>
        <a  data-toggle="modal" data-target="#upOrdown${goods.gid}" class="addCartLink" href="###">
            <button class="addCartButton"><s:if test="goods.status==2"><i class="fa fa-level-up"></i> 上架</s:if><s:if test="goods.status==0"><i class="fa fa-level-down"></i> 下架</s:if></button>
        </a>
    </div>
    <%--商品上下架--%>
    <div class="modal fade" id="upOrdown${goods.gid}" style="padding-top:180px;">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h5 class="modal-title">
                        <s:if test="goods.status==0">
                            是否下架此商品
                        </s:if>
                        <s:elseif test="goods.status==2">
                            是否上架此商品
                        </s:elseif>
                    </h5>
                    <button type="button" class="close" data-dismiss="modal"
                            style="width: 10px;height: 20px;position: relative;margin-top: -23px;background-color:white;margin-bottom: -7px">
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
                        <s:if test="goods.status==0">
                            是否删除此商品
                        </s:if>
                        <s:elseif test="goods.status==2">
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
</div>
<div style="clear:both"></div>
</div>
<div class="productReviewDiv">
    <div class="productReviewTopPart">
        <a href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>
        <a href="#nowhere" class="selected">累计评价
            <span class="productReviewTopReviewLinkNumber">${count}</span>
        </a>
    </div>
    <div class="productReviewContentPart-img">
        <s:if test="commentList.size()>0">
        <s:iterator value="commentList" var="comment">
            <s:if test="#comment.respondent==null">
            <div class="productReviewItem">
                <div class="productReviewItemDesc">
                    <div class="productReviewItemContent">
                        <s:property value="content"/>
                    </div>
                    <div class="productReviewItemDate"><s:date name="createTime" format="yyyy-MM-dd"/> </div>
                </div>
                <div class="productReviewItemUserInfo">
                    <s:iterator value="userList" var="user">
                        <s:if test="#comment.commentator == #user.uid">
                            <s:property value="#user.nickname"/>
                            <div class="uid" uid="<s:property value="#user.uid"/>" hidden></div>
                            <s:if test="#comment.anonymous==1">
                                <span class="userInfoGrayPart">（匿名）</span>
                            </s:if>
                        </s:if>
                    </s:iterator>
                </div>

                <s:set var="flag" value="true"/>
                <s:iterator value="commentList" var="com">
                    <s:if test="(#comment.odid==#com.odid)&&(#com.respondent!=null)&&(#comment.commentator==#com.respondent)">
                        <div class="productReviewItemUserInfo" style="overflow: inherit;">
                            <span style="color:#b00000;"><s:property value="#session.loginUser.nickname"/> &nbsp;&nbsp;回复 ：</span>${com.content}
                        </div>
                        <s:set var="flag" value="false"/>
                    </s:if>
                </s:iterator>
                <s:if test="flag">
                <div style="clear:both; padding-left: 3%;" class="replay">
                    <a  class="feedback"  selected="false" onclick="show(this);">回复</a>
                    <div class="feedback_content" style="display: none;">
                        <textarea placeholder="你想说点什么..."></textarea>
                        <button type="submit" style="margin: 10px 0px 0px 93%;" onclick="submit(this,'${user.uid}','${goods.gid}','${comment.odid}','${user.nickname}');">
                            确定</button>
                    </div>
                </div>
                </s:if>
            </div>
            </s:if>
        </s:iterator>
        </s:if>
        <s:else>
            <div class="productParamterPart-img">
                    <img src="images\no.jpg" style="width: 280px;height:224px;margin-left:255px;margin-top:14px;"/>
                <span>暂无评价，去看看其他的吧~</span>
            </div>
        </s:else>
    </div>
</div>
<div class="productDetailDiv">
    <div class="productReviewTopPart">
        <a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
        <a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span
                class="productReviewTopReviewLinkNumber">${count}</span> </a>
    </div>
    <div class="productParamterPart">
        <div class="productParamter"><s:property value="goods.detail"/></div>
        <div style="clear:both"></div>
    </div>
</div>

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
