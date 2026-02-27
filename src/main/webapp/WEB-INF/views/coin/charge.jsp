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
		<spring:message code="coin.header.chargeCoin" />
	</h2>

	<form:form modelAttribute="chargeCoin"
		action="${pageContext.request.contextPath}/coin/charge" method="post"
		id="chargeCoin">

		<table class="form-table">
			<tr>
				<td><spring:message code="coin.amount" /></td>
				<td><form:input path="amount" type="number" min="1"
						max="1000000" /> <font color="red"><form:errors
							path="amount" /></font></td>
			</tr>
		</table>

		<div class="button-container">
			<button type="submit" id="btnRegister">
				<spring:message code="coin.charge" />
			</button>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>

	</form:form>
</div>

<script>
	$(function() {
		$("#btnList").on("click", function() {
			location.href = "${pageContext.request.contextPath}/coin/list";
		});
	});
</script>