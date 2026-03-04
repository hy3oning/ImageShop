<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="header-wrapper">
	<div align="center">
		<table>
			<tr>
				<!-- 로그인을 하지 않은 경우 로그인 페이지로 이동할 수 있게 한다. -->
				<sec:authorize access="!isAuthenticated()">
					<td width="80"><a href="/user/register"> <spring:message
								code="header.joinMember" />
					</a></td>

					<!-- 로그인을 메뉴에 추가한다. (기존 링크 유지) -->
					<td width="80"><a href="/auth/login"> <spring:message
								code="header.login" />
					</a></td>
				</sec:authorize>

				<!-- 로그인을 거친 인증된 사용자인 경우 사용자명을 보여주고 로그아웃 처리(POST)할 수 있게 한다. -->
				<sec:authorize access="isAuthenticated()">
					<td width="220"><sec:authentication
							property="principal.username" /> 님
						<form action="/logout" method="post" style="display: inline;">
							<button type="submit"
								style="background: none; border: 0; padding: 0; cursor: pointer; text-decoration: underline;">
								<spring:message code="header.logout" />
							</button>
						</form></td>
				</sec:authorize>
			</tr>
		</table>
	</div>
</div>

<hr>