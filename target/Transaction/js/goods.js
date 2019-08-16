//点击按钮添加数量
$(function() {
	var stock = $(".total").text();
	stock=parseInt(stock);
	console.log(stock);
	$(".productNumberSetting").keyup(function() {
		var num = $(".productNumberSetting").val();
		num = parseInt(num);
		if(isNaN(num))
			num = 1;
		if(num <= 0)
			num = 1;
		if(num > stock)
			num = stock;
		$(".productNumberSetting").val(num);
	});
	$(".increaseNumber").click(function() {
		var num = $(".productNumberSetting").val();
		num++;
		if(num > stock)
			num = stock;
		$(".productNumberSetting").val(num);
	});
	$(".decreaseNumber").click(function() {
		var num = $(".productNumberSetting").val();
		--num;
		if(num <= 0)
			num = 1;
		$(".productNumberSetting").val(num);
	});
});
//鼠标移到小图片,图片放大显示
$(function() {
	$(".smallImage").mouseenter(function() {
		var bigImageURL = $(this).attr("bigImageURL");
		$(".bigImg").attr("src", bigImageURL);
	});
	$(".bigImg").load(
		function() {
			$(".smallImage").each(function() {
				var bigImageURL = $(this).attr("bigImageURL");
				img = new Image();
				img.src = bigImageURL;
				img.onload = function() {
					$(".img4load").append($(img));
				};
			});
		}
	);
});
//添加购物车
$(function() {
	$(".addCartLink").click(function() {
		var page = "forecheckLogin";
		$.get(
			page,
			function(result) {
				if("success" == result) {
					var pid = 151;
					var num = $(".productNumberSetting").val();
					var addCartpage = "foreaddCart";
					$.get(
						addCartpage, {
							"pid": pid,
							"num": num
						},
						function(result) {
							if("success" == result) {
								$(".addCartButton").html("已加入购物车");
								$(".addCartButton").attr("disabled", "disabled");
								$(".addCartButton").css("background-color", "lightgray")
								$(".addCartButton").css("border-color", "lightgray")
								$(".addCartButton").css("color", "black")

							} else {

							}
						}
					);
				} else {
					$("#loginModal").modal('show');
				}
			}
		);
		return false;
	});
});
//立即购买
$(function() {
	$(".buyLink").click(function() {
		var page = "forecheckLogin";
		$.get(
			page,
			function(result) {
				if("success" == result) {
					var num = $(".productNumberSetting").val();
					location.href = $(".buyLink").attr("href") + "&num=" + num;
				} else {
					$("#loginModal").modal('show');
				}
			}
		);
		return false;
	});
});
//	商品详情,累计评价切换
$(function() {
	$(".productDetailTopReviewLink").click(function() {
		$(".productReviewDiv").show();
		$(".productDetailDiv").hide();
	});
	$(".productReviewTopPartSelectedLink").click(function() {
		$(".productReviewDiv").hide();
		$(".productDetailDiv").show();
	});
});

function formatMoney(num) {
	num = num.toString().replace(/\$|\,/g, '');
	if(isNaN(num))
		num = "0";
	sign = (num == (num = Math.abs(num)));
	num = Math.floor(num * 100 + 0.50000000001);
	cents = num % 100;
	num = Math.floor(num / 100).toString();
	if(cents < 10)
		cents = "0" + cents;
	for(var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
		num = num.substring(0, num.length - (4 * i + 3)) + ',' +
		num.substring(num.length - (4 * i + 3));
	return(((sign) ? '' : '-') + num + '.' + cents);
}

function checkEmpty(id, name) {
	var value = $("#" + id).val();
	if(value.length == 0) {

		$("#" + id)[0].focus();
		return false;
	}
	return true;
}
$(function() {
	$("span.leaveMessageTextareaSpan").hide();
	$("img.leaveMessageImg").click(function() {
		$(this).hide();
		$("span.leaveMessageTextareaSpan").show();
		$(".orderItemSum").css("height", "100px");
	});
});
$(function() {
	$("button.loginSubmitButton").click(function() {
		var name = $("#name").val();
		var password = $("#password").val();

		if(0 == name.length || 0 == password.length) {
			$("span.errorMessage").html("请输入账号密码");
			$(".loginErrorMessage").show();
			return false;
		}

		var page = "foreloginAjax";
		$.get(
			page, {
				"name": name,
				"password": password
			},
			function(result) {
				if("success" == result) {
					location.reload();
				} else {
					$("span.errorMessage").html("账号密码错误");
					$(".loginErrorMessage").show();
				}
			}
		);

		return true;
	});
});