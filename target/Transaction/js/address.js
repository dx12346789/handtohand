var delAddress = function (Aid,obj) {
    $.ajax({
        url:"delAddress",
        type:"post",
        dataType:"json",
        data:{"aid":Aid},
        success:function (data) {
            data = eval(data);
            if(data.status === "200"){
                alert("删除成功");
                if($(obj).parent().siblings().length <= 0){
                    $(obj).parent().parent().append("<p>暂无收货地址</p>");
                }
                $(obj).parent().remove();

            }else {
                alert("删除成功");
            }
        }
    })
};