<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>상품을 찾을 수 없습니다</title>

<style>
body {
	font-family: Arial, sans-serif;
	background: #f5f6fa;
	text-align: center;
	padding-top: 120px;
}

.box {
	background: white;
	width: 420px;
	margin: auto;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
}

h2 {
	margin-bottom: 10px;
}

p {
	color: #666;
	margin-bottom: 25px;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	margin: 5px;
	background: #4a69bd;
	color: white;
	text-decoration: none;
	border-radius: 6px;
}

.btn:hover {
	background: #3b55a3;
}
</style>

</head>
<body>

	<div class="box">
		<h2>상품을 찾을 수 없습니다</h2>
		<p>요청하신 상품이 존재하지 않거나 삭제되었습니다.</p>

		``` <a class="btn" href="<%=request.getContextPath()%>/">홈으로 이동</a> <a
			class="btn" href="<%=request.getContextPath()%>/item/list">상품 목록</a>
		```

	</div>

</body>
</html>
