<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<script src="slideshow/js/modernizr.custom.63321.js"></script>
<script src="slideshow/js/jquery.catslider.js"></script>
<link href="slideshow/css/catslider.css" rel="stylesheet" />
<style>
    .mi-slider {
        height: 700px;
    }
    .mi-slider ul li img {
        height: 600px;
    }
    .mi-slider ul li{
    	width:100%;
    }
    .mi-slider nav a{
    	letter-spacing: 2px;
    }
</style>
<h3>Thống kê doanh số bán hàng</h3>
<script>
    $(function () {
        showCatSlider('.mi-slider', 30000);
    });
</script>
<div class="mi-slider">
	<ul>
		<li>
			<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		    <script type="text/javascript">
		      google.load("visualization", "1", {packages:["corechart"]});
		      google.setOnLoadCallback(drawChart);
		      function drawChart() {
		        var data = google.visualization.arrayToDataTable([
		          ['Loại', 'Doanh số'],
		          <c:forEach var="a" items="${proRevenue}">
		          ["${a[0]}", ${a[1]}],
		          </c:forEach>
		        ]);
		
		        var options = {
		          title: 'Doanh số từng mặt hàng',
		          is3D: false,
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
		        chart.draw(data, options);
		      }
		    </script>
		    <div id="piechart_3d" style="width: 800px; height: 700px;"></div>
		</li>
	</ul>
	<ul>
	    <li>
	      	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		    <script type="text/javascript">
		      google.load("visualization", "1", {packages:["corechart"]});
		      google.setOnLoadCallback(drawChart);
		      function drawChart() {
		        var data = google.visualization.arrayToDataTable([
		          ['Loại', 'Doanh số'],
		          <c:forEach var="a" items="${cateRevenue}">
		          ["${a[0]}", ${a[1]}],
		          </c:forEach>
		        ]);
		
		        var options = {
		          title: 'Doanh số theo từng loại',
		          is3D: false,
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d2'));
		        chart.draw(data, options);
		      }
		    </script>
		    <div id="piechart_3d2" style="width: 800px; height: 700px;"></div>
	    </li>
	</ul>
	<ul>
	    <li>
	       	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		    <script type="text/javascript">
		      google.load("visualization", "1", {packages:["corechart"]});
		      google.setOnLoadCallback(drawChart);
		      function drawChart() {
		        var data = google.visualization.arrayToDataTable([
		          ['Loại', 'Doanh số'],
		          <c:forEach var="a" items="${supRevenue}">
		          ["${a[0]}", ${a[1]}],
		          </c:forEach>
		        ]);
		
		        var options = {
		          title: 'Doanh số theo từng hãng',
		          is3D: false,
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d3'));
		        chart.draw(data, options);
		      }
		    </script>
		    <div id="piechart_3d3" style="width: 800px; height: 700px;"></div>
	    </li>
	</ul>
	<ul>
	    <li>
	      	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		    <script type="text/javascript">
		      google.load("visualization", "1", {packages:["corechart"]});
		      google.setOnLoadCallback(drawChart);
		      function drawChart() {
		        var data = google.visualization.arrayToDataTable([
		          ['Loại', 'Doanh số'],
		          <c:forEach var="a" items="${yearRevenue}">
		          ["${a[0]}", ${a[1]}],
		          </c:forEach>
		        ]);
		
		        var options = {
		          title: 'Doanh số theo từng năm',
		          is3D: false,
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d4'));
		        chart.draw(data, options);
		      }
		    </script>
		    <div id="piechart_3d4" style="width: 800px; height: 700px;"></div>
	    </li>
	</ul>	
    <nav>
		<a href="#">Theo mặt hàng</a>
		<a href="#">Theo loại hàng</a>
		<a href="#">Theo hãng</a>
		<a href="#">Theo năm</a>
    </nav>
</div>