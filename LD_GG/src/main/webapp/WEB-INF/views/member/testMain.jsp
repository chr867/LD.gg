<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
</head>
<body>
	<h1>Test Main</h1>
	<h1>${msg}</h1>
	<p>이메일 : ${sessionScope.email}</p>
	<p>롤 계정 : ${sessionScope.lol_account}</p>
	<p>유저 타입 : ${sessionScope.user_type}</p>

	<form id="logoutFrm" action="/member/logout" method="post">
		<a href="javascript:logout()">로그아웃</a>
	</form>
	<a href="/member/profile">개인정보 수정</a>
	<a href="/member/myPage">마이페이지</a>
	<a href="/mate/">메이트페이지</a>
	<a href="/tip/">공략페이지</a>
	<a href="/userinterface/admin">어드민페이지</a>
	<a href="/">메인페이지</a>
	<a href="/chat/chat-list">채팅방</a>
	<a href ="/wallet/payment">지갑</a>
</body>
<script type="text/javascript">
	function logout(){
		document.querySelector('#logoutFrm').submit();
	}
</script>
</html>