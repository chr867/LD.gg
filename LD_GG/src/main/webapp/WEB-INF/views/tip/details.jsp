<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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

<style type="text/css">
body {
	font-family: Arial, sans-serif;
	background-color: #F5F5F5;
}

h1 {
	font-size: 24px;
	color: #333;
	margin-top: 20px;
	margin-bottom: 10px;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
	background-color: #FFF;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #CCC;
}

th {
	background-color: #EEE;
}

.label {
	display: inline-block;
	width: 120px;
	font-weight: bold;
	color: #666;
	margin-right: 10px;
	margin-bottom: 5px;
}

.value {
	color: #333;
}

#comment-form {
	margin-top: 20px;
	padding: 10px;
	border-radius: 10px;
	background-color: #f2f2f2;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

#comment-textarea {
	width: 90%;
	height: 70px;
	margin-bottom: 10px;
	padding: 10px;
	border: none;
	border-radius: 5px;
	resize: none;
	background-color: #fff;
	font-size: 16px;
	color: #444;
	font-family: 'Noto Sans KR', sans-serif;
}

#comment-form input[type="submit"] {
	display: block;
	margin: 0 auto;
	width: 100px;
	height: 30px;
	background-color: #0077b6;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	font-family: 'Noto Sans KR', sans-serif;
}

#comment-form input[type="submit"]:hover {
	background-color: #023e8a;
}

#comment-submit-btn {
	display: inline-block;
	background-color: #EAEAEA;
	padding: 8px 12px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	width: 8%;
	height: 70px;
}

