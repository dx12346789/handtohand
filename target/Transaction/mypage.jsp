<%--
  Created by IntelliJ IDEA.
  User: hmxh
  Date: 2019-08-06
  Time: 下午 07:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
    <title>MyPage</title>
    <!--meta tags -->
    <meta charset="UTF-8">
    <!-- Mobile Specific Meta-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link href="css/home.css" rel='stylesheet' type='text/css' media="all">
    <script src="js/jquery.min.js"></script>
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/model2.css"/>
    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="js/dcalendar.picker.js"></script>
    <script type="text/javascript" src="js/UserRule.js"></script>
    <script type="text/javascript" src="js/jquery.md5.js"></script>
    <script type="text/javascript" src="js/address.js"></script>
</head>
<body background="images/bg2.jpg" style="background-size: cover;">
<div class="agileits_main">
    <span>我的主页</span>
    <a href="${pageContext.request.contextPath}/" class="pull-right return" style="padding-right: 40px;"><i
            class="fa fa-reply fa-2x " aria-hidden="true"></i></a>
    <br/>
    <h3>MyPage</h3>
</div>

<div class="info">
    <div class="info-body">
        <div class="myimg">
            <img src="images/logo.png" class="img-circle">
        </div>

        <div class="col-sm-6 info-left">
            <label>昵称</label><br>
        </div>
        <div class="col-sm-6">
            <p><s:property value="user.nickname"/></p>
        </div>
        <div class="col-sm-6 info-left">
            <label>性别</label><br>
        </div>
        <div class="col-sm-6">
            <p><s:if test="user.sex == 0">
                女
            </s:if>
                <s:elseif test="user.sex == 1">
                    男
                </s:elseif>
                <s:else>
                    未知
                </s:else>
            </p>
        </div>
        <div class="col-sm-6 info-left">
            <label>生日</label><br>
        </div>
        <div class="col-sm-6">
            <p><s:date name="user.birthday" format="yyyy-MM-dd"/></p>
        </div>
        <s:if test="#session.loginUser.uid == uid">
            <div class="col-sm-6 info-left">
                <label>积分</label><br>
            </div>
            <div class="col-sm-6">
                <p><s:property value="user.gold"/></p>
            </div>
            <div class="col-sm-6 info-left">
                <label>我的手机</label><br>
            </div>
            <div class="col-sm-6">
                <p><s:property value="user.telphone"/><a href="toupdateacount.action?accountType=0" class="update">&nbsp<i
                        class="fa fa-pencil-square-o" aria-hidden="true"></i> </a></p>
            </div>
            <div class="col-sm-6 info-left">
                <label>电子邮箱</label><br>
            </div>
            <div class="col-sm-6">
                <p><a href="mailto:<s:property value='user.mail'/>" class="update"> <s:property value="user.mail"/></a>
                    <a href="toupdateacount.action?accountType=1" class="update">&nbsp;
                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                    </a>
                </p>
            </div>

            <div class="col-sm-6 info-left">
                <label>收货地址</label><br>
            </div>
            <div class="col-sm-6">
                <s:if test="addresses==null || addresses.size() <= 0">
                    <p>暂无收货地址</p>
                </s:if>
                <s:iterator value="addresses" var="address">
                    <p><s:property value="province"/><s:property value="city"/>
                        <s:property value="town"/><s:property value="detailAddress"/>
                        <a href="toupdateaddress.action?aid=<s:property value="aid"/>" class="update">&nbsp;
                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                        </a>
                        <a href="javascript:void(0);" onclick="delAddress('<s:property value="aid"/>',this)"
                           class="update">&nbsp;
                            <i class="fa fa-trash" aria-hidden="true"></i>
                        </a>
                    </p>
                </s:iterator>
            </div>

            <div class="col-sm-6 info-left">
                <label>添加新地址</label><br>
            </div>
            <div class="col-sm-6">
                <p>&nbsp;<a href="toAddress.action" class="update"><i class="fa fa-plus-square-o "
                                                                      aria-hidden="true"></i></a></p>
            </div>
        </s:if>

        <s:if test="#session.loginUser.uid == uid">
            <div class="col-sm-12 submit">
                <input type="hidden" id="uid" value="<s:property value="user.uid"/>">
                <button type="button" data-toggle="modal" data-target="#myModalPass">修改密码</button>
                <button type="button" data-toggle="modal" data-target="#baseinformat">编辑资料</button>
                <form id="passForm" action="updatepass" method="post">
                    <input type="hidden" id="submitPassUid" name="uid" value="">
                    <div class="modal fade" id="myModalPass" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                                    </button>
                                    <span class="modal-title">修改密码</span>
                                </div>
                                <div class="modal-body">
                                    原密码： <input type="password" value="" id="originalPass"><br/>
                                    新密码： <input type="password" name="pass" value="" id="newPass"><br/>
                                    确认密码:<input type="password" value="" id="newPass2"><br/>
                                    <div class="error">
                                        <span id="errorPass"></span>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="mod-button btn-cansal" data-dismiss="modal">关闭</button>
                                    <button type="submit" class="mod-button btn-submit">修改</button>
                                </div>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->

                </form>
                <script type="text/javascript">
                    var passOk = false;
                    $('#myModalPass').on('show.bs.modal', function () {
                        $("#originalPass").val("");
                        $("#newPass").val("");
                        $("#newPass2").val("");
                        $("#submitPassUid").val($("#uid").val());
                        /*$("#localSubmit").attr("disabled", "disabled");*/
                        passOk = false;
                    });
                    $("#originalPass").change(function () {
                        let uId = $("#uid").val();
                        let pass = $("#originalPass").val();
                        let data = "{\"uid\":\"" + uId + "\",\"pass\":\"" + pass + "\"}";
                        console.log(data);
                        $.ajax({
                            url: "checkpass",
                            dataType: "json",
                            type: "post",
                            data: {"uid": uId, "pass": $.md5(pass)},
                            success: function (data) {
                                data = eval(data);
                                console.log(data);
                                passOk = "ok" === data.msg;
                                if (passOk) {
                                    $("#errorPass").text("");
                                } else {
                                    $("#errorPass").text("原密码错误");
                                }
                            }
                        });
                    });
                    $("#passForm").submit(function () {
                        let pass1 = $("#newPass").val();
                        let pass2 = $("#newPass2").val();
                        if (passOk) {
                            if (isPass(pass1)) {
                                if (pass1 === pass2) {
                                    if ($("#originalPass").val() === pass1) {
                                        $("#errorPass").text("修改密码不能和原密码相同");
                                    } else {
                                        $("#newPass").val($.md5(pass1));
                                        return true;
                                    }
                                } else {
                                    $("#errorPass").text("两次密码不一致");
                                }
                            } else {
                                $("#errorPass").text("密码由6-8位的字母或数字组成");
                            }
                        } else {
                            $("#errorPass").text("原密码错误");
                        }
                        return false;
                    });
                </script>

            </div>
        </s:if>
        <s:else>
            <div class="col-sm-12 submit">
                <button onclick="window.location.href ='towebsocket?uid=<s:property value="uid"/>'" type="button">联系TA</button>
                <button type="button" data-toggle="modal" data-target="#report">举报TA</button>
            </div>
            <!--模态框-->
            <div class="modal fade" id="report" tabindex="-1" role="dialog"
                 aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"
                                    aria-hidden="true">×
                            </button>
                            <span class="modal-title">举报</span>
                        </div>
                        <div class="modal-body">
                            <textarea id="textAreaContent" rows="5" cols="75"></textarea>
                        </div>
                        <div class="modal-footer">
                                            <span id="errorReport">
                                                <s:property value="jsonObject.data"/>
                                            </span>
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">关闭
                            </button>
                            <button id="reportSubmit" class="btn btn-primary" data-dismiss="modal">
                                举报
                            </button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>
            <script type="text/javascript">
                $("#reportSubmit").click(function () {
                    var content = $("#textAreaContent").val();
                    $.ajax({
                        url: "addReport",
                        type: "post",
                        dataType: "json",
                        data: {
                            "notic.content": content,
                            "notic.sender": "<s:property value="#session.loginUser.uid"/>",
                            "notic.recipient": "<s:property value="user.uid"/>"
                        },
                        success: function (data) {

                        }

                    });
                    alert("举报成功");
                });
            </script>
        </s:else>
    </div>
