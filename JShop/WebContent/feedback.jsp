<%@ page pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h2><spring:message code="feedback.title"/></h2>
${message}
<hr>
<form action="home/feedback.htm" method="post">
	<div class="form-group">
		<label for="name"><spring:message code="feedback.cus.name"/></label> <input type="text"
			class="form-control" id="name" name="name" placeholder="Enter your name">
	</div>
	<div class="form-group">
		<label for="email"><spring:message code="feedback.cus.email"/></label> <input type="email"
			class="form-control" id="email" name="email" placeholder="Enter email">
	</div>
	<label for="cat"><spring:message code="feedback.cus.category"/></label>
	<select class="form-control" id="cat" name="comboCat">
		<option value="web"><spring:message code="feedback.cus.cate.web"/></option>
		<option value="service"><spring:message code="feedback.cus.cate.service"/></option>
		<option value="employee"><spring:message code="feedback.cus.cate.employee"/></option>
	</select>
	<br>
	<label for="info"><spring:message code="feedback.cus.content"/></label>
	<textarea id="info" name="info" class="form-control" rows="5"></textarea>
	<br>
	<button type="submit" class="btn btn-default"><spring:message code="feedback.cus.button"/></button>
</form>