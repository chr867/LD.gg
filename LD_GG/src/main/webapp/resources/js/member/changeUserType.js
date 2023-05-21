$(document).ready(function() {
	
	var userType = document.getElementById('session-user-type').innerText;

  if(userType == 1){
	document.getElementById("userTypeText").innerHTML = "멘토회원으로 전환하기";
	}else if(userType == 2){
		document.getElementById("userTypeText").innerHTML = "일반회원으로 전환하기";
	}else{
		document.getElementById("userTypeText").innerHTML = "로그인 후 이용할 수 있습니다";
	}
});


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
	        	  location.href = '/member/changeUserType';
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