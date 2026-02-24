<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
				<spring:message code="user.header.register" />
			</h2>
		</header>

		<form:form id="member" modelAttribute="member"
			action="${pageContext.request.contextPath}/user/register"
			method="post">
			<table class="form-table">
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
				<tr>
					<td><spring:message code="user.job" /></td>
					<td><form:select path="job" items="${jobList}"
							itemValue="value" itemLabel="label" /> <form:errors path="job"
							cssClass="form-errors" /></td>
				</tr>
			</table>

			<div class="button-container">
				<button type="button" id="btnRegister">
					<spring:message code="action.register" />
				</button>
				<%-- 인 가 정 책 --%>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="button" id="btnList">
						<spring:message code="action.list" />
					</button>
				</sec:authorize>
			</div>
		</form:form>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
        $(document).ready(function() {
            var formObj = $("#member");

            $("#btnRegister").on("click", function() {
                formObj.submit();
            });

            <sec:authorize access="hasRole('ADMIN')">
                $("#btnList").on("click", function() {
                    self.location = "${pageContext.request.contextPath}/user/list";
                });
            </sec:authorize>
        });
    </script>
</body>
</html>