#comment-submit-btn:hover {
	background-color: #BDBDBD;
} 
.modifyBox{
	width: 380px;
	height: 70px;
}
.button-box{
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 250px;
	height: 60px;
	padding: 10px 20px 10px 20px;
	border-radius: 4rem;
	background-color: #F6F6F6;
}
.button-box img{
	width: 30px;
	height: 30px;
	transition : 0.5s;
}
.button-box img:hover{
	transform: scale(1.3);
    z-index: 1;
}
.button-box button{
	border: none;
	border-radius: 4rem;
	background-color: #fff;
}
.reply-img{
	width: 20px;
	height: 20px;
}
</style>
</head>
<body>
	<div id="session-summoner-name" style="display: none">${sessionScope.lol_account}</div>
	<div id="session-user-type" style="display: none">${sessionScope.user_type}</div>
	<div id="session-summoner-name" style="display: none">${sessionScope.summoner_name}</div>
	<div id="session-summoner-icon" style="display: none">${sessionScope.summoner_icon}</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 사이드바 -->
	<div class="sidebar">
		<div class="sidebar-nothover-menu">
			<div class="sidebar-menu" style="padding: 8px 0px 8px 12px;">
				<img src="/resources/img/logo/LD_logo_gray.png" alt=""
					style="width: 40px; height: 40px;">
			</div>
			<div class="sidebar-menu" style="padding: 18px;">
				<img src="" alt="">
			</div>
			<div class="sidebar-menu">
				<img src="/resources/img/icon/free-icon-ranking-3162263.png" alt=""
					class="side-bar-icon">
			</div>
			<div class="sidebar-menu">
				<img src="/resources/img/icon/free-icon-community-3594834.png"
					alt="" class="side-bar-icon">
			</div>
			<div class="sidebar-menu">
				<img src="/resources/img/icon/free-icon-mentorship-8920780.png"
					alt="" class="side-bar-icon">
			</div>
			<div class="sidebar-menu">
				<img src="/resources/img/icon/free-icon-game-control-4315528.png"
					alt="" class="side-bar-icon">
			</div>
			<div class="sidebar-menu">
				<img src="/resources/img/icon/free-icon-user-996484.png" alt=""
					class="side-bar-icon">
			</div>
			<div class="sidebar-menu">
				<img src="/resources/img/icon/free-icon-megaphone-92206.png" alt=""
					class="side-bar-icon">
			</div>
		</div>

		<div class="sidebar-area">
			<div class="sidebar-logo-box" onclick="moveMain()">
				<img src="/resources/img/logo/LoLing in the Deep2.svg" alt="LD.GG로고">
			</div>

			<div class="accordion" id="accordionExample">

				<div class="accordion-item">
					<h2 class="accordion-header" id="headingOne">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseOne"
							aria-expanded="true" aria-controls="collapseOne">
							<img src="/resources/img/icon/free-icon-ranking-3162263.png"
								alt="" class="side-bar-icon"> 랭킹
						</button>
					</h2>
					<div id="collapseOne" class="accordion-collapse collapse"
						aria-labelledby="headingOne" data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<div class="accordion-body-menu">
								<a href="/champion/rank" class="accordion-body-link"><span>• 챔피언 티어</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/summoner/rank" class="accordion-body-link"><span>• 소환사 랭킹</span></a>
							</div>
						</div>
					</div>
				</div>

				<div class="accordion-item">
					<h2 class="accordion-header" id="headingTwo">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseTwo"
							aria-expanded="false" aria-controls="collapseTwo">
							<img src="/resources/img/icon/free-icon-community-3594834.png"
								alt="" class="side-bar-icon"> 커뮤니티
						</button>
					</h2>
					<div id="collapseTwo" class="accordion-collapse collapse"
						aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<span class="bullet bullet-dot"></span>
							<div class="accordion-body-menu">
								<a href="/tip/" class="accordion-body-link"><span>• 챔피언 공략</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mate/" class="accordion-body-link"><span>• 롤 메이트</span></a>
							</div>
						</div>
					</div>
				</div>

				<div class="accordion-item">
					<h2 class="accordion-header" id="headingThree">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseThree"
							aria-expanded="false" aria-controls="collapseThree">
							<img src="/resources/img/icon/free-icon-mentorship-8920780.png"
								alt="" class="side-bar-icon"> 멘토링
						</button>
					</h2>
					<div id="collapseThree" class="accordion-collapse collapse"
						aria-labelledby="headingThree" data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<div class="accordion-body-menu">
								<a href="/mentor/custom-mentor/" class="accordion-body-link"><span>• 맞춤 멘토</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mentor/list/" class="accordion-body-link"><span>• 멘토 찾기</span></a>
							</div>
						</div>
					</div>
				</div>

				<div class="accordion-item">
					<h2 class="accordion-header" id="headingFour">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseFour"
							aria-expanded="false" aria-controls="collapseFour">
							<img src="/resources/img/icon/free-icon-game-control-4315528.png"
								alt="" class="side-bar-icon"> 미니게임
						</button>
					</h2>
					<div id="collapseFour" class="accordion-collapse collapse"
						aria-labelledby="headingFour" data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<div class="accordion-body-menu">
								<a href="" class="accordion-body-link"><span>• 승부예측</span></a>
							</div>
						</div>
					</div>
				</div>

				<div class="accordion-item">
					<h2 class="accordion-header" id="headingFive">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseFive"
							aria-expanded="false" aria-controls="collapseFive">
							<img src="/resources/img/icon/free-icon-user-996484.png" alt=""
								class="side-bar-icon"> 마이 메뉴
						</button>
					</h2>
					<div id="collapseFive" class="accordion-collapse collapse"
						aria-labelledby="headingFive" data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<div class="accordion-body-menu">
								<a href="/summoner/testDashBoard" class="accordion-body-link"><span>• 대시보드</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mentor/write-profile" class="accordion-body-link"><span>• 프로필</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="" class="accordion-body-link"><span>• 개인정보
										수정</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mentor/my-mentoring/" class="accordion-body-link"><span>• 마이 멘토링</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="" class="accordion-body-link"><span>• 내 지갑</span></a>
							</div>
						</div>
					</div>
				</div>

				<div class="accordion-item">
					<h2 class="accordion-header" id="headingSix">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseSix"
							aria-expanded="false" aria-controls="collapseSix">
							<img src="/resources/img/icon/free-icon-megaphone-92206.png"
								alt="" class="side-bar-icon"> 고객지원
						</button>
					</h2>
					<div id="collapseSix" class="accordion-collapse collapse"
						aria-labelledby="headingSix" data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<div class="accordion-body-menu">
								<a href="/userinterface/notice" class="accordion-body-link"><span>• 공지사항</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/faq/" class="accordion-body-link"><span>• FAQ</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/faq/inquiries/" class="accordion-body-link"><span>• 문의사항</span></a>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 헤더 -->
	<div class="header-container">
		<header>

			<div class="search-bar-box">
				<img src="/resources/img/logo/LD_logo_bluered.png" alt=""
					class="search-bar-logo"> <input type="text"
					class="search-bar-input" placeholder="소환사명을 입력해주세요"
					autocomplete="off"> <img
					src="/resources/img/icon/free-icon-magnifying-glass-49116.png"
					alt="" class="search-bar-icon">
			</div>

			<div class="header-icon-box" style="display: none;">
				<div class="message-icon-box">
					<img src="/resources/img/icon/free-icon-message-5941217.png" alt=""
						class="message-icon-img" onclick="chatPopup();">
					<div class="message-notification"></div>
				</div>
				<div class="alarm-icon-box">
					<img
						src="/resources/img/icon/free-icon-notification-bell-3680267.png"
						alt="" class="alarm-icon-img"> <span
						class="alarm-notification"></span>
				</div>
				<div class="bookmark-icon-box">
					<img src="/resources/img/icon/free-icon-bookmark-white-25667.png"
						alt="" class="bookmark-icon-img">
				</div>
			</div>

			<div class="user-info-box" style="display: none;" onclick="go_mypage()">
				<div class="summoner-profile-icon-box">
					<img src="/resources/img/icon/profileIcon5626.webp" alt="">
				</div>
				<div class="summoner-name-box">
					<h5>${sessionScope.lol_account} 님</h5>
				</div>
				<div class="user-type-box">
					<div class="user-type-common" style="display: none;">
						<h5>일반회원</h5>
					</div>
					<div class="user-type-mentor" style="display: none;">
						<h5>멘토회원</h5>
					</div>
					<div class="user-type-admin" style="display: none;">
						<h5>어드민</h5>
					</div>
					<div class="user-type-stop" style="display: none;">
						<h5>정지회원</h5>
					</div>
				</div>
			</div>

			<div class="login-button-box">
				<button class="login-button" data-bs-toggle="modal"
					data-bs-target="#login-modal" onclick="loginCheck()">LOGIN</button>
			</div>

			<div class="logout-button-box" style="display: none;">
				<form id="logoutFrm" action="/member/logout" method="post">
					<button class="logout-button" onclick="logout()">LOGOUT</button>
				</form>
			</div>

		</header>
	</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 로그인 모달박스 -->
	<div class="modal fade" id="login-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #172B36;">
					<h1 class="modal-title fs-5" id="exampleModalLabel"></h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close" style="background-color: #ffffff;"></button>
				</div>
				<div class="modal-body login-modal-body"
					style="background-image: url(/resources/img/logo/2020_key_art_Banner.png);">
					<div class="login-img-box">
						<img src="/resources/img/logo/main.png" alt="로그인 이미지">
					</div>
					<div class="login-box">
						<div class="input-area">
							<div>
								<img src="/resources/img/logo/LD_logo.svg" alt="LD_logo"
									style="width: 100px; height: 100px;">
							</div>
							<form action="/member/login" name="logFrm" method="post">
								<div class="input-id">
									<input type="text" placeholder="아이디" name="email">
								</div>
								<div class="input-pw">
									<input type="password" placeholder="비밀번호" name="password">
								</div>
								<div>
									<button class="login-modal-button">로그인</button>
								</div>
							</form>
							<div>
								<button class="login-modal-button" onclick="join()">회원가입</button>
							</div>
							<div>
								<a href="/member/findEmail" class="find-tag">이메일아이디 찾기</a>
							</div>
							<div>
								<a href="/member/findPassword" class="find-tag">비밀번호 찾기</a>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="background-color: #1E3D4F;">
				</div>
			</div>
		</div>
	</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 푸터 -->
	<div class="footer-container">
		<footer>
			<div class="team-name-box">
				<img src="/resources/img/logo/team_name_logo.png" alt=""
					class="team-name-img">
				<h5 class="team-name-h5">TEAM : Loling Thunder</h5>
			</div>

			<div class="team-members-box">
				<h5 class="team-members-box">TEAM MEMBERS: 오건오, 박민규, 채희정, 최형로,
					김시현, 이태현</h5>
			</div>
		</footer>
	</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<div class="container">
		<h1>공략 게시판 상세페이지</h1>
		<table>
			<tr>
				<th class="label">글 번호</th>
				<td class="value">${tipDetails.t_b_num}</td>
			</tr>
			<tr>
				<th class="label">제목</th>
				<td class="value">${tipDetails.t_b_title}</td>
			</tr>
			<tr>
				<th class="label">내용</th>
				<td class="value">${tipDetails.t_b_content}</td>
			</tr>
			<tr>
				<th class="label">조회수</th>
				<td class="value">${tipDetails.t_b_views}</td>
			</tr>
			<tr>
				<th class="label">추천수</th>
				<td class="value">${tipDetails.t_b_recom}</td>
			</tr>
			<tr>
				<th class="label">작성일</th>
				<td class="value">${tipDetails.t_b_date}</td>
			</tr>
			<tr>
				<th class="label">챔피언</th>
				<td class="value">${tipDetails.champion_kr_name}</td>
			</tr>
			<tr>
				<th class="label">작성자</th>
				<td class="value">${tipDetails.lol_account}</td>
			</tr>
		</table>
		<div class="button-box">
			<button onclick="tipRecom(${tipDetails.t_b_num})" id="recommendButton">
			    <img src="/resources/img/icon/free-icon-like-5372262.png" alt="게시물 추천하기">
			</button>
			<button onclick="modifyTip(${tipDetails.t_b_num})" id="modifyButton">
			    <img src="/resources/img/icon/free-icon-edit-1159633.png" alt="게시물 수정하기">
			</button>
			<button onclick="deleteTip(${tipDetails.t_b_num})" id="deleteButton">
			    <img src="/resources/img/icon/free-icon-delete-7945112.png" alt="게시물 삭제하기">
			</button>
		</div>
		<br>
		<h2>댓글</h2>
		<div id="comment-section">
			<div id="comment-form">
				<input type="text" placeholder="댓글을 입력해주세요" id="comment-textarea">
				<button id="comment-submit-btn" onclick="submitComment()">등록</button>
			</div>

			<table id="comment-list">

			</table>

		</div>
	</div>
