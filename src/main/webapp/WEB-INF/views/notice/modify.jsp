<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<div class="container">
	<h2>
		<spring:message code="notice.header.modify" />
	</h2>

	<form:form modelAttribute="notice"
		action="${pageContext.request.contextPath}/notice/modify"
		method="post" id="noticeModifyForm">

		<form:hidden path="noticeNo" id="noticeNo" />

		<!--  페이징 유지 -->
		<input type="hidden" id="page" name="page" value="${pgrq.page}">
		<input type="hidden" id="sizePerPage" name="sizePerPage"
			value="${pgrq.sizePerPage}">

		<table class="form-table">
			<tr>
				<td><spring:message code="notice.title" /></td>
				<td><form:input path="title" /> <font color="red"><form:errors
							path="title" /></font></td>
			</tr>

			<tr>
				<td><spring:message code="notice.content" /></td>
				<td><form:textarea path="content" rows="10" /> <font
					color="red"><form:errors path="content" /></font></td>
			</tr>
		</table>

		<div class="button-container">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="submit" id="btnModify">
					<spring:message code="action.modify" />
				</button>
			</sec:authorize>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>

	</form:form>
</div>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		const ctx = "${pageContext.request.contextPath}";

		const pageEl = document.getElementById("page");
		const sizeEl = document.getElementById("sizePerPage");

		function safe(v, def) {
			if (!v)
				return def;
			const t = ("" + v).trim();
			return t === "" ? def : t;
		}

		document.getElementById("btnList").addEventListener(
				"click",
				function() {
					const page = safe(pageEl.value, "1");
					const size = safe(sizeEl.value, "10");

					location.href = ctx + "/notice/list?page=" + page
							+ "&sizePerPage=" + size;
				});
	});
</script>