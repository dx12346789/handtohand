function formatMoney(num) {
    num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num))
        num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10)
        cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
        num = num.substring(0, num.length - (4 * i + 3)) + ',' +
            num.substring(num.length - (4 * i + 3));
    return (((sign) ? '' : '-') + num + '.' + cents);
}

function createItem(msg) {
    var name = msg.name.substring(0,10) + "..." || msg.name;
    var html = "<!-- Cart Item -->\n" +
        "     <div class=\"media\" sid=\"" + msg.sid + "\" gid=\"" + msg.gid + "\">\n" +
        "      <a class=\"pull-left\" href=\"#\">\n" +
        "       <img class=\"media-object\" src=\"" + msg.imgPath.split(",")[0] + "\" alt=\"image\"/>\n" +
        "       </a>\n" +
        "        <div class=\"media-body\">\n" +
        " <h6 class=\"media-heading\"><a href=\"toGoods?gid=" + msg.gid + "\" title=\"" + msg.name + "\">" + name + "</a></h6>\n" +
        "          <div class=\"cart-price\">\n" +
        "           <span>" + msg.count + " x</span>\n" +
        "             <span>" + msg.price + "</span>\n" +
        "          </div>\n" +
        "           <h5><strong class=\"cartItemPrice\">$" + (msg.count * msg.price) + "</strong></h5>\n" +
        "          </div>\n" +
        "          <a href=\"javascript:void(0)\" class=\"remove\" onclick='deleteCartItem(\"" + msg.sid + "\")'><i class=\"tf-ion-close\"></i></a>\n" +
        "       </div><!-- / Cart Item -->";
    return html;
}

function deleteCartItem(sid) {
    var page = "deleteOrderItem";
    $.ajax({
        url: page,
        type: "post",
        data: {"result":sid},
        success: function(data) {
            if ("success" === data.trim()){
                var obj = $(".media[sid=" + sid + "]");
                obj.hide();
                getTotalPrice();
            } else {
                alert("请先登录");
                location.href = "tologin.action";
            }
        }
    });
}

function getTotalPrice(){
    var totalPrice = 0;
    $(".cartItemPrice").each(function () {
        totalPrice += Number($(this).text().substring(1));
    });
    $(".total-price").text("$" + totalPrice);
}
$(function () {
    $(".createOrderButton").on('click',function () {
        var gid = "";
        $(".media").each(function () {
            gid += "&gid=" + $(this).attr("gid");
        });
        console.log(gid);
        gid = gid.substring(1);
        console.log(gid);
        location.href = "tobuyitem?" + gid;
    });
});
$(function(){
    $(".clearItem").on("click",function () {
        var sid = "";
        $(".media").each(function () {
            sid = $(this).attr("sid");
            $(this).remove();
            $.ajax({
                url: "deleteOrderItem",
                type: "post",
                data: {"result":sid},
                success:function () {
                    getTotalPrice();
                }
            });
        });

    });
});