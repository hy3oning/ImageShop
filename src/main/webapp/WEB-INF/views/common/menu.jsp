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

				<!-- 로그인한 사용자만 게시판 메뉴 표시 -->
				<sec:authorize access="isAuthenticated()">
					<td width="120"><a href="/board/list"> <spring:message
								code="menu.board.member" />
					</a></td>
				</sec:authorize>

				<!-- 인증된 사용자 -->
				<sec:authorize access="isAuthenticated()">

					<!-- 관리자 권한 -->
					<sec:authorize access="hasRole('ADMIN')">
						<td width="100"><a href="/user/register"> <spring:message
									code="header.joinMember" />
						</a></td>

						<td width="140"><a href="/codegroup/list"> <spring:message
									code="menu.codegroup.list" />
						</a></td>

						<td width="120"><a href="/codedetail/list"> <spring:message
									code="menu.codedetail.list" />
						</a></td>

						<td width="120"><a href="/user/list"> <spring:message
									code="menu.user.admin" />
						</a></td>
					</sec:authorize>

					<!-- 회원 권한 -->
					<sec:authorize access="hasRole('MEMBER')">
					</sec:authorize>

				</sec:authorize>

			</tr>
		</table>
	</div>
</div>

<hr>