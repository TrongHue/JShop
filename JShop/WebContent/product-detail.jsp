<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="jquery-ui/jquery-ui.js"></script>

<!-- Include Cloud Zoom CSS. -->
<link rel="stylesheet" type="text/css" href="css/cloudzoom.css" />
<!-- Include Cloud Zoom script. -->
<script type="text/javascript" src="js/cloudzoom.js"></script>
<!-- Call quick start function. -->
<script type="text/javascript">
    CloudZoom.quickStart();
</script>    
        
${message }
<script type="text/javascript">
	$(function(){
		$("#sendToFriend").validate({
			rules:{
				from:{required: true,email: true},
				to:{required: true, email: true},
				subject:{required: true},
				body:{required: true}
			},
			messages:{
				from:{required:'<spring:message code="send.email.require"/>',email: '<spring:message code="register.validate.email"/>'},
				to:{required:'<spring:message code="send.email.require"/>',email: '<spring:message code="register.validate.email"/>'},
				subject:{required:'<spring:message code="send.email.require"/>'},
				body:{required:'<spring:message code="send.email.require"/>'},
			}
		});
	});
</script>
<style>
label.error{
	color: red;
	font-style: italic;
	padding-left: 20px;
	background: url("images/anifire.gif") no-repeat left center;
}
img.cloudzoom{
	width: 200px; height:200px;
	padding: 10px !important;
	border: 1px solid lightgray;
	border-radius:10px;
	box-shadow: inset 0 0 10px lightgray;
}
.producCates:hover{
opacity: 0.4;
}
.producCates img:hover{
border: 2px solid #FF0066;
width: 300px;
height: 400px;
}
li.producCates{
	margin: 0px;
}
</style>
<h1 class="page-subject"><spring:message code="detail.title"/></h1>
<table>
	<tr class="row">
		<td class="col-md-4" align="center" >
			<img style="max-width: 200px" class = "cloudzoom" data-cloudzoom = "zoomImage: 'images/products/${product.image}'" id="${product.id}" id="product" src="images/products/${product.image}"/>
			<br><a><span class="glyphicon glyphicon-zoom-in"> Rê chuột để zoom ảnh</span></a>
			<br> 
			<a title='<spring:message code="detail.like"/>' class="like" href="script:;" data-id="${p.id}" id="like-${p.id }">
				<img src="images/icons/Heart.png">
			</a> 
			<a title='<spring:message code="detail.send"/>' href="product/detail/${product.id}.htm?pos=Tab3"> <img src="images/icons/Letter.png" /></a> 
			<a title='<spring:message code="products.cart"/>' class="add-to-cart" data-id="${product.id}" data-url="shopping-cart/add-ajax/${product.id}.htm" href="#"> <img src="images/icons/Add to basket.png"></a>
		</td>
		<td class="col-md-8" style="vertical-align: top">
			<table class="table table-striped" style="margin-left: 20px;font-stretch:ultra-condensed;">
			<tr>
				<td style="font-size: 16px; font-weight: bold;" colspan="2" align="center" ><spring:message code="detail.name"/><span>: ${product.name}</span></td>
			</tr>
			<tr>
				<td><spring:message code="detail.id"/></td>
				<td>: ${product.id}</td>
			</tr>
			<tr>
				<td><spring:message code="detail.price"/></td>
				<td>: ${product.unitPrice}</td>
			</tr>
			<tr>
				<td><spring:message code="detail.date"/></td>
				<td>: ${product.productDate}</td>
			</tr>
			<tr>
				<td><spring:message code="detail.quantity"/></td>
				<td>: ${product.quantity}</td>
			</tr>
			<tr>
				<td><spring:message code="detail.unit"/></td>
				<td>: ${product.unitBrief}</td>
			</tr>
			<tr>
				<td><spring:message code="detail.category"/></td>
				<td>: ${product.category.name}</td>
			</tr>
			<tr>
				<td><spring:message code="detail.supplier"/></td>
				<td>: ${product.supplier.name}</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
	<td colspan="3">
		<div style="text-align: justify; margin-top: 20px">${product.description}</div>
	</td>
	</tr>
</table>
	
