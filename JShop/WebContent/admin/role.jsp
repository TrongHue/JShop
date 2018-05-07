<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<fieldset>
	<legend>Role Manager</legend>

	${message}
	<form:form action="admin/role/index.htm" role="form" modelAttribute="role">
		<div class="form-group">
			<label for="id">Role Id</label>
			<form:input path="id" cssClass="form-control"/>
		</div>
		
		<div class="form-group">
			<label for="name">Role Name</label>
			<form:input path="name" cssClass="form-control"/>
		</div>
				  
		<div class="form-group">
			<button onclick="form.action='admin/role/insert.htm'" class="btn btn-default">Insert</button>
			<button onclick="form.action='admin/role/update.htm'" class="btn btn-default">Update</button>
			<a href="admin/role/delete/${id}.htm" class="btn btn-default">Delete</a>
			<a href="admin/role/index.htm" class="btn btn-default">Reset</a>
		</div>
	</form:form>	
				
	<hr>
	
	<table class="table table-default">
		<tr>
			<th>Role Id</th>
			<th>Role Name</th>
			<th></th>
		</tr>
		<c:forEach var="r" items="${roles}">
		<tr>
			<td>${r.id}</td>
			<td>${r.name}</td>
			<td>
				<a href="admin/role/edit/${r.id}.htm" class="btn btn-default">Edit</a>
			</td>
		</tr>
		</c:forEach>
	</table>
		
</fieldset>