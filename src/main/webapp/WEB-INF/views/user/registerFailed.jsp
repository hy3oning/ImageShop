<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Failed</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<div class="home-hero">

			<!-- ❌ 실패 아이콘 -->
			<div style="font-size: 4rem; margin-bottom: 20px; color: #dc2626;">❌</div>

			<h2>
				<spring:message code="common.joinMemberFailed" />
			</h2>

			<!-- 상세 에러 메시지 (있을 경우 출력) -->
			<c:if test="${not empty errorMsg}">
				<p style="color: #dc2626; margin-top: 10px;">${errorMsg}</p>
			</c:if>

			<p style="color: #64748b; margin-bottom: 30px;">회원가입 처리 중 문제가
				발생했습니다. 다시 시도해주세요.</p>

			<div class="button-container">
				<a href="${pageContext.request.contextPath}/user/register"
					class="btn-link"> <spring:message code="action.retry" />
				</a> <a href="${pageContext.request.contextPath}/" class="btn-link">
					<spring:message code="action.home" />
				</a>
			</div>

		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>