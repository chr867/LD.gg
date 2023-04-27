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
	<h1>${email}</h1>
	<h1>${member.lol_account}</h1>
	<h1>${member.user_type}</h1>

	<form id="logoutFrm" action="/logout" method="post">
		<a href="javascript:logout()">로그아웃</a>
	</form>

</body>
<script type="text/javascript">
	function logout() {
		document.querySelector('#logoutFrm').submit();
	}
</script>
</html>