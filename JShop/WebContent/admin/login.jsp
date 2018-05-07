<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.validate.min.js"></script>

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
<h3>Login Administration Tool</h3>
<label class="error">${message}</label>
<form:form action="admin/login.htm" modelAttribute="master" role="form" id="login">
  <div class="form-group">
    <label for="id">User Name</label>
    <form:input path="id"
    	cssClass="form-control" placeholder="User Name"/>
  </div>
  
  <div class="form-group">
    <label for="password">Password</label>
    <form:input path="password" type="password"
    	cssClass="form-control" placeholder="Password"/>
  </div>
  
  <button class="btn btn-default">Login</button>
</form:form>