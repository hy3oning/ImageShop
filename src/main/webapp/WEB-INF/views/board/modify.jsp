<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<h2>
	<spring:message code="board.header.modify" />
</h2>

<form:form modelAttribute="board"
	action="${pageContext.request.contextPath}/board/modify" method="post"
	id="board">
	<form:hidden path="boardNo" id="boardNo" />

	<input type="hidden" id="page" name="page" value="${pgrq.page}">
	<input type="hidden" id="sizePerPage" name="sizePerPage"
		value="${pgrq.sizePerPage}">
	<input type="hidden" id="searchType" name="searchType"
		value="${pgrq.searchType}">
	<input type="hidden" id="keyword" name="keyword"
		value="${pgrq.keyword}">

	<table>
		<tr>
			<td><spring:message code="board.title" /></td>
			<td><form:input path="title" /></td>
			<td><font color="red"><form:errors path="title" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.writer" /></td>
			<td><form:input path="writer" readonly="true" /></td>
			<td><font color="red"><form:errors path="writer" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.content" /></td>
			<td><form:textarea path="content" /></td>
			<td><font color="red"><form:errors path="content" /></font></td>
		</tr>
	</table>

	<div style="margin-top: 16px;">
		<sec:authentication property="principal" var="pinfo" />

		<c:set var="canModify" value="false" />

		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<c:set var="canModify" value="true" />
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<c:if test="${pinfo.username eq board.writer}">
				<c:set var="canModify" value="true" />
			</c:if>
		</sec:authorize>

		<c:if test="${canModify}">
			<button type="button" id="btnModify">
				<spring:message code="action.modify" />
			</button>
		</c:if>

		<button type="button" id="btnList">
			<spring:message code="action.list" />
		</button>
	</div>
</form:form>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		const formObj = document.getElementById("board");
		const ctx = "${pageContext.request.contextPath}";

		const btnModify = document.getElementById("btnModify");
		const btnList = document.getElementById("btnList");

		const pageEl = document.getElementById("page");
		const sizeEl = document.getElementById("sizePerPage");
		const searchTypeEl = document.getElementById("searchType");
		const keywordEl = document.getElementById("keyword");

		function buildQuery() {
			let q = "page=" + pageEl.value + "&sizePerPage=" + sizeEl.value;

			const st = searchTypeEl ? searchTypeEl.value : "";
			const kw = keywordEl ? keywordEl.value : "";

			if (st && st !== "n")
				q += "&searchType=" + encodeURIComponent(st);
			if (kw)
				q += "&keyword=" + encodeURIComponent(kw);

			return q;
		}

		if (btnModify) {
			btnModify.addEventListener("click", function() {
				// hidden(page/size/searchType/keyword) 같이 POST로 전송됨
				formObj.submit();
			});
		}

		if (btnList) {
			btnList.addEventListener("click", function() {
				location.href = ctx + "/board/list?" + buildQuery();
			});
		}
	});
</script>