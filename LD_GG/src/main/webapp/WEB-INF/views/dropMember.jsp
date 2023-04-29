<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
<body>
	<h1>자기야 시발 어떻게 사랑이 이래?</h1>
	<h1>진짜 탈퇴할거야? 나 평생 사랑한다며</h1>
	<h1>나랑 평생 함께한다며 진짜 탈퇴하는거야?</h1>
	<input class="input" type="password" id="password" name="password"
		placeholder="패스워드 적어">
	<input type="button" id="dropMember" value="탈퇴하기">
	<h1>그래 가버려 좋다고 할 땐 언제고 다 가버려</h1>
</body>
<script type="text/javascript">
	document.getElementById("dropMember").addEventListener("click", function() {
		const password = document.getElementById("password").value;
		if(password !== ""){
			$.ajax({
		        method: 'post',
		        url: '/drop_member',
		        data: {email:'${sessionScope.email}', password:password},
		      }).done(res=>{
		        console.log(res);
		        location.href = '/';
		      }).fail(err=>{
		        console.log(err);
		        alert("자기야 한번만 다시 생각해봐 나 이렇게 잡을게 회원탈퇴 실패")
		      }); 
		}else{
			alert("패스워드나 적어")
		}
	});
</script>
</html>