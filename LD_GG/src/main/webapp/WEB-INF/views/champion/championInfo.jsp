<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챔피언 상세</title>
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
.main-container {
	box-sizing: border-box;
	padding: 100px 50px 100px 100px;
}

.champion-info-box {
	width: 350px;
	height: 100px;
	box-sizing: border-box;
	background-color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
}

.champion-info {
	margin-left: 10px;
}

.champion-img {
	width: 75px;
	height: 75px;
	border-radius: 0.5rem;
	margin-right: 5px;
}

.ability-img {
	width: 40px;
	height: 40px;
	border-radius: 0.5rem;
	margin-right: 7px;
}

.champion_name {
	font-size: 20px;
	font-weight: 700;
	align-items: center;
}

.tooltip {
	position: absolute;
	z-index: 10;
	width: 300px;
	background-color: black;
	color: #fff;
	border-radius: 1rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
}

.champion-table td:hover .tooltip {
	visibility: visible;
	opacity: 1;
}

.champion-twpb-box {
	width: 350px;
	height: 50px;
	box-sizing: border-box;
	background-color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
	text-align: center;
}

.champion-twpb {
	width: 80px;
	text-align: center;
}

.champion-tier {
	font-weight: 700;
}

.lane-select-box {
	display: flex;
	height: 50px;
	width: 350px;
	box-sizing: border-box;
	margin-bottom: 5px;
	align-items: center;
}

.lane-img img {
	width: 40px;
	height: 40px;
}

.lane-img {
	border-radius: 0.1rem;
	transition: 0.3s;
	background-color: #fff;
	margin-right: 10px;
}

.lane-img:hover, .lane-img:active {
	background-color: #E4E6EF;
}

.champion-easy-box {
	width: 350px;
	height: 120px;
	padding: 10px 10px 0 10px;
	background-color: #FFF;
	box-sizing: border-box;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
	text-align: center;
	font-weight: 700;
}
.easy-champ-img{
	width: 80px;
	text-align: center;
}
.easy-champ-img img {
	width: 50px;
	height: 50px;
}

