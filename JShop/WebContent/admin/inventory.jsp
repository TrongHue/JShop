<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<fieldset>
	<legend>Kiểm kê hàng tồn</legend>
	<table class="table table-default">
		<tr>
			<th>Nhóm</th>
			<th>Số lượng</th>
			<th>Tổng giá trị</th>
			<th>Giá thấp nhất</th>
			<th>Giá cao nhất</th>
			<th>Giá trung bình</th>
		</tr>
		<c:forEach var="a" items="${arrays}">
		<tr>
			<td>${a[0]}</td>
			<td>${a[1]}</td>
			<td><fmt:formatNumber value="${a[2]}" type="currency" maxFractionDigits="2" minFractionDigits="2"/> </td>
			<td><fmt:formatNumber value="${a[3]}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
			<td><fmt:formatNumber value="${a[4]}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
			<td><fmt:formatNumber value="${a[5]}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
		</tr>
		</c:forEach>
	</table>	
</fieldset>