<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>프로필 - 개인정보수정 페이지</h1>

	<br>
	<a href="/member/dropMember">회원탈퇴</a>

	<h3 id="userTypeText"></h3>
	<button id="userTypeChange">전환하기</button>
	<input class="input" type="password" id="password" name="password"
		placeholder="비밀번호 적으라우">
	<span id="result"></span>

</body>
<script type="text/javascript">
	const userType = ${sessionScope.user_type};
	if(userType == 1){
		document.getElementById("userTypeText").innerHTML = "멘토회원으로 전환하기";
	}else if(userType == 2){
		document.getElementById("userTypeText").innerHTML = "일반회원으로 전환하기";
	}else{
		document.getElementById("userTypeText").innerHTML = "로그인 후 이용할 수 있습니다";
	}
	
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
		        data: {email:'${sessionScope.email}',password:password, user_type:changeType},
		      }).done(res=>{
		        console.log(res);
		        if (res) {
		        	  console.log()
		        	  location.href = '/member/testMain';
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