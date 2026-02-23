<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
            <spring:message code="codegroup.header.read" />
        </h2>

        <form:form modelAttribute="codeGroup">
            <table class="form-table">
                <tr>
                    <td class="label"><spring:message code="codegroup.groupCode" /></td>
                    <td class="input-field">
                        <form:input path="groupCode" readonly="true" cssClass="read-only" />
                    </td>
                </tr>
                <tr>
                    <td class="label"><spring:message code="codegroup.groupName" /></td>
                    <td class="input-field">
                        <form:input path="groupName" readonly="true" cssClass="read-only" />
                    </td>
                </tr>
            </table>

            <div class="button-container">
                <button type="button" id="btnEdit" class="btn-primary">
                    <spring:message code="action.edit" />
                </button>
                <button type="button" id="btnRemove" class="btn-danger">
                    <spring:message code="action.remove" />
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

            // 수정 페이지로 이동
            $("#btnEdit").on("click", function() {
                let groupCodeVal = $("#groupCode").val();
                self.location = "modify?groupCode=" + groupCodeVal;
            });

            // 삭제 처리 (POST)
            $("#btnRemove").on("click", function() {
                if(confirm("정말로 삭제하시겠습니까?")) {
                    formObj.attr("action", "/codegroup/remove");
                    formObj.attr("method", "post");
                    formObj.submit();
                }
            });

            // 목록으로 이동
            $("#btnList").on("click", function() {
                self.location = "list";
            });
        });
    </script>
</body>
</html>