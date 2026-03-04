<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/codegroup.css">
</head>

<body class="page">

	<!-- 로그아웃 성공 시 alert -->
	<c:if test="${not empty logoutMsg}">
		<script>
			alert("${logoutMsg}");
		</script>
	</c:if>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<main>
		<div class="container">
			<div class="home-hero">
				<h1>
					<spring:message code="common.homeWelcome" />
				</h1>
				<div class="time-widget">
					<div class="tw-top">
						<div class="tw-title">NOW</div>
						<div id="clock" class="tw-clock"></div>
					</div>

					<div class="tw-mid">
						<div class="tw-row">
							<span class="tw-label">DAY PROGRESS</span> <span id="dayPercent"
								class="tw-value">0.00%</span>
						</div>

						<div class="tw-bar">
							<div id="dayBar" class="tw-bar-fill" style="width: 0%"></div>
						</div>

						<div class="tw-sub">
							<span id="elapsedText">경과 00:00:00</span> <span id="remainText">남음
								24:00:00</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
	function pad2(n) {
		return String(n).padStart(2, '0');
	}

	function formatHMS(totalSeconds) {
		const h = Math.floor(totalSeconds / 3600);
		const m = Math.floor((totalSeconds % 3600) / 60);
		const s = totalSeconds % 60;
		return pad2(h) + ":" + pad2(m) + ":" + pad2(s);
	}

	function updateClock() {
		const now = new Date();

		// 1) 날짜 + 시간
		const date = now.toLocaleDateString();
		const hours = pad2(now.getHours());
		const minutes = pad2(now.getMinutes());
		const seconds = pad2(now.getSeconds());

		document.getElementById("clock").innerText = date + " " + hours + ":"
				+ minutes + ":" + seconds;

		// 2) 오늘 진행률
		const secondsToday = now.getHours() * 3600 + now.getMinutes() * 60
				+ now.getSeconds();

		const total = 24 * 3600; // 86400
		const percent = (secondsToday / total) * 100;
		const remain = total - secondsToday;

		// 3) UI 반영
		document.getElementById("dayPercent").innerText = percent.toFixed(2)
				+ "%";
		document.getElementById("dayBar").style.width = percent.toFixed(4)
				+ "%";

		document.getElementById("elapsedText").innerText = "경과 "
				+ formatHMS(secondsToday);
		document.getElementById("remainText").innerText = "남음 "
				+ formatHMS(remain);
	}

	updateClock();
	setInterval(updateClock, 1000);
</script>
</html>