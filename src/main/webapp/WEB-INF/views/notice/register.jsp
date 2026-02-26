<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<div class="container">
	<h2>
		<spring:message code="notice.header.register" />
	</h2>

	<form:form modelAttribute="notice" action="register" method="post"
		id="noticeForm">

		<table class="form-table">
			<tr>
				<td><spring:message code="notice.title" /></td>
				<td><form:input path="title" /> <font color="red"><form:errors
							path="title" /></font></td>
			</tr>
			<tr>
				<td><spring:message code="notice.content" /></td>
				<td><form:textarea path="content" rows="8" /> <font
					color="red"><form:errors path="content" /></font></td>
			</tr>
		</table>

		<div class="button-container">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="submit" id="btnRegister">
					<spring:message code="action.register" />
				</button>
			</sec:authorize>

			<button type="button" id="btnList" onclick="location.href='list'">
				<spring:message code="action.list" />
			</button>
		</div>
	</form:form>
</div>
<script>
	$(document).ready(function() {
		let formObj = $("#notice");
		$("#btnRegister").on("click", function() {
			formObj.submit();
		});
		$("#btnList").on("click", function() {
			self.location = "list";
		});
	});
</script>