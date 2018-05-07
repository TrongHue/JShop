<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<script src="/EShopV20/nicEditor/nicEdit.js" type="text/javascript"></script>

<script type="text/javascript">

	bkLib.onDomLoaded(function() {
		new nicEditor({ 
			fullPanel: true, 
			iconsPath : '/EShopV20/nicEditor/nicEditorIcons.gif', 
			uploadURI: '/EShopV20/nic-editor/upload.htm' 
		}).panelInstance('description');
	});
</script>
<script src="js/jquery-1.7.1.min.js"></script>
<script src="jquery-ui/jquery-ui.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("input#datepicker").datepicker();
		$("#productadmin").validate({
			rules:{
				unitPrice : {required : true, number:true},
				discount : {required : true, number:true},
				quantity : {required : true, digits:true},
				productDate : {required : true, date:true}
			},
			messages:{
				unitPrice : {required : 'Không được để trống!', number: 'Vui lòng nhập số' },
				discount : {required : 'Không được để trống!', number: 'Vui lòng nhập số' },
				quantity : {required : 'Không được để trống!', digits: 'Vui lòng nhập số nguyên' },
				productDate : {required : 'Không được để trống!', date:'Vui lòng nhập ngày'}
			}
		});
	});
</script>
<style>
label.error {
	color: red;
	font-style: italic;
	padding-left: 20px;
	background: url("images/anifire.gif") no-repeat left center;
}
</style>
	
<fieldset>
	<legend>Quản lý hàng hóa</legend>
	<br>
	
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a href="#edit" role="tab" data-toggle="tab">Sửa đổi</a></li>
		<li><a href="#list" role="tab" data-toggle="tab">Danh sách</a></li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content">
		<div class="tab-pane active" id="edit">
		${message}
			<form:form action="admin/product/index.htm" modelAttribute="productAd"
				enctype="multipart/form-data" role="form" id="productadmin">
				
				<div class="row">
					<div class="form-group col-md-4">
						<label for="id">Mã hàng hóa</label>
						<form:input path="id" cssClass="form-control"/>
					</div>
					
					<div class="form-group col-md-4">
						<label for="name">Tên hàng hóa</label>
						<form:input path="name" cssClass="form-control"/>
					</div>
				
					<div class="form-group col-md-4">
						<label for="unitPrice">Đơn giá</label>
						<form:input path="unitPrice" cssClass="form-control"/>
					</div>
				</div>
				
				<div class="row">	
					<div class="form-group col-md-4">
						<label for="unitBrief">Đơn vị tính</label>
						<form:input path="unitBrief" cssClass="form-control"/>
					</div>

					<div class="form-group col-md-4">
						<label for="discount">Giảm giá</label>
						<form:input path="discount" cssClass="form-control"/>
					</div>
					
					<div class="form-group col-md-4">
						<label for="quantity">Số lượng</label>
						<form:input path="quantity" cssClass="form-control"/>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-4">
						<label for="productDate">Ngày nhập</label>
						<form:input path="productDate" id="datepicker" cssClass="form-control"/>
					</div>
	
					<div class="form-group col-md-4">
						<label for="supplier.id">Nhãn hiệu</label>
						<form:select path="supplier.id" 
							items="${suppliers}" itemValue="id" itemLabel="name" cssClass="form-control"/>
					</div>

					<div class="form-group col-md-4">
						<label for="category.id">Loại</label>
						<form:select path="category.id" 
							items="${categories}" itemValue="id" itemLabel="name" cssClass="form-control"/>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-4">
						<label>Đặc điểm</label>
						<div>
							<label><form:checkbox path="available"/> Available</label>
							<label><form:checkbox path="special"/> Special</label>
							<label><form:checkbox path="latest"/> latest</label>
						</div>
					</div>
					
					<div class="form-group col-md-4">
						<label for="image">Hình ảnh</label>
						<input id="image" type="file" name="file_image">
						<form:hidden path="image"/>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-12">
						<label for="description">Mô tả</label>
						<form:textarea path="description" rows="5" cssClass="form-control"/>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-12">
						<button onclick="form.action='admin/product/insert.htm'" class="btn btn-default">Thêm mới</button>
						<button onclick="form.action='admin/product/update.htm'" class="btn btn-default">Cập nhật</button>
						<a href="admin/product/delete/${id}.htm" class="btn btn-default">Xóa</a>
						<a href="admin/product/index.htm" class="btn btn-default">Nhập lại</a>
					</div>
				</div>
				
			</form:form>			
		</div>
		
		<div class="tab-pane" id="list">
			<table class="table table-default">
			<tr>
				<th>Mã</th>
				<th>Tên</th>
				<th>Đơn giá</th>
				<th>Đơn vị</th>
				<th>Giảm giá</th>
				<th>Số lượng</th>
				<th>Loại</th>
				<th>Nhãn hiệu</th>
				<th></th>
			</tr>
			<c:forEach var="p" items="${products}">
			<tr>
				<td>${p.id}</td>
				<td>${p.name}</td>
				<td><fmt:formatNumber value="${p.unitPrice}" type="currency"/></td>
				<td>${p.unitBrief}</td>
				<td><fmt:formatNumber value="${p.discount}" type="percent"/> </td>
				<td>${p.quantity}</td>
				<td>${p.category.name}</td>
				<td>${p.supplier.name}</td>
				<td>
					<a href="admin/product/edit/${p.id}.htm" class="btn btn-default">Sửa</a>
				</td>
			</tr>
			</c:forEach>
			</table>			
		</div>
	</div>
</fieldset>