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
<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
	
	
<style type="text/css">
 .main-container{
	display: flex;
	justify-content: center;
} 
.champion-container{
	margin-top: 90px;
	width: 25%;
	height: 80vh;
	background-color: #fff;
	margin-right: 20px;
	margin-left: 60px;
	box-sizing: border-box;
}
.tip-write-container{
	margin-top: 90px;
	width: 68%;
	height: 80vh;
	background-color: #fff;
	box-sizing: border-box;
	padding: 50px 30px 0 30px;
	box-shadow: 0 0 10px rgba(0,0,0,0.1);
	padding-top: 20xp;
}

.title-box{
	text-align: center;
	margin-bottom: 50px;
	background-color: #202B46;
	color: #fff;
	margin: auto;
	width: 300px;
	height: 70px;
	display: flex;
	border-radius: 3rem;
	justify-content: center;
	align-items: center;
}

.search-container{
	text-align: center;
	justify-content: space-between;
}

 .lane-select-box {
    display: flex;
    height: 50px;
    justify-content: space-between;
    width: 90%;
    margin: auto;
    margin-top: 10px;
    background-color: #E4E6EF;
    box-sizing: border-box;
    padding: 0 50px 0 50px;
    margin-bottom: 20px;
    align-items: center;
}

.lane-img img {
    width: 40px;
    height: 40px;
}

.lane-img {
    border-radius: 0.5rem;
    transition: 0.5s;
}

.lane-img:hover,
.lane-img:active {
    background-color: #fff;
}

.champion-img-container {
    width: 90%;
    background-color: #E4E6EF;
    height: 600px;
    margin: auto;
    box-sizing: border-box;
    overflow-y: auto;
    max-height: 600px;
}

.champions {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    text-align: center;
    box-sizing: border-box;
    flex-wrap: wrap;
    padding: 5px;
}

.champions img {
    width: 60px;
    height: 60px;
    border-radius: 1rem;
    border: 5px solid #fff;
    transition : 0.5s;
}
.champions img:hover{
    transform: scale(1.3);
    z-index: 1;
}

.champion {
    display: flex;
    align-items: center;
    flex-direction: column;
    margin: 5px;
    flex-grow: 1;
}
::-webkit-scrollbar {
  width: 5px; /* 스크롤바의 너비 */
}

::-webkit-scrollbar-track {
  background-color: #f1f1f1; /* 스크롤바의 트랙(배경) 색상 */
}

::-webkit-scrollbar-thumb {
  background-color: #888; /* 스크롤바의 썸(막대) 색상 */
}
</style>
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
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<div class="champion-container">
			<div class="lane-select-box">
				<div class="lane-img lane-top" onclick="selectLane('TOP')"><img src="/resources/img/ranked-positions/Position_Silver-Top.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-jungle" onclick="selectLane('JUNGLE')"><img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-middle" onclick="selectLane('MIDDLE')"><img src="/resources/img/ranked-positions/Position_Silver-Mid.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-bottom" onclick="selectLane('BOTTOM')"><img src="/resources/img/ranked-positions/Position_Silver-Bot.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-support" onclick="selectLane('UTILITY')"><img src="/resources/img/ranked-positions/Position_Silver-Support.png" alt="로그인 이미지"></div>
			</div>
			<div class="champion-img-container">
				<div class="champions">

				</div>
			</div>
		</div>
		<div class="tip-write-container">
			<div class="title-box">
				<h3 class="text-center">공략 글 수정</h3>
			</div>
		  
		    <form method="post" action="/tip/modify_tip" class="form-group mx-auto w-75">
		        <input type="text" name="t_b_title" class="form-control mb-3" placeholder="제목" value="${title}" style="margin-top: 20px;">
		        <textarea id="summernote" name="t_b_content" class="form-control mb-3">${content}</textarea>
		        <input type="number" name="champion_id" class="form-control mb-3" placeholder="챔피언아이디" value="${champion}">
		        <div class="d-flex justify-content-between">
		            <input id="subBtn" type="button" class="btn btn-primary" value="글 작성" onclick="goWrite(this.form)" />
		            <input id="reset" type="reset" class="btn btn-secondary" value="취소">
		            <input type="hidden" name="t_b_num" value="${num}"/>
		        </div>
		    </form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
    $('#summernote').summernote({
        height : 300, // 에디터 높이
        minHeight : null, // 최소 높이
        maxHeight : null, // 최대 높이
        focus : true, // 에디터 로딩후 포커스를 맞출지 여부
        lang : "ko-KR", // 한글 설정
        placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
        callbacks: {
            onInit: function() {
                var editable = $('.note-editable');
                var toolbar = $('.note-toolbar');

                editable.css({
                    backgroundColor: 'rgba(255, 255, 255, 0.9)' // 에디터 부분 배경색 설정
                });

                toolbar.css({
                    backgroundColor: 'rgba(255, 255, 255, 0.9)' // 툴바 부분 배경색 설정
                });
            }
        }
    });
});




	function goWrite(frm) {
		let title = frm.t_b_title.value;
		let email = '${sessionScope.lol_account}';
		if (email==''){
			alert('로그인을 해주세요')
			return false;
		}
		console.log(title);
		let contents = frm.t_b_content.value; //공백 => &nbsp 
		console.log(contents);
		let champion = frm.champion_id.value;
		console.log(champion);
		if (title.trim() == '') {
			alert('제목을 입력해주세욧!!')
			return false;
		}
		if (contents.trim() == '') {
			alert('내용을 입력해주세욧!!!')
			return false;
		}
		if (champion.trim() == '') {
			alert('챔피언을 입력해주세욧!!!')
			return false;
		}
		frm.submit();
	}
	
	function championList() {
	    $.ajax({
	        method: 'get',
	        url: '/tip/champion/list'
	    }).done(res => {
	        var championHTML = '';
	        res.forEach(function(champion) {
	            championHTML += '<div class="champion">';
	            championHTML += '<img alt="' + champion.champion_en_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/'
	            + champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_id + '\')">'; 
	            championHTML += '</div>';
	        });

	        $('.champions').html(championHTML);
	    }).fail(err => {
	        console.log(err);
	    });
	}

	championList();


	function selectLane(team_position) {
		$('.champions').empty();
		$.ajax({
			method: 'get',
			url: '/tip/champion/lane',
			data: {team_position:team_position},
		}).done(res=>{
	        var championHTML = '';
	        res.forEach(function(champion) {
	            championHTML += '<div class="champion">';
	            championHTML += '<img alt="' + champion.champion_en_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/'
	            + champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_id + '\')">'; 
	            championHTML += '</div>';
	        });

	        $('.champions').html(championHTML);
		}).fail(err=>{
			console.log(err);
		})
	} 
	
	function selectChampion(champion_id) {
	    var inputField = document.querySelector('input[name="champion_id"]');
	    inputField.value = champion_id;
	    inputField.readOnly = true;  // 변경: disabled -> readOnly
	}
	
	
$(document).ready(function(){
    $(document).on('click', '.champion-img', function(){
        var altText = $(this).attr('alt');
        $('.tip-write-container').css('background-image', 'url(/resources/img/champion_img/splash/'+altText+'_0.jpg)');
    });
});

	

</script>
</html>