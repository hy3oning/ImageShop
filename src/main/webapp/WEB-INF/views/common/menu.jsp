<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="menu-wrapper">
	<div align="right">
		<table style="display: inline-table;"> <tr>
				<td width="100">
					<a href="/user/register">
						<spring:message code="header.joinMember" />
					</a>
				</td>
				<td width="140">
					<a href="/codegroup/list">
						<spring:message code="menu.codegroup.list" />
					</a>
				</td>
			</tr>
		</table>
	</div>
</div>

<hr>