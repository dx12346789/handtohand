var sendManage = function (url, data) {
    console.log(data)
    $.ajax({
        url: url,
        type: "post",
        dataType: "json",
        data: data,
        success: function (data) {
            data = eval(data);
            console.log(data);
        }
    });
};
var del = function (uid,obj) {
    let url = "deluser";
    let data = {"uid":uid};
    sendManage(url,data);
    $(obj).html("已删除");
    $.each($(obj).siblings(),function (index,item) {
        $(item).remove();
    });
    $(obj).attr("disabled","disabled");
};
var free = function (uid,obj) {
    let url = "freezeuser";
    let data = {"uid":uid};
    sendManage(url,data);
    console.log($(obj).text());
    let content = $(obj).text().trim();
    if(content === "冻结"){
        $(obj).text("已冻结")
    }else {
        $(obj).text("冻结")
    }
};
var updatePass = function (uid) {
    let url = "adminUpdatePass";
    let data = {"uid":uid,"message":$.md5("123456")};
    sendManage(url,data);
    alert("已重置为123456");
};