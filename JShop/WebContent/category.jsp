<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-th-list"></span>
        <strong><spring:message code="vmenu.category"/></strong>
    </div>

    <div class="list-group">
    <c:forEach var="c" items="${categories}">
    	<a href="product/list-by-category/${c.id}.htm"
    		class="list-group-item">
		    <c:choose>
		    	<c:when test="${language == 'en'}">${c.name}</c:when>
		    	<c:otherwise>${c.nameVN}</c:otherwise>
		    </c:choose>
    	</a>
    </c:forEach>
    </div>
</div>