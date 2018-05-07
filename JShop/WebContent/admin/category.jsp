<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<fieldset>
	<legend>Quản Lý Danh Mục Hàng Hóa</legend>
	
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a href="#edit" role="tab" data-toggle="tab">CẬP NHẬT</a></li>
		<li><a href="#list" role="tab" data-toggle="tab">DANH SÁCH</a></li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content">
		<div class="tab-pane active" id="edit">
			${message}
			<form:form action="admin/category/index.htm" modelAttribute="category" 
				enctype="multipart/form-data" role="form">
				<div class="form-group">
					
					<form:hidden path="id" cssClass="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="name">Tên loại hàng - tiếng Anh</label>
					<form:input path="name" cssClass="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="nameVN">Tên loại hàng - tiếng Việt</label>
					<form:input path="nameVN" cssClass="form-control"/>
				</div>
						  
				<div class="form-group">
					<button onclick="form.action='admin/category/insert.htm'" class="btn btn-default">Thêm mới</button>
					<button onclick="form.action='admin/category/update.htm'" class="btn btn-default">Cập nhật</button>
					<a href="admin/category/delete/${id}.htm" class="btn btn-default">Xóa</a>
					<a href="admin/category/index.htm" class="btn btn-default">Nhập lại</a>
				</div>
			</form:form>	
					
		</div>
		
		<div class="tab-pane" id="list">
		
			<table class="table table-default">
			<tr>
				<th>Mã loại hàng hóa</th>
				<th>Tên loại hàng - tiếng Anh</th>
				<th>Tên loại hàng - tiếng Việt</th>
				<th></th>
			</tr>
			<c:forEach var="c" items="${categories}">
			<tr>
				<td>${c.id}</td>
				<td>${c.name}</td>
				<td>${c.nameVN}</td>
				<td>
					<a href="admin/category/edit/${c.id}.htm" class="btn btn-default">Sửa</a>
				</td>
			</tr>
			</c:forEach>
			</table>	
					
		</div>
	</div>
</fieldset>