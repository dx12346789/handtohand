/**
 * sendMessage  发送消息
 * loadHistory 加载历史信息
 * loadMessage 页面进入加载信息
 * unreadMessage 未读信息
 * listMessage 消息列表
 */
var hostname;
var port;
var path;
var selfId;
var targetId;
var ws;

$(function () {
    hostname = document.location.hostname;
    port = document.location.port;
    path = "/Transaction";
    selfId = $("#uid").text().trim();
    console.log(selfId);
    ws = new WebSocket("ws://" + hostname + ":" + port + path + "/websocket/" + selfId + "/" + $("#destId").text().trim());

    $("#text").keyup(function (evt) {
        if (evt.which === 13 && !evt.ctrlKey) {
            var msg = $(this).val();
            msg = packMsg(msg);
            doSend(msg);
            $(this).val('');
        }
        if (evt.which === 13 && evt.ctrlKey) {
            var msg = $(this).val();
            msg += "\r\n";
            $(this).val(msg);
        }
    });
    $("#submit").click(function () {
        var msg = $("#text").val();
        msg = packMsg(msg);
        doSend(msg);
        $("#text").val('');
    });


    ws.onopen = function (ev) {
        alert("点击发起聊天的目标即可聊天");
        console.log(ev);
    };

    ws.onerror = function (ev) {
        alert('异常错误，请刷新页面');
        console.log(ev);
    };

    ws.onmessage = function (ev) {
        var msg = ev.data;
        console.log(ev);
        console.log(msg);
        parseMsg(msg);
    };

    $("#histStart").on("click", function () {
        //点击加载历史消息
        var histtime = $("#hists").children(":first").find(".msg-ball").attr("time");
        var time = histtime || $("#msgs").children(":first").find(".msg-ball").attr("time");
        console.log(time);
        var param = "{\"data\":\"loadHistory\",\"message\":{\"destId\":\"" + targetId + "\",\"srcId\":\"" + selfId + "\",\"time\":\"" + time + "\"}}";
        console.log(param);
        doSend(param);
    });
});

/**
 * 将空格和回车这两个特殊字符转成html格式
 * @param msg
 * @returns {string}
 */
function packMsg(msg) {
    console.log(msg.length);
    if (msg === "" || msg === null || msg === undefined) {
        alert("不能发送空信息");
    } else {
        console.log(msg);
        msg = msg.replace(new RegExp("\n", "g"), "<br/>").replace(new RegExp(" ", "g"), "&nbsp;");
        console.log(msg);
        var tId = targetId || $("#destId").text().trim();
        return "{\"data\":\"sendMessage\",\"message\":{\"destId\":\"" + tId + "\",\"srcId\":\"" + selfId + "\",\"message\":\"" + msg + "\"}}";
    }
}

/**
 *  * sendMessage  发送消息
 * loadHistory 加载历史信息
 * loadMessage 页面进入加载信息
 * unreadMessage 未读信息
 * listMessage 消息列表
 */
function parseMsg(msg) {
    msg = jQuery.parseJSON(msg);
    console.log(msg);
    var messages = msg.message;
    console.log(messages);
    if (msg.data === "loadHistory") {
        //同下
        for (message of messages) {
            console.log(message);
            var result = createMessageHtml(message);
            appendHistoryHtml(result);
        }
        downScroll();
    } else if (msg.data === "loadMessage") {
        //src:uid、nickname、headImage    dest:uid、nickname、headImaage   message   time
        for (message of messages) {
            console.log(message);
            var result = createMessageHtml(message);
            appendLoadHtml(result);
        }
        downScroll();
        changeMesssageStauts();
    } else if (msg.data === "unreadMessage") {
        // uid、count
    } else if (msg.data === "listMessage") {
        // uid、nickname、headIamge
        for (message of messages) {
            console.log(message);
            if (message.uid === selfId) continue;
            var result = createListHtml(message);
            appendListHtml(result);
        }
    } else if (msg.data === "sendMessage") {

        for (message of messages) {
            console.log("目标id" + message.dest.uid);
            console.log("来源id" + message.src.uid);
            console.log("selfid" + selfId);
            console.log("targetid" + targetId);
            if ((message.src.uid === targetId && message.dest.uid === selfId) ||(message.src.uid === selfId && message.dest.uid === targetId)) {
                console.log(123);
                var result = createMessageHtml(message);
                appendMessageHtml(result);
            } else if (message.dest.uid === selfId && message.src.uid !== targetId ) {
                console.log(456);
                createUnreadMessage(message);
            }

        }
        downScroll();
    }
}

/**
 *  src包含 uid、nickname、headImage
 *  dest包含 uid、nickname、headImage
 *  message对应发送的信息
 *  time就是发送的时间
 * */
