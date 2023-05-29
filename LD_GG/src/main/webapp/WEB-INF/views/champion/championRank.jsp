<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>챔피언 랭크</title>
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
</head>
<style>
.container_box {
	width: 65%;
	position: absolute;
	left: 32%;
	top: 10%;
	height: 80vh;
	overflow: scroll;
}

.container {
	height: 100px;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.col {
	display: flex;
	flex-direction: row;
	align-items: center;
	background-color: #E4E6EF;
}

.tier_container_box {
	position: relative;
	top: 22%;
	left: 0%;
	z-index: 90;
}

.table th:nth-last-child(-n+4) {
	cursor: pointer;
}

button{
	border: 1px solid black;
}

.lane_button button{
	margin-right: 20px;
	width: 150px;
	height: 35px;
}

.lane_button{
	position: relative;
	left: 150px;
}


#option_container button,
#tier_select{
	width: 120px;
	height: 35px;
}

.lane_button button:hover{
	background-color: #7c83a0;
	opacity: 0.6;
}

.table{
	background-color: #E4E6EF;
	margin-top: 20px;
}

.table tbody:nth-child(2) td{
	line-height: 50px;
}


.table tbody:nth-child(2) td:nth-child(2){
	width: 50px;
}

.table tbody:nth-child(2) td:nth-child(3){
	width: 150px;
}

.table td:nth-child(2),
 .table td:nth-child(3) {
	cursor: pointer;
}
.table td{
	font-size: 16px;
	font-weight: 700;
}

th{
	text-align: center;
	font-weight: 700;
	font-size: 18px;
}

.table img {
	width: 60px;
	height: 60px;
}

.champion-container {
	margin-top: 90px;
	width: 25%;
	height: 80vh;
	background-color: #fff;
	margin-right: 20px;
	margin-left: 60px;
	box-sizing: border-box;
	position: absolute;
	left: 2%;
	top: 2%;
}

