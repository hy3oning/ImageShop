<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop - Modify</title>
<link rel="stylesheet" href="/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<h2>
			<spring:message code="user.header.modify" />
		</h2>

		<form:form modelAttribute="member" id="member" action="/user/modify"
			method="post">
			<form:hidden path="userNo" />

			<table class="user_table">
				<tr>
					<td><spring:message code="user.userId" /></td>
					<td><form:input path="userId" readonly="true" /> <form:errors
							path="userId" cssClass="form-errors" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.userName" /></td>
					<td><form:input path="userName" /> <form:errors
							path="userName" cssClass="form-errors" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.job" /></td>
					<td><form:select path="job" items="${jobList}"
							itemValue="value" itemLabel="label" /> <form:errors path="job"
							cssClass="form-errors" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.auth" /> - 1</td>
					<td><form:select path="authList[0].auth">
							<form:option value="" label="=== 선택해 주세요 ===" />
							<form:option value="ROLE_USER" label="사용자" />
							<form:option value="ROLE_MEMBER" label="회원" />
							<form:option value="ROLE_ADMIN" label="관리자" />
						</form:select> <form:errors path="authList[0].auth" cssClass="form-errors" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.auth" /> - 2</td>
					<td><form:select path="authList[1].auth">
							<form:option value="" label="=== 선택해 주세요 ===" />
							<form:option value="ROLE_USER" label="사용자" />
							<form:option value="ROLE_MEMBER" label="회원" />
							<form:option value="ROLE_ADMIN" label="관리자" />
						</form:select> <form:errors path="authList[1].auth" cssClass="form-errors" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.auth" /> - 3</td>
					<td><form:select path="authList[2].auth">
							<form:option value="" label="=== 선택해 주세요 ===" />
							<form:option value="ROLE_USER" label="사용자" />
							<form:option value="ROLE_MEMBER" label="회원" />
							<form:option value="ROLE_ADMIN" label="관리자" />
						</form:select> <form:errors path="authList[2].auth" cssClass="form-errors" /></td>
				</tr>
			</table>

			<div class="button-container">
				<button type="button" id="btnModify">
					<spring:message code="action.modify" />
				</button>
				<button type="button" id="btnList">
					<spring:message code="action.list" />
				</button>
			</div>
		</form:form>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#member");

			$("#btnModify").on("click", function() {
				formObj.submit();
			});

			$("#btnList").on("click", function() {
				location.href = "/user/list";
			});
		});
	</script>
</body>
</html>