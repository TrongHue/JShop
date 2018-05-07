<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
$(function(){
	$(".sendToFriend").click(function(){
		$("#sendToFriendDialog").dialog("open");
		return false;
	});

	$("#sendToFriendDialog").dialog({
		width: 430, modal: true, autoOpen: false,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="dialog.send"/>': function(){
				id = $("#id").val();
				from = $("#from").val();
				to = $("#to").val();
				subject = $("#subject").val();
				body = $("#body").val();
				$.ajax({
					url:"product/sendToFriend2.htm",
					data: "id=" + id + "&from=" + from + "&to=" +to + "&subject=" + subject+ "&body=" + body,
					success: function(response){
						if(response == "true"){
							jalert({message:'<spring:message code="dialog.success"/>'});
						}
						else {
							jalert({
								message:'<spring:message code="dialog.error"/>'});
						}
					}
				});
			},
			"<spring:message code="signin.close"/>": function(){
				$("#sendToFriendDialog").dialog("close");
			}
		}
	});
});
</script>

<div hidden="true" id="sendToFriendDialog" title="<spring:message code="dialog.title"/>">
	<h6 id="login-error" style="color:red"><spring:message code="dialog.prompt"/></h6>
	<table cellpadding="5">
	<tr>
		<td><spring:message code="dialog.from"/></td>
		<td><input  style="width: 250px" id="from" value=""></td>
	</tr>
	<tr>
		<td><spring:message code="dialog.to"/></td>
		<td><input  style="width: 250px" id="to" value=""></td>
	</tr>
	<tr>
		<td><spring:message code="dialog.subject"/></td>
		<td><input style="width: 250px" id="subject" value=""></td>
	</tr>
	<tr>
		<td><spring:message code="dialog.body"/></td>
		<td><textarea id="body" cols="30" rows="3"></textarea></td>
	</tr>
	<tr>
		<td><input type="hidden" id="id" value="<%=request.getParameter("pid")%>"></td>
	</tr>
	</table>
</div>
<jsp:include page="JDialogs.jsp"></jsp:include>
