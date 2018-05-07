<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.validate.min.js"></script>

<script type="text/javascript">
	$(function(){
		$("#editProfile").validate({
			rules:{
				id:{required: true},
				fullname:{required: true},
				email:{required: true,email: true}
			},
			messages:{
				id:{required:'<spring:message code="register.validate.id"/>'},
				fullname:{required:'<spring:message code="register.validate.fullname"/>'},
				email:{required:'<spring:message code="register.validate.emailRq"/>',email: '<spring:message code="register.validate.email"/>'}
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

<h1><spring:message code="profile.title"/></h1>

<h3>${message}</h3>
<form:form action="account/edit.htm" modelAttribute="user" 
	enctype="multipart/form-data" role="form" id="editProfile">
 
  <div class="form-group">
    <label for="id"><spring:message code="login.id"/></label>
    <form:input path="id" 
    	cssClass="form-control"/>
  </div>
  
  <form:hidden path="password"/>
  
  <div class="form-group">
    <label for="fullname"><spring:message code="register.fullname"/></label>
    <form:input path="fullname" 
    	cssClass="form-control"/>
  </div>
  
  <div class="form-group">
    <label for="email"><spring:message code="register.em"/></label>
    <form:input path="email" 
    	cssClass="form-control"/>
  </div>
  
  <div class="form-group">
    <label for="photo"><spring:message code="register.pt"/>Photo</label>
    <br>
    <input type="file" name="file_photo"><br/>
    <img style="max-width: 200px" src="images/customers/${user.photo}">
    <form:hidden path="photo"/>
  </div>
  
  <form:hidden path="activated"/>
  
  <button class="btn btn-default">Update</button>
</form:form>