</body>
<script type="text/javascript">
let modifyButton = document.getElementById("modifyButton");
let deleteButton = document.getElementById("deleteButton");
let writerEmail = '${tipDetails.email}';
let myEmail = '${sessionScope.email}';
let myUserType = ${sessionScope.user_type};

if(writerEmail === myEmail || myUserType == 3){
	modifyButton.style.display = "block";
	deleteButton.style.display = "block";
}else{
	modifyButton.style.display = "none";
	deleteButton.style.display = "none";
}

function tipRecom(t_b_num) { 
	$.ajax({
		method: 'post',
		url: '/tip/recom',
		data: {t_b_num:t_b_num},
	}).done(res=>{
		if(res == 1){
			alert("추천 성공")
			location.href = "/tip/details?t_b_num="+${tipDetails.t_b_num};
		}else if(res == 2){
			alert("추천 취소 성공")
			location.href = "/tip/details?t_b_num="+${tipDetails.t_b_num};
		}else if(res == 4){
			alert("로그인 후 이용해주세요")
		}else{
			alert("오류")
		}
		
	}).fail(err=>{
		console.log(err);
	})
}

function modifyTip(t_b_num) {
	location.href = "/tip/modify?t_b_num="+t_b_num;
}

function deleteTip(t_b_num) {
	$.ajax({
        method: 'post',
        url: '/tip/delete',
        data: {t_b_num:t_b_num},
      }).done(res=>{
        console.log(res);
        if (res==1) {
        	  console.log()
        	  alert("공략글 삭제 성공")
        	  location.href = "/tip/"
        	}else if(res==2){
        	  console.log(res)
        	  alert("공략글 삭제 실패")
        	}else if(res==3){
          	  console.log(res)
        	  alert("본인 게시물 외엔 삭제할 수 없습니다.")
        	}else{
              console.log(res)
              alert("오류발생")
        	}
      }).fail(err=>{
        console.log(err);
        alert("오류발생")
      }); 
}

