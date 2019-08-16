/**
 * 账号规则
 */

/**
 * 内容是否是邮箱
 * @param content
 * @returns {boolean}
 */
var isMail = function (content) {
    var email = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
    return email.test(content);
};

/**
 * 内容是否是电话
 * @param content
 * @returns {boolean}
 */
var isPhone = function (content) {
    // var phone = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
    var phone = /^1[34578]\d{9}$/;
    return phone.test(content);
};

/**
 * 判断密码是否符合规则
 * @param content
 * @returns {boolean}
 */
var isPass = function (content) {
    var pass = /^[a-zA-Z0-9]{6,8}$/;
    return pass.test(content);
};

/**
 * 判断联系方式是否正确
 */
var isAccount = function (account) {
    let isOk = false;
    if (isMail(account)) {
        isOk = true;
    } else if (isPhone(account)) {
        isOk = true;
    } else {
        isOk = false;
    }
    return isOk;
};

/**
 * 验证码用户名
 * @param content
 */
var isNickName = function (content) {
    var nickName = /^[a-zA-Z\u4e00-\u9fa5]{4,8}$/;
    return nickName.test(content);
};


/**
 * 判断两个密码是否一致
 * @param content1
 * @param content2
 * @returns {boolean}
 */
var isSamePass = function (content1, content2) {
    return content1 === content2;
};


var checkAccount = function (account,obj) {
    account = account.trim();
    $.ajax({
        url: "checkaccount",
        type:"post",
        dataType:"json",
        data:{"account":account},
        success:function (data) {
            data = eval(data);
            obj(data.data);
        }
    });
};

/**
 * 获取图片验证码
 * @param label 标签
 */
var getCountCode = function (label) {
    $(label).attr("src", "getCountCode?t=" + new Date());
};

/**
 * 获取手机或邮箱验证码
 * @param content
 */
var getCode = function (content, obj, localtime) {
    var url = "";
    var data = {"receiver": content};
    console.log(content);
    if (isMail(content)) {
        url = "getRegisterEmailCode";
    } else if (isPhone(content)) {
        url = "getRegisterPhoneCode";
    } else {
        return false;
    }
    time = localtime;
    setTime(obj);
    $.ajax({
        url: url,
        type: "post",
        async: true,
        dataType: "json",
        data: data,
        success: function (data) {
            data = eval(data);
            if (data.status === "200") {
                console.log("发送成功");
            } else {
                console.log("发送失败");
            }
        }
    });
};

/**
 * 检查验证码是否正确
 * @param content
 * @returns {boolean}
 */
var checkCode = function (content, status) {
    $.ajax({
        url: "checkCode",
        type: "post",
        dataType: "json",
        async: true,
        data: {"newCode": content},
        success: function (data) {
            data = eval(data);
            status(data.status === "200");
        }
    });
};


/**
 * 取验证码时长
 * @type {number}
 */
var time;

/**
 * 倒计时
 */
var setTime = function (obj) {
    if (time === 0) {
        time = 60;
        isGetCode = true;
        $(obj).text("获取验证码");
        $(obj).removeAttr("disabled");
        return;
    } else {
        $(obj).attr("disabled", "disabled");
        isGetCode = false;
        time--;
        $(obj).text(time);
    }
    setTimeout(function () {
        setTime(obj);
    }, 1000);
};

