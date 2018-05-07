<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<form method="post">
	Min date:<input name="min" class="datepicker" value="${param.min}">
	Max date:<input name="max" class="datepicker" value="${param.max}">
	<button>Filter</button>
</form>

<script>
$(function(){
	$(".datepicker").datepicker({dateFormat:'mm/dd/yy'});
});
</script>

<fieldset>
	<legend>Doanh số bán hàng</legend>

	<table class="table table-default">
		<tr>
			<th>Nhóm</th>
			<th>Số lượng</th>
			<th>Doanh số</th>
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

<fieldset>
	<legend>Biểu đồ</legend>
	 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Loại', 'Doanh số'],
          <c:forEach var="a" items="${arrays}">
          ["${a[0]}", ${a[2]}],
          </c:forEach>
        ]);

        var options = {
          title: 'Doanh số từng loại',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
    <div id="piechart_3d" style="width: 900px; height: 500px;"></div>
</fieldset>