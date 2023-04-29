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
	<h1>비밀번호 변경 페이지</h1>
	<h1>세션 확인 이메일: ${sessionScope.email}</h1>
	<input class="input" type="password" id="password" name="password" placeholder="느그 비밀번호 적으라우">
	<input class="input" type="password" id="passwordTochange1" name="passwordTochange1" placeholder="변경할 비밀번호 적으라우">
	<input class="input" type="password" id="passwordTochange2" name="passwordTochange2" placeholder="한번 더 적으라우">
	
	<input type="button" id="changePassword" value="비밀번호 변경하기">
	<span id="result"></span>
</body>
<script type="text/javascript">

document.getElementById("changePassword").addEventListener("click", function() {
	  const password = document.getElementById("password").value;
	  const passwordTochange1 = document.getElementById("passwordTochange1").value;
	  const passwordTochange2 = document.getElementById("passwordTochange2").value;
	  
 	  if (password !== "" && passwordTochange1 !== "" && passwordTochange2 !== "") {
	    if (passwordTochange1 === passwordTochange2) {
 	      $.ajax({
	        method: 'post',
	        url: '/change_password',
	        data: {email:'${sessionScope.email}', password:password, changePw:passwordTochange2},
	      }).done(res=>{
	        console.log(res);
	        if(res) {
	          $('#result').html("비밀번호 변경완료").css('color', 'blue');
	        } else {
	          $('#result').html("비밀번호 변경 실패").css('color', 'red');
	        } 
	      }).fail(err=>{
	        console.log(err);
	      }); 
	    } else {
	      alert("변경할 비밀번호가 일치하지 않습니다.");
	    }
	  }else{
		  alert("값을 모두 입력해주세요")
	  } 
	});

</script>
</html>