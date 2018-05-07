<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
<head>
	<base href="${pageContext.servletContext.contextPath}/">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/nhatnghe.css" rel="stylesheet" />

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
    <link href="jquery-ui/jquery-ui.min.css" rel="stylesheet" />
    <script src="jquery-ui/jquery-ui.min.js"></script>
    <script>
	$(window).scroll(function () {
	    if ($(this).scrollTop() > 10) {
	        var $top = $('#topcControl');
	        $top.fadeIn();
	        $(".top-nav-wrap").addClass("fix");
	        $(".main-nav-wrap").addClass("fix");
	    } else {
	        $('#topcControl').fadeOut();
	        $(".top-nav-wrap").removeClass("fix");
	        $(".main-nav-wrap").removeClass("fix");
	    }
	});
	 $(document).ready(function(){
		 $('.btn_top').click(function () {
			    $("html, body").animate({ scrollTop: 0 }, 500);
			    return false;
			});
	
			$('.btn_down').click(function () {
			    $("html, body").animate({ scrollTop: $(document).height() }, 500);
			    return false;
			});		
	 })
	</script>
</head>
<body>
    <div class="container">

        <div class="navbar navbar-inverse">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="admin/home.htm" class="navbar-brand">Trang chủ</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Quản lý <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="admin/product/index.htm">Hàng hóa</a></li>
                            <li><a href="admin/supplier/index.htm">Nhà cung cấp</a></li>
                            <li><a href="admin/category/index.htm">Chủng loại</a></li>
                            <li><a href="admin/customer/index.htm">Khách hàng</a></li>
                            <li><a href="admin/order/index.htm">Hóa đơn</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Thống kê <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li class="media-heading">Kiểm kê hàng tồn</li>
                            <li><a href="admin/inventory/by-category.htm">Theo loại</a></li>
                            <li><a href="admin/inventory/by-supplier.htm">Theo hãng</a></li>
                            <li class="media-heading">Thống kê doanh số</li>
                            <li><a href="admin/revenue/by-product.htm">Theo từng mặt hàng</a></li>
                            <li><a href="admin/revenue/by-category.htm">Theo từng loại hàng</a></li>
                            <li><a href="admin/revenue/by-supplier.htm">Theo từng hãng</a></li>
                            <li><a href="admin/revenue/by-customer.htm">Theo từng khách hàng</a></li>
                            <li class="divider"></li>
                            <li><a href="admin/revenue/by-year.htm">Theo từng năm</a></li>
                            <li><a href="admin/revenue/by-quarter.htm">Theo từng quí</a></li>
                            <li><a href="admin/revenue/by-month.htm">Theo từng tháng</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" class="dropdown-toggle" data-toggle="dropdown">Tài khoản <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="admin/login.htm?logoff">Đăng xuất</a></li>
                            <li><a href="admin/user/index.htm">Quản lý tài khoản</a></li>
                            <li><a href="admin/role/index.htm">Quản lý vai trò</a></li>
                            <li class="divider"></li>
                            <li><a href="admin/user-role/index.htm">Phân vai trò</a></li>
                            <li><a href="admin/permission/index.htm">Phân quyền sử dụng</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

        <div class="nn-sheet row">

            <article class="col-md-12">
                <div class="nn-body"  style="min-height: 400px">
                	<tiles:insertAttribute name="body">Nội dung trang web</tiles:insertAttribute>
                </div>
            </article>

        </div>
        <footer class="row" style="text-align: center; vertical-align: center;">
			
			<div class="col-md-12">
				
			</div>
        </footer>
    </div>
	<div id="topcControl" class="top-control" >
	        <a class="btn_top" href="javascript:void(0);" title="Trở về đầu trang"><img src="images/contacts/up.png"></a>
	        <a href="javascript:void(0);" class="btn_down" title="Xuống cuối trang"><img src="images/contacts/down.png"></a>
	</div>
</body>
</html>