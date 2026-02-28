<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">
	<h2>
		<spring:message code="useritem.header.read" />
	</h2>

	<form:form modelAttribute="userItem">
		<form:hidden path="userItemNo" />

		<table class="form-table">
			<tr>
				<td><spring:message code="useritem.itemName" /></td>
				<td><form:input path="itemName" readonly="true" /></td>
			</tr>

			<tr>
				<td><spring:message code="useritem.itemPrice" /></td>
				<td><form:input path="price" readonly="true" /></td>
			</tr>

			<tr>
				<td><spring:message code="useritem.itemFile" /></td>
				<td><img class="item-img"
					src="${pageContext.request.contextPath}/item/display?itemId=${userItem.itemId}"
					alt="preview"></td>
			</tr>

			<tr>
				<td><spring:message code="useritem.itemDescription" /></td>
				<td><form:textarea path="description" readonly="true" /></td>
			</tr>
		</table>
	</form:form>

	<div class="button-container">
		<button type="button" id="btnList"
			onclick="location.href='${pageContext.request.contextPath}/useritem/list'">
			<spring:message code="action.list" />
		</button>

		<a class="btn-link btn-download"
			href="${pageContext.request.contextPath}/useritem/download?userItemNo=${userItem.userItemNo}">
			<spring:message code="useritem.download" />
		</a>
	</div>
</div>