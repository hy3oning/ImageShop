<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop - Read</title>
<link rel="stylesheet" href="/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<h2>
			<spring:message code="user.header.read" />
		</h2>

		<form:form modelAttribute="member" id="member">
			<form:hidden path="userNo" />

			<%-- CSS의 .user_table 스타일을 적용하기 위해 클래스 추가 --%>
			<table class="user_table">
				<tr>
					<td><spring:message code="user.userId" /></td>
					<td><form:input path="userId" readonly="true" /></td>
				</tr>
				<tr>
					<td><spring:message code="user.userName" /></td>
					<td><form:input path="userName" readonly="true" /></td>
				</tr>
				<tr>
					<td><spring:message code="user.job" /></td>
					<td><form:select path="job" items="${jobList}"
							itemValue="value" itemLabel="label" disabled="true" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.auth" /> - 1</td>
					<td><form:select path="authList[0].auth" disabled="true">
							<form:option value="" label="=== 선택해 주세요 ===" />
							<form:option value="ROLE_USER" label="사용자" />
							<form:option value="ROLE_MEMBER" label="회원" />
							<form:option value="ROLE_ADMIN" label="관리자" />
						</form:select></td>
				</tr>

				<tr>
					<td><spring:message code="user.auth" /> - 2</td>
					<td><form:select path="authList[1].auth" disabled="true">
							<form:option value="" label="=== 선택해 주세요 ===" />
							<form:option value="ROLE_USER" label="사용자" />
							<form:option value="ROLE_MEMBER" label="회원" />
							<form:option value="ROLE_ADMIN" label="관리자" />
						</form:select></td>
				</tr>

				<tr>
					<td><spring:message code="user.auth" /> - 3</td>
					<td><form:select path="authList[2].auth" disabled="true">
							<form:option value="" label="=== 선택해 주세요 ===" />
							<form:option value="ROLE_USER" label="사용자" />
							<form:option value="ROLE_MEMBER" label="회원" />
							<form:option value="ROLE_ADMIN" label="관리자" />
						</form:select></td>
				</tr>
			</table>
		</form:form>

		<%-- 버튼들을 중앙 정렬하기 위해 .button-container 클래스 적용 --%>
		<div class="button-container">
			<button type="button" id="btnEdit">
				<spring:message code="action.edit" />
			</button>

			<button type="button" id="btnRemove">
				<spring:message code="action.remove" />
			</button>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>
	<%-- .container 끝 --%>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			var formObj = $("#member");

			// 수정 페이지 이동
			$("#btnEdit").on("click", function() {
				var userNoVal = $("input[name='userNo']").val();
				location.href = "/user/modify?userNo=" + userNoVal;
			});

			// 삭제 처리
			$("#btnRemove").on("click", function() {
				if (confirm("정말로 삭제하시겠습니까?")) {
					formObj.attr("action", "/user/remove");
					formObj.submit();
				}
			});

			// 목록 이동
			$("#btnList").on("click", function() {
				location.href = "/user/list";
			});
		});
	</script>
</body>
</html>