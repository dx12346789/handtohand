<%--
  Created by IntelliJ IDEA.
  User: 糖糖正
  Date: 2019/8/12
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>修改</title>

    <!-- Mobile Specific Meta-->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />

    <!-- Themefisher Icon font -->
    <link rel="stylesheet" href="plugins/themefisher-font/style.css">
    <!-- bootstrap.min css -->
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css" />
    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css"/>

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Main jQuery -->
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>

    <!-- Slick Carousel -->
    <script src="plugins/slick-carousel/slick/slick.min.js"></script>

    <!-- Main Js File -->
    <script src="js/script.js"></script>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/issue.css">
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
                    <h1 class="page-name">修改</h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                        <li><a href="toMyissue.action">我的发布</a></li>
                        <li class="active">修改</li>
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
                <div class="content" >
                    <form action="UpdateMyGoods.action" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">标题</label>
                            <div class="col-sm-6">
                                <input type="hidden" name="goods.gid" value="${goods.gid}" class="form-control" id="title" placeholder="品类/品牌型号"/>
                                <input type="text" name="goods.name" value="${goods.name}" class="form-control" id="title" placeholder="品类/品牌型号"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" name="goods.detail" rows="3" id="desc">${goods.detail}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">分类</label>
                            <div class="col-sm-2">
                                <select class="form-control" name="goods.cid">
                                    <option value="${category.cid}" selected style="background-color: lightgrey;">${category.name}</option>
                                    <s:iterator value="categoryList" var="categorys">
                                            <option value="${categorys.cid}">${categorys.name}</option>
                                    </s:iterator>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">价格</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="goods.price" value="${goods.price}" id="price" placeholder="售价"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">数量</label>
                            <div class="col-sm-6">
                                <input type="text" name="goods.count" value="${goods.count}" class="form-control" id="amount" value="1"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">宝贝图片</label>
                            <div class="col-sm-6" id="updatebox" style="width: 555px;height: 103px;*border:1px solid red;margin-left: 16px;overflow: hidden;white-space: nowrap;">
                                <s:iterator value="goods.imgPath.split(',')" var="img" status="st">
                                    <s:if test="#st.last">
                                        <s:if test="#st.count<5">
                                            <div class="col-sm-3" id="picture${st.count}" style="width:102px;height:103px;border:1px solid cadetblue;margin-left: -16px;padding-left:0px;margin-right:19px;">
                                                <div class='panel panel-info'>
                                                    <img class="updateimg img-responsive" src="${img}" style="width:200px;height:100px;"/>
                                                    <input hidden="hidden" name="img" value="${img}" />
                                                </div>
                                                <div id="del-div" onclick="del(${st.count})">
                                                    <i class="fa fa-window-close" aria-hidden="true"></i>
                                                </div>
                                            </div>
                                            <div class="image-div-input" id="img-div-input11">
                                                <label class="lable" for="file2">
                                                    <i class="fa tf-ion-android-add" style="font-size: 30px;padding: 34px 28px 28px 38px;color:lightgray;"></i>
                                                    <input type="file" class="upload"  id="file2" value="" name="upload" onchange="addfile(this)" style="display: none;"/>
                                                </label>
                                            </div>
                                        </s:if>
                                        <s:else>
                                            <div class="col-sm-3" id="picture${st.count}" style="width:102px;height:103px;border:1px solid cadetblue;margin-left: -16px;padding-left:0px;margin-right:19px;">
                                                <div class='panel panel-info'>
                                                    <img class="updateimg img-responsive" src="${img}" style="width:200px;height:100px;"/>
                                                    <input hidden="hidden" name="img" value="${img}" />
                                                </div>
                                                <div id="del-div3" onclick="del(${st.count})">
                                                    <i class="fa fa-window-close" aria-hidden="true"></i>
                                                </div>
                                            </div>
                                        </s:else>
                                    </s:if>
                                    <s:else>
                                        <div class="col-sm-3" id="picture${st.count}" style="width:102px;height:103px;border:1px solid cadetblue;margin-left: -16px;padding-left:0px;margin-right:19px;">
                                            <div class='panel panel-info'>
                                                <img class="updateimg img-responsive" src="${img}" style="width:200px;height:100px;"/>
                                                <input hidden="hidden" name="img" value="${img}" />
                                            </div>
                                            <div id="del-div2" onclick="del(${st.count})">
                                                <i class="fa fa-window-close" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </s:else>
                                </s:iterator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-6">
                                <button type="submit" class="btn btn-primary btn-lg btn-block" style="background-color: #2B2B2B;color: white;">提交修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

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
<script type="text/javascript">
    var i=0;
    var num=11;
    var addfile = function(obj) {
        add();
        console.log(obj);
        var imgFile = obj.files[0];
        console.log(imgFile);
        i++;
        if(i==5){
            $("#img-div-input"+num).hide();
        }

        var fr = new FileReader();
        fr.onload = function() {
            var imgs = document.getElementsByClassName('updateimg'+num);
            imgs[imgs.length-1].src = fr.result;

        };
        fr.readAsDataURL(imgFile);
    };

    function add(){
        $('#img-div-input'+num).hide();
        num++;
        var html = "<div class='col-sm-3' id='picture" + num + "' style='width:102px;height:103px;border:1px solid cadetblue;margin-left: -16px;padding-left:0px;margin-right:19px;'><div class='panel panel-info'><img class='updateimg"+num+" img-responsive' src='img/p_big3.jpg' style='width:200px;height:100px;'/></div><div id='del-div' onclick='del("+num+")'><i class='fa fa-window-close' aria-hidden='true'></i></div></div>";
        $('#updatebox').append(html);
        var html2="<div class='image-div-input' id='img-div-input"+num+"'><label class='lable' for='file"+num+"'><i class='fa tf-ion-android-add' style='font-size: 30px;padding: 34px 28px 28px 38px;color:lightgray;'></i><input type='file' value=''  name='upload' class='upload' id='file"+num+"' onchange='addfile(this)' style='display: none;'/></label></div>";
        $('#updatebox').append(html2);

    }

    var del = function (x) {
        console.log("删除");
        $("#picture"+x).remove();
        $('#img-div-input'+num).show();
        if(x==5) {
            var html2="<div class='image-div-input' id='img-div-input"+num+"'><label class='lable' for='file"+num+"'><i class='fa tf-ion-android-add' style='font-size: 30px;padding: 34px 28px 28px 38px;color:lightgray;'></i><input type='file' value=''  name='upload' class='upload' id='file"+num+"' onchange='addfile(this)' style='display: none;'/></label></div>";
            $('#updatebox').append(html2);
        }

    };

</script>
</html>
