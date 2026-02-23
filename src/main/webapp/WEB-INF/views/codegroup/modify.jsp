<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <spring:message code="codegroup.header.modify" />
        </h2>

        <form:form modelAttribute="codeGroup" action="modify" method="post">
            <table class="form-table">
                <tr>
                    <td class="label"><spring:message code="codegroup.groupCode" /></td>
                    <td class="input-field">
                        <form:input path="groupCode" readonly="true" cssClass="read-only" />
                    </td>
                    <td class="error-msg"><form:errors path="groupCode" /></td>
                </tr>
                <tr>
                    <td class="label"><spring:message code="codegroup.groupName" /></td>
                    <td class="input-field">
                        <form:input path="groupName" />
                    </td>
                    <td class="error-msg"><form:errors path="groupName" /></td>
                </tr>
            </table>

            <div class="button-container">
                <button type="button" id="btnModify" class="btn-primary">
                    <spring:message code="action.modify" />
                </button>
                <button type="button" id="btnList" class="btn-secondary">
                    <spring:message code="action.list" />
                </button>
            </div>
        </form:form>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        $(document).ready(function() {
            let formObj = $("#codeGroup");

            // 수정 버튼 클릭
            $("#btnModify").on("click", function() {
                formObj.submit();
            });

            // 목록 버튼 클릭
            $("#btnList").on("click", function() {
                self.location = "list";
            });
        });
    </script>
</body>
</html>