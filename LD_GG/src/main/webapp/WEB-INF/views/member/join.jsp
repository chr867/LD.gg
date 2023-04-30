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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
</head>
<body style="text-align: center; justify-content: center;">
	<h1>join.jsp</h1>
	<h1>joinFrm.jsp--회원가입 양식</h1>
	<h1>${msg}</h1>
	<form id="joinFrm" name="joinFrm" action="/member/join" method="post"
		onsubmit="return check()">

		<table border="1" style="margin: auto;">
			<tr>
				<td colspan="2" class="subject">회원가입</td>
			</tr>
			<tr>
				<td width="100">EMAIL</td>
				<td><input class="input" type="email" id="email" name="email">
					<input type="button" id="check_email" value="중복검사"> <span
					id="result"></span>
			</tr>
			<tr>
				<td width="100">PW</td>
				<td><input class="input" type="password" id="pw"
					name="password"></td>
			</tr>
			<tr>
				<td width="100">PHONE</td>
				<td><input class="input" type="text" id="phone"
					name="phone_num"><input type="button"
					id="check_phone_num" value="중복검사"> <span id="result3"></span></td>
			</tr>
			<tr>
				<td width="100">SUMMONER</td>
				<td><input class="input" type="text" id="summoner"
					name="lol_account"><input type="button"
					id="check_lol_account" value="중복검사"> <span id="result2"></span></td>
			</tr>
			<tr>
				<td width="100">TYPE</td>
				<td><input class="radio_box" type="radio" value=1
					name="user_type" checked="checked">일반회원 <input class="radio_box" type="radio"
					value=2 name="user_type">멘토회원</td>
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
	
	let emailSubmit = false;
	let accountSubmit = false;
	let phoneSubmit = false;
	
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
		
		if(!emailSubmit){
			alert("이메일 중복검사를 다시해주세요")
			return false;
		}
		
		if(!accountSubmit){
			alert("소환사계정 중복검사를 다시해주세요")
			return false;
		}
		return true;//성공시 서버로 전송
	}//end function
	
	$('#check_lol_account').on('click',function(){
		if($('#summoner').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_lol_account',
				data: {lol_account:$('#summoner').val()},
			}).done(res=>{
				if(res.length === 0){
					$('#result2').html("사용가능").css('color','blue');
					accountSubmit = true;
				}else{
					$('#result2').html("사용불가").css('color','red');
					console.log(res[0].email);
					console.log(res[0].lol_account);
					$('#summoner').val("");
					accountSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})
	
	$('#check_email').on('click',function(){
		if($('#email').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_email',
				data: {email:$('#email').val()},
				//dataType: 'html', //json,html(text)
			}).done(res=>{
				if(res == true){
					$('#result').html("사용가능").css('color','blue');
					console.log('res : '+res);
					emailSubmit = true;
				}else{
					$('#result').html("사용불가").css('color','red');
					$('#email').val("");
					emailSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})
	
	$('#check_phone_num').on('click',function(){
		if($('#phone').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_phone_num',
				data: {phone_num:$('#phone').val()},
				//dataType: 'html', //json,html(text)
			}).done(res=>{
				if(res == true){
					$('#result3').html("사용가능").css('color','blue');
					console.log('res : '+res);
					phoneSubmit = true;
				}else{
					$('#result3').html("사용불가").css('color','red');
					$('#phone').val("");
					phoneSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})
</script>
</html>