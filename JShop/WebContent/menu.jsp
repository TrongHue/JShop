<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<ul class="nav navbar-nav art-hmenu">
    <li><a href="home/index.htm"><spring:message code="menu.home"/></a></li>
    <li><a href="product/list.htm"><spring:message code="menu.product"/></a></li>
    <li><a href="home/about.htm"><spring:message code="menu.about"/></a></li>
    <li><a href="home/contact.htm"><spring:message code="menu.contact"/></a></li>
    <li><a href="home/feedback.htm"><spring:message code="menu.feedback"/></a></li>

    <li>
        <a>
        <c:choose>
        	<c:when test="${empty sessionScope.user}"><spring:message code="menu.account"/></c:when>
        	<c:otherwise>${sessionScope.user.id}</c:otherwise>
        </c:choose>
         <span class="caret"></span></a>
        <ul>
        <c:choose>
        	<c:when test="${empty sessionScope.user}">
	        	<li><a id="lnkLogin" href="#"><spring:message code="menu.acc.login"/></a></li>
	            <li><a id="lnkForgotPwd" href="#"><spring:message code="menu.acc.forgot"/></a></li>
	            <li><a href="account/register.htm"><spring:message code="menu.acc.register"/></a></li>
	            <jsp:include page="LoginDialog.jsp"></jsp:include>
        	</c:when>
        	<c:otherwise>
	            <li><a href="account/logoff.htm"><spring:message code="menu.acc.logoff"/></a></li>
	            <li><a id="lnkChangePassword" href="#"><spring:message code="menu.acc.change"/></a></li>
	            <li><a href="account/edit.htm"><spring:message code="menu.acc.profile"/></a></li>
	            <li><a href="order/list.htm"><spring:message code="menu.acc.orders"/></a></li>
	            <li><a href="order/products.htm"><spring:message code="menu.acc.products"/></a></li>
	            <jsp:include page="ChangePasswordDialog.jsp"></jsp:include>
        	</c:otherwise>
        </c:choose>
            
            
        </ul>
    </li>
</ul>

<script>
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