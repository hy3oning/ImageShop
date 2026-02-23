<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/codegroup.css">
</head>
<body class="page">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<main>
		<div class="container">
			<div class="home-hero">
				<h1>
					<spring:message code="common.homeWelcome" />
				</h1>
				<p>서버 시간: ${serverTime}</p>
			</div>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>