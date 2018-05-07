<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<script>
$(function(){
	$("input.datepicker").datepicker();
});
</script>
<fieldset>
	<legend>Quản Lý Hóa Đơn</legend>
	
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a href="#edit" role="tab" data-toggle="tab">CẬP NHẬT</a></li>
		<li><a href="#list" role="tab" data-toggle="tab">DANH SÁCH</a></li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content">
		<div class="tab-pane active" id="edit">
			${message}
			<form:form action="admin/order/index.htm" modelAttribute="order" 
				enctype="multipart/form-data" role="form">
				
				<div class="row">
 					 <div class="col-md-3">
 					 	<div class="form-group">
									<label for="id">Mã hoá đơn</label>
									<form:input path="id" cssClass="form-control" />
						</div>
						<img alt="Order IMage" src="images/others/orderImage.png">
 					 </div>
 					 <div class="col-md-9">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="amount">Tổng tiền hóa đơn</label>
									<form:input path="amount" cssClass="form-control" />
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="customer.id">Mã khách hàng đặt</label>
									<form:input path="customer.id" cssClass="form-control" />
									<a>${order.customer.fullname}</a>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="orderDate">Ngày đặt</label>
									<form:input path="orderDate" cssClass="form-control datepicker" />
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="requireDate">Ngày cần</label>
									<form:input path="requireDate" cssClass="form-control datepicker" />
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="receiver">Người nhận</label>
									<form:input path="receiver" cssClass="form-control" />
								</div>
							</div>
							<div class="col-md-8">
								<div class="form-group">
									<label for="address">Địa chỉ</label>
									<form:input path="address" cssClass="form-control" />
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label for="description">Ghi chú</label>
									<form:textarea rows="5" path="description"
										cssClass="form-control" />
								</div>
							</div>
						</div>
					</div>
				</div>
			  
				<div class="form-group">
					<button onclick="form.action='admin/order/update.htm'" class="btn btn-default">Cập nhật</button>
					<a href="admin/order/delete/${id}.htm" class="btn btn-default">Xóa</a>
				</div>
			</form:form>	
					
		</div>
		
		<div class="tab-pane" id="list">
		
			<table class="table table-default">
			<tr>
				<th>Mã hóa đơn</th>
				<th>Ngày đặt</th>
				<th>Ngày cần</th>
				<th>Tên người đặt</th>
				<th>Tên người nhận</th>
				<th></th>
			</tr>
			<c:forEach var="o" items="${orders}">
			<tr>
				<td>${o.id}</td>
				<td>${o.orderDate}</td>
				<td>${o.requireDate}</td>
				<td>${o.customer.fullname}</td>
				<td>${o.receiver}</td>
				<td>
					<a href="admin/order/edit/${o.id}.htm" class="btn btn-default">Sửa</a>
				</td>
			</tr>
			</c:forEach>
			</table>	
					
		</div>
	</div>
</fieldset>