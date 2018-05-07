<%@page import="java.net.URLEncoder"%>
<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
	
<h1><spring:message code="login.title"/></h1>
<script type="text/javascript">
	$(function(){
		$("#login").validate({
			rules:{
				id:{required: true},
				password:{required: true}
			},
			messages:{
				id:{required:'<spring:message code="login.validate.id"/>'},
				password:{required:'<spring:message code="login.validate.password"/>'}
			}
		});
	});
</script>
	
<style>
label.error{
	color: red;
	font-style: italic;
	padding-left: 20px;
	background: url("images/anifire.gif") no-repeat left center;
}
</style>
<label class="error"><spring:message code="${message}"/></label>

<form:form action="account/login.htm" modelAttribute="user" role="form" id="login">

  <div class="form-group" style="width: 300px">
    <label for="id"><spring:message code="login.id"/></label>
    <form:input path="id"
    	cssClass="form-control" placeholder="User Name"/>
  </div>
  
  <div class="form-group" style="width: 300px">
    <label for="password"><spring:message code="login.pw"/></label>
    <form:input path="password"
    	cssClass="form-control" placeholder="Password"/>
  </div>
  
  <div class="checkbox">
  	<label>
  		<input type="checkbox" name="remember" value="true">
  		<spring:message code="login.rm"/>
  	</label>
  </div>
  
  <button type="submit" class="btn btn-default"><spring:message code="login.signin"/></button>
</form:form>