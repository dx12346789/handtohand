<%--
  Created by IntelliJ IDEA.
  User: 一别半笙
  Date: 2019/8/4
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
    <title>注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="jquery-1.11.3/jquery.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="plugins/slick-carousel/slick/slick-theme.css"/>
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/jquery.md5.js"></script>
    <script src="js/UserRule.js" type="text/javascript"></script>
</head>
<body id="body">
<section class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="content">
                    <h1 class="page-name">Register</h1>
                    <ol class="breadcrumb">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="tologin.action">Login</a></li>
                        <li class="active">Register</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="page-wrapper">
    <div class="contact-section">
        <div class="container">
            <div class="row">
                <!-- Contact Form -->
                <div class="contact-form col-md-6 " >
                    <form id="contact-form" method="post" action="register.action" role="form" name="form1">
                        <input type="hidden" name="user.auth" value="0">
                        <div class="input-group subscription-form" style="padding: 10px 0;">
                            <input type="text" class="form-control" placeholder="邮箱 | 手机号" name="account" id="Account">
                            <span class="input-group-btn">
								<a id="getcode" class="btn btn-main" href="javascript:void(0);">点击获取验证码</a>
							</span>
                        </div><!-- /input-group -->
                        <div class="form-group">
                            <input type="text" placeholder="昵称" id="nick" class="form-control" name="user.nickname">
                        </div>

                        <div class="form-group">
                            <input type="password" placeholder="密码" class="form-control" name="user.pass" id="Pwd">
                        </div>
                        <div class="form-group">
                            <input type="password" placeholder="确认密码" class="form-control" id="Pwd2">
                        </div>
                        <div class="form-group">
                            <input type="text" AUTOCOMPLETE="off" placeholder="验证码" class="form-control" id="Volidate">
                        </div>
                        <div id="cf-submit">
                            <input type="submit" id="contact-submit" class="btn btn-transparent" value="注册">
                        </div>
                        <div  class="form-group" style="text-align: center;padding: 10px 0;">
                            <span id="error"><s:property value="jsonObject.data" /></span>
                        </div>
                    </form>
                </div>
                <div class="col-sm-1">

                </div>

                <div class="col-md-5" id="handtohand" style="height: 350px;text-align: center;">
                    <h1 style="line-height: 310px;">Hand To Hand</h1>
                </div>
            </div>
            <!-- / End Contact Details -->
        </div> <!-- end row -->
    </div> <!-- end container -->
    </div>
    <script type="text/javascript" src="js/user.js"></script>
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

            </div>
        </div>
    </div>
</footer>
</body>
</html>
