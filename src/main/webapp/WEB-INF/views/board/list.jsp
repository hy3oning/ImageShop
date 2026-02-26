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
			<a href="${pageContext.request.contextPath}/board/register"
				class="btn-new"> <spring:message code="action.new" />
			</a>
		</sec:authorize>
	</div>

	<!-- ===== 검색 ===== -->
	<div class="search-bar">
		<form action="${pageContext.request.contextPath}/board/list"
			method="get">
			<input type="hidden" name="page" value="1" /> <input type="hidden"
				name="sizePerPage" value="${pgrq.sizePerPage}" /> <select
				name="searchType">
				<option value="n"
					${pgrq.searchType == null || pgrq.searchType == 'n' ? 'selected' : ''}>---</option>
				<option value="t" ${pgrq.searchType == 't' ? 'selected' : ''}>Title</option>
				<option value="c" ${pgrq.searchType == 'c' ? 'selected' : ''}>Content</option>
				<option value="w" ${pgrq.searchType == 'w' ? 'selected' : ''}>Writer</option>
				<option value="tc" ${pgrq.searchType == 'tc' ? 'selected' : ''}>Title
					OR Content</option>
				<option value="cw" ${pgrq.searchType == 'cw' ? 'selected' : ''}>Content
					OR Writer</option>
				<option value="tcw" ${pgrq.searchType == 'tcw' ? 'selected' : ''}>Title
					OR Content OR Writer</option>
			</select> <input type="text" name="keyword" value="${pgrq.keyword}"
				placeholder="검색어 입력" />

			<button type="submit" class="btn-new">검색</button>

			<c:url var="resetUrl" value="/board/list">
				<c:param name="page" value="1" />
				<c:param name="sizePerPage" value="${pgrq.sizePerPage}" />
			</c:url>
			<a href="${pageContext.request.contextPath}${resetUrl}"
				class="btn-new search-reset">초기화</a>
		</form>
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
						<c:url var="readUrl" value="/board/read">
							<c:param name="boardNo" value="${board.boardNo}" />
							<c:param name="page" value="${pgrq.page}" />
							<c:param name="sizePerPage" value="${pgrq.sizePerPage}" />
							<c:param name="searchType" value="${pgrq.searchType}" />
							<c:param name="keyword" value="${pgrq.keyword}" />
						</c:url>

						<tr>
							<td>${board.boardNo}</td>
							<td class="td-title"><a
								href="${pageContext.request.contextPath}${readUrl}">${board.title}</a>
							</td>
							<td>${board.writer}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
									value="${board.regDate}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<!-- ===== 페이징 ===== -->
	<div class="pagination">

		<c:if test="${pagination.prev}">
			<c:url var="prevUrl" value="/board/list">
				<c:param name="page" value="${pagination.startPage - 1}" />
				<c:param name="sizePerPage" value="${pgrq.sizePerPage}" />
				<c:param name="searchType" value="${pgrq.searchType}" />
				<c:param name="keyword" value="${pgrq.keyword}" />
			</c:url>
			<a href="${pageContext.request.contextPath}${prevUrl}">&laquo;</a>
		</c:if>

		<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}"
			var="idx">
			<c:url var="pageUrl" value="/board/list">
				<c:param name="page" value="${idx}" />
				<c:param name="sizePerPage" value="${pgrq.sizePerPage}" />
				<c:param name="searchType" value="${pgrq.searchType}" />
				<c:param name="keyword" value="${pgrq.keyword}" />
			</c:url>

			<a href="${pageContext.request.contextPath}${pageUrl}"
				class="${idx == pgrq.page ? 'active' : ''}">${idx}</a>
		</c:forEach>

		<c:if test="${pagination.next}">
			<c:url var="nextUrl" value="/board/list">
				<c:param name="page" value="${pagination.endPage + 1}" />
				<c:param name="sizePerPage" value="${pgrq.sizePerPage}" />
				<c:param name="searchType" value="${pgrq.searchType}" />
				<c:param name="keyword" value="${pgrq.keyword}" />
			</c:url>
			<a href="${pageContext.request.contextPath}${nextUrl}">&raquo;</a>
		</c:if>

	</div>

</div>

<script>
	let result = "${msg}";
	if (result === "SUCCESS") {
		alert("<spring:message code='common.processSuccess' />");
	} else if (result === "FAILED") {
		alert("FAILED");
	}
</script>