<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<h1>Change Password</h1>

${message}
<form:form action="account/change.htm" modelAttribute="user" role="form">
 
  <div class="form-group">
    <label for="id">User Name</label>
    <form:input path="id"
    	cssClass="form-control" placeholder="User Name"/>
  </div>
  
  <div class="form-group">
    <label for="password">Current Password</label>
    <form:password path="password"
    	cssClass="form-control" placeholder="Current Password"/>
  </div>
  
  <div class="form-group">
    <label for="password">New Password</label>
    <input type="password" name="password1"
    	class="form-control" placeholder="New Password"/>
  </div>
  
  <div class="form-group">
    <label for="password">Confirm New Password</label>
    <input type="password" name="password2"
    	class="form-control" placeholder="New Password"/>
  </div>
  		  
  <button type="submit" class="btn btn-default">Change Password</button>
</form:form>