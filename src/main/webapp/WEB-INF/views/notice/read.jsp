<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<div class="container">
	<h2>
		<spring:message code="notice.header.read" />
	</h2>

	<form:form modelAttribute="notice" id="noticeForm" method="post">
		<form:hidden path="noticeNo" id="noticeNo" />

		<input type="hidden" id="page" name="page" value="${pgrq.page}">
		<input type="hidden" id="sizePerPage" name="sizePerPage"
			value="${pgrq.sizePerPage}">

		<table class="form-table">
			<tr>
				<td><spring:message code="notice.title" /></td>
				<td><form:input path="title" readonly="true" /> <font
					color="red"><form:errors path="title" /></font></td>
			</tr>

			<tr>
				<td><spring:message code="notice.content" /></td>
				<td><form:textarea path="content" readonly="true" rows="10" />
					<font color="red"><form:errors path="content" /></font></td>
			</tr>
		</table>

		<div class="button-container">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="button" id="btnEdit">
					<spring:message code="action.edit" />
				</button>
				<button type="button" id="btnRemove">
					<spring:message code="action.remove" />
				</button>
			</sec:authorize>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</form:form>
</div>

<script>
$(document).ready(function() {
	let formObj = $("#noticeForm");
	let ctx = "${pageContext.request.contextPath}";

	function getPageParams() {
		let page = $("#page").val();
		let sizePerPage = $("#sizePerPage").val();

		page = (page && page.trim() !== "") ? page : "1";
		sizePerPage = (sizePerPage && sizePerPage.trim() !== "") ? sizePerPage : "10";

		return { page, sizePerPage };
	}

	$("#btnEdit").on("click", function() {
		let noticeNo = $("#noticeNo").val();
		let p = getPageParams();

		location.href = ctx + "/notice/modify?noticeNo=" + noticeNo
				+ "&page=" + p.page
				+ "&sizePerPage=" + p.sizePerPage;
	});

	$("#btnRemove").on("click", function() {
		if (!confirm("정말 삭제하시겠습니까?")) return;

		formObj.attr("action", ctx + "/notice/remove");
		formObj.submit();
	});

	$("#btnList").on("click", function() {
		let p = getPageParams();

		location.href = ctx + "/notice/list?page=" + p.page
				+ "&sizePerPage=" + p.sizePerPage;
	});
});
</script>