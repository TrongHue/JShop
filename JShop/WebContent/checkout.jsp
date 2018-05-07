<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="js/jquery-1.7.1.min.js"></script>
<script src="jquery-ui/jquery-ui.js"></script>
<script src="js/jquery.validate.min.js"></script>

<script type="text/javascript">
	$(function(){
		$("#order").validate({
			rules:{
				requireDate:{required: true},
				receiver:{required: true},
				address:{required: true}
			},
			messages:{
				requireDate:{required:'<spring:message code="order.validate.requireDate"/>'},
				receiver:{required:'<spring:message code="order.validate.receiver"/>'},
				address:{required:'<spring:message code="order.validate.address"/>'}
			}
		});
	});
	$(function(){
		$("input.datepicker").datepicker();
	});
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
</script>
	
<style>
label.error{
	color: red;
	font-style: italic;
	padding-left: 20px;
	background: url("images/anifire.gif") no-repeat left center;
}
</style>

<h2><spring:message code="order.title"/></h2>

<h3>${message}</h3>

<form:form action="order/purchase.htm" modelAttribute="order" role="form" id="order">
  <div class="row">
	  <div class="form-group col-md-6">
	    <label for="customer.id"><spring:message code="order.id"/></label>
	    <form:input path="customer.id" readonly="true"
	    	cssClass="form-control"/>
	  </div>
	  
	  <div class="form-group col-md-6">
	    <label for="orderDate"><spring:message code="order.date"/></label>
	    <form:input path="orderDate" readonly="true"
	    	cssClass="form-control"/>
	  </div>
  </div>
  
  <div class="row">
	  <div class="form-group col-md-6">
	    <label for="requireDate"><spring:message code="order.dateRq"/></label>
	    <form:input path="requireDate" 
	    	cssClass="form-control datepicker"/>
	  </div>
	  
	  <div class="form-group col-md-6">
	    <label for="receiver"><spring:message code="order.receiver"/></label>
	    <form:input path="receiver" 
	    	cssClass="form-control"/>
	  </div>
  </div>
  
  <div class="row">
	  <div class="form-group col-md-6">
	    <label for="address"><spring:message code="order.address"/></label>
	    <form:input path="address" 
	    	cssClass="form-control"/>
	  </div>
	  
	  <div class="form-group col-md-6">
	    <label for="amount"><spring:message code="order.amount"/></label>
	    <form:input path="amount" readonly="true"
	    	cssClass="form-control"/>
	  </div>
  </div>
  
  <div class="row">
	  <div class="form-group col-md-12">
	    <label for="description"><spring:message code="order.description"/></label>
	    <form:textarea path="description" rows="5"
	    	cssClass="form-control"/>
	  </div>
  </div>

  <div class="row">
  	<div class="form-group col-md-12">
  		<button class="btn btn-default"><spring:message code="order.purchase"/></button>
  	</div>
  </div>
  
</form:form>

<h3><spring:message code="order.cart.title"/></h3>
<table class="table">
<tr>
	<th><spring:message code="order.cart.name"/></th>
	<th><spring:message code="order.cart.unitPrice"/></th>
	<th><spring:message code="order.cart.quantity"/></th>
	<th><spring:message code="order.cart.discount"/></th>
	<th><spring:message code="order.cart.amount"/></th>
</tr>
<c:forEach var="p" items="${cart.items}">
<tr>
	<td>${p.name}</td>
	<td><fmt:formatNumber value="${p.unitPrice}" minFractionDigits="3" maxIntegerDigits="3"/> </td>
	<td>${p.quantity}</td>
	<td><fmt:formatNumber value="${p.discount}" type="percent"/> </td>
	<td>${p.unitPrice*p.quantity*(1-p.discount)}</td>
</tr>
</c:forEach>
</table>
