<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<div class="container">
	<h2>
		<spring:message code="user.header.register" />
	</h2>

	<form:form modelAttribute="member" action="setup" id="member">
		<table class="user_table">
			<tr>
				<td><spring:message code="user.userId" /></td>
				<td><form:input path="userId" placeholder="아이디를 입력하세요" /> <form:errors
						path="userId" cssClass="form-errors" /></td>
			</tr>
			<tr>
				<td><spring:message code="user.userPw" /></td>
				<td><form:password path="userPw" placeholder="비밀번호를 입력하세요" />
					<form:errors path="userPw" cssClass="form-errors" /></td>
			</tr>
			<tr>
				<td><spring:message code="user.userName" /></td>
				<td><form:input path="userName" placeholder="이름을 입력하세요" /> <form:errors
						path="userName" cssClass="form-errors" /></td>
			</tr>
		</table>

		<div class="button-container">
			<button type="button" id="btnRegister">
				<spring:message code="action.register" />
			</button>
			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</form:form>
</div>

<script>
	$(document).ready(function() {
		var formObj = $("#member");

		$("#btnRegister").on("click", function() {
			formObj.submit();
		});

		$("#btnList").on("click", function() {
			self.location = "list";
		});
	});
</script>