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
			<form:form action="admin/customer/index.htm" modelAttribute="customer" 
				enctype="multipart/form-data" role="form">
				
				<div class="row">
 					<div class="col-md-3">
 						<div id="avatar"><br>
 							<img alt="Avatar" src="images/customers/${customer.photo}">
 						</div><br>
						
						<input id="photo" type="file" name="file_image">
						
					</div>
					
					<div class="col-md-9">
						<form:hidden path="photo"/>
						
						<div class="form-group">
							<label for="id">Tài khoản</label>
							<form:input path="id" cssClass="form-control" />
						</div>

						<div class="form-group">
							<label for="password">Mật khẩu</label>
							<form:input path="password" cssClass="form-control" />
						</div>
						
						<label><form:checkbox path="activated"/>Kích hoạt</label>

						<div class="form-group">
							<label for="fullname">Họ tên</label>
							<form:input path="fullname" cssClass="form-control" />
						</div>

						<div class="form-group">
							<label for="email">Địa chỉ email</label>
							<form:input path="email" cssClass="form-control" />
						</div>
					</div>
				</div>
						  
				<div class="form-group">
					<button onclick="form.action='admin/customer/insert.htm'" class="btn btn-default">Thêm mới</button>
					<button onclick="form.action='admin/customer/update.htm'" class="btn btn-default">Cập nhật</button>
					<a href="admin/customer/delete/${id}.htm" class="btn btn-default">Xóa</a>
					<a href="admin/customer/index.htm" class="btn btn-default">Nhập lại</a>
				</div>
			</form:form>	
					
		</div>
		
		<div class="tab-pane" id="list">
		
			<table class="table table-default">
			<tr>
				<th>Tài khoản</th>
				<th>Mật khẩu</th>
				<th>Họ tên</th>
				<th>Email</th>
				<th>Hình ảnh</th>
				<th>Kích hoạt</th>
				<th></th>
			</tr>
			<c:forEach var="s" items="${customers}">
			<tr>
				<td>${s.id}</td>
				<td>${s.password}</td>
				<td>${s.fullname}</td>
				<td>${s.email}</td>
				<td>${s.photo}</td>
				<td>${s.activated}</td>
				<td>
					<a href="admin/customer/edit/${s.id}.htm" class="btn btn-default">Sửa</a>
				</td>
			</tr>
			</c:forEach>
			</table>	
					
		</div>
	</div>
</fieldset>

<style>
#avatar>img{
width: 200px;
height: 200px;
border: 1px solid;
border-radius: 10%;
}
</style>