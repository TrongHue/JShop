<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
$(function(){
	$("#lnkChangePassword").click(function(){
		$("#change-password-dialog").dialog("open");
		return false;
	});
	
	$("#change-password-dialog").dialog({
		width: 430, modal: true, autoOpen: false,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="change.change"/>': function(){
				uid = $("#uid").val();
				pwd = $("#pwd1").val();
				pwd21 = $("#pwd21").val();
				pwd22 = $("#pwd22").val();
				
				if(pwd21 != pwd22){
					jalert({message:'<spring:message code="change.match"/>'});
				}
				
				else{
					$.ajax({
						url:"account/change2.htm",
						data: "id=" + uid + "&pw=" + pwd + "&pw2=" + pwd21,
						success: function(response){
							if(response == "true"){
								jalert({
									message:'<spring:message code="change.success"/>',
									callback:function(){
										$("#change-password-dialog").dialog("close");
									}
								});
							}
							else{
								jalert({message:'<spring:message code="change.error"/>'});
							}
						}
					});
				}
			},
			'<spring:message code="change.close"/>': function(){
				$("#change-password-dialog").dialog("close");
			}
		}
	});
	$("#uid, #pwd1, #pwd21, #pwd22").css({width:"390px"});
});
</script>
<div hidden=true id="change-password-dialog" title="<spring:message code="change.title"/>">
	<table cellpadding="1">
	<tr>
		<td><spring:message code="change.id"/>:</td>
	</tr>
	<tr>
		<td><input id="uid" value="${user.id}"></td>
	</tr>
	<tr>
		<td><spring:message code="change.oldpw"/>:</td>
	</tr>
	<tr>
		<td><input id="pwd1" type="password"></td>
	</tr>
	<tr>
		<td><spring:message code="change.newpw"/>:</td>
	</tr>
	<tr>
		<td><input id="pwd21" type="password"></td>
	</tr>
	<tr>
		<td><spring:message code="change.retype"/>:</td>
	</tr>
	<tr>
		<td><input id="pwd22" type="password"></td>
	</tr>
	</table>
</div>
<jsp:include page="JDialogs.jsp"></jsp:include>