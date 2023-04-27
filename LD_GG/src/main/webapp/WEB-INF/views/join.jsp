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
<body style="text-align: center; justify-content: center;">
	<h1>join.jsp</h1>
	<h1>joinFrm.jsp--회원가입 양식</h1>
	<h1>${msg}</h1>
	<form id="joinFrm" name="joinFrm" action="/join" method="post"
		onsubmit="return check()">

		<table border="1" style="margin: auto;">
			<tr>
				<td colspan="2" class="subject">회원가입</td>
			</tr>
			<tr>
				<td width="100">EMAIL</td>
				<td><input class="input" type="email" id="email" name="email">
			</tr>
			<tr>
				<td width="100">PW</td>
				<td><input class="input" type="password" id="pw"
					name="password"></td>
			</tr>
			<tr>
				<td width="100">PHONE</td>
				<td><input class="input" type="text" id="phone"
					name="phone_num"></td>
			</tr>
			<tr>
				<td width="100">SUMMONER</td>
				<td><input class="input" type="text" id="summoner"
					name="lol_account"></td>
			</tr>
			<tr>
				<td width="100">TYPE</td>
				<td>
					<input class="radio_box" type="radio" value= 1 name="user_type">일반회원
					<input class="radio_box" type="radio" value= 2 name="user_type">멘토회원
				</td>
			</tr>
			<tr>
				<td colspan="2" class="subject"><input type="submit"
					id="submit" value="회원가입"> <input type='reset' value="취소">
				</td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
	function check() {
		let frm = document.joinFrm
		let length = frm.length - 1
		for (let i = 0; i < length; i++) {
			if (frm[i].value == '') {
				alert(frm[i].name + "을 입력하세요!!")
				frm[i].focus();
				return false;//실패시
			}
		}
		return true;//성공시 서버로 전송
	}//end function
</script>
</html>