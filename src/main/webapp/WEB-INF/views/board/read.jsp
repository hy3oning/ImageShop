<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/codegroup.css">

<c:if test="${not empty msg}">
	<script>
		alert('${msg}');
	</script>
</c:if>

<h2>
	<spring:message code="board.header.read" />
</h2>

<!-- 로그인 정보 -->
<sec:authentication property="principal" var="pinfo" />

<form:form modelAttribute="board" id="board" method="post">
	<form:hidden path="boardNo" id="boardNo" />

	<input type="hidden" id="page" name="page" value="${pgrq.page}">
	<input type="hidden" id="sizePerPage" name="sizePerPage"
		value="${pgrq.sizePerPage}">
	<input type="hidden" id="searchType" name="searchType"
		value="${pgrq.searchType}">
	<input type="hidden" id="keyword" name="keyword"
		value="${pgrq.keyword}">

	<table>
		<tr>
			<td><spring:message code="board.title" /></td>
			<td><form:input path="title" readonly="true" /></td>
			<td><font color="red"><form:errors path="title" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.writer" /></td>
			<td><form:input path="writer" readonly="true" /></td>
			<td><font color="red"><form:errors path="writer" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.content" /></td>
			<td><form:textarea path="content" readonly="true" /></td>
			<td><font color="red"><form:errors path="content" /></font></td>
		</tr>

		<tr>
			<td><spring:message code="board.regdate" /></td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
					value="${board.regDate}" /></td>
			<td></td>
		</tr>

		<c:if
			test="${board.updDate ne null and board.updDate ne board.regDate}">
			<tr>
				<td><spring:message code="board.upddate" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
						value="${board.updDate}" /></td>
				<td></td>
			</tr>
		</c:if>
	</table>

	<div style="margin-top: 16px;">

		<!-- 관리자 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="button" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="button" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
		</sec:authorize>

		<!-- 회원(본인 글만) -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<c:if test="${pinfo.username eq board.writer}">
				<button type="button" id="btnEdit">
					<spring:message code="action.edit" />
				</button>
				<button type="button" id="btnRemove">
					<spring:message code="action.remove" />
				</button>
			</c:if>
		</sec:authorize>

		<button type="button" id="btnList">
			<spring:message code="action.list" />
		</button>
	</div>
</form:form>

<hr>

<!-- =========================
     댓글 섹션
     ========================= -->
<div class="reply-section">
	<h3 class="reply-title">댓글</h3>

	<!-- 댓글 목록 -->
	<c:forEach var="r" items="${replyList}">
		<div class="reply-card">
			<div class="reply-meta">
				<b class="reply-writer">${r.writer}</b> <span class="reply-sep">|</span>
				<span class="reply-date"> <fmt:formatDate
						value="${r.regDate}" pattern="yyyy-MM-dd HH:mm" />
				</span>
			</div>

			<div class="reply-content">${r.content}</div>

			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq r.writer}">
					<div class="reply-actions">
						<button type="button"
							class="reply-btn reply-btn-primary btn-reply-edit"
							data-replyno="${r.replyNo}">수정</button>

						<form class="reply-inline-form"
							action="${pageContext.request.contextPath}/reply/remove"
							method="post">
							<input type="hidden" name="replyNo" value="${r.replyNo}">
							<input type="hidden" name="boardNo" value="${r.boardNo}">
							<button type="submit" class="reply-btn reply-btn-danger">삭제</button>
						</form>
					</div>

					<form class="reply-edit-form" id="replyEditForm-${r.replyNo}"
						action="${pageContext.request.contextPath}/reply/modify"
						method="post">
						<input type="hidden" name="replyNo" value="${r.replyNo}">
						<input type="hidden" name="boardNo" value="${r.boardNo}">

						<textarea name="content" class="reply-textarea" rows="3">${r.content}</textarea>

						<div class="reply-form-actions">
							<button type="submit" class="reply-btn reply-btn-primary">저장</button>

							<button type="button"
								class="reply-btn reply-btn-cancel btn-reply-cancel"
								data-replyno="${r.replyNo}">취소</button>
						</div>
					</form>
				</c:if>
			</sec:authorize>
		</div>
	</c:forEach>

	<!-- 댓글 등록 -->
	<sec:authorize access="isAuthenticated()">
		<form class="reply-form"
			action="${pageContext.request.contextPath}/reply/register"
			method="post">
			<input type="hidden" name="boardNo" value="${board.boardNo}">
			<textarea class="reply-textarea" name="content" rows="4"
				placeholder="댓글을 입력하세요"></textarea>
			<div class="reply-form-actions">
				<button type="submit" class="reply-btn reply-btn-primary">댓글
					등록</button>
			</div>
		</form>
	</sec:authorize>

	<sec:authorize access="!isAuthenticated()">
		<p class="reply-guest">댓글을 작성하려면 로그인하세요.</p>
	</sec:authorize>
</div>

<script>
	$(document).ready(
			function() {
				let formObj = $("#board");
				let ctx = "${pageContext.request.contextPath}";

				function getParams() {
					return {
						page : $("#page").val(),
						sizePerPage : $("#sizePerPage").val(),
						searchType : $("#searchType").val(),
						keyword : $("#keyword").val()
					};
				}

				function buildQuery(p) {
					let q = "page=" + p.page + "&sizePerPage=" + p.sizePerPage;

					if (p.searchType && p.searchType !== "n") {
						q += "&searchType=" + encodeURIComponent(p.searchType);
					}
					if (p.keyword) {
						q += "&keyword=" + encodeURIComponent(p.keyword);
					}
					return q;
				}

				$("#btnEdit").on(
						"click",
						function() {
							let boardNo = $("#boardNo").val();
							let p = getParams();

							self.location = ctx + "/board/modify?boardNo="
									+ boardNo + "&" + buildQuery(p);
						});

				$("#btnRemove").on("click", function() {
					if (!confirm("정말 삭제하시겠습니까?"))
						return;

					formObj.attr("action", ctx + "/board/remove");
					formObj.submit();
				});

				$("#btnList").on("click", function() {
					let p = getParams();
					self.location = ctx + "/board/list?" + buildQuery(p);
				});
			});

	// 댓글 수정 폼
	$(document).on("click", ".btn-reply-edit", function() {
		let replyNo = $(this).data("replyno");
		$("#replyEditForm-" + replyNo).slideToggle(150);
	});

	// 댓글 수정 취소
	$(document).on("click", ".btn-reply-cancel", function() {
		let replyNo = $(this).data("replyno");
		$("#replyEditForm-" + replyNo).slideUp(150);
	});
	// 댓글 삭제
	$(document).on("submit", ".reply-inline-form", function(e) {
		if (!confirm("정말 삭제하시겠습니까?")) {
			e.preventDefault();
		}
	});

	// 댓글 수정
	$(document).on("submit", ".reply-edit-form", function(e) {
		if (!confirm("댓글을 수정하시겠습니까?")) {
			e.preventDefault();
		}
	});
</script>