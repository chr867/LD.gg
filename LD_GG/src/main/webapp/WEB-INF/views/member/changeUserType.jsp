<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>LD.GG</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
    </script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--JQUERY-->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<!--AJAX-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!--JQUERY VALIDATE-->
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
<!--sideBar CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/sideBar.css">
<!--header CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/header.css">
<!--footer CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/footer.css">
<!--loginModal CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/loginModal.css">
<!--로그인 및 세션관련 JS-->
<script src="/resources/js/main/loginSession.js" defer></script>
<!-- 채팅 관련 JS-->
<script src="/resources/js/main/chat.js" defer></script>
<!--CHANGE USER TYPE CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/member/changeUserType.css">
<!--CHANGE USER TYPE JS-->
<script src="/resources/js/member/changeUserType.js" defer></script>

<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<div class="change-usertype-container">
			<h3>유저타입 변경</h3>
			<h4 id="userTypeText"></h4>
			<input class="input" type="password" id="password" name="password"
				placeholder="비밀번호를 입력해주세요">
			<input type="button" id="userTypeChange" value="변경하기">
			<span id="result"></span>
		</div>
	</div>
</body>
<script type="text/javascript">
document.getElementById("userTypeChange").addEventListener("click", function() {
	let changeType = 0;
	let password = document.getElementById('password').value;
	
	if(userType == 1){
		changeType = 2;
	}else if(userType == 2){
		changeType = 1;
	}else{
		alert("로그인 후 이용해주세요")
	}
	
	if(changeType != 0){
		$.ajax({
	        method: 'post',
	        url: '/member/change_usertype',
	        data: {password:password, user_type:changeType},
	      }).done(res=>{
	        console.log(res);
	        if (res) {
	        	  console.log()
	        	  location.href = '/member/changeUserType';
	        	  alert("유저타입 변경을 완료하였습니다.")
	        	} else {
	        	  console.log(res)
	        	  document.getElementById("result").innerHTML = "유저타입 변경 실패";
	        	  document.getElementById("result").style.color = "red";
	        	} 
	      }).fail(err=>{
	        console.log(err);
	      }); 
	}else{
		alert("유저타입 변경 실패");
	}
});	
</script>

</html>