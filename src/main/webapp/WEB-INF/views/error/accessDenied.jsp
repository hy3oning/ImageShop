<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">
	<h2>접근 권한이 없습니다</h2>

	<table class="form-table">
		<tr>
			<td>상태</td>
			<td>403 Forbidden</td>
		</tr>
		<tr>
			<td>안내</td>
			<td>요청하신 페이지에 접근할 권한이 없습니다.<br> 계정 권한(ROLE) 또는 로그인 상태를
				확인해주세요.
			</td>
		</tr>
		<c:if test="${not empty msg}">
			<tr>
				<td>메시지</td>
				<td>${msg}</td>
			</tr>
		</c:if>
	</table>

	<div class="button-container">
		<a class="btn-link" id="btnList"
			href="${pageContext.request.contextPath}/">홈으로</a> <a
			class="btn-link" id="btnEdit" href="javascript:history.back()">이전
			페이지</a>
	</div>

	<div class="auth-links">
		<a class="auth-link"
			href="${pageContext.request.contextPath}/member/login">로그인</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />