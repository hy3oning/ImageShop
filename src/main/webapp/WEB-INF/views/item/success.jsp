<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">
    <h2>
        <spring:message code="${msgKey}" />
    </h2>

    <div class="button-container">
        <a class="btn-link"
           href="${pageContext.request.contextPath}/item/list">
            <spring:message code="action.list" />
        </a>
    </div>
</div>