.champion-hard-box {
	width: 350px;
	height: 120px;
	padding: 10px 10px 0 10px;
	background-color: #FFF;
	box-sizing: border-box;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
	text-align: center;
	font-weight: 700;
}
.hard-champ-img{
	width: 80px;
	text-align: center;
}
.hard-champ-img img {
	width: 50px;
	height: 50px;
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
								<a href="/champion/rank" class="accordion-body-link"><span>•
										챔피언 티어</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/summoner/rank" class="accordion-body-link"><span>•
										소환사 랭킹</span></a>
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
								<a href="/tip/" class="accordion-body-link"><span>•
										챔피언 공략</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mate/" class="accordion-body-link"><span>•
										롤 메이트</span></a>
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
								<a href="/mentor/custom-mentor/" class="accordion-body-link"><span>•
										맞춤 멘토</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mentor/list/" class="accordion-body-link"><span>•
										멘토 찾기</span></a>
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
								<a href="/summoner/testDashBoard" class="accordion-body-link"><span>•
										대시보드</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mentor/write-profile" class="accordion-body-link"><span>•
										프로필</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="" class="accordion-body-link"><span>• 개인정보
										수정</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/mentor/my-mentoring/" class="accordion-body-link"><span>•
										마이 멘토링</span></a>
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
								<a href="/userinterface/notice" class="accordion-body-link"><span>•
										공지사항</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/faq/" class="accordion-body-link"><span>•
										FAQ</span></a>
							</div>
							<div class="accordion-body-menu">
								<a href="/faq/inquiries/" class="accordion-body-link"><span>•
										문의사항</span></a>
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

			<div class="user-info-box" style="display: none;"
				onclick="go_mypage()">
				<div class="summoner-profile-icon-box">
					<img
						src="/resources/img/profileicon/${sessionScope.summoner_icon}.png"
						alt="">
				</div>
				<div class="summoner-name-box">
					<h5>${sessionScope.lol_account}님</h5>
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
	<div class="main-container">
		<div class="lane-select-box"></div>
		<div class="champion-info-box">
			<table class="champion-table">
				<tr>
					<td rowspan="2"><img alt=""
						src="/resources/img/champion_img/square/${chamInfo.champion_img}"
						class="champion-img"></td>
					<td colspan="5"><h3 class="champion_name">${chamInfo.champion_kr_name}</h3></td>
				</tr>
				<tr>
					<td><img alt=""
						src="/resources/img/passive/${chamInfo.champion_p_img}"
						class="ability-img">
						<div class="tooltip">
							<div>${chamInfo.champion_p_name}</div>
							<br>
							<div>${chamInfo.champion_p_desc}</div>
						</div></td>
					<td><img alt=""
						src="/resources/img/spell/${chamInfo.champion_q_img}"
						class="ability-img">
						<div class="tooltip">
							<div>${chamInfo.champion_q_name}</div>
							<br>
							<div>${chamInfo.champion_q_desc}</div>
						</div></td>
					<td><img alt=""
						src="/resources/img/spell/${chamInfo.champion_w_img}"
						class="ability-img">
						<div class="tooltip">
							<div>${chamInfo.champion_w_name}</div>
							<br>
							<div>${chamInfo.champion_w_desc}</div>
						</div></td>
					<td><img alt=""
						src="/resources/img/spell/${chamInfo.champion_e_img}"
						class="ability-img">
						<div class="tooltip">
							<div>${chamInfo.champion_e_name}</div>
							<br>
							<div>${chamInfo.champion_e_desc}</div>
						</div></td>
					<td><img alt=""
						src="/resources/img/spell/${chamInfo.champion_r_img}"
						class="ability-img">
						<div class="tooltip">
							<div>${chamInfo.champion_r_name}</div>
							<br>
							<div>${chamInfo.champion_r_desc}</div>
						</div></td>
				</tr>
			</table>
		</div>
		<div class="champion-twpb-box">
			<table>
				<tr>
					<th class="champion-twpb">티어</th>
					<th class="champion-twpb">승률</th>
					<th class="champion-twpb">픽률</th>
					<th class="champion-twpb">밴률</th>
				</tr>
				<tr>
					<td class="champion-tier" id="tier"></td>
					<td class="champion-tier" id="win-rate"></td>
					<td class="champion-tier" id="pick-rate"></td>
					<td class="champion-tier" id="ban-rate"></td>
				</tr>
			</table>
		</div>
		<div class="champion-easy-box">
			<caption>상대하기 쉬운 챔피언</<caption>
			<table>
				<tr>
					<th class="easy-champ-img"></th>
					<th class="easy-champ-img"></th>
					<th class="easy-champ-img"></th>
					<th class="easy-champ-img"></th>
					<th class="easy-champ-img"></th>
				</tr>
				<tr>
					<td class="easy-champ-win-rate"></td>
					<td class="easy-champ-win-rate"></td>
					<td class="easy-champ-win-rate"></td>
					<td class="easy-champ-win-rate"></td>
					<td class="easy-champ-win-rate"></td>
				</tr>
			</table>

		</div>
		<div class="champion-hard-box">
			<caption>상대하기 힘든 챔피언</<caption>
			<table>
				<tr>
					<th class="hard-champ-img"></th>
					<th class="hard-champ-img"></th>
					<th class="hard-champ-img"></th>
					<th class="hard-champ-img"></th>
					<th class="hard-champ-img"></th>
				</tr>
				<tr>
					<td class="hard-champ-win-rate"></td>
					<td class="hard-champ-win-rate"></td>
					<td class="hard-champ-win-rate"></td>
					<td class="hard-champ-win-rate"></td>
					<td class="hard-champ-win-rate"></td>
				</tr>
			</table>
		</div>


	</div>

</body>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
	championLaneInfo(${chamInfo.champion_id});
});

function championLaneInfo(champion_id) {
	  $.ajax({
	    method: 'get',
	    url: '/champion/info/lane',
	    data: { champion_id: champion_id },
	  }).done(res => {
	    let laneSelectBox = document.querySelector('.lane-select-box');
	    laneSelectBox.innerHTML = ''; // 기존 내용 초기화

	    for (let i = 0; i < res.length; i++) {
	      let team_position = res[i].team_position;
	      let html = '';

	      if (team_position === 'TOP') {
	        html = '<div class="lane-img lane-top" onclick="selectLane(\'TOP\')"><img src="/resources/img/ranked-positions/Position_Silver-Top.png" alt="로그인 이미지"></div>';
	      } else if (team_position === 'JUNGLE') {
	        html = '<div class="lane-img lane-jungle" onclick="selectLane(\'JUNGLE\')"><img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" alt="로그인 이미지"></div>';
	      } else if (team_position === 'MIDDLE') {
	        html = '<div class="lane-img lane-middle" onclick="selectLane(\'MIDDLE\')"><img src="/resources/img/ranked-positions/Position_Silver-Mid.png" alt="로그인 이미지"></div>';
	      } else if (team_position === 'BOTTOM') {
	        html = '<div class="lane-img lane-bottom" onclick="selectLane(\'BOTTOM\')"><img src="/resources/img/ranked-positions/Position_Silver-Bot.png" alt="로그인 이미지"></div>';
	      } else if (team_position === 'UTILITY') {
	        html = '<div class="lane-img lane-support" onclick="selectLane(\'UTILITY\')"><img src="/resources/img/ranked-positions/Position_Silver-Support.png" alt="로그인 이미지"></div>';
	      }

	      laneSelectBox.innerHTML += html;
	    }
	    championBuildInfo(res[0].champion_id, res[0].team_position);
	  }).fail(err => {
	    console.log(err);
	  });
	}

