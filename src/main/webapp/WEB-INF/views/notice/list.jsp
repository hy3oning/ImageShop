<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">

	<h2>
		<spring:message code="notice.header.list" />
	</h2>

	<!-- 신규 등록 버튼: board/list.jsp랑 동일한 위치/스타일 -->
	<div class="button-container" style="margin-top: 0; margin-bottom: 20px;">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a class="btn-new"
				href="${pageContext.request.contextPath}/notice/register">
				<spring:message code="action.new" />
			</a>
		</sec:authorize>
	</div>

	<table>
		<thead>
			<tr>
				<th><spring:message code="notice.no" /></th>
				<th><spring:message code="notice.title" /></th>
				<th><spring:message code="notice.regdate" /></th>
			</tr>
		</thead>

		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="3"><spring:message code="common.listEmpty" /></td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${list}" var="notice">
						<tr>
							<td>${notice.noticeNo}</td>

							<!-- 제목은 좌측정렬 원하면 td-title 클래스 쓰기 -->
							<td class="td-title">
								<a href="${pageContext.request.contextPath}/notice/read
									?noticeNo=${notice.noticeNo}
									&page=${pgrq.page}
									&sizePerPage=${pgrq.sizePerPage}">
									<c:out value="${notice.title}" />
								</a>
							</td>

							<td>
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${notice.regDate}" />
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<!-- ===== 페이징: board/list.jsp 패턴으로 통일 ===== -->
	<c:if test="${not empty pagination and pagination.totalCount > 0}">
		<div class="pagination">

			<c:if test="${pagination.prev}">
				<a href="${pageContext.request.contextPath}/notice/list
					?page=${pagination.startPage - 1}
					&sizePerPage=${pgrq.sizePerPage}">
					&laquo;
				</a>
			</c:if>

			<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
				<a href="${pageContext.request.contextPath}/notice/list
					?page=${idx}
					&sizePerPage=${pgrq.sizePerPage}"
					class="${idx == pgrq.page ? 'active' : ''}">
					${idx}
				</a>
			</c:forEach>

			<c:if test="${pagination.next}">
				<a href="${pageContext.request.contextPath}/notice/list
					?page=${pagination.endPage + 1}
					&sizePerPage=${pgrq.sizePerPage}">
					&raquo;
				</a>
			</c:if>

		</div>
	</c:if>

</div>

<script>
	let result = "${msg}";
	if (result === "SUCCESS") {
		alert("<spring:message code='common.processSuccess' />");
	} else if (result === "FAILED") {
		alert("FAILED");
	}
</script>