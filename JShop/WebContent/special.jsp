<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-star-empty"></span>
        <strong><spring:message code="vmenu.specials"/></strong>
    </div>

    <div class="list-group">
        <a href="product/special/best.htm" class="list-group-item"><spring:message code="vmenu.best"/></a>
        <a href="product/special/latest.htm" class="list-group-item"><spring:message code="vmenu.new"/></a>
        <a href="product/special/salesoff.htm" class="list-group-item"><spring:message code="vmenu.discount"/></a>
        <a href="product/special/favorite.htm" class="list-group-item"><spring:message code="vmenu.favorite"/></a>
        <a href="product/special/views.htm" class="list-group-item"><spring:message code="vmenu.views"/></a>
        <a href="product/special/special.htm" class="list-group-item"><spring:message code="vmenu.special"/></a>
    </div>
</div>