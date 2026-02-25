<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<div class="menu-wrapper">
	<div align="right">
		<table style="display: inline-table;">
			<tr>
				<td width="80"><a href="/"> <spring:message
							code="header.home" />
				</a></td>
				<!-- 로그인을 하지 않은 경우 true -->
				<sec:authorize access="!isAuthenticated()">
				</sec:authorize>
				<!-- 인증된 사용자인 경우 true -->
				<sec:authorize access="isAuthenticated()">
					<!-- 관리자 권한을 가진 사용자인 경우 true -->
					<sec:authorize access="hasRole('ADMIN')">
						<!-- 회원가입 메뉴-->
						<td width="100"><a href="/user/register"> <spring:message
									code="header.joinMember" />
						</a></td>
						<!-- 코드 그룹관리 메뉴 -->
						<td width="140"><a href="/codegroup/list"> <spring:message
									code="menu.codegroup.list" />
						</a></td>
						<!-- 코드 관리를 메뉴 -->
						<td width="120"><a href="/codedetail/list"><spring:message
									code="menu.codedetail.list" /></a></td>
						<!-- 회원 관리를 메뉴에 추가한다. -->
						<td width="120"><a href="/user/list"><spring:message
									code="menu.user.admin" /></a></td>
					</sec:authorize>
					<!-- 회원 권한을 가진 사용자인 경우 true -->
					<sec:authorize access="hasRole('MEMBER')">
					</sec:authorize>
				</sec:authorize>

			</tr>
		</table>
	</div>
</div>

<hr>