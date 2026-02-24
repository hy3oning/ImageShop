<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Image Shop</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/codegroup.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/menu.jsp" />

    <main class="container">
        <h2>
            <spring:message code="user.header.list" />
        </h2>

        <div class="btn-new-wrapper">
            <a href="register" class="btn-new">
                <spring:message code="user.header.register" />
            </a>
        </div>

        <table>
            <thead>
                <tr>
                    <th width="80"><spring:message code="user.no" /></th>
                    <th width="120"><spring:message code="user.userId" /></th>
                    <th><spring:message code="user.userPw" /></th>
                    <th width="120"><spring:message code="user.userName" /></th>
                    <th width="100"><spring:message code="user.job" /></th>
                    <th width="180"><spring:message code="user.regdate" /></th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" style="padding: 40px; color: #64748b;">
                                <spring:message code="common.listEmpty" />
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${list}" var="member">
                            <tr>
                                <td>${member.userNo}</td>
                                <td>
                                    <a href='/user/read?userNo=${member.userNo}' style="color: #3b82f6; font-weight: 600;">
                                        ${member.userId}
                                    </a>
                                </td>
                                <td style="text-align: left; font-family: monospace;">${member.userPw}</td>
                                <td>${member.userName}</td>
                                <td>${member.job}</td>
                                <td style="color: #64748b; font-size: 0.9rem;">
                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.regDate}" />
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        var result = "${msg}";
        if (result === "SUCCESS") {
            alert("<spring:message code='common.processSuccess' />");
        }
    </script>
</body>
</html>