<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Success</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<div class="home-hero">
			<div style="font-size: 4rem; margin-bottom: 20px;">✅</div>

			<h2>
				<spring:message code="common.joinMemberSuccess"
					arguments="${userName}" />
			</h2>

			<p style="color: #64748b; margin-bottom: 30px;">회원가입이 완료되었습니다. 이제
				서비스를 이용하실 수 있습니다.</p>

			<div class="button-container">
				<a href="${pageContext.request.contextPath}/auth/login"
					id="btnRegister" class="btn-link"> <spring:message
						code="action.login" />
				</a>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>