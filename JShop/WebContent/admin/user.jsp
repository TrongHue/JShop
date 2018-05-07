<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<fieldset>
	<legend>User Manager</legend>

	${message}
	<form:form action="admin/user/index.htm" user="form" modelAttribute="user">
		<div class="form-group">
			<label for="id">User Name</label>
			<form:input path="id" cssClass="form-control"/>
		</div>
		
		<div class="form-group">
			<label for="name">Email</label>
			<form:input path="email" cssClass="form-control"/>
		</div>
		
		<div class="form-group">
			<label for="name">Password</label>
			<form:input path="password" cssClass="form-control"/>
		</div>
				  
		<div class="form-group">
			<button onclick="form.action='admin/user/insert.htm'" class="btn btn-default">Insert</button>
			<button onclick="form.action='admin/user/update.htm'" class="btn btn-default">Update</button>
			<a href="admin/user/delete/${id}.htm" class="btn btn-default">Delete</a>
			<a href="admin/user/index.htm" class="btn btn-default">Reset</a>
		</div>
	</form:form>	
				
	<hr>
	
	<table class="table table-default">
		<tr>
			<th>User Name</th>
			<th>Email</th>
			<th>Password</th>
			<th></th>
		</tr>
		<c:forEach var="u" items="${users}">
		<tr>
			<td>${u.id}</td>
			<td>${u.email}</td>
			<td>${u.password}</td>
			<td>
				<a href="admin/user/edit/${u.id}.htm" class="btn btn-default">Edit</a>
			</td>
		</tr>
		</c:forEach>
	</table>
		
</fieldset>