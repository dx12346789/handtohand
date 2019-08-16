var sendManage = function (url, data) {
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
var del = function (nid,obj) {
    let url = "delReport";
    let data = {"nid":nid};
    sendManage(url,data);
    $(obj).parent().parent().remove();
};

var updatestatux = function (nid,obj) {
    let url = "updateStatus";
    let data = {"nid":nid};
    sendManage(url,data);
    $(obj).text("已读");
};