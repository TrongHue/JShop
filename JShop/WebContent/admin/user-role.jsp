<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

	<fieldset>
		<legend>User Role Manager</legend>
		
		<div class="user-role">
			<form role="form">
			<h4>Role: </h4>
				<c:forEach var="r" items="${roles}">
					<c:choose>
						<c:when test="${param.roleId == r.id}">
							<label><input type="radio" name="roleId" value="${r.id}" checked>${r.name}</label>
						</c:when>
						<c:otherwise>
							<label><input type="radio" name="roleId" value="${r.id}">${r.name}</label>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
			</form>
			<hr>
			<h4>Users in Role: </h4>
			<c:forEach var="ur" items="${userRoles}">
				<div class="col-md-3">
					<div class="checkbox">
						<label><input type="checkbox" ${ur.allow ? 'checked' : ''} 
							data-id="${ur.id}">${ur.user.id}</label>
					</div>
				</div>
			</c:forEach>
		</div>
	</fieldset>
	
	<!-- JavaScript & CSS -->
	<script>
	$(function(){
		$(".user-role :checkbox").click(function(){
			urid = $(this).attr("data-id")
			$.ajax({
				url:"admin/user-role/update.htm",
				data:{id:urid},
				success:function(response){}
			});
		});
		
		$(".user-role :radio").click(function(){
			$(this.form).submit();
		});
	});
	</script>
