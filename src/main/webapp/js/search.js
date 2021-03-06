$(function () {
    $.ajax({
        url: "getGoodsType",
        type: "post",
        success: function (data) {
            console.log(data);
            var ul = $(".select-box").children(":last");
            console.log(ul);
            for (category of data) {
                var html = "<li value=\"" + category.cid + "\">" + category.name + "</li>";
                console.log(html);
                ul.append($(html));
            }
            addUlEvent();
        }
    });
});

function addUlEvent() {
    $(".select-box").hover(function(){
        $(this).children("ul").stop().show();
    },function(){
        $(this).children("ul").stop().hide();
    });
    $(".select-box").children('ul').find("li")
        .mousemove(function(){
            $(this).addClass('change').siblings('').removeClass('change');
        }).click(function(){
        $(this).parent().prev().text($(this).html());
        var value = $(this).attr("value");
        console.log(value);
        $("#select").attr("value",value);
        // $(this).parent().css('display','none');
        $(this).parent().stop().hide();
    });
}

$(function () {
    $("#searchText").keyup(function () {
        var name = $(this).val();
        var ul = $(".searchul");
        if (name === undefined || name.trim() === ""){
            ul.empty();
            return false;
        }
        $.ajax({
            url: "getGoodsTitle.action",
            type: "post",
            data: {"title":name},
            success: function (data) {
                ul.empty();
                for (goods of data) {
                    var li = "<li  gid=\"" + goods.gid + "\" onclick='clickGoodsName(this)'>" + goods.name + "</li>";
                    ul.append($(li));
                }
            }
        });
    });
});

var clickGoodsName = function(obj) {
    var name = $(obj).text();
    console.log(name);
    $("#searchText").val(name);
};

$(function(){
    $(".select-box").hover(function(){
        $(this).children("ul").stop().show();
    },function(){
        $(this).children("ul").stop().hide();
    });
    $(".select-box").children('ul').find("li")
        .mousemove(function(){
            $(this).addClass('change').siblings('').removeClass('change');
        }).click(function(){
        $(this).parent().prev().text($(this).html());
        // $(this).parent().css('display','none');
        $(this).parent().stop().hide();
    });
});
$(function(){
    $(".search").on("input",function(){
        var name = $(".search").val();
        if (undefined === name || name.trim() === ""){
            return false;
        }
        $(".searchul").show();
    });
    $(".searchinput").mouseleave(function(){
        $(".searchul").hide();
    });
});