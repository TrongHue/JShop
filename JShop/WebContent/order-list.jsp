<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<h1><spring:message code="order.list"/></h1>
<table class="table table-hover">
<tr>
	<th>Id</th>
	<th><spring:message code="order.id"/></th>
	<th><spring:message code="order.dateRq"/></th>
	<th><spring:message code="order.receiver"/></th>
	<th><spring:message code="order.amount"/></th>
	<th></th>
</tr>
<c:forEach var="o" items="${orders}">
<tr>
	<td>${o.id}</td>
	<td>${o.orderDate}</td>
	<td>${o.requireDate}</td>
	<td>${o.receiver}</td>
	<td>${o.amount}</td>
	<td>
		<a href="order/detail/${o.id}.htm"><spring:message code="order.detail.button"/></a>
	</td>
</tr>
</c:forEach>
</table>
