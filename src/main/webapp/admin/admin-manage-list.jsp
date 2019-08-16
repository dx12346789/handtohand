<%@ taglib prefix="s" uri="/struts-tags" %>

<script type="text/javascript" src="js/jquery.md5.js"></script>
<script src="js/UserRule.js" type="text/javascript"></script>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">添加管理员</h4>
            </div>
            <div class="modal-body">
                <span>账号:</span> <input type="text" class="form-control" placeholder="邮箱 | 手机号" name="account" id="Account">
                <span>昵称:</span> <input type="text" placeholder="昵称" id="nick" class="form-control" name="user.nickname">
                <span>密码:</span><input type="password" placeholder="密码" class="form-control" name="user.pass" id="Pwd">
                <span>确认密码:</span><input type="password" placeholder="密码" class="form-control" id="Pwd2">
            </div>
            <div class="modal-footer">
                <span id="error"><s:property value="jsonObject.data" /></span>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="contact-submit" class="btn btn-primary">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script type="text/javascript">
    $("#contact-submit").click(function () {
        $("#Account").trigger('change',['1']);
        console.log("1231231");
        if (isAccountOk) {
            if (isNickOk) {
                if (isPassOk) {
                    $("#Pwd").val($.md5($("#Pwd").val()));
                    let account = $("#Account").val();
                    let pass = $("#Pwd").val();
                    let nick = $("#nick").val();
                    $.ajax({
                        url:"register",
                        type:"post",
                        dataType:"json",
                        data:{"user.auth":1,"account":account,"user.pass":pass,"user.nickname":nick},
                        success:function (data) {
                            data = eval(data);
                            if(data.status === "200"){
                                alert("添加成功");
                                getHtml("admin-manage","toAdminManage.action");
                            }else {
                                alert("添加失败");
                            }
                        }
                    });
                    $('#myModal').modal('hide')
                } else {
                    $("#error").html("密码由6-8位的数字和字母组成");
                }
            } else {
                $("#error").html("请输入昵称");
            }
        } else {
            $("#error").html("请输入正确的手机号或邮箱");
        }
        return false;
    });
    $('#myModal').on('show.bs.modal', function () {
        // 执行一些动作...
    })
</script>
<script type="text/javascript" src="js/user.js"></script>
<!-- 内容头部 -->
<section class="content-header">
    <h1>
        管理员管理
    </h1>
    <ol class="breadcrumb pull-right ">
        <button <s:if test="#session.loginUser.auth != 2">disabled="disabled"</s:if> data-toggle="modal" data-target="#myModal" type="button" class="btn bg-olive btn-xs">
            添加管理员
        </button>
    </ol>
</section>
<!-- 内容头部 /-->
<!-- 正文区域 -->
<section class="content">
    <!-- .box-body -->
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">列表</h3>
        </div>
        <div class="box-body">
            <!-- 数据表格 -->
            <div class="table-box">
                <!--数据列表-->
                <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                    <thead>
                    <tr>
                        <th class="sorting_asc">ID</th>
                        <th class="sorting">昵称</th>
                        <th class="sorting">性别</th>
                        <th class="sorting">生日</th>
                        <th class="sorting">邮箱</th>
                        <th class="sorting">手机号</th>
                        <th class="sorting">积分</th>
                        <th class="text-center">操作</th>
                    </tr>
                    </thead>
                    <tbody id="adminBody">
                    <s:iterator value="users" var="user" status="st">
                        <tr>
                            <td>
                                <s:property value="#st.index + 1"/>
                            </td>
                            <td><s:property value="nickname"/></td>
                            <td>
                                <s:if test="sex == 0">
                                    女
                                </s:if>
                                <s:elseif test="sex == 1">
                                    男
                                </s:elseif>
                                <s:else>
                                    未知
                                </s:else>
                            </td>
                            <td><s:date name="birthday" format="yyyy-MM-dd"/></td>
                            <td><s:property value="mail"/></td>
                            <td><s:property value="telphone"/></td>
                            <td><s:property value="gold"/></td>
                            <td class="text-center operation">
                                <s:if test="status == 1">
                                    <button disabled="disabled" type="button" class="btn bg-olive btn-xs">
                                        已删除
                                    </button>
                                </s:if>
                                <s:else>
                                    <button <s:if test="#session.loginUser.uid == uid"> disabled="disabled"</s:if> type="button" class="btn bg-olive btn-xs" onclick='del("<s:property value="uid"/>",this)'>
                                        删除
                                    </button>
                                    <button <s:if test="#session.loginUser.uid == uid"> disabled="disabled"</s:if> type="button" class="btn bg-olive btn-xs" onclick='free("<s:property value="uid"/>",this)'><s:if test="status == 2">已冻结</s:if><s:else>冻结</s:else></button>
                                    <button <s:if test="#session.loginUser.uid == uid"> disabled="disabled"</s:if> type="button" class="btn bg-olive btn-xs" onclick='updatePass("<s:property value="uid"/>")'>
                                        重置密码
                                    </button>
                                </s:else>
                            </td>
                        </tr>
                    </s:iterator>
                    <s:if test="#session.loginUser.auth != 2">
                        <script >
                            var btn = $(".operation").children("button");
                            console.log(btn)
                            $.each(btn,function (index,item) {
                                $(item).attr("disabled","disabled");
                            });
                        </script>
                    </s:if>
                    </tbody>
                </table>
                <!--数据列表/-->
            </div>
            <!-- 数据表格 /-->
        </div>
        <!-- /.box-body -->

        <!-- .box-footer-->
        <div class="box-footer">
            <div class="pull-left">
                <div class="form-group form-inline">
                    总共1页，共<s:property value="users.size()"/> 条数据。
                </div>
            </div>

            <div class="box-tools pull-right">
                <ul class="pagination">
                    <li>
                        <a href="javascript:void(0);" aria-label="Previous">首页</a>
                    </li>
                    <li><a href="javascript:void(0);">上一页</a></li>
                    <li><a href="javascript:void(0);">1</a></li>
                    <li><a href="javascript:void(0);">下一页</a></li>
                    <li>
                        <a href="javascript:void(0);" aria-label="Next">尾页</a>
                    </li>
                </ul>
            </div>

        </div>
        <!-- /.box-footer-->
    </div>
</section>
<!-- 正文区域 /-->

<script src="admin/js/userManage.js"></script>