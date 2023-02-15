//自定义验证方法
jQuery.validator.addMethod("isMobile", function(value, element) {
	var length = value.length;
	var mobile = /^(13[0-9])\d{8}$/;
	return this.optional(element) || (length == 11 && mobile.test(value));
}, "请正确填写您的手机号码");

//jQuery.validate的optional(element)，用于表单控件的值不为空时才触发验证。
//当element为空时this.optional(element)=true，用于在该控件为非必填项目时可以通过验证，及条件可以不填但是不能填错格式。