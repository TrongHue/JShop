<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h3>QUẢN LÝ GIỎ HÀNG</h3>
<form name="frm-cart" action="shopping-cart/update.htm" method="post">
<table class="table">
<tr>
	<th><spring:message code="order.cart.name"/></th>
	<th><spring:message code="order.cart.unitPrice"/></th>
	<th><spring:message code="order.cart.quantity"/></th>
	<th><spring:message code="order.cart.discount"/></th>
	<th><spring:message code="order.cart.amount"/></th>
	<th></th>
</tr>
<c:forEach var="p" items="${cart.items}">
<tr>
	<td>${p.name}</td>
	<td><fmt:formatNumber value="${p.unitPrice}" minFractionDigits="3" maxIntegerDigits="3"/> </td>
	<td><input name="${p.id}" value="${p.quantity}" size="3"></td>
	<td><fmt:formatNumber value="${p.discount}" type="percent"/> </td>
	<td>${p.unitPrice*p.quantity*(1-p.discount)}</td>
	<td>
		<a class="remove-from-cart" data-url="shopping-cart/remove-ajax/${p.id}.htm" href="#">
			<img src="images/icons/Trash.png">
		</a>
	</td>
</tr>
</c:forEach>
</table>

<ul class="pager">
	<li><a href="javascript:document.forms['frm-cart'].submit()"><spring:message code="order.cart.update"/></a></li>
	<li><a href="shopping-cart/clear.htm"><spring:message code="order.cart.clear"/></a></li>
	<li><a href="product/list.htm"><spring:message code="order.cart.continue"/></a></li>
	<c:choose>
		<c:when test="${!empty sessionScope.user && cart.count > 0}">
			<li><a href="order/checkout.htm"><spring:message code="order.cart.checkout"/></a></li>
		</c:when>
		<c:otherwise>
			<li><a href="javascript:alert('Vui lòng đăng nhập và chọn hàng !')"><spring:message code="order.cart.checkout"/></a></li>
		</c:otherwise>
	</c:choose>
	
</ul>

</form>

<script>
$(function(){
	$("a.remove-from-cart").click(function(){
		tr = $(this).parents("tr");
		dataUrl = $(this).attr("data-url");
		$.ajax({
			url:dataUrl,
			data:{},
			dataType:"json",
			success:function(response){
				$("li#cart-count").html(response.count + " items");
				$("li#cart-amount").html(response.amount + " USD");
				
				tr.hide(500);
			}
		});
		return false;
	});
});
</script>