</div>


<!-- 模态框基本信息修改 -->
<div class="modal fade" id="baseinformat" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="updateEssentialInformation" action="updateEssentialInformation.action" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        修改基本信息
                    </h4>
                    <%--                    <h5>edit</h5>--%>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="uid" value="<s:property value="user.uid"/> ">
                    <div class="modal-div">
                        昵称：<input id="localNickName" type="text" name="user.nickname"
                                  value="<s:property value="user.nickname"/>" class="text-input input-size1"/>
                        <script type="text/javascript">
                            $("#localNickName").on("input propertychange", function () {
                                let content = $("#localNickName").val();
                                if (isNickName(content)) {
                                    $("#error").text("");
                                    $("#localSubmit").removeAttr("disabled");
                                } else {
                                    $("#error").text("昵称由4-8位的汉字或字母组成");
                                    $("#localSubmit").attr("disabled", "disabled");
                                }
                            });
                        </script>
                    </div>

                    <div class="modal-div">
                        生日：<input type="text" name="user.birthday" value="" readonly AUTOCOMPLETE="off"
                                  class="text-input input-size1" id="mydatepicker1"/>
                        <script type="text/javascript">
                            $('#mydatepicker1').dcalendarpicker({
                                format: 'yyyy-mm-dd'
                            });
                            $(function () {
                                $('#mydatepicker1').val("<s:date name="user.birthday" format="yyyy-MM-dd"/>");
                            });
                        </script>
                    </div>
                    <div class="modal-div">
                        性别：<select name="user.sex" class="select">
                        <option value="1"
                                <s:if test="user.sex == 1">selected="selected"</s:if> >男
                        </option>
                        <option value="0" <s:if test="user.sex == 0">selected="selected"</s:if>>女</option>
                    </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="form-group" style="text-align: center;padding: 10px 0;">
                        <span id="error"><s:property value="jsonObject.data"/></span>
                    </div>
                    <button type="button" class="mod-button btn-cansal" data-dismiss="modal">关闭</button>
                    <button id="localSubmit" type="submit" class=" mod-button btn-submit">确定</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script type="text/javascript">
    $('#baseinformat').on('show.bs.modal', function () {
        /*$("#localSubmit").attr("disabled", "disabled");*/
    });
    $("#updateEssentialInformation").submit(function () {
        $("#localNickName").trigger("input propertychange");
    });
</script>
<!-- /拟态框1——基本信息修改 -->

</body>
</html>
