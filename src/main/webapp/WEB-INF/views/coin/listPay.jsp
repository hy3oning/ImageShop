<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">
	<h2>
		<spring:message code="coin.header.listPay" />
	</h2>
	<table>
		<colgroup>
			<col style="width: 80px;">
			<col style="width: 240px;">
			<col style="width: 140px;">
			<col style="width: 200px;">
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="coin.no" /></th>
				<th><spring:message code="coin.itemName" /></th>
				<th><spring:message code="coin.payAmount" /></th>
				<th><spring:message code="coin.regdate" /></th>
			</tr>
		</thead>

		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="4"><spring:message code="common.listEmpty" /></td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${list}" var="payCoin">
						<tr>
							<td>${payCoin.historyNo}</td>
							<td style="text-align: left;">${payCoin.itemName}</td>
							<td style="text-align: right;"><fmt:formatNumber
									value="${payCoin.amount}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
									value="${payCoin.regDate}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>