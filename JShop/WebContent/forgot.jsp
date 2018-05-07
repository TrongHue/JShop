<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<h1>Forgot Password</h1>

${message}
<form:form action="account/forgot.htm" modelAttribute="user" role="form">
  
  <div class="form-group">
    <label for="id">User Name</label>
    <form:input path="id"
    	cssClass="form-control" placeholder="User Name"/>
  </div>
  
  <div class="form-group">
    <label for="email">Email Address</label>
    <form:input path="email"
    	cssClass="form-control" placeholder="Email Address"/>
  </div>
  		  
  <button type="submit" class="btn btn-default">Get Password</button>
</form:form>