function createMessageHtml(msg) {
    var src = msg.src;
    var dest = msg.dest;
    var result = "";
    if (src.uid === selfId) {  //显示在自己这里
        result = "<div class=\"msg robot\">\n" +
            "     <div class=\"msg-right\" uid=\"" + src.uid + "\">\n" +
            "    <div class=\"msg-host photo\" style=\"background-image: url('" + src.headImage + "');\"></div>\n" +
            "      <div class=\"msg-ball\" title=\"" + timeStamp2String(msg.time) + "\" time='" + msg.time + "'>" + msg.message + "</div>\n" +
            "                        </div>\n" +
            "                    </div>";
    } else {   //显示在对方那里
        result = "   <div class=\"msg guest\">\n" +
            "         <div class=\"msg-left\" worker=\"" + src.nickname + "\" uid=\"" + src.uid + "\">\n" +
            "         <div class=\"msg-host photo\" style=\"background-image: url('" + src.headImage + "')\"></div>\n" +
            "         <div class=\"msg-ball\" title=\"" + timeStamp2String(msg.time) + "\" time='" + msg.time + "'>"+ msg.message + "</div>\n" +
            "         </div>\n" +
            "         </div>";
    }
    return result;
}

/**
 * headImage 用户头像
 * uid 用户id
 * nickname 用户名
 * 创建消息列表
 */
var createListHtml = function (msg) {
    var hidden = msg.count === 0 ? "hidden" : "";
    var result = " <div class=\"chat-user\">\n" +
        "                                <span class=\"pull-right label label-primary " + hidden + "\">" + msg.count + "</span>\n" +
        "                                <img class=\"chat-avatar\" src=\" " + msg.headImage + " \" alt />\n" +
        "                                <div class=\"chat-name \" onclick='nicknameClick(this);'>\n" +
        "                                    <a href=\"#\" uid=\"" + msg.uid + "\"> " + msg.nickname + " </a>\n" +
        "                                </div>\n" +
        "                            </div>";
    return result;
};

var createUnreadMessage = function (msg) {
    isChat(msg);
    console.log("消息进来了");
    var div = $($(".chat-name").find("a[uid=\"" + msg.src.uid + "\"]").parents(".chat-user")[0]);
    var span = $(div).children(":first");
    console.log(span);
    span.removeClass("hidden");
    var count = Number(span.text());
    count++;
    console.log(count);
    span.text(count);
};

function doSend(msg) {
    console.log(msg);
    ws.send(msg);
}

function appendMessageHtml(msg) {
    $("#msgs").append($(msg));
}

function appendLoadHtml(msg) {
    $("#msgs").prepend($(msg));
}

function appendHistoryHtml(msg) {
    $("#hists").prepend($(msg));
}

function appendListHtml(msg) {
    $(".chat-list").prepend($(msg));
}

var nicknameClick = function (obj) {
    $("#msgs").empty();
    $("#hists").empty();
    changeMesssageStauts();
    var div = $(obj).parents(".chat-user")[0];
    var span = $(div).children(":first");
    span.addClass("hidden");
    span.text(0);
    var newId = $(obj).children(":first").attr("uid").trim()
    console.log($(obj).children(":first").attr("uid"));
    if (newId === targetId) {
        return false;
    }
    targetId = newId;
    $(".chat-user").each(function () {
        $(this).removeClass("now-chat");
    });
    var div1 = $(obj).parents('.chat-user');
    console.log(div1);
    $(div1).addClass('now-chat');
    var param = "{\"data\":\"loadMessage\",\"message\":{\"destId\":\"" + targetId + "\",\"srcId\":\"" + selfId + "\"}}";
    console.log(param);
    doSend(param);
};

function changeMesssageStauts(){
    var param = "{\"data\":\"changeStatus\",\"message\":{\"destId\":\"" + selfId + "\",\"srcId\":\"" + targetId + "\"}}";
    console.log(param);
    doSend(param);
}


function downScroll() {
    var scrollDiv = $("#show");
    console.log(scrollDiv[0].scrollHeight);
    scrollDiv.scrollTop(scrollDiv[0].scrollHeight);
    console.log(scrollDiv);

}

function isChat(msg){
    console.log("判断是否聊天");
    var ischat = 0;
    $(".chat-name").each(function () {
        var uid = $(this).find("a[uid=" + msg.dest.uid + "]").attr("uid");
        console.log(uid);
        if (uid !== undefined){
            ischat = 1;
        } else{
            uid = $(this).find("a[uid=" + msg.src.uid + "]").attr("uid");
            if (uid !== undefined) {
                ischat = 2;
            }
            console.log(uid);
        }
    });
    var result;
    if (ischat === 0) {
        if (msg.dest.uid === selfId){
            msg.src.count = 0;
            result = createListHtml(msg.src);
            appendListHtml(result);
        } else if (msg.src.uid === selfId) {
            msg.dest.count = 0;
            result = createListHtml(msg.dest);
            appendListHtml(result);
        }
    }
}

function timeStamp2String(time){
    var datetime = new Date();
    datetime.setTime(time);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
    var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
    var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
    var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
    return year + "-" + month + "-" + date+" "+hour+":"+minute+":"+second;
}