<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>LD.GG</title>
<!--BOOTSTRAP CSS-->
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
</head>
<style>
body {
  background-color: #202B46;
}

.main-container {
  display: flex;
  justify-content: center;
}

.join-container {
  height: 100vh;
  width: 50%;
  display: flex;
  margin-left: auto;
  background-color: #f7f5f5;
  justify-content: center;
  text-align: center;
}

.join-main-logo-container {
  display: flex;
  justify-content: center;
  text-align: center;
  margin-right: auto;
  margin-top: 160px;
}

.join-main-log-box {
  margin-left: 180px;
}

.join-main-logo-img {
  width: 500px;
  height: 500px;
}

.join-box {
  margin-top: 100px;
}

.input-area input {
  background-color: #f7f5f5;
  padding-left: 20px;
  width: 400px;
  height: 60px;
  border: none;
  border-bottom: 2px solid #c9c9c9;
  transition: .2s;
  color: #000;
}

.input-area input::placeholder {
  color: #c9c9c9;
}

.input-area input:active,
.input-area input:focus,
.input-area input:hover {
  outline: none;
  border-bottom-color: #777777;
}

.input-area .join-button,
.move-main-button {
  width: 400px;
  height: 60px;
  border: none;
  border-radius: 5rem;
  background-color: #FFF;
  transition: .5s;
}

.input-area .join-button:active,
.input-area .join-button:hover,
.move-main-button:active,
.move-main-button:hover {
  background-color: #c5c5c5;
}

.input-area div {
  margin: 25px 0 0 0;
}

.duplicate-inspection-button-box button {
  border: none;
  background-color: #f7f5f5;
  color: #777777;
  transition: .5s;
}

.duplicate-inspection-button-box button:hover {
  color: #000;
}

.input-id,
.input-phone,
.input-summoner {
  display: flex;
  justify-content: center;
  padding-left: 40px;
}

.duplicate-inspection-button-box {
  position: relative;
  right: 50px;
  bottom: 5px;
}

.duplicate-warning {
  display: flex;
  /* margin-right: 0px; */
}

.duplicate-warning p {
  font-size: 12px;
  color: red;
}

.input-area .radio_box {
  margin: 0;
  width: 20px;
  height: 20px;
  align-items: center;
}

.input-area label {
  color: #777777;
}

.radio-button-container {
  display: flex;
  justify-content: space-between;
  padding: 0 100px 0 100px;
  text-align: center;
  align-items: center;
  text-align: center;
}

.duplicate-pass {
  display: flex;
  margin-right: 354px;
}

.duplicate-pass p {
  font-size: 12px;
  color: blue;
}

</style>
<body style="text-align: center; justify-content: center;">
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<div class="join-main-logo-container">
			<div class="join-main-log-box">
				<img src="/resources/img/logo/LoLing in the Deep Logo.png" alt=""
					class="join-main-logo-img">
			</div>
		</div>
		<div class="join-container">
			<div class="join-box">
				<div>
					<h3>회원가입</h3>
				</div>
				<form id="joinFrm" name="joinFrm" action="/member/join"
					method="post" onsubmit="return check()">
					<div class="input-area">
						<div class="input-id">
							<input type="text" placeholder="아이디" id="email" name="email"
								autocomplete="off">
							<div class="duplicate-inspection-button-box">
								<button class="duplicate-inspection-email" id="check_email">확인</button>
							</div>
						</div>
						<span class="duplicate-warning" id="eamlil-duplicate"
							style="display: none"><p>이미 사용중인 이메일입니다.</p></span> <span
							class="duplicate-pass" id="eamlil-duplicate-pass"
							style="display: none"><p>사용가능</p></span>
						<div class="input-pw">
							<input type="password" placeholder="비밀번호" name="password"
								id="password" autocomplete="off">
						</div>
						<div class="input-phone">
							<input type="number" placeholder="전화번호" name="phone" id="phone"
								autocomplete="off">
							<div class="duplicate-inspection-button-box">
								<button class="duplicate-inspection-phone" id="check_phone_num">확인</button>
							</div>
						</div>
						<span class="duplicate-warning" id="phone-duplicate"
							style="display: none"><p>이미 사용중인 번호입니다.</p></span> <span
							class="duplicate-pass" id="phone-duplicate-pass"
							style="display: none"><p>사용가능</p></span>
						<div class="input-summoner">
							<input type="text" placeholder="소환사계정" name="lol_account"
								id="summoner" autocomplete="off">
							<div class="duplicate-inspection-button-box">
								<button class="duplicate-inspection-summoner"
									id="check_lol_account">확인</button>
							</div>
						</div>
						<span class="duplicate-warning" id="summoner-duplicate"
							style="display: none"><p>이미 사용중인 계정입니다.</p></span> <span
							class="duplicate-pass" id="summoner-duplicate-pass"
							style="display: none"><p>사용가능</p></span>
						<div class="radio-button-container">
							<input class="radio_box" type="radio" value="1" name="user_type"
								checked="checked"> <label>일반회원</label> <input
								class="radio_box" type="radio" value="2" name="user_type">
							<label>멘토회원</label>
						</div>

						<div>
							<input type="submit" id="submit" class="join-button join-container-button" value="회원가입">
						</div>
				</form>
				
				<div>
					<button class="move-main-button join-container-button" onclick="moveMain(event)">메인페이지로
						돌아가기</button>
				</div>

			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	function moveMain() {
		event.preventDefault();
		location.href = "/"
	}
	
	let emailSubmit = false;
	let accountSubmit = false;
	let phoneSubmit = false;
	
	function check() {
		let frm = document.joinFrm;
		  let inputs = frm.getElementsByTagName("input");

		  for (let i = 0; i < inputs.length; i++) {
		    if (inputs[i].type === "text" || inputs[i].type === "password") {
		      if (inputs[i].value.trim() === "") {
		        alert(inputs[i].placeholder + "을(를) 입력하세요!!");
		        inputs[i].focus();
		        return false; // 실패시
		      }
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
		
		if(!phoneSubmit){
			alert("전화번호 중복검사를 다시해주세요")
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
					$('#summoner-duplicate').hide();
					$('#summoner-duplicate-pass').show()
				}else{
					$('#summoner-duplicate').show();
					$('#summoner-duplicate-pass').hide()
					$('#summoner').val("");
					accountSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})
	
	$('#check_email').on('click',function(){
		event.preventDefault();
		if($('#email').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_email',
				data: {email:$('#email').val()},
				//dataType: 'html', //json,html(text)
			}).done(res=>{
				if(res == true){
					$('#eamlil-duplicate-pass').show();
					$('#eamlil-duplicate').hide();
					console.log('res : '+res);
					emailSubmit = true;
				}else{
					$('#eamlil-duplicate-pass').hide();
					$('#eamlil-duplicate').show();
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
					$('#phone-duplicate-pass').show();
					$('#phone-duplicate').hide();
					console.log('res : '+res);
					phoneSubmit = true;
				}else{
					$('#phone-duplicate-pass').hide();
					$('#phone-duplicate').show();
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