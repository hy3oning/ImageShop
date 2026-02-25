<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<h2>
	<spring:message code="board.header.read" />
</h2>

<form:form modelAttribute="board" id="board" method="post">
	<form:hidden path="boardNo" id="boardNo" />

	<table>
		<tr>
			<td><spring:message code="board.title" /></td>
			<td><form:input path="title" readonly="true" /></td>
			<td><font color="red"><form:errors path="title" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.writer" /></td>
			<td><form:input path="writer" readonly="true" /></td>
			<td><font color="red"><form:errors path="writer" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.content" /></td>
			<td><form:textarea path="content" readonly="true" /></td>
			<td><font color="red"><form:errors path="content" /></font></td>
		</tr>

		<!-- 작성일 -->
		<tr>
			<td><spring:message code="board.regdate" /></td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
					value="${board.regDate}" /></td>
			<td></td>
		</tr>

		<!--  수정된 경우에만 수정일 표시 (null이 아니고, 작성일과 다를 때) -->
		<c:if
			test="${board.updDate ne null and board.updDate ne board.regDate}">
			<tr>
				<td><spring:message code="board.upddate" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
						value="${board.updDate}" /></td>
				<td></td>
			</tr>
		</c:if>
	</table>

	<div style="margin-top: 16px;">
		<sec:authentication property="principal" var="pinfo" />

		<!-- 관리자 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="button" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="button" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
		</sec:authorize>

		<!-- 회원(본인 글만) -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<c:if test="${pinfo.username eq board.writer}">
				<button type="button" id="btnEdit">
					<spring:message code="action.edit" />
				</button>
				<button type="button" id="btnRemove">
					<spring:message code="action.remove" />
				</button>
			</c:if>
		</sec:authorize>

		<button type="button" id="btnList">
			<spring:message code="action.list" />
		</button>
	</div>
</form:form>

<script>
	$(document).ready(function() {
		let formObj = $("#board");
		let ctx = "${pageContext.request.contextPath}";

		$("#btnEdit").on("click", function() {
			let boardNoVal = $("#boardNo").val();
			self.location = ctx + "/board/modify?boardNo=" + boardNoVal;
		});

		$("#btnRemove").on("click", function() {
			formObj.attr("action", ctx + "/board/remove");
			formObj.submit();
		});

		$("#btnList").on("click", function() {
			self.location = ctx + "/board/list";
		});
	});
</script>