function submitComment() {
	let t_b_num = ${tipDetails.t_b_num};
	let t_r_content = document.getElementById("comment-textarea").value;
	
	$.ajax({
        method: 'post',
        url: '/tip/reply/insert',
        data: {t_b_num:t_b_num,t_r_content:t_r_content},
      }).done(res=>{
        console.log(res);
        if (res) {
        	  console.log(res);
        	  document.getElementById("comment-textarea").value = null;
        	  loadComments(); //댓글 등록시 비동기로 댓글로드
        	} else {
        	  console.log(res)
        	  alert("댓글 등록 실패")
        	} 
      }).fail(err=>{
        console.log(err);
      }); 
}

function loadComments() {
    $.ajax({
        method: 'get',
        url: '/tip/reply/list',
        data: {t_b_num: ${tipDetails.t_b_num}},
    }).done(res => {
    	console.log(res);
    	let replyList = "";
        res.forEach(reply => {
        	let deleteButton = '';
        	let modifyButton = '';
        	let modifySubmitButton = '';
        	if(myEmail===reply.email || myUserType == 3){
        		deleteButton = '<button id="comment-delete-btn-'+reply.t_r_num+'" onclick="deleteComment('+reply.t_r_num+')"><img class="reply-img" src="/resources/img/icon/free-icon-delete-7945112.png" alt="댓글 삭제하기"></button>'
        		modifyButton = '<button id="comment-modify-btn-'+reply.t_r_num+'" onclick="modifyReplyBtn('+reply.t_r_num+')"><img class="reply-img" src="/resources/img/icon/free-icon-edit-1159633.png" alt="댓글 수정하기"></button>'
        		modifySubmitButton = '<button style="display: none;" id="comment-modify-submit-btn-'+reply.t_r_num+'" onclick="submitModifiedComment(' + reply.t_r_num + ')"><img class="reply-img" src="/resources/img/icon/free-icon-confirm-467129.png" alt="댓글 수정완료"></button>'
        	}
        	replyList += '<tr height="35" align="center" id="reply_box_'+reply.t_r_num+'">'
        	replyList += '<td width="100">'+reply.lol_account+'</td>'
        	replyList += '<td width="500" id="content_num_'+reply.t_r_num+'">'+reply.t_r_content+'</td>'
        	replyList += '<td width="100">'+reply.t_r_date+'</td>'
        	replyList += '<td>'
        	replyList += modifyButton
        	replyList += deleteButton
        	replyList += modifySubmitButton
        	replyList += '</td>'
        	replyList += '</tr>'
        });
        console.log(replyList);
        $('#comment-list').html(replyList)
    }).fail(err => {
        console.log(err);
    }); 
}


