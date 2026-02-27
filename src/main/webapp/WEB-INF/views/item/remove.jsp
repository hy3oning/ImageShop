<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="container">

	<h2>
		<spring:message code="item.header.remove" />
	</h2>

	<form:form modelAttribute="item" action="remove" method="post"
		id="item">
		<form:hidden path="itemId" />

		<table class="form-table">

			<tr>
				<td><spring:message code="item.itemName" /></td>
				<td><form:input path="itemName" disabled="true" /></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemPrice" /></td>
				<td><form:input path="price" disabled="true" /> &nbsp;원</td>
			</tr>

			<tr>
				<td><spring:message code="item.picture" /></td>
				<td><img class="item-img" src="picture?itemId=${item.itemId}"
					alt="picture"
					onerror="this.src='https://via.placeholder.com/210x150?text=No+Image'">
				</td>
			</tr>

			<tr>
				<td><spring:message code="item.preview" /></td>
				<td><img class="item-img" src="display?itemId=${item.itemId}"
					alt="preview"
					onerror="this.src='https://via.placeholder.com/210x150?text=No+Preview'">
				</td>
			</tr>

			<tr>
				<td><spring:message code="item.itemDescription" /></td>
				<td><form:textarea path="description" rows="5" disabled="true" />
				</td>
			</tr>

		</table>

		<div class="button-container">
			<button type="button" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>

	</form:form>

</div>

<script>
	$(document).ready(function() {
		let formObj = $("#item");

		$("#btnRemove").on("click", function() {
			if (confirm("정말 삭제하시겠습니까?")) {
				formObj.submit();
			}
		});

		$("#btnList").on("click", function() {
			location.href = "list";
		});
	});
</script>