<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="input-group">
      
      <span class="input-group-btn">
        <a class="btn btn-default" type="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></a>
      </span>
      <form:form action="/EShopV20/product/search-product.htm">
      <input id="txtSearch" name="search" type="text" value="${param.search}" class="form-control" placeholder="<spring:message code="search.placeholder"/>">
      </form:form>
      
</div><!-- /input-group -->
