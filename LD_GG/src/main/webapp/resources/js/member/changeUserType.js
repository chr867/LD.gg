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


