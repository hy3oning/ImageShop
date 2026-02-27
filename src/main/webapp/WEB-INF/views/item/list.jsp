<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />
<div class="container">
	<h2>
		<spring:message code="item.header.list" />
	</h2>

	<!-- 관리자만 등록 버튼 -->
	<sec:authorize access="hasRole('ADMIN')">
		<div class="button-container"
			style="margin-top: 0; margin-bottom: 18px;">
			<a class="btn-new" href="register"> <spring:message
					code="action.new" />
			</a>
		</div>
	</sec:authorize>

	<table>
		<tr>
			<th width="80"><spring:message code="item.itemId" /></th>
			<th width="400"><spring:message code="item.itemName" /></th>
			<th width="100"><spring:message code="item.itemPrice" /></th>

			<sec:authorize access="hasRole('ADMIN')">
				<th width="80"><spring:message code="item.edit" /></th>
				<th width="80"><spring:message code="item.remove" /></th>
			</sec:authorize>
		</tr>

		<c:choose>
			<c:when test="${empty itemList}">
				<tr>
					<td colspan="5"><spring:message code="common.listEmpty" /></td>
				</tr>
			</c:when>

			<c:otherwise>
				<c:forEach items="${itemList}" var="item">
					<tr>
						<td>${item.itemId}</td>
						<td style="text-align: left;"><a
							href="read?itemId=${item.itemId}"
							style="text-decoration: none; color: inherit;"> <strong>${item.itemName}</strong>
						</a></td>
						<td style="text-align: right;">${item.price}원</td>

						<%-- 관리자에게만 수정/삭제 버튼 노출 --%>
						<sec:authorize access="hasRole('ADMIN')">
							<td><a class="auth-link" href="modify?itemId=${item.itemId}">
									<spring:message code="item.edit" />
							</a></td>
							<td><a class="auth-link" href="remove?itemId=${item.itemId}">
									<spring:message code="item.remove" />
							</a></td>
						</sec:authorize>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</div>

<script>
	let result = "${msg}";
	if (result === "SUCCESS") {
		alert("<spring:message code='common.processSuccess' />");
	} else if (result === "FAILED") {
		alert("FAILED");
	}
</script>