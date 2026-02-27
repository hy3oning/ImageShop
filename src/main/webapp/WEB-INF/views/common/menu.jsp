<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<div class="menu-wrapper">
	<div align="right">
		<table style="display: inline-table;">
			<tr>
				<!-- 공통: 홈 -->
				<td width="80"><a href="/"><spring:message
							code="header.home" /></a></td>

				<!-- 비로그인: 회원가입/로그인 (필요하면) -->
				<sec:authorize access="isAnonymous()">
				</sec:authorize>

				<!-- 로그인 사용자 공통 메뉴 -->
				<sec:authorize access="isAuthenticated()">
					<td width="120"><a href="/board/list"><spring:message
								code="menu.board.member" /></a></td>
					<td width="120"><a href="/notice/list"><spring:message
								code="menu.notice.member" /></a></td>
					<td width="120"><a href="/coin/charge"><spring:message
								code="menu.coin.charge" /></a></td>
					<td width="120"><a href="/coin/list"><spring:message
								code="menu.coin.list" /></a></td>

					<!-- 상품: 관리자면 '상품관리', 아니면 '상품' -->
					<sec:authorize access="hasRole('ADMIN')">
						<td width="120"><a href="/item/list"><spring:message
									code="menu.item.admin" /></a></td>
					</sec:authorize>
					<sec:authorize access="!hasRole('ADMIN')">
						<td width="120"><a href="/item/list"><spring:message
									code="menu.item.member" /></a></td>
					</sec:authorize>

					<!-- 관리자 전용 메뉴 -->
					<sec:authorize access="hasRole('ADMIN')">
						<td width="140"><a href="/codegroup/list"><spring:message
									code="menu.codegroup.list" /></a></td>
						<td width="120"><a href="/codedetail/list"><spring:message
									code="menu.codedetail.list" /></a></td>
						<td width="120"><a href="/user/list"><spring:message
									code="menu.user.admin" /></a></td>
					</sec:authorize>

				</sec:authorize>

			</tr>
		</table>
	</div>
</div>

<hr>