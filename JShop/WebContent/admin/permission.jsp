<%@page pageEncoding="utf-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

	<fieldset>
		<legend>Permission Manager</legend>
		
		<div class="permission">
			<form method="post" role="form">
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
			<h4>Permissions: </h4>
			<c:forEach var="p" items="${permissions}" varStatus="status">
				<div class="col-md-3">
					<div class="checkbox">
						<label><input type="checkbox" ${p.allow ? 'checked' : ''} 
							data-id="${p.id}">${p.action.name}</label>
					</div>
				</div>
			</c:forEach>
		</div>
	</fieldset>
	
	<!-- JavaScript & CSS -->
	<script>
	$(function(){
		$(".permission :checkbox").click(function(){
			pid = $(this).attr("data-id")
			allow = $(this).prop("checked");
			$.ajax({
				url:"admin/permission/update.htm",
				data:{id:pid, allow:allow},
				success:function(response){}
			});
		});
		
		$(".permission :radio").click(function(){
			$(this.form).submit();
		});
	});
	</script>
