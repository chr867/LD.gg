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
<!--JOIN CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/member/join.css">
<!--JOIN JS-->
<script src="/resources/js/member/join.js" defer></script>
</head>
<Style>
table {
	font-family: Arial, sans-serif;
	border-collapse: collapse;
	margin: 0 auto;
}

th, td {
	padding: 5px;
	text-align: center;
}

.find-summoner-icon{
	width: 40px;
	height: 40px;
	border-radius: 50%;
}

.summoner-name {
	font-weight: bold;
}

.summoner-level {
	font-style: italic;
}
</Style>
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
								<button class="duplicate-inspection-email" id="check_email"
									type="button">확인</button>
							</div>
						</div>
						<span class="duplicate-warning" id="email-duplicate"
							style="display: none">
							<p>이미 사용중인 이메일입니다.</p>
						</span> <span class="duplicate-pass" id="email-duplicate-pass"
							style="display: none">
							<p>사용 가능</p>
						</span>
						<div class="input-pw">
							<input type="password" placeholder="비밀번호" name="password"
								id="password" autocomplete="off">
						</div>
						<div class="input-phone">
							<input type="number" placeholder="전화번호" name="phone" id="phone"
								autocomplete="off">
							<div class="duplicate-inspection-button-box">
								<button class="duplicate-inspection-phone" id="check_phone_num"
									type="button">확인</button>
							</div>
						</div>
						<span class="duplicate-warning" id="phone-duplicate"
							style="display: none">
							<p>이미 사용중인 번호입니다.</p>
						</span> <span class="duplicate-pass" id="phone-duplicate-pass"
							style="display: none">
							<p>사용 가능</p>
						</span>
						<div class="input-summoner">
							<input type="text" placeholder="소환사계정" name="lol_account"
								id="summoner" autocomplete="off">
							<div class="duplicate-inspection-button-box">
								<button class="duplicate-inspection-summoner"
									id="check_lol_account" type="button">확인</button>
							</div>
						</div>
						<span class="duplicate-warning" id="summoner-duplicate"
							style="display: none">
							<p>이미 사용중인 계정이거나 계정을 찾을 수 없습니다.</p>
						</span> <span class="duplicate-pass" id="summoner-duplicate-pass"
							style="display: none">
							<p>사용 가능</p>
						</span>
						<div class="radio-button-container">
							<input class="radio_box" type="radio" value="1" name="user_type"
								checked="checked"> <label>일반회원</label> <input
								class="radio_box" type="radio" value="2" name="user_type">
							<label>멘토회원</label>
						</div>
						<div>
							<input type="submit" id="submit"
								class="join-button join-container-button" value="회원가입">
						</div>
					</div>
				</form>

				<div>
					<button class="move-main-button join-container-button"
						onclick="moveMain(event)">메인페이지로 돌아가기</button>
				</div>

			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">소환사 계정 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<th>소환사 아이콘</th>
							<th>소환사 이름</th>
							<th>소환사 레벨</th>
							<th>선택</th>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="confirmSummoner()">확인</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>