<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:forEach var="p" items="${list}">
<div class="box">
	<ul>
		<li>${p.name}</li>
		<li>
			<a href="product/detail/${p.id}.htm">
				<img id="${p.id}" src="images/products/${p.image}">
			</a>
		</li>
		<li class="price">${p.unitPrice} $</li>
		<li class="nn-box-actions">
			<a class="add-to-cart" title='<spring:message code="products.cart"/>' data-id="${p.id}" data-url="shopping-cart/add-ajax/${p.id}.htm" href="#">
				<img src="images/icons/Add to basket.png">
			</a>
			<a title='<spring:message code="detail.send"/>' href="product/detail/${p.id }.htm?pos=Tab3">
				<img style="cursor:pointer;" src="images/icons/Letter.png"></a>
			<a title='<spring:message code="detail.like"/>' class="like" href="script:;" data-id="${p.id}" id="like-${p.id }">
				<img src="images/icons/Heart.png">
			</a>
		</li>
		<li class="feature">
			<c:choose>
				<c:when test="${p.special}">
					<img src="images/special_icon.gif">
				</c:when>
				<c:when test="${p.latest}">
					<img src="images/new_icon.gif">
				</c:when>
				<c:when test="${p.discount > 0}">
					<a class="discount">-<fmt:formatNumber value="${p.discount}" type="percent" /></a>
				</c:when>
			</c:choose>
		</li>
	</ul>
</div>
</c:forEach>

<!--Pagination  -->
<form class="pager" 
	<c:choose>
		<c:when test="${flat == 'search-product'}">
			action="product/${flat}.htm?search=${search}"
		</c:when>
		<c:otherwise>
			action="product/${flat}.htm"
		</c:otherwise>
	</c:choose>
method="post">
	<c:choose>
		<c:when test="${acpager.pageNo != 0}">
			<input type="submit" name="btnPageNo:${0}" value="<<"/>
			<input type="submit" name="btnPageNo:${acpager.pageNo-1}" value="<"/>
		</c:when>
		<c:otherwise>
			<input disabled="disabled" type="submit" name="btnPageNo:${0}" value="<<"/>
			<input disabled="disabled" type="submit" name="btnPageNo:${acpager.pageNo-1}" value="<"/>
		</c:otherwise>
	</c:choose>

	<c:forEach var="i" begin="${acpager.startPage}"  end="${acpager.endPage}">
		<input style="box-shadow:0 0 5px ${i==acpager.pageNo?'red':'gray'};" type="submit" name="btnPageNo:${i}" value="${i+1}"/>
	</c:forEach>

	<c:choose>
		<c:when test="${acpager.pageNo != acpager.lastPageNo}">
			<input type="submit" name="btnPageNo:${acpager.pageNo+1}" value=">"/>
			<input type="submit" name="btnPageNo:${acpager.lastPageNo}" value=">>"/>
		</c:when>
		<c:otherwise>
			<input disabled="disabled" type="submit" name="btnPageNo:${acpager.pageNo+1}" value=">"/>
			<input disabled="disabled" type="submit" name="btnPageNo:${acpager.lastPageNo}" value=">>"/>
		</c:otherwise>
	</c:choose>
	
</form>

<style>
.pager input{
	background-color: #C6C6C6;
	border-radius: 100%;
}
.pager input[disabled]{
	background-color: #F9F9F9;
}
.box>ul img[id]:hover{
opacity: 0.6;
}
.box>ul:hover{
	box-shadow:0 0 5px red;
}
</style>

<!--End Pagination  -->

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

/* Xử lý button like (Hàng yêu thích) */
$(function(){
		$("a.like").click(function(){
			id = $(this).attr("data-id");
			$( "#like-"+id ).effect( "puff", 500, function(){
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