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
       <style>
    		.logo{
    			width: 100%;
    			position: absolute;
    			height: 170px;
    		}
    </style>
</head>
<body>
    <div class="container">
        <header class="nn-header row">
            <img class="logo" src="images/banner.jpg"/>
        </header>

        <div class="navbar navbar-inverse row">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse">
            	<!-- Menu -->
                <tiles:insertAttribute name="menu"/>
            	<!-- /Menu -->
            </div>
        </div>

        <div class="nn-sheet row">

            <article class="col-md-9">
                <div class="nn-body">
                	<tiles:insertAttribute name="body">Nội dung trang web</tiles:insertAttribute>
                </div>
            </article>

            <aside class="col-md-3">
		        <br/>
                <!--Cart Info-->
                <tiles:insertAttribute name="cart-info"/>
                <!--/Cart Info-->
                
                <!--Search product-->
                <tiles:insertAttribute name="search"/>
                <!--/Search product-->
                <br/>
            	<br>
				
                <!--Chủng loại-->
                <tiles:insertAttribute name="category"/>
                <!--/Chủng loại-->

                <!--Nhà cung cấp-->
                <tiles:insertAttribute name="supplier"/>
                <!--/Nhà cung cấp-->

                <!--Hàng đặc biệt-->
                <tiles:insertAttribute name="special"/>
                <!--/Hàng đặc biệt-->
            </aside>
        </div>
        <footer class="row" style="text-align: center; vertical-align: center;">
			
			<div class="col-md-6">
				<div>Copyright © 2015 w3.layouts.com . All Rights Reserved</div><br>
			</div>
				<br>
			<div class="col-md-4" id="footer3">
				<hr>
				<ul class="social" >
					<li><a style="font-size: 20px;"><spring:message code="footer.contact"/></a></li>
					<li><a href="https://www.facebook.com/"><img src="images/contacts/facebook_social.png" alt="" /></a></li>
					<li><a href="https://twitter.com"><img src="images/contacts/twitter_social.png" alt="" /></a></li>
					<li><a href="https://plus.google.com"><img src="images/contacts/google_social.png" alt="" /></a></li>
				</ul>
			</div>
        </footer>
    </div>
    <script>
$(function(){
	$(".language a").click(function(){
		$.ajax({
			url:"home/set-language.htm?language="+$(this).attr("href"),
			success:function(){
				location.reload();
			}
		});
		return false;
	});
});
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
<div id="topcControl" class="top-control" >
        <a class="btn_top" href="javascript:void(0);" title="Trở về đầu trang"><img src="images/contacts/up.png"></a>
        <a href="javascript:void(0);" class="btn_down" title="Xuống cuối trang"><img src="images/contacts/down.png"></a>
    </div>
</body>
</html>