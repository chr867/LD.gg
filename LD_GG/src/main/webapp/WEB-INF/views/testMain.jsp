<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Test Main</h1>
	<h1>${msg}</h1>
	<p>이메일 : ${sessionScope.email}</p>
	<p>롤 계정 : ${sessionScope.lol_account}</p>
	<p>유저 타입 : ${sessionScope.user_type}</p>

	<form id="logoutFrm" action="/logout" method="post">
		<a href="javascript:logout()">로그아웃</a>
	</form>
	<br>
	<a href="/dropMember">회원탈퇴</a>

</body>
<script type="text/javascript">
	function logout() {
		document.querySelector('#logoutFrm').submit();
	}
</script>
</html>