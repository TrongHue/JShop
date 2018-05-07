<%@page import="jshop.utils.XCaptcha"%>
<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.validate.min.js"></script>

<h1><spring:message code="register.title"/></h1>

<script type="text/javascript">
	$(function() {
		$("#register")
				.validate(
						{
							rules : {
								id : {
									required : true
								},
								email : {
									email : true,
									required : true
								},
								password : {
									required : true,
									minlength : 6
								},
								fullname : {
									required : true
								}
							},
							messages : {
								id : {
									required : '<spring:message code="register.validate.id"/>'
								},
								password : {
									required : '<spring:message code="register.validate.passwordRq"/>',
									minlength : '<spring:message code="register.validate.password"/>'
								},
								email : {
									email : '<spring:message code="register.validate.email"/>',
									required : '<spring:message code="register.validate.emailRq"/>'
								},
								fullname : {
									required : '<spring:message code="register.validate.fullname"/>'
								}
							}
						});
	});
</script>
<style>
label.error {
	color: red;
	font-style: italic;
	padding-left: 20px;
	background: url("images/anifire.gif") no-repeat left center;
}
</style>

<label class="error"><spring:message code="${message}"/></label>

<form:form action="account/register.htm" modelAttribute="user"
	enctype="multipart/form-data" role="form" id="register">

	<div class="form-group">
		<label for="id"><spring:message code="register.id"/></label>
		<form:input path="id" cssClass="form-control" placeholder="User Name" />
	</div>

	<div class="form-group">
		<label for="password"><spring:message code="register.pw"/></label>
		<form:input path="password" cssClass="form-control"
			placeholder="Password" />
	</div>

	<div class="form-group">
		<label for="fullname"><spring:message code="register.fullname"/></label>
		<form:input path="fullname" cssClass="form-control"
			placeholder="Full Name" />
	</div>

	<div class="form-group">
		<label for="email"><spring:message code="register.em"/></label>
		<form:input path="email" cssClass="form-control"
			placeholder="Email Address" />
	</div>
	
	<div class="form-group">
		<label for="photo"><spring:message code="register.pt"/></label> <input type="file" name="file_photo">
	</div>

	<input type="hidden" name="activated" value="false">

	<button type="submit" class="btn btn-default"><spring:message code="register.submitButton"/></button>
</form:form>
