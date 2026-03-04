<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="container">

	<h2>
		<spring:message code="item.header.modify" />
	</h2>

	<form:form modelAttribute="item" action="modify" method="post"
		enctype="multipart/form-data" id="item">

		<form:hidden path="itemId" />
		<form:hidden path="pictureUrl" />
		<form:hidden path="previewUrl" />

		<table class="form-table">

			<tr>
				<td><spring:message code="item.itemName" /></td>
				<td><form:input path="itemName" required="required" />
					<div class="form-errors">
						<form:errors path="itemName" />
					</div></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemPrice" /></td>
				<td><form:input path="price" type="number" min="0" step="1"
						required="required" />
					<div class="form-errors">
						<form:errors path="price" />
					</div></td>
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
				<td><spring:message code="item.itemFile" /></td>
				<td class="file-field"><input type="file" name="picture" /> <small>(변경
						시에만 선택)</small></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemPreviewFile" /></td>
				<td class="file-field"><input type="file" name="preview" /> <small>(변경
						시에만 선택)</small></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemDescription" /></td>
				<td><form:textarea path="description" rows="5" />
					<div class="form-errors">
						<form:errors path="description" />
					</div></td>
			</tr>

		</table>
	</form:form>

	<div class="button-container">
		<button type="button" id="btnModify">
			<spring:message code="action.modify" />
		</button>

		<button type="button" id="btnList">
			<spring:message code="action.list" />
		</button>
	</div>

</div>

<script>
	$(document).ready(function() {
		var formObj = $("#item");

		$("#btnModify").on("click", function() {
			if (formObj[0].checkValidity()) {
				formObj.submit();
			} else {
				formObj[0].reportValidity();
			}
		});

		$("#btnList").on("click", function() {
			location.href = "list";
		});
	});
</script>