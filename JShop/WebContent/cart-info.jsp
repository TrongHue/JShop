<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="panel panel-default nn-cart">
    <div class="panel-body">
        <img id="cart-image" class="col-md-5 img-responsive" src="images/shoppingcart.gif"/>
        <ul class="col-md-7">
            <li id="cart-count">${cart.count} <spring:message code="cart.items"/></li>
            <li id="cart-amount">${cart.amount} <spring:message code="cart.currency"/></li>
            <li><a href="shopping-cart/index.htm"><spring:message code="cart.view"/></a></li>
        </ul>
    </div>
</div>
<style>
#cart-image{
	background-size:100% 100%; 
}
</style>
