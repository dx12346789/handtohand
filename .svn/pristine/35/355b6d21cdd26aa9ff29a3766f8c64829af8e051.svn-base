<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- 内容头部 -->
<section class="content-header">
    <h1>
        消息管理
    </h1>
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
                        <th class="sorting">标题</th>
                        <th class="sorting">时间</th>
                        <th class="sorting">内容</th>
                        <th class="sorting">举报人</th>
                        <th class="sorting">被举报人</th>
                        <th class="text-center">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <s:iterator value="jsonObject.data" var="notic" status="st">
                        <tr>
                            <td>
                                <s:property value="#st.index + 1"/>
                            </td>
                            <td><s:property value="title"/></td>
                            <td><s:property value="date"/></td>
                            <td><s:property value="content"/></td>
                            <td><s:property value="sender"/></td>
                            <td><s:property value="recipient"/></td>
                            <td class="text-center">
                                <button type="button" class="btn bg-olive btn-xs" onclick='getContent("<s:property value="nid"/>",this)'>
                                    <s:if test="status == 2">
                                        已读
                                    </s:if>
                                    <s:else>
                                        未读
                                    </s:else>
                                </button>
                                <button type="button" class="btn bg-olive btn-xs" onclick='del("<s:property value="nid"/>",this)'>
                                    删除
                                </button>
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

        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="myModalLabel">举报详情</h4>
                    </div>
                    <div class="modal-body">
                        <span>标题：</span><span id="title"></span><br/>
                        <span>内容：</span>
                        <span id="contentText"></span><br/>
                        <span>举报人：</span><span id="sender"></span><br/>
                        <span>被举报人：</span><span id="recipient"></span><br/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
        <script type="text/javascript">
            var getContent = function(nid,obj){
                let objs = $(obj).parent().siblings();
                $("#title").text($(objs).eq(1).text());
                $("#contentText").text($(objs).eq(3).text());
                $("#sender").text($(objs).eq(4).text());
                $("#recipient").text($(objs).eq(5).text());
                $('#myModal').modal('show');
                if($(obj).text().trim() === "未读"){
                    updatestatux(nid,obj);
                }
            };
        </script>
        <!-- .box-footer-->
        <div class="box-footer">
            <div class="pull-left">
                <div class="form-group form-inline">
                    总共1页，共<s:property value="jsonObject.data.size()"/>条数据。
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

<script src="admin/js/message.js"></script>