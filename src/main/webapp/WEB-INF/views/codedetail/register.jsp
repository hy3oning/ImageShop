<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop - Register</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<header class="form-header">
			<h2>
				<spring:message code="codedetail.header.register" />
			</h2>
		</header>

		<%-- ID를 명시적으로 부여하여 스크립트 제어를 용이하게 함 --%>
		<form:form modelAttribute="codeDetail" id="codeDetailForm"
			action="register" method="post">
			<table class="form-table">
				<tr>
					<td><spring:message code="codedetail.groupCode" /></td>
					<td><form:select path="groupCode" items="${groupCodeList}"
							itemValue="value" itemLabel="label" /> <form:errors
							path="groupCode" cssClass="error-message" /></td>
				</tr>
				<tr>
					<td><spring:message code="codedetail.codeValue" /></td>
					<td><form:input path="codeValue" /> <form:errors
							path="codeValue" cssClass="error-message" /></td>
				</tr>
				<tr>
					<td><spring:message code="codedetail.codeName" /></td>
					<td><form:input path="codeName" /> <form:errors
							path="codeName" cssClass="error-message" /></td>
				</tr>
			</table>

			<div class="action-bar">
				<button type="button" id="btnRegister" class="btn btn-primary">
					<spring:message code="action.register" />
				</button>
				<button type="button" id="btnList" class="btn btn-outline">
					<spring:message code="action.list" />
				</button>
			</div>
		</form:form>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			// 변수 선언 시 명확한 ID 사용
			const $formObj = $("#codeDetailForm");

			// 등록 버튼 이벤트
			$("#btnRegister").on("click", function() {
				// 추가적인 클라이언트 사이드 유효성 검사가 필요하다면 이곳에 작성
				$formObj.submit();
			});

			// 목록 버튼 이벤트
			$("#btnList").on("click", function() {
				self.location = "/codedetail/list";
			});
		});
	</script>
</body>
</html>