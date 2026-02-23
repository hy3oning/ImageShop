<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Image Shop - CodeGroup List</title>
    <link rel="stylesheet" href="/css/codegroup.css">
</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/menu.jsp" />

    <div class="container">
        
        <h2>
            <spring:message code="codegroup.header.list" />
        </h2>

        <div class="btn-new-wrapper">
            <a href="register" class="btn-new">
                <spring:message code="action.new" />
            </a>
        </div>

        <table class="list-table">
            <thead>
                <tr>
                    <th width="160"><spring:message code="codegroup.groupCode" /></th>
                    <th><spring:message code="codegroup.groupName" /></th>
                    <th width="200"><spring:message code="codegroup.regdate" /></th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="3" class="empty-msg">
                                <spring:message code="common.listEmpty" />
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach items="${list}" var="codeGroup">
                            <tr>
                                <td>${codeGroup.groupCode}</td>
                                <td class="text-left">
                                    <a href="/codegroup/read?groupCode=${codeGroup.groupCode}">
                                        ${codeGroup.groupName}
                                    </a>
                                </td>
                                <td>
                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${codeGroup.regDate}" />
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

    </div> 
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        let result = "${msg}";
        if (result === "SUCCESS") {
            alert("<spring:message code='common.processSuccess' />");
        } else if (result === "FAIL") {
            alert("삭제처리 실패");
        }
    </script>
</body>
</html>