function deleteComment(t_r_num) {
 	$.ajax({
        method: 'post',
        url: '/tip/reply/delete',
        data: {t_r_num:t_r_num},
      }).done(res=>{
        console.log(res);
        if (res==1) {
        	  console.log()
        	  alert("댓글 삭제 성공")
        	  loadComments();
        	}else if(res==2){
        	  console.log(res)
        	  alert("댓글 삭제 실패")
        	}else if(res==3){
          	  console.log(res)
        	  alert("본인 게시물 외엔 삭제할 수 없습니다.")
        	}else{
              console.log(res)
              alert("오류발생")
        	}
        loadComments(); //댓글 삭제시 비동기로 댓글로드
      }).fail(err=>{
        console.log(err);
        alert("오류발생")
      });  
}

function modifyReplyBtn(t_r_num) {
    $.ajax({
        method: 'get',
        url: '/tip/reply/match',
        data: {t_r_num: t_r_num},
    }).done(res => {
        if (res) {
            console.log(res);
            const contentId = 'content_num_' + t_r_num;
            const inputId = 'content_input_num_' + t_r_num;
            const contentElement = document.getElementById(contentId);
            const content = contentElement.innerHTML;
            contentElement.innerHTML = '<input class="modifyBox" type="text" id="' + inputId + '" value="' + content + '">';

            const deleteBtn = document.getElementById('comment-delete-btn-' + t_r_num);
            const modifyBtn = document.getElementById('comment-modify-btn-' + t_r_num);
            const modifySubmit = document.getElementById('comment-modify-submit-btn-' + t_r_num);
/*             const submitBtnId = 'comment-submit-btn-' + t_r_num;
            const submitBtn = '<button id="' + submitBtnId + '" onclick="submitModifiedComment(' + t_r_num + ')">수정완료</button>'; */
            deleteBtn.style.display = "none";
            modifyBtn.style.display = "none";
            modifySubmit.style.display = "block";
           
        } else {
            console.log(res)
            alert("본인 댓글만 수정 가능합니다.")
        }
    }).fail(err => {
        console.log(err);
    });
}

function submitModifiedComment(t_r_num) {
	console.log(t_r_num);

    const t_r_content = document.getElementById('content_input_num_' + t_r_num).value;
    $.ajax({
        method: 'post',
        url: '/tip/reply/modify',
        data: {t_r_num:t_r_num, t_r_content:t_r_content},
      }).done(res=>{
        console.log(res);
        if (res) {
            console.log(res);
            loadComments(); //댓글 수정시 비동기로 댓글로드
        } else {
            console.log(res)
            alert("댓글 수정 실패")
        } 
      }).fail(err=>{
        console.log(err);
      }); 
}


loadComments(); 
</script>
</html>