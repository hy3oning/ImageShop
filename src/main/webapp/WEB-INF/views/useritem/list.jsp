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
		<spring:message code="useritem.header.list" />
	</h2>

	<table>
		<colgroup>
			<col style="width: 80px;">
			<col style="width: 280px;">
			<col style="width: 140px;">
			<col style="width: 200px;">
			<col style="width: 160px;">
		</colgroup>

		<thead>
			<tr>
				<th><spring:message code="useritem.no" /></th>
				<th><spring:message code="useritem.itemName" /></th>
				<th><spring:message code="useritem.itemPrice" /></th>
				<th><spring:message code="useritem.regdate" /></th>
				<th><spring:message code="useritem.download" /></th>
			</tr>
		</thead>

		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="5"><spring:message code="common.listEmpty" /></td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${list}" var="useritem">
						<tr>
							<td>${useritem.userItemNo}</td>

							<td style="text-align: left;"><a
								href="${pageContext.request.contextPath}/useritem/read?userItemNo=${useritem.userItemNo}">
									${useritem.itemName} </a></td>

							<td style="text-align: right;"><fmt:formatNumber
									value="${useritem.price}" /></td>

							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
									value="${useritem.regDate}" /></td>

							<td><a class="btn-link"
								href="${pageContext.request.contextPath}/useritem/download?userItemNo=${useritem.userItemNo}">
									<spring:message code="useritem.download" />
							</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>