<hr><hr>
	<div class="tabs">
		<ul class="tab-links">		
			<li <c:choose><c:when test="${param.pos == 'Tab3'}"></c:when><c:otherwise>class="active"</c:otherwise></c:choose>><a href="#Tab1"><spring:message code="detail.samecate"/></a></li>
			<li><a href="#Tab4"><spring:message code="detail.samesupp"/></a></li>
			<li><a href="#Tab2"><spring:message code="detail.viewed"/></a></li>
			<li <c:if test="${param.pos == 'Tab3'}">class="active"</c:if>><a href="#Tab3"><spring:message code="detail.send"/></a></li>
		</ul>
	
		<div class="tab-content">
			<!--Tab1-->
			<div <c:choose><c:when test="${param.pos == 'Tab3'}">class="tab"</c:when><c:otherwise>class="tab active"</c:otherwise></c:choose> id="Tab1">
				<table>
				<tr>
					<td>
						<c:forEach var="p" items="${product.category.products}">
							<li class="producCates"><a href="product/detail/${p.id}.htm" title="${p.name}"><img id="proImg" class="img-thumbnail" src="images/products/${p.image}"/></a></li>
						</c:forEach>
					</td>
				</tr>
				</table>			
			</div>
			
			<!--Tab4-->
			<div class="tab" id="Tab4">
				<table>
				<tr>
					<td>
						<c:forEach var="p" items="${product.supplier.products}">
							<li class="producCates"><a href="product/detail/${p.id}.htm" title="${p.name}"><img id="proImg" class="img-thumbnail" src="images/products/${p.image}"/></a></li>
						</c:forEach>
					</td>
				</tr>
				</table>			
			</div>
			<!--Tab2-->
			<div class="tab" id="Tab2">
				<table>
				<tr>
					<td>
						<c:forEach var="p" items="${views}">
							<li class="producCates"><a href="product/detail/${p.id}.htm" title="${p.name}"><img id="proImg" class="img-thumbnail" src="images/products/${p.image}"/></a></li>							
						</c:forEach>
					</td>
				</tr>
				</table>			
			</div>
			<div <c:choose><c:when test="${param.pos == 'Tab3'}">class="tab active"</c:when><c:otherwise>class="tab"</c:otherwise></c:choose> id="Tab3">
				<form id="sendToFriend" action="product/sendToFriend.htm" method="post">
					<h5 style="font-weight: bold;"><spring:message code="detail.send.description"/></h5>
					<br>
					<div><spring:message code="detail.send.from"/></div>
					<input class="required email" name="from" style="width:570px">
					<div><spring:message code="detail.send.to"/></div>
					<input class="required email" name="to" style="width:570px">
					<div><spring:message code="detail.send.subject"/></div>
					<input class="required" name="subject" style="width:570px">
					<div><spring:message code="detail.send.body"/></div>
					<textarea class="required" name="body" style="width:570px;height:100px;"></textarea>
					<br>
					<input type="submit" value="<spring:message code="detail.send.button"/>">
					<input type="hidden" name="id" value="${product.id}">
				</form>
			</div>
		</div>
</div>
<style id="cart-fly"></style>
<style>
#cart-image{
	background-size:100% 100%; 
}
</style>
<script>
$(function(){
	$("a.add-to-cart").click(function(){
		/*
		 * Hieu ung gio hang
		 */
		id = $(this).attr("data-id");
		src = $("#" + id).attr("src");
		css = ".cart-fly{background:url('?');background-size: 100% 100%;}";
		css = css.replace('?', src);
		$("style#cart-fly").html(css);
		options = {to:"#cart-image", className:"cart-fly"}
		
		$("#" + id).effect("transfer", options, 500, function(){
			$("#cart-image").effect("bounce", 200);
		});
		
		/*
		 * Bo hang vao gio
		 */
		dataUrl = $(this).attr("data-url");
		$.ajax({
			url:dataUrl,
			data:{},
			dataType:"json",
			success:function(response){
				$("li#cart-count").html(response.count + " items");
				$("li#cart-amount").html(response.amount + " USD");
			}
		});
		return false;
	});
});
jQuery(document).ready(function() {
    jQuery('.tabs .tab-links a').on('click', function(e)  {
        var currentAttrValue = jQuery(this).attr('href');
 
     // Show/Hide Tabs
        jQuery('.tabs ' + currentAttrValue).slideDown(400).siblings().slideUp(400);
 
        // Change/remove current tab to active
        jQuery(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });
});
/* Xử lý button like (Hàng yêu thích) */
$(function(){
		$("a.like").click(function(){
			id = $(this).attr("data-id");
			$( "#like-"+id ).effect( "pulsate", 500, function(){
				setTimeout(function() {
			        $( "#like-"+id ).removeAttr( "style" ).hide().fadeIn();
			      }, 500 );
			});
			$.ajax({
				url:"product/like.htm",
				data: "id=" + id
			});
			return false;
		});
	});
</script>