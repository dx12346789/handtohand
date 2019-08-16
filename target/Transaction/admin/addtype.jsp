<%--
  Created by IntelliJ IDEA.
  User: 一别半笙
  Date: 2019/8/5
  Time: 17:53
 类型管理页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
    <title>添加分类</title>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/type.css"/>
    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script src="jquery-1.11.3/jquery.min.js"></script>
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="jquery-1.11.3/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png"/>
    <script type="text/javascript">
        var sad=function(name,cid){
            console.log(name);
            console.log(cid);
            $("#delname").html(name);
            var data = "deltype('" + cid +"')";
            console.log(data);
            $("#delcid").attr("onclick",data);

        };
        var deltype=function (cid) {
            console.log(cid);
            $.ajax({
                url:"delType",
                type:"post",
                data:{"cid":cid},
                dataType:"json",
                success:function (data) {
                    data = eval(data);
                    console.log("进入删除操作");
                    if(data.status==="200"){
                        console.log("删除成功");
                        $("#"+cid).remove();
                    }else {
                        console.log("删除异常");
                        console.log(data.data);
                        alert(data.data);
                    }
                }
            });

        }


    </script>
</head>
<body>
<section class="content-header">
    <h1>
        类型管理
    </h1>
</section>
<section class="page-two">
    <div class="table_button">
        <button id="mytype" class="addtype">
            增加类型
        </button>

    </div>
    <div class="col-sm-5">
        <div class="type_table">
            <table style="width: 450px;" cellspacing="0" cellpadding="0" border="0" id="typetable">

                <thead style="border-top:1px solid #DDDDDD;height: 60px;">
                <tr>
                    <th class="pl40 j-multi-level jz-table-column-left">
                        <div class="jz-table-cell"><span>分类名称</span></div>
                    </th>

                    <th class="jz-table-column-center">
                        <div><span>操作</span></div>
                    </th>
                </tr>
                </thead>
                <tbody>
                <s:iterator value="categorys" var="type" status="st">
                    <s:if test="#st.index%2==0">
                        <tr id="<s:property value="cid" />" class="column_single">
                            <td class="tb-table-column-left">
                                <div><span><s:property value="name" /> </span></div>
                            </td>
                            <td class="tb-table-column-center">
                                <div><a href="javascript:void(0);" onclick="sad('<s:property value="name" />','<s:property value="cid" />')" data-toggle="modal" data-target="#del"><span><i
                                        class="fa fa-trash" aria-hidden="true"></i></span></a></div>
                            </td>
                        </tr>
                    </s:if>
                    <s:else>
                        <tr id="<s:property value="cid" />" class="column_double">
                            <td class="tb-table-column-left">
                                <div><span><s:property value="name"/></span></div>
                            </td>
                            <td class="tb-table-column-center">
                                <div><a href="javascript:void(0);" onclick="sad('<s:property value="name" />','<s:property value="cid" />')" data-toggle="modal" data-target="#del"><span><i
                                        class="fa fa-trash" aria-hidden="true"></i></span></a></div>
                            </td>
                        </tr>

                    </s:else>

                </s:iterator>
                <!-- 模态框 -->
                <div class="modal fade" id="del" style="padding-top:180px;">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">

                            <!-- 模态框头部 -->
                            <div class="modal-header">
                                <h5 class="modal-title">是否删除</h5>
                                <button type="button" class="close" data-dismiss="modal"
                                        style="width: 10px;height: 20px;position: relative;margin-top: -20px;background-color:white;">
                                    &times;
                                </button>
                            </div>

                            <!-- 模态框主体 -->
                            <div class="modal-body">
                                <i class="fa fa-crosshairs" style="color: #A94442;"></i><span id="delname"></span>
                            </div>

                            <!-- 模态框底部 -->
                            <div class="modal-footer">

                                <div class="conf">
                                    <a id="delcid" data-dismiss="modal" onclick="" href="javascript:void(0);">确定</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 模态框 -->

                </tbody>

            </table>


        </div>
    </div>


    </div>

    <div class="col-sm-5  pull-right" id="inputbox">
        <div class="type_box">
            分类名：<input type="text" class="input_box" name="type.name" id="Typename" placeholder="请输入类型名"/>
        </div>
        <div class="" style="text-align: center;">
            <a href="javascript:void(0);" class="btn btn-main" style="color: white;border-radius: 0;" id="AddType">
                添 加
            </a>

        </div>
        <div style="text-align: center;color:black;padding: 10px 0">
           <span id="error"></span>
        </div>


    </div>
</section>


</body>
<script type="text/javascript">
    $("#AddType").click(function () {
        console.log("进入AddType");
        var data = $("#Typename").val();
        // console.log(data);
        $.ajax({
            url:"addtype",
            type:"post",
            data:{"typename":data},
            dataType:"json",
            success:function (data) {
                data = eval(data);
                if(data.status === "200"){
                    console.log("保存成功");
                    // console.log(data.data.typeid);
                    // console.log(data.data.typename);
                    var da;
                    if ($("#typetable tr").length % 2 === 1) {
                        da = "<tr id='" + data.data.typeid + "' class='column_single'> ";
                    } else {
                        if ($("#typetable tr").length % 2 === 0) {

                            da = "<tr  id='" + data.data.typeid + "' class='column_double'> ";
                        }
                    }
                    da = da + "<td class='tb-table-column-left'>" +
                        "<div><span>" + data.data.typename + "</span></div>" +
                        "</td>" +
                        "<td class='tb-table-column-center'>" +
                        "<div><a href='javascript:void(0);' onclick='sad(\"" + data.data.typename + "\",\"" + data.data.typeid + "\")' data-toggle='modal' data-target='#del'><span><i " +
                        "class='fa fa-trash' aria-hidden='true'></i></span></a></div>" +
                        "</td>" +
                        "</tr>";
                    $("tbody").append(da);
                }else{
                    data.data;
                    console.log("保存失败");
                    $("#error").html(data.data);
                    console.log(data.data);
                }

            }
        });
    });



</script>

</html>
