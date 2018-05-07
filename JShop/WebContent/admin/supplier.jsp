<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<fieldset>
	<legend>Quản lý hãng</legend>
	
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a href="#edit" role="tab" data-toggle="tab">CẬP NHẬT</a></li>
		<li><a href="#list" role="tab" data-toggle="tab">DANH SÁCH</a></li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content">
		<div class="tab-pane active" id="edit">
			${message}
			<form:form action="admin/supplier/index.htm" modelAttribute="supplier" 
				enctype="multipart/form-data" role="form">
				<div class="form-group">
					<label for="id">Mã hãng</label>
					<form:input path="id" cssClass="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="name">Tên hãng</label>
					<form:input path="name" cssClass="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="email">Địa chỉ email</label>
					<form:input path="email" cssClass="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="phone">Điện thoại</label>
					<form:input path="phone" cssClass="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="logo">Logo</label>
					<input id="logo" type="file" name="file_logo">
					<form:hidden path="logo"/>
				</div>
						  
				<div class="form-group">
					<button onclick="form.action='admin/supplier/insert.htm'" class="btn btn-default">Thêm mới</button>
					<button onclick="form.action='admin/supplier/update.htm'" class="btn btn-default">Cập nhật</button>
					<a href="admin/supplier/delete/${id}.htm" class="btn btn-default">Xóa</a>
					<a href="admin/supplier/index.htm" class="btn btn-default">Nhập lại</a>
				</div>
			</form:form>	
					
		</div>
		
		<div class="tab-pane" id="list">
		
			<table class="table table-default">
			<tr>
				<th>Mã hãng</th>
				<th>Tên hãng</th>
				<th>Email</th>
				<th>Điện thoại</th>
				<th>Logo</th>
				<th></th>
			</tr>
			<c:forEach var="s" items="${suppliers}">
			<tr>
				<td>${s.id}</td>
				<td>${s.name}</td>
				<td>${s.email}</td>
				<td>${s.phone}</td>
				<td>${s.logo}</td>
				<td>
					<a href="admin/supplier/edit/${s.id}.htm" class="btn btn-default">Sửa</a>
				</td>
			</tr>
			</c:forEach>
			</table>	
					
		</div>
	</div>
</fieldset>