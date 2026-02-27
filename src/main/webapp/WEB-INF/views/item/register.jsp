<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="container">
	<h2>
		<spring:message code="item.header.register" />
	</h2>

	<form:form modelAttribute="item"
		action="${pageContext.request.contextPath}/item/register"
		method="post" enctype="multipart/form-data" id="item">
		<table class="form-table">

			<tr>
				<td><spring:message code="item.itemName" /></td>
				<td><form:input path="itemName" required="required" /> <font
					color="red"><form:errors path="itemName" /></font></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemPrice" /></td>
				<td><form:input path="price" required="required" />&nbsp;원 <font
					color="red"><form:errors path="price" /></font></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemFile" /></td>
				<td><input type="file" name="picture" required /></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemPreviewFile" /></td>
				<td><input type="file" name="preview" required /></td>
			</tr>

			<tr>
				<td><spring:message code="item.itemDescription" /></td>
				<td><form:textarea path="description" rows="5" required="required" /> <font
					color="red"><form:errors path="description" /></font></td>
			</tr>
		</table>

		<div class="button-container">
			<button type="button" id="btnRegister">
				<spring:message code="action.register" />
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

		$("#btnRegister").on("click", function() {
			// 파일 입력 필드 확인
			if (formObj[0].checkValidity()) {
				formObj.submit();
			} else {
				// 유효하지 않으면 브라우저가 알아서 메시지를 띄웁니다.
				formObj[0].reportValidity();
			}

		});
		$("#btnList").on("click", function() {
			location.href = "${pageContext.request.contextPath}/item/list";
		});
	});
</script>
