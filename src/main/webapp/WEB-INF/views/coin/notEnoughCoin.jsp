<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />
<h2>
	<spring:message code="coin.header.chargeCoin" />
</h2>
<p>
	<spring:message code="coin.notEnoughCoin" />
</p>
<a href="charge"><spring:message code="coin.charge" /></a>
