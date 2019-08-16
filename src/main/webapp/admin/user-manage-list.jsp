<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- 内容头部 -->
<section class="content-header">
    <h1>
        用户管理
    </h1>
</section>
<!-- 内容头部 /-->
<!-- 正文区域 -->
<section class="content">
    <!-- .box-body -->
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">列表</h3>
            <button type="button" onclick="window.location.href='exportUser.action'" class="btn bg-olive btn-xs pull-right">
                导出
            </button>

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
                    <tbody>
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
                            <td class="text-center">
                                <s:if test="status == 1">
                                    <button disabled="disabled" type="button" class="btn bg-olive btn-xs">
                                        已删除
                                    </button>
                                </s:if>
                                <s:else>
                                    <button type="button" class="btn bg-olive btn-xs" onclick='del("<s:property value="uid"/>",this)'>
                                        删除
                                    </button>
                                    <button type="button" class="btn bg-olive btn-xs" onclick='free("<s:property value="uid"/>",this)'><s:if test="status == 2">已冻结</s:if><s:else>冻结</s:else></button>
                                    <button type="button" class="btn bg-olive btn-xs" onclick='updatePass("<s:property value="uid"/>")'>
                                        重置密码
                                    </button>
                                </s:else>
                            </td>
                        </tr>
                    </s:iterator>
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