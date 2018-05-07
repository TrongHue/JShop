<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<h2><spring:message code="order.title"/></h2>

<form:form modelAttribute="order">
	<div class="form-group">
	  <label for="customer.id"><spring:message code="order.id"/></label>
	  <form:input path="customer.fullname" readonly="true"
	  	cssClass="form-control"/>
	</div>
	
	<div class="form-group">
	  <label for="orderDate"><spring:message code="order.date"/></label>
	  <form:input path="orderDate" readonly="true"
	  	cssClass="form-control"/>
	</div>
	
	<div class="form-group">
	  <label for="requireDate"><spring:message code="order.dateRq"/></label>
	  <form:input path="requireDate" 
	  	cssClass="form-control"/>
	</div>
	
	<div class="form-group">
	  <label for="receiver"><spring:message code="order.receiver"/></label>
	  <form:input path="receiver" 
	  	cssClass="form-control"/>
	</div>
	
	<div class="form-group">
	  <label for="address"><spring:message code="order.address"/></label>
	  <form:input path="address" 
	  	cssClass="form-control"/>
	</div>
	
	<div class="form-group">
	  <label for="amount"><spring:message code="order.amount"/></label>
	  <form:input path="amount" readonly="true"
	  	cssClass="form-control"/>
	</div>
	
	<div class="form-group">
	  <label for="description"><spring:message code="order.description"/></label>
	  <form:textarea path="description" rows="5"
	  	cssClass="form-control"/>
	</div>
</form:form>

<h3><spring:message code="order.detail"/></h3>
<table class="table table-hover">
<tr>
	<th>Id</th>
	<th><spring:message code="order.cart.name"/></th>
	<th><spring:message code="order.cart.unitPrice"/></th>
	<th><spring:message code="order.cart.discount"/></th>
	<th><spring:message code="order.cart.quantity"/></th>
	<th><spring:message code="order.cart.amount"/></th>
</tr>
<c:forEach var="d" items="${details}">
<tr>
	<td>${d.product.id}</td>
	<td>${d.product.name}</td>
	<td>${d.unitPrice}</td>
	<td>${d.discount}</td>
	<td>${d.quantity}</td>
	<td>${d.unitPrice*d.quantity*(1-d.discount)}</td>
</tr>
</c:forEach>
</table>