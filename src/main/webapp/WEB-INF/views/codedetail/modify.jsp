<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop - Modify</title>
<link rel="stylesheet" href="/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="container">
		<h2>
			<spring:message code="codedetail.header.modify" />
		</h2>

		<!-- ✅ 수정 폼 -->
		<form:form modelAttribute="codeDetail" action="modify" method="post" id="codeDetailForm">
			<table class="codedetail_table">
				<tr>
					<td><spring:message code="codedetail.groupCode" /></td>
					<td>
						<!-- ✅ select는 readonly 불가 → disabled로 잠그고 -->
						<form:select path="groupCode"
							items="${groupCodeList}"
							itemValue="value"
							itemLabel="label"
							disabled="true" />
						<!-- ✅ disabled는 submit 시 값이 안 넘어가므로 hidden으로 groupCode 유지 -->
						<form:hidden path="groupCode" />
					</td>
					<td><font color="red"><form:errors path="groupCode" /></font></td>
				</tr>

				<tr>
					<td><spring:message code="codedetail.codeValue" /></td>
					<td>
						<!-- ✅ PK(또는 식별자)라면 수정 불가 -->
						<form:input path="codeValue" readonly="true" />
					</td>
					<td><font color="red"><form:errors path="codeValue" /></font></td>
				</tr>

				<tr>
					<td><spring:message code="codedetail.codeName" /></td>
					<td>
						<form:input path="codeName" />
					</td>
					<td><font color="red"><form:errors path="codeName" /></font></td>
				</tr>
			</table>
		</form:form>

		<div>
			<!-- 버튼은 폼 밖이라 JS로 submit -->
			<button type="button" id="btnModify">
				<spring:message code="action.modify" />
			</button>
			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#codeDetailForm");

			$("#btnModify").on("click", function() {
				formObj.submit();
			});

			$("#btnList").on("click", function() {
				self.location = "list";
			});
		});
	</script>
</body>
</html>