function selectLane(team_position) {
	championBuildInfo(${chamInfo.champion_id}, team_position);
}

function championBuildInfo(champion_id, team_position) {
	$.ajax({
		  method: 'get',
		  url: '/champion/info/build',
		  data: { champion_id: champion_id, team_position: team_position},
		}).done(res => {
			let championBuildInfo = res;
			let champRuneData = championBuildInfo.champRuneData;
			let champItemData = championBuildInfo.champItemData;
			let champMythicItemData = championBuildInfo.champMythicItemData;
			let champItemBuildData = championBuildInfo.champItemBuildData;
			let champShoesData = championBuildInfo.champShoesData;
			let champSpellData = championBuildInfo.champSpellData;
			let champSkillBuildData = championBuildInfo.champSkillBuildData;
			let champAccessoriesData = championBuildInfo.champAccessoriesData;
			let champTierData = championBuildInfo.champTierData;
			let champEasyChampData = championBuildInfo.champEasyChampData;
			let champHardChampData = championBuildInfo.champHardChampData;
			
			  console.log(champRuneData);
			  console.log(champItemData);
			  console.log(champMythicItemData);
			  console.log(champItemBuildData);
			  console.log(champShoesData);
			  console.log(champSpellData);
			  console.log(champSkillBuildData);
			  console.log(champAccessoriesData);
			  console.log(champTierData[0].tier);
			  console.log(champTierData[0].win_rate);
			  console.log(champTierData[0].pick_rate);
			  console.log(champTierData[0].ban_rate);
			  console.log(champTierData[0].tier);
			  console.log(champTierData[0].win_rate);
			  console.log(champTierData[0].pick_rate);
			  console.log(champTierData[0].ban_rate);
			  console.log(champEasyChampData);
			  console.log(champHardChampData);
			  if(champTierData[0].tier == 0){
				  document.getElementById('tier').textContent = 'OP';
			  }else{
				  document.getElementById('tier').textContent = champTierData[0].tier;  
			  }
			  document.getElementById('win-rate').textContent = champTierData[0].win_rate+'%';
			  document.getElementById('pick-rate').textContent = champTierData[0].pick_rate+'%';
			  document.getElementById('ban-rate').textContent = champTierData[0].ban_rate+'%';
			  
			  let easyTableHeaders = document.getElementsByClassName('easy-champ-img');
			  for (var i = 0; i < easyTableHeaders.length; i++) {
				  easyTableHeaders[i].innerHTML = '';
				  easyTableHeaders[i].innerHTML = '<img alt="" src="/resources/img/champion_img/square/'+champEasyChampData[i].champion_img+'" class="champion-img">';
			  }
			  let hardEasyTableData = document.getElementsByClassName('easy-champ-win-rate');

			  for (var i = 0; i < hardEasyTableData.length; i++) {
				  hardEasyTableData[i].innerHTML = '';
				  hardEasyTableData[i].innerHTML = champEasyChampData[i].match_up_win_rate+'%';
			  }
			  
			  let hardTableHeaders = document.getElementsByClassName('hard-champ-img');
			  for (var i = 0; i < hardTableHeaders.length; i++) {
				  hardTableHeaders[i].innerHTML = '';
				  hardTableHeaders[i].innerHTML = '<img alt="" src="/resources/img/champion_img/square/'+champHardChampData[i].champion_img+'" class="champion-img">';
			  }
			  var hardTableData = document.getElementsByClassName('hard-champ-win-rate');

			  for (var i = 0; i < hardTableData.length; i++) {
				  hardTableData[i].innerHTML = '';
				  hardTableData[i].innerHTML = champHardChampData[i].match_up_win_rate+'%';
			  }
		}).fail(err => {
		  console.log(err);
		});	
}

/* <div class="lane-img lane-top" onclick="selectLane('TOP')"><img src="/resources/img/ranked-positions/Position_Silver-Top.png" alt="로그인 이미지"></div>
<div class="lane-img lane-jungle" onclick="selectLane('JUNGLE')"><img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" alt="로그인 이미지"></div>
<div class="lane-img lane-middle" onclick="selectLane('MIDDLE')"><img src="/resources/img/ranked-positions/Position_Silver-Mid.png" alt="로그인 이미지"></div>
<div class="lane-img lane-bottom" onclick="selectLane('BOTTOM')"><img src="/resources/img/ranked-positions/Position_Silver-Bot.png" alt="로그인 이미지"></div>
<div class="lane-img lane-support" onclick="selectLane('UTILITY')"><img src="/resources/img/ranked-positions/Position_Silver-Support.png" alt="로그인 이미지"></div> */

</script>

</html>