.search-container {
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

.lane-img:hover, .lane-img:active {
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
	transition: 0.5s;
}

.champions img:hover {
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
	width: 5px;
	/* 스크롤바의 너비 */
}

::-webkit-scrollbar-track {
	background-color: #f1f1f1;
	/* 스크롤바의 트랙(배경) 색상 */
}

::-webkit-scrollbar-thumb {
	background-color: #888;
	/* 스크롤바의 썸(막대) 색상 */
}

.ai-score{
	width: 60px;
	background-color: #75c7fb;
	color: #fff;
	font-size: 22px;
	font-weight: 900;
	border-radius: 1rem;
}

.hi-score{
	background-color: #ff3847;
}
</style>

<body>
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
					<img src="/resources/img/profileicon/${sessionScope.summoner_icon}.png" alt="">
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
	
	<div class="champion-container">
		<div class="lane-select-box">
			<div class="lane-img lane-top" onclick="selectLane('TOP')">
				<img src="/resources/img/ranked-positions/Position_Silver-Top.png"
					alt="로그인 이미지">
			</div>
			<div class="lane-img lane-jungle" onclick="selectLane('JUNGLE')">
				<img
					src="/resources/img/ranked-positions/Position_Silver-Jungle.png"
					alt="로그인 이미지">
			</div>
			<div class="lane-img lane-middle" onclick="selectLane('MIDDLE')">
				<img src="/resources/img/ranked-positions/Position_Silver-Mid.png"
					alt="로그인 이미지">
			</div>
			<div class="lane-img lane-bottom" onclick="selectLane('BOTTOM')">
				<img src="/resources/img/ranked-positions/Position_Silver-Bot.png"
					alt="로그인 이미지">
			</div>
			<div class="lane-img lane-support" onclick="selectLane('UTILITY')">
				<img
					src="/resources/img/ranked-positions/Position_Silver-Support.png"
					alt="로그인 이미지">
			</div>
		</div>
		<div class="champion-img-container">
			<div class="champions"></div>
		</div>
	</div>

	<div class="container_box">
		<div>
			<div class="container">
<!-- 				<div class="tier_container_box">
					<button id="tier_select">티어 선택</button>
					<div id="option_container"></div>
				</div> -->
				
				<div class="col">
					<div class='lane_button'>
						<button class="TOP">탑</button>
						<button class="JUNGLE">정글</button>
						<button class="MIDDLE">미드</button>
						<button class="BOTTOM">바텀</button>
						<button class="UTILITY">서포터</button>
					</div>
				</div>

			</div>
			<table class="table table-striped">
				<th class='rank'>순위</th>
				<th class='champ' colspan="2">챔피언</th>
				<th class='tier'>티어</th>
				<th class='ai_score'>Ai-Score</th>
				<th class='win_rate'>승률</th>
				<th class='pick_rate'>픽률</th>
				<th class='ban_rate'>밴률</th>
			</table>
		</div>
	</div>

</body>

<!-- 비동기 -->
<script>
	let response;
	let lane = 'TOP';
	let tier = 1;
	// 페이지 로드 후
	$.ajax({
		url: '/champion/rank.json',
		type: 'POST',
		data: {
			lane: lane,
			tier: tier
		}
	}).done(res => {
		response = res
		let cList = '<tbody>';
		let i = 1;
		for (champion of res) {
			let src;
			if(champion.tier == 0){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-op.svg'
			}else if(champion.tier == 1){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-1.svg'
			}else if(champion.tier == 2){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-2.svg'
			}else if(champion.tier == 3){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-3.svg'
			}else if(champion.tier == 4){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-4.svg'
			}else if(champion.tier == 5){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-5.svg'
			}
			cList += '<tr>'
			cList += '<td align="center">' + i + '</td>'
			cList += '<td onclick="selectChampion('+ champion.champion_id +')"><img src="/resources/img/champion_img/square/' +
			champion.champion_img + '" alt="#"></td>'
			cList += '<td onclick="selectChampion('+ champion.champion_id +')" align="center">' + champion.champion_kr_name + '</td>'
			cList += '<td align="center"><img src="'+ src +'"></td>'
			if (champion.ai_score > 70){
				cList += '<td align="center"><div class="ai-score hi-score">' + champion.ai_score + '</div></td>'
			}else{
				cList += '<td align="center"><div class="ai-score">' + champion.ai_score + '</div></td>'
			}
			cList += '<td align="center">' + champion.win_rate + '%</td>'
			cList += '<td align="center">' + champion.pick_rate + '%</td>'
			cList += '<td align="center">' + champion.ban_rate + '%</td>'
			cList += '</tr>'
			i++
		}
		cList += '</tbody>';
		$('.table').append(cList);
	}).fail(err => {
		console.log(err)
	})
	// 페이지 로드 끝

	// 티어 선택
	function tier_select(tier_){
		document.getElementById("tier_select").innerHTML = tier_;
		document.getElementById("option_container").innerHTML = '';
		button_toggle = !button_toggle;

		if(tier_ == 'Challenger'){
			tier = 1
		}
		else if(tier_ == 'Grandmaster'){
			tier = 2
		}
		else if(tier_ == 'Master'){
			tier = 3
		}
		else if(tier_ == 'Diamond'){
			tier = 4
		}
		else if(tier_ == 'Platinum'){
			tier = 5
		}
		else if(tier_ == 'Gold'){
			tier = 6
		}
		else if(tier_ == 'Silver'){
			tier = 7
		}
		else if(tier_ == 'Bronze'){
			tier = 8
		}
		else if(tier_ == 'Iron'){
			tier = 9
		}
		
		$.ajax({
			url: '/champion/rank.json',
			type: 'POST',
			data: {
				lane: lane,
				tier: tier
			}
		}).done(res => {
			response = res
			let cList = '<tbody>';
			let i = 1;
			for (champion of res) {
				let src;
				if(champion.tier == 0){
					src = 'https://s-lol-web.op.gg/images/icon/icon-tier-op.svg'
				}else if(champion.tier == 1){
					src = 'https://s-lol-web.op.gg/images/icon/icon-tier-1.svg'
				}else if(champion.tier == 2){
					src = 'https://s-lol-web.op.gg/images/icon/icon-tier-2.svg'
				}else if(champion.tier == 3){
					src = 'https://s-lol-web.op.gg/images/icon/icon-tier-3.svg'
				}else if(champion.tier == 4){
					src = 'https://s-lol-web.op.gg/images/icon/icon-tier-4.svg'
				}else if(champion.tier == 5){
					src = 'https://s-lol-web.op.gg/images/icon/icon-tier-5.svg'
				}
				cList += '<tr>'
				cList += '<td align="center">' + i + '</td>'
				cList += '<td onclick="selectChampion('+ champion.champion_id +')"><img src="/resources/img/champion_img/square/' +
				champion.champion_img + '" alt="#"></td>'
				cList += '<td onclick="selectChampion('+ champion.champion_id +')" align="center">' + champion.champion_kr_name + '</td>'
				cList += '<td align="center"><img src="'+ src +'"></td>'
				if (champion.ai_score > 70){
					cList += '<td align="center"><div class="ai-score hi-score">' + champion.ai_score + '</div></td>'
				}else{
					cList += '<td align="center"><div class="ai-score">' + champion.ai_score + '</div></td>'
				}
				cList += '<td align="center">' + champion.win_rate + '%</td>'
				cList += '<td align="center">' + champion.pick_rate + '%</td>'
				cList += '<td align="center">' + champion.ban_rate + '%</td>'
				cList += '</tr>'
				i++
			}
			cList += '</tbody>';
			$('td').remove();
			$('.table').append(cList);
		}).fail(err => {
			console.log(err)
		})
	}
	// 티어 선택 끝

	// 라인 변경
	const lane_buttons = document.querySelectorAll(".lane_button button")
	lane_buttons.forEach(lane_button =>{
		lane_button.addEventListener('click', function (evt) {
			lane_buttons.forEach(check=>{
				if(lane_button == check){
					check.style.backgroundColor = '#7c83a0';
					check.style.opacity = 0.8;
				}else{
					check.style.backgroundColor = 'white';
					check.style.opacity = 1
				}
			})

			lane = lane_button.className

			$.ajax({
				url: '/champion/rank.json',
				type: 'POST',
				data: {
					lane: lane,
					tier: tier
				}
			}).done(res => {
				response = res
				console.log(res)
				let cList;
				let i = 1;
				for (champion of res) {
							let src;
					if(champion.tier == 0){
						src = 'https://s-lol-web.op.gg/images/icon/icon-tier-op.svg'
					}else if(champion.tier == 1){
						src = 'https://s-lol-web.op.gg/images/icon/icon-tier-1.svg'
					}else if(champion.tier == 2){
						src = 'https://s-lol-web.op.gg/images/icon/icon-tier-2.svg'
					}else if(champion.tier == 3){
						src = 'https://s-lol-web.op.gg/images/icon/icon-tier-3.svg'
					}else if(champion.tier == 4){
						src = 'https://s-lol-web.op.gg/images/icon/icon-tier-4.svg'
					}else if(champion.tier == 5){
						src = 'https://s-lol-web.op.gg/images/icon/icon-tier-5.svg'
					}
					cList += '<tr>'
					cList += '<td align="center">' + i + '</td>'
					cList += '<td onclick="selectChampion('+ champion.champion_id +')"><img src="/resources/img/champion_img/square/' +
					champion.champion_img + '" alt="#"></td>'
					cList += '<td onclick="selectChampion('+ champion.champion_id +')" align="center">' + champion.champion_kr_name + '</td>'
					cList += '<td align="center"><img src="'+ src +'"></td>'
					if (champion.ai_score > 70){
						cList += '<td align="center"><div class="ai-score hi-score">' + champion.ai_score + '</div></td>'
					}else{
						cList += '<td align="center"><div class="ai-score">' + champion.ai_score + '</div></td>'
					}
					cList += '<td align="center">' + champion.win_rate + '%</td>'
					cList += '<td align="center">' + champion.pick_rate + '%</td>'
					cList += '<td align="center">' + champion.ban_rate + '%</td>'
					cList += '</tr>'
					i++
				}
				$('tbody:eq(1)').empty();
				$('tbody:eq(1)').html(cList);
			}).fail(err => {
				console.log(err)
			})
		})
	})
	// 라인 변경 끝
</script>

<!-- champion-container -->
<script>
	// 챔피언 리스트
function championList() {
	$.ajax({
		method: 'get',
		url: '/champion/list.json'
	}).done(res => {
		let championHTML = '';
		res.forEach(function (champion) {
			championHTML += '<div class="champion">';
			championHTML += '<img alt="' + champion.champion_kr_name +
				'" class="bg-image champion-img" src="/resources/img/champion_img/square/' +
				champion.champion_img + '" onclick="selectChampion(' + champion.champion_id + ')">';
			championHTML += '</div>';
		});

		$('.champions').html(championHTML);
	}).fail(err => {
		console.log(err);
	});
}
championList();
// 챔피언 리스트 끝

// 라인 선택
function selectLane(team_position) {
	$('.champions').empty();
	$.ajax({
		method: 'get',
		url: '/tip/champion/lane',
		data: {
			team_position: team_position
		},
	}).done(res => {
		let championHTML = '';
		res.forEach(function (champion) {
			championHTML += '<div class="champion">';
			championHTML += '<img alt="' + champion.champion_kr_name +
				'" class="bg-image champion-img" src="/resources/img/champion_img/square/' +
				champion.champion_img + '" onclick="selectChampion(' + champion.champion_id + ')">';
			championHTML += '</div>';
		});

		$('.champions').html(championHTML);
	}).fail(err => {
		console.log(err);
	})
}
// 라인 선택 끝
</script>

<!-- container_box -->
<script>
	// 티어 버튼
/* 	let button_toggle = false; // 초기에는 옵션 숨김 상태로 시작
	document.getElementById("tier_select").onclick = function() {
		let option_container = document.getElementById("option_container");
		if (button_toggle) {
			// 옵션을 숨김
			option_container.innerHTML = "";
		} else {
			// 옵션을 보여줌
			const tier_list = ['Challenger', 'Grandmaster', 'Master', 'Diamond', 'Platinum', 'Gold', 'Silver', 'Bronze', 'Iron'];
			for (const tier_ of tier_list) {
				let tier_button = document.createElement("button");
				tier_button.style.display = 'block';
				tier_button.onclick = () => {
					tier_select(tier_);
				};
				tier_button.innerHTML = tier_;
				option_container.appendChild(tier_button);
			}
		}

		button_toggle = !button_toggle;
	}; */
	// 티어 버튼 끝

	// 정렬 버튼
	let win_rate_reverse = false
	let pick_rate_reverse = false
	let ban_rate_reverse = false
	let tier_reverse = true
	const th_list = document.querySelectorAll('.table th')
	const sort_buttons = Array.from(th_list).slice(-4);
	sort_buttons.forEach((sort_button) => {
		sort_button.addEventListener('click', () => {
		key = sort_button.className;
		console.log(key);

		if (key == 'win_rate') {
			win_rate_reverse = !win_rate_reverse;
			pick_rate_reverse = false
			ban_rate_reverse = false
			tier_reverse = false
		} else if (key == 'pick_rate') {
			pick_rate_reverse = !pick_rate_reverse;
			win_rate_reverse = false
			ban_rate_reverse = false
			tier_reverse = false
		} else if (key == 'ban_rate') {
			ban_rate_reverse = !ban_rate_reverse;
			pick_rate_reverse = false
			win_rate_reverse = false
			tier_reverse = false
		} else if (key == 'tier') {
			pick_rate_reverse = false
			win_rate_reverse = false
			ban_rate_reverse = false
			tier_reverse = !tier_reverse;
		}

		if (win_rate_reverse || pick_rate_reverse || ban_rate_reverse || tier_reverse) {
			console.log('역방향')
			response.sort((a, b) => {
				if (key == 'tier') {
					if (a[key] > b[key]) {
						return 1;
					} else if (a[key] < b[key]) {
						return -1;
					} else {
						return 0;
					}
				} else {
					let numA = parseFloat(a[key]);
					let numB = parseFloat(b[key]);
					if (numA > numB) {
						return -1;
					} else if (numA < numB) {
						return 1;
					} else {
						return 0;
					}
				}
			})
		} else {
			console.log('정방향')
			response.sort((b, a) => {
				if (key == 'tier') {
					if (a[key] > b[key]) {
						return 1;
					} else if (a[key] < b[key]) {
						return -1;
					} else {
						return 0;
					}
				} else {
					let numA = parseFloat(a[key]);
					let numB = parseFloat(b[key]);
					if (numA > numB) {
						return -1;
					} else if (numA < numB) {
						return 1;
					} else {
						return 0;
					}
				}
			})
		}

		let cList;
		let i = 1;
		for (champion of response) {
			let src;
			if(champion.tier == 0){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-op.svg'
			}else if(champion.tier == 1){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-1.svg'
			}else if(champion.tier == 2){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-2.svg'
			}else if(champion.tier == 3){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-3.svg'
			}else if(champion.tier == 4){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-4.svg'
			}else if(champion.tier == 5){
				src = 'https://s-lol-web.op.gg/images/icon/icon-tier-5.svg'
			}
			cList += '<tr>'
			cList += '<td align="center">' + i + '</td>'
			cList += '<td onclick="selectChampion('+ champion.champion_id +')"><img src="/resources/img/champion_img/square/' +
			champion.champion_img + '" alt="#"></td>'
			cList += '<td onclick="selectChampion('+ champion.champion_id +')" align="center" >' + champion.champion_kr_name + '</td>'
			cList += '<td align="center"><img src="'+ src +'"></td>'
			cList += '<td align="center">' + champion.win_rate + '%</td>'
			cList += '<td align="center">' + champion.pick_rate + '%</td>'
			cList += '<td align="center">' + champion.ban_rate + '%</td>'
			cList += '</tr>'
			i++
		}
		$('tbody:eq(1)').empty();
		$('tbody:eq(1)').html(cList);
		})
	})
	// 정렬 버튼 끝

	function selectChampion(champion_id) {
		location.href = `/champion/info?champion=\${champion_id}`
	}
</script>

<script type="text/javascript">

</script>
</html>