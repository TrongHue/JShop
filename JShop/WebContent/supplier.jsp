<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-list-alt"></span>
        <strong><spring:message code="vmenu.supplier"/></strong>
    </div>

    <div class="list-group">
        <c:forEach var="s" items="${suppliers}">
    	<a href="product/list-by-supplier/${s.id}.htm"
    		class="list-group-item">${s.name}</a>
    </c:forEach>
    </div>
</div>