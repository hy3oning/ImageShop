<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="container">
	<h2>
		<spring:message code="board.header.register" />
	</h2>

	<form:form modelAttribute="board" action="register" id="boardForm">
		<table class="form-table">
			<tr>
				<td><spring:message code="board.title" /></td>
				<td><form:input path="title" /> <form:errors path="title"
						cssClass="form-errors" /></td>
			</tr>

			<tr>
				<td><spring:message code="board.writer" /></td>
				<td><input type="text" value="${board.writer}"
					readonly="readonly" /></td>
			</tr>

			<tr>
				<td><spring:message code="board.content" /></td>
				<td><form:textarea path="content" rows="10" /> <form:errors
						path="content" cssClass="form-errors" /></td>
			</tr>
		</table>

		<div class="button-container">
			<sec:authorize access="isAuthenticated()">
				<button type="submit" id="btnRegister">
					<spring:message code="action.register" />
				</button>
			</sec:authorize>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</form:form>
</div>

<script>
	$(function() {
		$("#btnList").on("click", function() {
			location.href = "list";
		});
	});
</script>