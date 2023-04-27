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

	<h3>${msg}</h3>
	<h1>Home.jsp-로그인 페이지</h1>
	<form action="/login" name="logFrm" method="post">
		<table border="1">
			<tr>
				<td colspan="2" align="center">로그인</td>
			</tr>
			<tr>
				<td><input type="text" name="email"></td>
				<td rowspan="2"><button>로그인</button>
			</tr>
			<tr>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" bgcolor="skyblue">마 쪼리나?</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><a href="/join">회원가입</a></td>
			</tr>
		</table>
	</form>

</body>

<script type="text/javascript">
	let	check = ${check}
	console.log(check);
	if(check === 1){
		 Swal.fire({
			icon:'success',
			title:'회원가입성공',
			text:'로그인해주세요!!!'
		}) 
		//alert('회원가입 성공');
	}else if (check ===2){
		//alert('로그인 실패');
		 Swal.fire({
				icon:'error',
				title:'로그인 실패',
				text:'아이디 또는 비번 오류입니다!!'
			}) 
	}
</script>

</html>