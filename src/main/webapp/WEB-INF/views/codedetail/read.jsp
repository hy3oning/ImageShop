<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop - Read</title>
<link rel="stylesheet" href="/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<h2>
			<spring:message code="codedetail.header.read" />
		</h2>
		<form:form modelAttribute="codeDetail" id="codeDetailForm">
			<table>
				<tr>
					<td><spring:message code="codedetail.groupCode" /></td>
					<td><form:select path="groupCode" items="${groupCodeList}"
							itemValue="value" itemLabel="label" disabled="true" /> <form:hidden
							path="groupCode" /></td>
					<td><font color="red"><form:errors path="groupCode" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="codedetail.codeValue" /></td>
					<td><form:input path="codeValue" readonly="true" /></td>
					<td><font color="red"><form:errors path="codeValue" /></font></td>
				</tr>
				<tr>
					<td><spring:message code="codedetail.codeName" /></td>
					<td><form:input path="codeName" readonly="true" /></td>
					<td><font color="red"><form:errors path="codeName" /></font></td>
				</tr>
			</table>
		</form:form>
		<div>
			<button type="submit" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="submit" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
			<button type="submit" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#codeDetailForm");

			$("#btnEdit").on("click", function() {
				formObj.attr("action", "modify");
				formObj.attr("method", "get");
				formObj.submit();
			});

			$("#btnRemove").on("click", function() {
				formObj.attr("action", "remove");
				formObj.attr("method", "post"); // 삭제는 GET 말고 POST 권장
				formObj.submit();
			});

			$("#btnList").on("click", function() {
				self.location = "list";
			});
		});
	</script>
</body>
</html>