$(document).ready(function() {
	var summonerName = document.getElementById('session-summoner-name').innerText;
	var userType = document.getElementById('session-user-type').innerText;

  sessionCheck(summonerName, userType);
});

function sessionCheck(summonerName,userType) {

  if (summonerName == '') {
	    $('.user-info-box, .header-icon-box').hide();
	  } else {
	    $('.user-info-box, .header-icon-box').show();
	    $('.logout-button-box').show();
	    $('.login-button-box').hide();

	    switch (userType) {
	      case '1':
	        $('.user-type-common').show();
	        $('.user-type-mentor, .user-type-admin, .user-type-stop').hide();
	        break;
	      case '2':
	        $('.user-type-common, .user-type-admin, .user-type-stop').hide();
	        $('.user-type-mentor').show();
	        break;
	      case '3':
	        $('.user-type-common, .user-type-mentor, .user-type-stop').hide();
	        $('.user-type-admin').show();
	        break;
	      case '4':
	        $('.user-type-common, .user-type-mentor, .user-type-admin').hide();
	        $('.user-type-stop').show();
	        break;
    }
  }
} 

//로그인 체크 메소드 로그인버튼 클릭시 실행 
function loginCheck() {
	$.ajax({
		method: 'get',
		url: '/member/check_login',
	}).done(res => {
		if (res) {
			alert("이미 로그인중입니다.")
			location.href = '/';
		}
	}).fail(err => {
		console.log(err);
	});
}

//로그아웃 버튼 메소드
function logout() {
	document.querySelector('#logoutFrm').submit();
	alert("로그아웃 되었습니다.");
}

//회원가입 페이지 이동 메소드
function join() {
	location.href="/member/join"
}

//메인페이지 이동 메소드 
function moveMain() {
	location.href="/"
}