<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: 一别半笙
  Date: 2019/8/8
  Time: 12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加收货地址</title>
    <!-- Mobile Specific Meta-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/chosen.css" rel="stylesheet">
    <link href="css/address.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css"/>

</head>
<body>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h2>
            <s:if test="address == null">
                新增收货地址
            </s:if>
            <s:else>
                修改收货地址
            </s:else>
        </h2>
    </div>
    <form action="<s:if test="address == null">addAddress.action</s:if><s:else>updateAddress.action</s:else>" method="post">
        <input type="hidden" name="address.aid" value="<s:property value="address.aid"/>">
        <div class="ibox-content">
            <h3>
                Address
            </h3>
            <!-- 单选 -->
            <div class="form-group">
                <label class="font-noraml">收货人</label>
                <div class="input-group">
                    <input type="text" name="address.nickname" class="input-size" value="<s:property value="address.nickname"/>" />
                </div>
                <br/>
                <label class="font-noraml">联系方式</label>
                <div class="input-group">
                    <input type="tel" name="address.telphone" class="input-size" value="<s:property value="address.telphone"/>"/>
                </div>
                <br/>
                <div class="form-inline">
                    <div data-toggle="distpicker">
                        <div class="form-group">
                            <label class="sr-only" for="province1">Province</label>
                            <select name="address.province" data-province="<s:property value="address.province"/>" class="form-control" id="province1"></select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="city1">City</label>
                            <select name="address.city" data-city="<s:property value="address.city"/>" class="form-control" id="city1"></select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="district1">District</label>
                            <select name="address.town" data-district="<s:property value="address.town"/>" class="form-control" id="district1"></select>
                        </div>
                    </div>
                </div>
                <br/>
                <label class="font-noraml">请输入详细地址</label>
                <div class="input-group">
                    <input type="text" value="<s:property value="address.detailAddress"/>" name="address.detailAddress" class="input-size"/>
                </div>
            </div>
        </div>
        <div style="padding-left: 30px;">
            <a href="##"><input type="submit" class="save fanhui" value="返回"></a>
            <input type="submit" class="save" value="保存">
        </div>

    </form>

</div>

<script src="jquery-1.11.3/jquery.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="js/content.js" type="text/javascript" charset="utf-8"></script>
<script src="js/distpicker.data.js"></script>
<script src="js/distpicker.js"></script>
<script src="js/main.js"></script>
</body>

</html>
