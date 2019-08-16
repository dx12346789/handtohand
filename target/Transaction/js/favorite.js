var mouseIn = function (obj) {
    $(obj).find(".type").show();
    $(obj).find(".shop").show();
}
var mouseLeave = function (obj) {
    $(obj).find(".type").hide();
    $(obj).find(".shop").hide();
}
$(function(){
    $(".dimmed_goods").click(function(){
        $(".figure2").show();
        $(".figure1").hide();
        $(this).addClass("active");
        $(this).prev().removeClass("active");
    });
    $(".all_goods").click(function(){
        $(".figure1").show();
        $(".figure2").hide();
        $(this).addClass("active");
        $(this).next().removeClass("active");
    });
});
//批量管理按钮
$(function (){
    var hide = true;
    $(".batchManagement").click(function () {
        if (hide){
            $(".management").show();
            $(".selOne").show();
            hide=false;
        } else {
            $(".management").hide();
            $(".selOne").hide();
            hide=true;
        }

        number = $(".cartProductItemIfSelected").length;
    });
});

var number = 0;
var selectNumber = 0;
//全选按钮
var allItemClick = function (obj) {
    var selectit = $(obj).attr("selectit");
    var param;
    if ("false" === selectit) {
        //选中
        param = {"img":$(obj),"imgPath":"images/cartSelected.png","selectit":"selectit"};
        setClickStyle(param);
        selectNumber = number;
        $(".cartProductItemIfSelected[selectit=false]").each(function () {
            param = {"img":$(this),"imgPath":"images/cartSelected.png","selectit":"selectit"};
            setClickStyle(param);
        });
    } else {
        //取消选中
        param = {"img":$(obj),"imgPath":"images/cartNotSelected.png","selectit":"false"};
        setClickStyle(param);
        $(".cartProductItemIfSelected[selectit=selectit]").each(function () {
            console.log($(this));
            param = {"img":$(this),"imgPath":"images/cartNotSelected.png","selectit":"false"};
            setClickStyle(param);
        });
        selectNumber = 0;
    }

};

// 单选框
var goodsTRClick = function (obj) {
    var param;
    var img = $(obj);
    if ('false' === img.attr('selectit')) {
        selectNumber++;
        param = {"img":obj,"imgPath":"images/cartSelected.png","selectit":"selectit"};
    } else {
        selectNumber--;
        param = {"img":obj,"imgPath":"images/cartNotSelected.png","selectit":"false"};
    }
    console.log(selectNumber);
    console.log(number);
    setClickStyle(param);
    asyncSelect();
};
function asyncSelect(){
    var param;
    if (selectNumber === number) {
        param = {"img":".selectAllItem","selectit":"selectit","imgPath":"images/cartSelected.png"};
    } else {
        param = {"img":".selectAllItem","selectit":"false","imgPath":"images/cartNotSelected.png"};
    }
    setClickStyle(param);
}
function setClickStyle(param) {
    if (param.obj !== undefined) {
        $(param.obj).css('background', param.color);
        $(param.obj).attr('selectit', param.selectit);
    }
    if (param.img !== undefined) {
        $(param.img).attr('src', param.imgPath);
        $(param.img).attr('selectit', param.selectit);
    }
}

function batchdeletel() {
    var gid = "";
    $(".cartProductItemIfSelected[selectit=selectit]").each(function () {
        gid +="&gid=" + $(this).attr("gid");
    });
    console.log(gid);
    gid = gid.substring(1);
    console.log(gid);
    f(gid);

}
function deletel(obj) {
   var gid="gid=" + $(obj).attr("gid");
   console.log(gid);
   f(gid);
}
function f(gid) {
    location.href="deletefavorite?" + gid;
}