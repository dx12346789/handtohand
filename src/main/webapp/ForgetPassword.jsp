<%--
  Created by IntelliJ IDEA.
  User: 一别半笙
  Date: 2019/8/8
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>忘记密码</title>
    <!-- Mobile Specific Meta-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/jquery.steps.css" rel="stylesheet">
    <link href="css/form.css" rel="stylesheet">
    <!-- 全局js -->
    <script src="jquery-1.11.3/jquery.min.js"></script>
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="js/jquery.md5.js" type="text/javascript"></script>
    <script src="js/UserRule.js" type="text/javascript" charset="UTF-8"></script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-content">
                    <h2>
                        忘记密码
                    </h2>
                    <form id="form" action="forgetPassword.action" method="post" class="wizard-big">
                        <h1>确认账号</h1>
                        <fieldset>
                            <h2>请输入找回账号</h2>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <label>
                                            原账号
                                        </label>
                                        <input type="text" name="account" id="account1" class="form-control required check-span"></input>
                                        <button type="button" id="Code1" class="check-button">获取验证码</button>
                                    </div>
                                    <div class="form-group">
                                        <label>验证码 </label>
                                        <input type="text" id="codeContent1" class="form-control required">
                                    </div>
                                    <script type="text/javascript">
                                        $("#Code1").click(function () {
                                            let content = $("#account1").val();
                                            checkAccount(content,getPCode);
                                        });
                                        var getPCode = function (status) {
                                            if(status === "0"){
                                                let content = $("#account1").val();
                                                $("#error").html("");
                                                getCode(content, $("#Code1"), 60);
                                            }else if(status === "1"){
                                                $("#error").html("账号不存在");
                                            }else {
                                                $("#error").html("账号已被冻结，请联系管理员处理！");
                                            }
                                        };
                                        var codeContent1Status = function (status) {
                                            if (status) {
                                                console.log("验证码正确");
                                                $("#error").html("");
                                                $("#next").attr("href", "#next");
                                            } else {
                                                $("#error").html("验证码错误");
                                                $("#next").attr("href", "javascript:void(0);");
                                            }
                                        };
                                        $("#codeContent1").on("input propertychange", function () {
                                            var content = $("#codeContent1").val();
                                            if (content.length > 0) {
                                                checkCode(content, codeContent1Status)
                                            }
                                        })
                                    </script>
                                </div>
                                <div class="col-sm-4">
                                    <div class="text-center">
                                        <div style="margin-top: 20px">
                                            <i class="fa fa-sign-in" style="font-size: 180px;color: #e5e5e5 "></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <h1>重置密码</h1>
                        <fieldset>
                            <h2>重置密码</h2>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <label>
                                            输入新密码
                                        </label>
                                        <input id="pass" name="pass" type="password" class="form-control required">
                                    </div>
                                    <div class="form-group">
                                        <label>再次输入密码</label>
                                        <input id="pass2" type="password" class="form-control required">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="text-center">
                                        <div style="margin-top: 20px">
                                            <i class="fa fa-sign-in" style="font-size: 180px;color: #e5e5e5 "></i>
                                        </div>
                                    </div>
                                </div>

                                <script type="text/javascript">
                                    $("#pass2").on("input propertychange",function () {
                                        let pass1 = $("#pass").val();
                                        let pass2 = $("#pass2").val();
                                        if (isSamePass(pass1,pass2)) {
                                            if(isPass(pass1)){
                                                console.log("密码正确");
                                                $("#error").html("");
                                                $("#finish").attr("href", "#finish");
                                            }else {
                                                console.log("密码由6-8位的字母或数字组成");
                                                $("#error").html("密码由6-8位的字母或数字组成");
                                                $("#finish").attr("href", "javascript:void(0);");
                                            }

                                        } else {
                                            $("#error").html("两次密码不一致");
                                            $("#finish").attr("href", "javascript:void(0);");
                                        }
                                    });
                                </script>
                            </div>
                        </fieldset>
                    </form>
                    <script type="text/javascript">
                        $("#form").submit(function () {
                            var pa = $("#pass").val();
                            $("#pass").val($.md5(pa));
                            return true;
                        });
                    </script>
                    <h1><span id="error"><s:property value="jsonObject.data"/> </span></h1>
                </div>
            </div>
        </div>

    </div>
</div>


<!-- Steps -->
<script src="js/form/jquery.steps.min.js"></script>
<!-- Jquery Validate -->
<script src="js/form/jquery.validate.min.js"></script>
<script src="js/form/messages_zh.min.js"></script>
<script>
    $(document).ready(function () {
        $("#wizard").steps();
        $("#form").steps({
            bodyTag: "fieldset",
            onStepChanging: function (event, currentIndex, newIndex) {
                // Always allow going backward even if the current step contains invalid fields!
                if (currentIndex > newIndex) {
                    return true;
                }

                // Forbid suppressing "Warning" step if the user is to young
                if (newIndex === 3 && Number($("#age").val()) < 18) {
                    return false;
                }

                var form = $(this);

                // Clean up if user went backward before
                if (currentIndex < newIndex) {
                    // To remove error styles
                    $(".body:eq(" + newIndex + ") label.error", form).remove();
                    $(".body:eq(" + newIndex + ") .error", form).removeClass("error");
                }

                // Disable validation on fields that are disabled or hidden.
                form.validate().settings.ignore = ":disabled,:hidden";

                // Start validation; Prevent going forward if false
                return form.valid();
            },
            onStepChanged: function (event, currentIndex, priorIndex) {
                // Suppress (skip) "Warning" step if the user is old enough.
                if (currentIndex === 2 && Number($("#age").val()) >= 18) {
                    $(this).steps("next");
                }

                // Suppress (skip) "Warning" step if the user is old enough and wants to the previous step.
                if (currentIndex === 2 && priorIndex === 3) {
                    $(this).steps("previous");
                }
            },
            onFinishing: function (event, currentIndex) {
                var form = $(this);

                // Disable validation on fields that are disabled.
                // At this point it's recommended to do an overall check (mean ignoring only disabled fields)
                form.validate().settings.ignore = ":disabled";

                // Start validation; Prevent form submission if false
                return form.valid();
            },
            onFinished: function (event, currentIndex) {
                var form = $(this);

                // Submit form input
                form.submit();
            }
        }).validate({
            errorPlacement: function (error, element) {
                element.before(error);
            },
            rules: {
                confirm: {
                    equalTo: "#password"
                }
            }
        });
    });
</script>
<script type="text/javascript">
    $(function () {
        if ($("a[href='#next']").length > 0) {
            $("a[href='#next']").attr("id", "next");
            $("#next").attr("href", "javascript:void(0);");
        }
        $("a[href='#finish']").attr("id", "finish");
        $("#finish").attr("href", "javascript:void(0);");
    });
</script>
</body>
</html>
