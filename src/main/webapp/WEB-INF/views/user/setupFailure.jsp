<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">
<div class="container">
	<div class="home-hero">
		<h2>
			<spring:message code="common.cannotSetupAdmin" />
		</h2>

		<hr />

		<p style="color: #64748b; margin-bottom: 30px;">관리자 설정을 진행할 수
			없습니다. 메인 화면으로 돌아가주세요.</p>

		<div class="button-container">
			<a href="/" class="btn-new" id="btnList"
				style="text-decoration: none;"> <spring:message
					code="action.home" />
			</a>
		</div>
	</div>
</div>