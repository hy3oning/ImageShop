<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<div class="container" style="max-width: 500px; margin-top: 100px;">
	<h2>
		<spring:message code="auth.header.login" />
	</h2>

	<c:if test="${not empty error}">
		<div style="text-align: center; margin-bottom: 15px;">
			<font color="red"><c:out value="${error}" /></font>
		</div>
	</c:if>

	<c:if test="${not empty logout}">
		<div
			style="text-align: center; margin-bottom: 15px; color: #10b981; font-weight: 500;">
			<c:out value="${logout}" />
		</div>
	</c:if>

	<form method="post" action="/login">
		<table class="user_table">
			<tr>
				<td><spring:message code="user.userId" text="아이디" /></td>
				<td><input type="text" name="username" autofocus required>
				</td>
			</tr>
			<tr>
				<td><spring:message code="user.userPw" text="비밀번호" /></td>
				<td><input type="password" name="password" required></td>
			</tr>
			<tr>
				<td></td>
				<td style="padding-top: 5px;"><label
					style="display: flex; align-items: center; cursor: pointer; font-size: 14px; color: #64748b;">
						<input type="checkbox" name="remember-me"
						style="width: auto; margin-right: 8px;"> <spring:message
							code="auth.rememberMe" />
				</label></td>
			</tr>
		</table>

		<div class="button-container">
			<button type="submit" id="btnRegister" style="width: 100%;">
				<spring:message code="action.login" />
			</button>
		</div>
		<div class="auth-links">
			<a class="auth-link"
				href="${pageContext.request.contextPath}/user/register"> <spring:message
					code="action.register" text="회원가입" />
			</a>
		</div>

		<sec:csrfInput />
	</form>
</div>