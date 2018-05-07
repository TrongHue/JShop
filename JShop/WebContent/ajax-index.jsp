<%@ page pageEncoding="utf-8"%>

<button class="value">Refresh</button>
<h1></h1>
<button class="object">Object</button>
<button class="array">Array</button>
<button class="list-object">List Object</button>

<script>
$(function(){
	$("button.value").click(function(){
		$.ajax({
			url:"/EShopV20/ajax/server-time.htm", // Action
			data:{}, // Tham số gửi đến server
			dataType:"json", // Kiểu dữ liệu nhận về
			success:function(response){ // Hàm gọi ngược (nhận kết quả từ server)
				$("h1").html(response);
			}
		});
	});
	
	$("button.object").click(function(){
		$.ajax({
			url:"/EShopV20/ajax/object.htm", 
			data:{},
			dataType:"json", 
			success:function(response){ 
				$("h1").html(response.nameVN);
			}
		});
	});
	
	$("button.array").click(function(){
		$.ajax({
			url:"/EShopV20/ajax/array.htm", 
			data:{},
			dataType:"json", 
			success:function(response){ 
				$(response).each(function(index, element){
					$("h1").append(index + "," + element + "<br>");
				})
			}
		});
	});
	
	$("button.list-object").click(function(){
		$.ajax({
			url:"/EShopV20/ajax/list-object.htm", 
			data:{},
			dataType:"json", 
			success:function(response){ 
				$(response).each(function(index, element){
					$("h1").append(index + "," + element.nameVN + "<br>");
				})
			}
		});
	});
});
</script>