<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<h2>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />
	<spring:message code="codegroup.header.modify" />
</h2>
<form:form modelAttribute="codeGroup" action="modify" method="post">
	<table>
		<tr>
			<td><spring:message code="codegroup.groupCode" /></td>
			<td><form:input path="groupCode" readonly="true" /></td>
			<td><font color="red"><form:errors path="groupCode" /></font></td>
		</tr>
		<tr>
			<td><spring:message code="codegroup.groupName" /></td>
			<td><form:input path="groupName" /></td>
			<td><font color="red"><form:errors path="groupName" /></font></td>
		</tr>
	</table>
</form:form>
<div>
	<button type="submit" id="btnModify">
		<spring:message code="action.modify" />
	</button>
	<button type="submit" id="btnList">
		<spring:message code="action.list" />
	</button>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
	$(document).ready(function() {
		var formObj = $("#codeGroup");
		$("#btnModify").on("click", function() {
			formObj.submit();
		});
		$("#btnList").on("click", function() {
			self.location = "list";
		});
	});
</script>