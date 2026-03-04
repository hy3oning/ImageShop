<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">
	<h2>
		<spring:message code="coin.header.list" />
	</h2>

	<table>
		<tr>
			<th width="80"><spring:message code="coin.no" /></th>
			<th width="320"><spring:message code="coin.amount" /></th>
			<th width="180"><spring:message code="coin.regdate" /></th>
		</tr>

		<c:choose>
			<c:when test="${empty list}">
				<tr>
					<td colspan="3"><spring:message code="common.listEmpty" /></td>
				</tr>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list}" var="chargeCoin">
					<tr>
						<td>${chargeCoin.historyNo}</td>
						<td>${chargeCoin.amount}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
								value="${chargeCoin.regDate}" /></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

	<div class="button-container">
		<a class="btn-link" id="btnList"
			href="${pageContext.request.contextPath}/coin/charge"> <spring:message
				code="coin.header.chargeCoin" />
		</a>
	</div>
</div>