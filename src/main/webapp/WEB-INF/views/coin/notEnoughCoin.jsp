<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">

	<h2>
		<spring:message code="coin.header.chargeCoin" />
	</h2>

	<table class="form-table">
		<tr>
			<td>안내</td>
			<td><spring:message code="coin.notEnoughCoin" /></td>
		</tr>
	</table>

	<div class="button-container">
		<a class="btn-link" id="btnEdit"
			href="${pageContext.request.contextPath}/coin/charge"> <spring:message
				code="coin.charge" />
		</a> <a class="btn-link" id="btnList" href="javascript:history.back()">
			이전 페이지 </a>
	</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />