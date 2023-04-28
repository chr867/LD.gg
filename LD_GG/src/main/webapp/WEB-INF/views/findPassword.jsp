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
	<h1>비밀번호 찾기~~~~~~</h1>
	<table border="1">
		<tr>
			<td><input type="email" id="email" name="email"></td>
			<td rowspan="2"><button id="find_password">비밀번호 찾기</button>
		</tr>
		<tr>
			<td><input type="text" id="phone" name="phone"></td>
		</tr>
		<tr>
			<td><span id="result">비밀번호찾기</span></td>
		</tr>
	</table>
</body>
<script type="text/javascript">
$('#find_password').on('click',function(){
	if($('#email').val() !='' && $('#phone').val() !=''){
		let email = $('#email').val();
		let phone = $('#phone').val()
		$.ajax({
			method: 'post',
			url: '/find_password',
			data: {email:$('#email').val(), phone_num:$('#phone').val()},
		}).done(res=>{
			console.log(res);
			if(res !== ""){
				$('#result').html("임시비밀번호 : "+res);
			}else{
				alert("이메일 또는 전화번호를 확인해주세요")
			}
			
		}).fail(err=>{
			console.log(err);
		})
	}
})
</script>
</html>