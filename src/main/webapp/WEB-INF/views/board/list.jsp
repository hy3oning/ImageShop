<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />
<div class="container">
	<h2>
		<spring:message code="board.header.list" />
	</h2>

	<div class="button-container"
		style="margin-top: 0; margin-bottom: 20px;">
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<a href="register" class="btn-new"> <spring:message
					code="action.new" />
			</a>
		</sec:authorize>
	</div>

	<table>
		<thead>
			<tr>
				<th><spring:message code="board.no" /></th>
				<th><spring:message code="board.title" /></th>
				<th><spring:message code="board.writer" /></th>
				<th><spring:message code="board.regdate" /></th>
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
					<c:forEach items="${list}" var="board">
						<tr>
							<td>${board.boardNo}</td>

							<td class="td-title"><a
								href="${pageContext.request.contextPath}/board/read?boardNo=${board.boardNo}">
									${board.title} </a></td>

							<td>${board.writer}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
									value="${board.regDate}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

</div>

<script>
	var result = "${msg}";
	if (result === "SUCCESS") {
		alert("<spring:message code='common.processSuccess' />");
	}
</script>