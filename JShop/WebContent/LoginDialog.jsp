<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
$(function(){
	$("#lnkLogin").click(function(){
		$("#login-dialog").dialog("open");
		return false;
	});

	$("#login-dialog").dialog({
		width: 430, modal: true, autoOpen: false,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="signin.login"/>': function(){
				uid = $("#uid").val();
				pwd = $("#pwd").val();
				rmm = $("#rmm").prop("checked");
				$.ajax({
					url:"account/login2.htm",
					data: "id=" + uid + "&password=" + pwd + "&remember=" + rmm,
					success: function(response){
						if(response == "activate"){
							jalert({message:'<spring:message code="signin.existed"/>'});
						}
						else if(response == "true"){
							jalert({
								message:'<spring:message code="signin.success"/>',
								callback:function(){
									// tải lại trang web để cập nhật trạng thái đã đăng nhập
									location.reload();
								}
							});
						}
						else{
							jalert({message:'<spring:message code="signin.error"/>'});
						}
					}
				});
			},
			"<spring:message code="signin.close"/>": function(){
				$("#login-dialog").dialog("close");
			}
		}
	});
	//$("#uid, #pwd, #email, #userId").css({width:"260px;", color:"red"});
	
	$("#lnkForgotPwd").click(function(){
		$("#forgotpwd-dialog").dialog("open");
		return false;
	});
	
	$("#forgotpwd-dialog").dialog({
		width: 430, modal: true, autoOpen: false,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="forgot.retrieve"/>': function(){
				userId = $("#userId").val();
				email = $("#email").val();
				
				$.ajax({
					url:"account/forgot2.htm",
					data: "id=" + userId + "&email=" + email,
					success: function(response){
						if(response == "true"){
							jalert({
								message:'<spring:message code="forgot.success"/>',
								callback:function(){
									$("#forgotpwd-dialog").dialog("close");
								}
							});
						}
						else if(response == "false"){
							jalert({message:'<spring:message code="forgot.error"/>'});
						}
						else {
							jalert({message: response});
						}
					}
				});
			},
			'<spring:message code="forgot.close"/>': function(){
				$("#forgotpwd-dialog").dialog("close");
			}
		}
	});
});
</script>

<div hidden="true" id="login-dialog" title="<spring:message code="signin.title"/>">
	<h6 id="login-error" style="color:red"><spring:message code="signin.prompt"/></h6>
	<table cellpadding="5">
	<tr>
		<td><spring:message code="signin.id"/></td>
		<td><input id="uid" value="${cookie.id.value}"></td>
	</tr>
	<tr>
		<td><spring:message code="signin.pw"/></td>
		<td><input id="pwd" type="password" value="${cookie.pw.value}"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input id="rmm" type="checkbox" ${empty cookie.id?'undefined':'checked'}>
			<label for="rmm"><spring:message code="signin.remember"/></label>
		</td>
	</tr>
	</table>
</div>

<div hidden="true" id="forgotpwd-dialog" title="<spring:message code="forgot.title"/>">
	<h6 id="forgotpwd-error" style="color:red">
			<spring:message code="forgot.prompt"/></h6>
	<table cellpadding="5">
	<tr>
		<td><spring:message code="forgot.id"/></td>
		<td><input id="userId"></td>
	</tr>
	<tr>
		<td><spring:message code="forgot.email"/></td>
		<td><input id="email" type="email"></td>
	</tr>
	</table>
</div>

<jsp:include page="JDialogs.jsp"></jsp:include>