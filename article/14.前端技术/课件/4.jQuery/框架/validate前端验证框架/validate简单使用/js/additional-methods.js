jQuery.validator.addMethod("isMobile", function(value, element) {
	var length = value.length;
	var mobile = /^(13[0-9])\d{8}$/;
	return this.optional(element) || (length == 11 && mobile.test(value));
}, "请正确填写您的手机号码");