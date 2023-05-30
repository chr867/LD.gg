<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>LD.GG</title>
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
<!-- 채팅 관련 JS-->
<script src="/resources/js/main/chat.js" defer></script>
</head>
<style>
.main-container {
	display: flex;
	text-align: center;
	margin-top: 80px;
}

#left_container {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	box-sizing: border-box;
	margin-left: 350px;
	margin-top: 20px;
	width: 20%;
	height: 58vh;
}

#right_container {
	display: flex;
	flex-direction: column;
	box-sizing: border-box;
	margin-left: 200px;
	margin-top: 20px;
	width: 40%;
	height: 58vh;
}

#bottom_container {
	display: flex;
	box-sizing: border-box;
	margin-left: 400px;
	width: 100%;
}


#champ_search_box input {
	width: 220px;
	border-radius: 5px;
}

#champ_search{
	margin-top: 20px;
}

#my_champion_img {
	width: 370px;
	height: 400px;
	padding-top: 20px;
	padding-bottom: 15px;
	border-radius: 70%;
}

#build_recom_box button {
	margin-top: 10px;
}

.select_lane{
	border-radius: 10px;
	display: flex;
	justify-content: space-between;
	position: relative;
	left: 10%;
	width: 80%;
}

.select_lane img{
	width: 100px;
	height: 100px;
}
.select_tag{
	display: flex;
	width: 100%;
	height: 100px;
	margin-top: 15px;
	justify-content: space-between;
}

.select_tag div{
	width: 100px;
	height: 100px;
	line-height: 100px;
	text-align: center;
}

#right_champion_img {
	position: relative;
	left: 0%;
	width: 140px;
	height: 140px;
	border-radius: 70%;
}

#right_champion_search div{
	position: relative;
	left: 10%;
}

#right_champ_search_box {
	display: flex;
	width: 342px;
	margin-top: 20px;
}

.search_box{
	display: flex;
	position: relative;
	left: -10%;
	top: 40%;
	width: 300px;
}

.search_box div{
	margin-left: 20px;
	line-height: 140px;
}

#right_champ_search{
	position: relative;
	margin-bottom: 10px;
	margin-top: 10px;
}

#recom_champ,
#recom_container{
	display: flex;
}

#recom_container{
	height: 200px;
}

#recom_img_container {
	text-align: center;
	display: flex;
	position: relative;
	left: 10%;
}

#recom_champ img {
	width: 140px;
	height: 140px;
	margin-right: 20px;
	border-radius: 70%;
}

#recom_champ_header{
	display: flex;
	flex-direction: column-reverse;
	position: relative;
	left: 2%;
	margin-top: 7%;
}

#recom_champ_header div:last-child{
	position: relative;
	top: -50%;
}

.recom_img{
	display: flex;
	flex-direction: column;
}


</style>

<style>
	.champion-container {
	position: relative;
	left: 35%;
	top: -21%;
	width: 65%;
	height: 250px;
	background-color: #F4F4F4;
	box-sizing: border-box;
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
	background-color: #F4F4F4;
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
	width: 100%;
	background-color: #F4F4F4;
	height: 87%;
	margin: auto;
	box-sizing: border-box;
	overflow-y: auto;
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
	border: 5px solid #E4E6EF;
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
</style>

<style>
/* 모달 스타일 */
#build_modal {
  display: none; /* 초기에 모달을 숨김 */
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.5); /* 배경을 어둡게 처리 */
}

#build_modal_content {
	flex-direction: columns;
	top: -22%;
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.champion-info-box{
	display: flex;

}

.mythic-common-item-container{
	width: 720px;
	height: 300px;
	display: flex;
	box-sizing: border-box;
}
.mythic-item-container{
	width: 350px;
	height: 100%;
	background-color: #fff;
	border-radius: 0.5rem;
	margin-right: 20px;
	box-sizing: border-box;
	
}
.common-item-container{
	width: 350px;
	height: 100%;
	background-color: #fff;
	border-radius: 0.5rem;
	box-sizing: border-box;
	
}
.mythic-item-title{
	text-align: center;
}
.mythic-item-title h4{
	font-size: 20px;
	font-weight: 700;
}
.common-item-title{
	text-align: center;
}
.common-item-title h4{
	font-size: 20px;
	font-weight: 700;
	
}

.start-item{
	margin-left: 32px;
	display: flex;
}


.item-img:hover .item-desc {
	visibility: visible;
	opacity: 1;
}

.item-desc {
	position: absolute;
	z-index: 300;
	width: 400px;
	background-color: black;
	color: #fff;
	border-radius: 1rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
}


.lane-desc {
	position: absolute;
	top: 35px;
	z-index: 300;
	width: 150px;
	background-color: black;
	color: #fff;
	border-radius: 0.5rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
	font-size: 14px;
}

.lane-img:hover .lane-desc {
	visibility: visible;
	opacity: 1;
}
	
.rune-container {
	display: flex;
	width: 500px;
	box-sizing: border-box;
	background-color: #fff;
	border-radius: 0 0 0.5rem 0.5rem;
}
.rune-title{
	margin-top: 20px;
	background-color: #fff;
	border-radius: 0.5rem 0.5rem 0 0;
}
.rune-title h4{
	margin: 0;
	font-size: 18px;
	font-weight: 700;
	text-align: center;
}
.rune-box {
	width: 100%;
	height: 300px;
	background-color: #fff;
	margin-right: 5px;
	justify-content: space-between;
	text-align: center;
	padding: 10px 0 0 0;
	box-sizing: border-box;
}

.first-rune {
	background-color: rgb(255, 255, 255);
	width: 50px;
	height: 50px;
	border-radius: 10rem;
	background-color: #202020;
	box-sizing: border-box;
	padding-top: 10px;

}
.first-rune img{
	
}

.runes {
	display: flex;
	justify-content: space-between;
}

.rune {
	background-color: #202020;
	width: 40px;
	height: 40px;
	margin: 10px;
	border-radius: 4rem;
}

.rune img {
	width: 40px;
	height: 40px;
	filter: grayscale(100%);
	opacity: 0.5;
}

.sub-runes {
	padding: 50px 0 0 0;
	border-left: 5px solid #f4f4f4;
	border-right: 5px solid #f4f4f4;
	box-sizing: border-box;
}

.sub-ability {
	padding: 125px 0 0 0;
}

.rune-desc {
	position: absolute;
	z-index: 10;
	width: 300px;
	background-color: black;
	color: #fff;
	border-radius: 0.5rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
	font-size: 14px;
}

.rune:hover .rune-desc {
	visibility: visible;
	opacity: 1;
}
.rune .fragment-img{
	width: 30px;
	height: 30px;
}
.fragment{
	width: 30px;
	height: 30px;
	
}
.sub-ability .runes{
	margin-bottom: 10px;
}
.rune-select-box{
	width: 100%;
	height: 50px;
	background-color: #fff;
	margin-left: 200px;
	box-sizing: border-box;
	padding: 5px;
	display: flex;
	border-radius: 0.5rem;
}
.rune-select-button{
	height: 100%;
	width: 100px;
	background-color: #f4f4f4;
	border-radius:1rem;
	display: flex;
	align-items: center;
	transition : 0.5s;
	margin-right: 10px;
}
.rune-select-button:hover{
	background-color: #606060;
}
.rune-select-main{
	width: 30px;
	height: 40px;
	border-radius: 0.5rem;
	align-items: center;
	justify-content: center;
	display: flex;
}
.rune-select-main img{
	width: 20px;
	height: 20px;
}
.rune-select-sub{
	width: 30px;
	height: 40px;
	border-radius: 0.5rem;
	align-items: center;
	justify-content: center;
	display: flex;
}
.rune-select-sub img{
	width: 20px;
	height: 20px;
}
.rune-select-mainStyle{
	width: 40px;
	height: 40px;
	border-radius: 0.5rem;
	align-items: center;
	justify-content: center;
	display: flex;
}
.rune-select-mainStyle img{
	width: 40px;
	height: 40px;
}

.rune-combination-desc {
	position: absolute;
	top: 320px;
	z-index: 300;
	width: 150px;
	background-color: black;
	color: #fff;
	border-radius: 0.5rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
	font-size: 14px;
}

.rune-select-button:hover .rune-combination-desc {
	visibility: visible;
	opacity: 1;
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

.spell-container{
	background-color: #fff;
	height: 150px;
	border-radius: 0.5rem;
	box-sizing: border-box;
}
.spell-title h4{
	margin: 0;
	font-size: 18px;
	font-weight: 700;
	text-align: center;
}
.spell-title{
	margin-top: 10px;
}
.spells{
	height: 60px;
	background-color: #fff;
	display: flex;
	align-items: center;
	padding: 0 0 0 10px;
}
.spells h4{
	margin: 0 10px 0 0;
	font-weight: 700;
	font-size: 16px;
}
.spells h6{
	margin: 0 10px 0 0;
	font-weight: 900;
	font-size: 16px;
}
.spell{
	border: 2px solid #f4f4f4;
	border-radius: 0.5rem;
}
.spells .spell img{
	width: 40px;
	height: 40px;
	border-radius: 0.5rem;
}
.spell-desc {
	position: absolute;
	z-index: 10;
	width: 200px;
	background-color: black;
	color: #fff;
	border-radius: 0.5rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
	font-size: 14px;
}

.spell:hover .spell-desc {
	visibility: visible;
	opacity: 1;
}
.spell-text{
text-align: center;
}

.skill-build-container {
	width: auto;
	height: 278px;
	background-color: #fff;
	margin-top: 79px;
	margin-left: 100px;
	border-radius: 0.5rem;
}
.skill-build-title{
	text-align: center;
}
.skill-build-title h4{
	font-size: 18px;
	font-weight: 700;
}
.arrow-img img{
	width: 40px;
	height: 40px;
}
.skill-build-sequence-box{
	display: flex;
	margin-left: 20px;
	margin-top: 20px;
}
.skill-build-sequence{
box-sizing: border-box;

}
.skill-key-icon{
	position: relative;
	width: 15px;
	height: 15px;
	background-color: black;
	border-radius: 3px;
	bottom: 15px;
	text-align: center;
}
.skill-key-icon h6{
	color: white;
	font-size: 10px;
	font-weight: 700;
}

.skill-build-sequence-box .squence-tooltip {
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

.skill-build-sequence-box .skill-build-sequence:hover .squence-tooltip {
	visibility: visible;
	opacity: 1;
}

.skill-build-rate{
	display: flex;
	align-items: center;
	margin-left: 120px;
}
.rate-text{
	margin-left: 15px;
}
.rate-text h4{
	font-size: 18px;
	font-weight: 700;
}
.rate-text h6{
	font-size: 16px;
	font-weight: 700;
}
.skill-bulid-all-box{
	height: 40px;
	margin-left: 20px;
	display: flex;
	align-items: center;
}
.q-skill{
	width: 30px;
	height: 30px;
	background-color: black;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 0.2rem;
	margin-right: 5px;
}
.q-skill h3{
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #FF0000;
}
.w-skill{
	width: 30px;
	height: 30px;
	background-color: black;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 0.2rem;
	margin-right: 5px;
}
.w-skill h3{
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #FFFF00;
}
.e-skill{
	width: 30px;
	height: 30px;
	background-color: black;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 0.2rem;
	margin-right: 5px;
}
.e-skill h3{
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #80FF00;
}

.r-skill{
	width: 30px;
	height: 30px;
	background-color: black;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 0.2rem;
	margin-right: 5px;
}
.r-skill h3{
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #0000CC;
}
</style>
<body>
	<%@ include file="./header.jsp"%>
	<%@ include file="./sidebar.jsp"%>
	<%@ include file="./footer.jsp"%>
  
	<!----------------------------------------------------------------------------------------------------------------->
	<div id="session-summoner-name" style="display: none">${sessionScope.lol_account}</div>
	<div id="session-user-type" style="display: none">${sessionScope.user_type}</div>
	<div id="session-summoner-name" style="display: none">${sessionScope.summoner_name}</div>
	<div id="session-summoner-icon" style="display: none">${sessionScope.summoner_icon}</div>
	<div id="error-check" style="display: none">${check}</div>
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

	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<br> <br> <br> <br> <br> <br> <br>
		<br>

		<div id="left_container">
			<div id="my_champion">
				<div id="champ_search_box">
					<form id=champ_search>
						<input id='champion_name_input' type="text"
							name="champion_name" placeholder="내 챔피언 검색">
					</form>
					<img id="my_champion_img" alt="#"
						src="/resources/img/profileicon/29.png">
				</div>
				<div id="build_recom_box" style="height: 70px;">
					<div style="height: 20px;"></div>
					<button onclick="recom_build()">추천 빌드</button>
				</div>
			</div>
		</div>

		<div id="right_container">
			<div id="counter_champion">
				<div class="select_lane lane_button">
					<img src="/resources/img/ranked-positions/Position_Silver-Top.png" onclick="selectLane('TOP')" class="TOP" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" onclick="selectLane('JUNGLE')" class="JUNGLE" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Mid.png" onclick="selectLane('MIDDLE')" class="MIDDLE" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Bot.png" onclick="selectLane('BOTTOM')" class="BOTTOM" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Support.png" onclick="selectLane('UTILITY')" class="UTILITY" alt="">
				</div>

				<div class="select_tag">
					<div class="all">전체</div>
					<div class="Assassin">암살자</div>
					<div class="Fighter">전사</div>
					<div class="Mage">마법사</div>
					<div class="Marksman">원거리 딜러</div>
					<div class="Controller">서포터</div>
					<div class="Tank">탱커</div>
				</div>

				<div id="right_champ_search_box">
					<div>
						<div class="search_box">
							<img id="right_champion_img" alt="#"
								src="/resources/img/profileicon/29.png" onclick="right_champion_img_click(this)"> <div></div>
						</div>
					</div>
				</div>
				
				<div class="champion-container">
					<form id=right_champ_search>
						<input id='right_champ_name_input' type="text"
							name="champion_name" placeholder="상대 챔피언 검색">
					</form>
					
					<div class="champion-img-container">
						<div class="champions"></div>
					</div>
				</div>
				
			</div>
		</div>
	</div>


	<div id="bottom_container">
		<div id="recom_container">
			<div id="recom_champ_header">
				<div>승률</div>
				<div>라인킬 확률</div>
				<div>추천 챔피언</div>
			</div>
			
			<div id="recom_champ">
				<div id="recom_img_container">
					<div class="recom_img">
						<img src="/resources/img/profileicon/29.png" class="champ1" alt=""
						id="recom_champ_0" onclick="recom_click(this)">
						<div></div>
						<div></div>
						<div></div>
					</div>

					<div class="recom_img">
						<img
						src="/resources/img/profileicon/29.png" class="champ2" alt=""
						id="recom_champ_1" onclick="recom_click(this)">
						<div></div>
						<div></div>
						<div></div>
					</div>

					<div class="recom_img">
						<img
						src="/resources/img/profileicon/29.png" class="champ3" alt=""
						id="recom_champ_2" onclick="recom_click(this)">
						<div></div>
						<div></div>
						<div></div>
					</div>

					<div class="recom_img">
						<img
						src="/resources/img/profileicon/29.png" class="champ4" alt=""
						id="recom_champ_3" onclick="recom_click(this)"> 
						<div></div>
						<div></div>
						<div></div>
					</div>

					<div class="recom_img">
						<img
						src="/resources/img/profileicon/29.png" class="champ5" alt=""
						id="recom_champ_4" onclick="recom_click(this)">
						<div></div>
						<div></div>
						<div></div>
					</div>

				</div>
				
			</div>
		</div>
	</div>
	
	<!-- 추천 빌드 모달 -->
	<div id="modalContainer">
		<!-- 모달 창 -->
		<div id="build_modal" class="modal">
			<div id="build_modal_content" class="modal-content">
				<span id="closeModalBtn" class="close">&times;</span>

				<div class="champion-info-box">
					<table class="champion-table">
						<tbody style="display: flex; flex-direction: column; width: 335px; height: 200px;">
							<tr>
								<td rowspan="2"><img alt=""
									src="/resources/img/champion_img/square/${chamInfo.champion_img}"
									class="champion-img_"></td>
								<td colspan="5"><h3 class="champion_name">${chamInfo.champion_kr_name}</h3></td>
							</tr>
							<tr style="display: flex;">
								<td><img alt=""
									src="/resources/img/passive/${chamInfo.champion_p_img}"
									class="ability-img">
									<div class="skill-key-icon">
										<h6>P</h6>
									</div>
									<div class="tooltip">
										<div>${chamInfo.champion_p_name}</div>
										<br>
										<div>${chamInfo.champion_p_desc}</div>
									</div></td>
								<td><img alt=""
									src="/resources/img/spell/${chamInfo.champion_q_img}"
									class="ability-img">
									<div class="skill-key-icon">
										<h6>Q</h6>
									</div>
									<div class="tooltip">
										<div>${chamInfo.champion_q_name}</div>
										<br>
										<div>${chamInfo.champion_q_desc}</div>
									</div></td>
								<td><img alt=""
									src="/resources/img/spell/${chamInfo.champion_w_img}"
									class="ability-img">
									<div class="skill-key-icon">
										<h6>W</h6>
									</div>
									<div class="tooltip">
										<div>${chamInfo.champion_w_name}</div>
										<br>
										<div>${chamInfo.champion_w_desc}</div>
									</div></td>
								<td><img alt=""
									src="/resources/img/spell/${chamInfo.champion_e_img}"
									class="ability-img">
									<div class="skill-key-icon">
										<h6>E</h6>
									</div>
									<div class="tooltip">
										<div>${chamInfo.champion_e_name}</div>
										<br>
										<div>${chamInfo.champion_e_desc}</div>
									</div></td>
								<td><img alt=""
									src="/resources/img/spell/${chamInfo.champion_r_img}"
									class="ability-img">
									<div class="skill-key-icon">
										<h6>R</h6>
									</div>
									<div class="tooltip">
										<div>${chamInfo.champion_r_name}</div>
										<br>
										<div>${chamInfo.champion_r_desc}</div>
									</div></td>
							</tr>
						</tbody>
					</table>

					<div class="spell-container">
						<div class="spell-title">
							<h4>추천 스펠</h4>
							<div class="spell-box"></div>
						</div>
					</div>
	
					<div class="start-item-shoes-container">
						<div class="start-item-box">
							<div class="start-item-title">
								<h4 style="margin-left: 31px;">시작 아이템 추천</h4>
								<div class="start-item-build-box"></div>
							</div>
						</div>
					</div>
		
					<div class="shoes-box">
						<div class="shoes-title">
							<h4 style="margin-left: 69px;">신발 추천</h4>
							<div class="shoes-recom-box"></div>
						</div>
					</div>

					<div class="item-build-container" style="margin-left: 20px;">
						<h4 class="item-build-title" style="margin-left: 40px;">아이템 빌드 추천</h4>
						<div class="item-build-stack" style="display: flex; flex-direction: column;"></div>
					</div>
				</div>

				<div class="middle-container" style="display: flex;">
					<div style="width: 610px;">
						<div class="rune-select-box"></div>
						<div class="rune-title">
							<h4>추천 룬</h4>
						</div>
						<div class="rune-container">
							<div class="rune-box main-runes">
								<div class="first-rune main-rune-top" style="margin: 0 auto"></div>
								<div class="runes main-rune-first"></div>
								<div class="runes main-rune-second"></div>
								<div class="runes main-rune-third"></div>
								<div class="runes main-rune-fourth"></div>
							</div>
							<div class="rune-box sub-runes">
								<div class="first-rune sub-rune-top" style="margin: 10px auto"></div>
								<div class="runes sub-rune-first"></div>
								<div class="runes sub-rune-second"></div>
								<div class="runes sub-rune-third"></div>
							</div>
							<div class="rune-box sub-ability">
								<div class="runes sub-ability-first">
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsAdaptiveForceIcon.png"
											alt="" id="first-fragment-5008" class="fragment-img">
										<div class="rune-desc">
											<div>OFFENSE</div>
											<br>
											<div>적응형 능력치 +9</div>
										</div>
									</div>
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsAttackSpeedIcon.png"
											alt="" id="first-fragment-5005" class="fragment-img">
										<div class="rune-desc">
											<div>OFFENSE</div>
											<br>
											<div>공격속도 10%</div>
										</div>
									</div>
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsCDRScalingIcon.png"
											alt="" id="first-fragment-5007" class="fragment-img">
										<div class="rune-desc">
											<div>OFFENSE</div>
											<br>
											<div>스킬 가속 +8</div>
										</div>
									</div>
								</div>
								<div class="runes sub-ability-second">
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsAdaptiveForceIcon.png"
											alt="" id="second-fragment-5008" class="fragment-img">
										<div class="rune-desc">
											<div>OFFENSE</div>
											<br>
											<div>적응형 능력치 +9</div>
										</div>
									</div>
									<div class="rune  fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsArmorIcon.png"
											alt="" id="second-fragment-5002" class="fragment-img">
										<div class="rune-desc">
											<div>FLEX</div>
											<br>
											<div>방어력 +6</div>
										</div>
									</div>
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsMagicResIcon.png"
											alt="" id="second-fragment-5003" class="fragment-img">
										<div class="rune-desc">
											<div>FLEX</div>
											<br>
											<div>마법저항력 +8</div>
										</div>
									</div>
								</div>
								<div class="runes sub-ability-third">
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsHealthScalingIcon.png"
											alt="" id="third-fragment-5001" class="fragment-img">
										<div class="rune-desc">
											<div>DEFFENSE</div>
											<br>
											<div>체력 +15 ~ 140</div>
										</div>
									</div>
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsArmorIcon.png"
											alt="" id="third-fragment-5002" class="fragment-img">
										<div class="rune-desc">
											<div>FLEX</div>
											<br>
											<div>방어력 +6</div>
										</div>
									</div>
									<div class="rune fragment">
										<img
											src="/resources/img/perk-images/StatMods/StatModsMagicResIcon.png"
											alt="" id="third-fragment-5003" class="fragment-img">
										<div class="rune-desc">
											<div>FLEX</div>
											<br>
											<div>마법저항력 +8</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="skill-build-container">
						<div class="skill-build-title">
							<h4>추천 스킬 빌드</h4>
						</div>
						<div class="skill-build-sequence-box"></div>
						<div class="skill-bulid-all-box"></div>
						<div class="skill-build-sequence-box"></div>
						<div class="skill-bulid-all-box"></div>
					</div>
				</div>

			</div>
		</div>

	</div>



<script type="text/javascript">
	let selected_lane;
	let selected_tag;
	let selected_left_champion;
	let selected_right_champion;


	function go_mypage(){
		location.href="/member/mypage"
	}

	// 라인 선택 start
	let select_lane_imgs = document.querySelectorAll('.select_lane img')
	select_lane_imgs.forEach(lane=>{
		lane.addEventListener('click', function(){
			$('.select_lane img').css('background-color', '#F4F4F4');
			lane.style.backgroundColor = "#E4E6EF";
			selected_lane = lane.className;
			console.log(selected_lane);
			if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
			}
		})
	})
	// 라인 선택 end

	// 역할군 선택 start
	let select_tag_divs = document.querySelectorAll('.select_tag div')
	select_tag_divs.forEach(tag=>{
		tag.addEventListener('click', function(){
			$('.select_tag div').css('background-color', '#F4F4F4');
			tag.style.backgroundColor = "#E4E6EF";
			selected_tag = tag.className;
			console.log(selected_lane, selected_tag, selected_right_champion);
			if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
			}
		})
	})
	// 역할군 선택 end

	// 추천 챔피언 선택 start
	function recom_click(champ){
		$('#my_champion_img').attr('src', champ.src);
		$('#build_recom_left_val').attr('value', $(champ).attr('class'));
		$.ajax({
			url: "/champion/search-eng.json",
			type: 'POST',
			data: {champion_en_name: $(champ).attr('class')},
		}).done(res=>{
			selected_left_champion = res // champion_kr_name
			$('#build_recom_box div').text(res);
		}).fail(err=>{
			$('#build_recom_box div').text('챔피언을 선택해 주세요');
		})
	}
	// 추천 챔피언 선택 end

	// 챔피언 추천 start
	function recom_champ(lane, tag, right_champion){
		console.log('recom', lane, tag, right_champion)
		$.ajax({
			url: "/champion/champ-recom.json",
			type: 'POST',
			data: {lane: lane, tag: tag, right_champion: right_champion}
		}).done(res=>{
			let recom_divs = document.querySelectorAll('.recom_img div')
			let slice_index = 0;
			res.forEach(champ=>{
				let idx = res.indexOf(champ)
				let champ_name = champ.cm.champion_name
				let path = `/resources/img/champion_img/tiles/\${champ_name}_0.jpg`
				$(`#recom_champ_\${idx}`).attr('src', path);
				$(`#recom_champ_\${idx}`).attr('class', champ_name);
				let sliced = Array.from(recom_divs).slice(slice_index, slice_index+3);
				sliced[0].textContent = champ.name
				sliced[1].textContent = champ.cm.lane_kill_rate
				sliced[2].textContent = champ.cm.match_up_win_rate
				slice_index +=3;
			})
		}).fail(err=>{
			console.log(err)
		})
	}
	// 챔피언 추천 end

// left 챔피언 검색 start
	$('#champ_search').submit(function(event){		
		event.preventDefault();
		let formData = $(this).serialize();		
		
		$('#build_recom_box div').text($('#champion_name_input').val());
		$('#champion_name_input').val('');
		
		$.ajax({
			url: "/champion/search.json",
			type: 'POST',
			data: formData,
		}).done(res=>{
			if(res){
				selected_left_champion = res.champion_en_name  // champion_en_name
				console.log(selected_left_champion)
				$('#my_champion_img').attr('src', `/resources/img/champion_img/tiles/\${res.champion_en_name}_0.jpg`);
				$('#build_recom_left_val').attr('value', res);
			}else{
				selected_left_champion = null;
				$('#my_champion_img').attr('src', '/resources/img/profileicon/29.png');
				$('#build_recom_box div').text('챔피언 이름을 확인해주세요');
			}
			
		}).fail(err=>{
			console.log(err)
		})
		
	})
// left 챔피언 검색 end

// right 챔피언 검색 start
	$('#right_champ_search').submit(function(evt){
		event.preventDefault();
		let formData = $(this).serialize();		
		let right_champ_name = $('#right_champ_name_input').val()
		$('.search_box div').text(right_champ_name);
		$('#right_champ_name_input').val('');
		
		$.ajax({
			url: "/champion/search.json",
			type: 'POST',
			data: formData,
		}).done(res=>{
			if(res){
				selected_right_champion = res.champion_en_name  // champion_en_name
				console.log(selected_right_champion)
				$('#right_champion_img').attr('src', `/resources/img/champion_img/square/\${res.champion_img}`);
				document.getElementById('right_champion_img').className = res.champion_id

				if(selected_lane && selected_tag && selected_right_champion){
					recom_champ(selected_lane, selected_tag, selected_right_champion)
				}
			}else{
				selected_right_champion = null;
				$('#right_champion_img').attr('src', '/resources/img/profileicon/29.png')
				$('.search_box div').text('챔피언 이름을 확인해주세요');
			}
			
		}).fail(err=>{
			console.log(err)
		})
		
	})
// right 챔피언 검색 end

function right_champion_img_click(right_img){
	if(right_img.className){
		location.href = `/champion/info?champion=\${right_img.className}`		
	}
}

// champion-container
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
				champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_en_name + '\', \'' + champion.champion_img + '\', \'' +
			    champion.champion_kr_name + '\', \'' + champion.champion_id + '\')">';
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
				champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_en_name + '\', \'' + champion.champion_img + '\', \'' +
			    champion.champion_kr_name + '\', \'' + champion.champion_id + '\')">';
			championHTML += '</div>';
		});

		if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
			}

		$('.champions').html(championHTML);
	}).fail(err => {
		console.log(err);
	})
}

function selectChampion(champion_en_name, champion_img, champion_kr_name, champion_id){
	selected_right_champion = champion_en_name
	$('#right_champion_img').attr('src', `/resources/img/champion_img/square/\${champion_img}`);
	document.getElementById('right_champion_img').className = champion_id
	$('.search_box div').text(champion_kr_name);

	if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
	}

}
// 라인 선택 끝
</script>

<script>

  // 모달 닫기 버튼 클릭 이벤트 처리
  document.getElementById('closeModalBtn').addEventListener('click', function() {
    closeModal();
  });

  // 모달 열기 함수
  function openModal(build) {
    let modal = document.getElementById('build_modal');
    modal.style.display = 'block';
		console.log(build)
  }

  // 모달 닫기 함수
  function closeModal() {
    let modal = document.getElementById('build_modal');
    modal.style.display = 'none';
  }

// 빌드 추천 start
let champinfo

async function get_champinfo(champion_kr_name) {
  return new Promise((resolve, reject) => {
    $.ajax({
      url: '/champion/search.json',
      type: 'post',
      data: { champion_name: champion_kr_name }
    }).done(res => {
      console.log(res);
			champinfo = res;
			let src = "/resources/img/champion_img/square/" + champinfo.champion_img;
			document.getElementsByClassName('champion-img_')[0].src = src
			console.log(document.getElementsByClassName('champion-img_')[0])
			document.getElementsByClassName('champion_name')[0].innerHTML=champinfo.champion_kr_name;
			console.log(champinfo)
			let abil = document.getElementsByClassName('ability-img')
			let tool = document.getElementsByClassName('tooltip')

			abil[0].src = `/resources/img/passive/\${champinfo['champion_p_img']}`
			abil[1].src = `/resources/img/spell/\${champinfo['champion_q_img']}`
			abil[2].src = `/resources/img/spell/\${champinfo['champion_w_img']}`
			abil[3].src = `/resources/img/spell/\${champinfo['champion_e_img']}`
			abil[4].src = `/resources/img/spell/\${champinfo['champion_r_img']}`
			
			tool[0].innerHTML = champinfo['champion_p_desc'];
			tool[1].innerHTML = champinfo['champion_q_desc'];
			tool[2].innerHTML = champinfo['champion_w_desc'];
			tool[3].innerHTML = champinfo['champion_e_desc'];
			tool[4].innerHTML = champinfo['champion_r_desc'];

      resolve(res);
    }).fail(err => {
      console.log(err);
      reject(err);
    });
  });
}

async function recom_build() {
  if (selected_lane && selected_left_champion && selected_right_champion) {
    try {
      const res = await $.ajax({
        url: "/champion/build-recom.json",
        type: 'POST',
        data: {
          left_champion: selected_left_champion,
          right_champion: selected_right_champion,
          team_position: selected_lane
        },
      });

      await get_champinfo(selected_left_champion);
      openModal(res);
      
      let spell = res['spell_recom'];
      let item = res['item_recom'];
      let rune = res['rune_recom'];
      let skill = res['skill_recom'];

      console.log('spell', spell);
      console.log('item', item);
      console.log('rune', rune);
      console.log('skill', skill);

      spellSplit(spell);
      startItemSplit(item[0]['start_item'], item[0]['start_item_pick_rate'], item[0]['start_item_win_rate']);
      shoesSplit(item[0]['shoe_item'], item[0]['shoe_item_win_rate'], item[0]['shoe_item_pick_rate']);
      itmeBuildSplit(item);
      skillSplit(skill);
			rune_full_data(rune[0].main_keystone_id, rune[0].sub_keystone_id, 0, rune);
			  
			  let rune_select_box = document.getElementsByClassName('rune-select-box')[0]; 
			  rune_select_box.innerHTML = ''
			  for (let i = 0; i < rune.length; i++) {
				html = ''
				html += '<div class="rune-select-button">'
				html += '<div class="rune-select-main">'
				html += '<img src="/resources/img/'+rune[i].main_keystone_id_img+'" alt="">'
				html += '</div>'
				html += '<div class="rune-select-mainStyle rune-combination">'
				html += '<img src="/resources/img/'+rune[i].main_sub1_id_img+'" alt="">'
				html += '</div>'
				html += '<div class="rune-select-sub rune-combination">'
				html += '<img src="/resources/img/'+rune[i].sub_keystone_id_img+'" alt="">'
				html += '</div>'
				html += '<div class="rune-combination-desc">'
				html += '<div>승률 : '+rune[i].win_rate+'%</div>'
				html += '<div>픽률 : '+rune[i].pick_rate+'%</div>'
				html += '</div>'
				html += '</div>'
				rune_select_box.innerHTML += html
				}
			  
			  let rune_select_buttons = document.getElementsByClassName('rune-select-button');
			  for (let i = 0; i < rune_select_buttons.length; i++) {
				    rune_select_buttons[i].addEventListener('click', function() {
				        rune_full_data(rune[i].main_keystone_id, rune[i].sub_keystone_id, i, rune);
				    });
				}

    } catch (error) {
      console.error(error);
    }
  }
}
	// 빌드 추천 end

// 아이템 빌드 출력 
function itmeBuildSplit(champItemBuildData) {
	let item_build_stack = document.getElementsByClassName('item-build-stack')[0];
	item_build_stack.innerHTML = ''; // 기존 내용 초기화
	for (let i = 0; i < champItemBuildData.length; i++) {
		
		let itemBuild = champItemBuildData[i].item_build;
		let parts = itemBuild.split(',');
		
		let html = '<div class="item-build-box">';
		html += '<div class="item-build" style="display: flex; margin-left:50px;">';
		let ajaxCounter = 0;

		for (let item_id of parts) {
			$.ajax({
				method: 'get',
				url: '/champion/info/item',
				data: { item_id: item_id },
				async: false
			}).done(res => {
				for (let item of res) {
					html += '<div class="item">'
					html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
					html += '<div class="item-desc">'
					html += '<div>' + item.item_kr_name + '</div>'
					html += '<br>'
					html += '<div>' + item.item_ability + '</div>'
					html += '<br>'
					html += '<div>' + item.item_desc + '</div>'
					html += '<br>'
					html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
					html += '</div>'
					html += '</div>'
				
				}
				ajaxCounter++;
				
				if (ajaxCounter != parts.length) {
					html += '<div class="arrow-img">'
					html += '<img alt="" src="/resources/img/icon/arrow-icon-right.png">'
					html += '</div>'
				}
			
				if (ajaxCounter === parts.length) {
					html += '</div>'
					html += '<div class="rate-text-box" style="display: flex;">'
					html += '<div class="rate-text"><h4>승률</h4></div>'
					html += '<div class="rate-text"><h6>' + champItemBuildData[i].item_build_win_rate + '%</h6></div>'
					html += '<div class="rate-text"><h4>픽률</h4></div>'
					html += '<div class="rate-text"><h6>' + champItemBuildData[i].item_build_pick_rate + '%</h6></div>'
					html += '</div>'
					item_build_stack.innerHTML += html;
				}
			}).fail(err => {
				console.log(err);
			});
		}
	}

}
//--------------------------------------------------------------------------------------------------------------------------------

// 신발 출력 
function shoesSplit(champShoesData, win_rate, pick_rate) {
	let shoes_recom_box = document.getElementsByClassName('shoes-recom-box')[0];
	shoes_recom_box.innerHTML = ''; // 기존 내용 초기화
	
	let item_id = champShoesData

	$.ajax({
		method: 'get',
		url: '/champion/info/item',
		data: { item_id: item_id },
		async: false
	}).done(res => {
		for (let item of res) {
			let html = '<div class="shoes">';
			html += '<div class="item-img">'
			html += '<img style="margin-left: 88px;" alt="" src="/resources/img/item/' + item.item_img + '">'
			html += '<div class="item-desc">'
			html += '<div>' + item.item_kr_name + '</div>'
			html += '<br>'
			html += '<div>' + item.item_ability + '</div>'
			html += '<br>'
			html += '<div>' + item.item_desc + '</div>'
			html += '<br>'
			html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
			html += '</div>'
			html += '</div>'
			html += '<div style="display: flex;">'
			html += '<div class="rate-text"><h4>승률</h4></div>'
			html += '<div class="rate-text"><h6>' + win_rate + '%</h6></div>'
			html += '<div class="rate-text"><h4>픽률</h4></div>'
			html += '<div class="rate-text"><h6>' + pick_rate + '%</h6></div>'
			html += '</div>'
			shoes_recom_box.innerHTML += html;
		}

	}).fail(err => {
		console.log(err);
	});
}

// --------------------------------------------------------------------------------------------------------------------------------

// 시작 아이템 출력 
function startItemSplit(champStartItemData, win_rate, pick_rate) {
	let start_item_build_box = document.getElementsByClassName('start-item-build-box')[0];
	start_item_build_box.innerHTML = ''; // 기존 내용 초기화

	let startItemBuild = champStartItemData;
	let parts = startItemBuild.split(',');
	
	let html = '<div class="start-item">';
	let ajaxCounter = 0;

	for (let item_id of parts) {
		$.ajax({
			method: 'get',
			url: '/champion/info/item',
			data: { item_id: item_id },
			async: false
		}).done(res => {
			for (let item of res) {
				html += '<div class="item-img">'
				html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
				html += '<div class="item-desc">'
				html += '<div>' + item.item_kr_name + '</div>'
				html += '<br>'
				html += '<div>' + item.item_ability + '</div>'
				html += '<br>'
				html += '<div>' + item.item_desc + '</div>'
				html += '<br>'
				html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
				html += '</div>'
				html += '</div>'
			}

			ajaxCounter++;
			if (ajaxCounter === parts.length) {
				html += '</div>'
				html += '<div class="start-item-rate" style="display: flex;">'
				html += '<div class="rate-text"><h4>승률</h4></div>'
				html += '<div class="rate-text"><h6>' + win_rate + '%</h6></div>'
				html += '<div class="rate-text"><h4>픽률</h4></div>'
				html += '<div class="rate-text"><h6>' + pick_rate + '%</h6></div>'
				start_item_build_box.innerHTML += html;
			}
		}).fail(err => {
			console.log(err);
		});
	}
	
}
//--------------------------------------------------------------------------------------------------------------------------------

// 스킬 빌드 출력 
function skillSplit(champSkillBuildData) {
	for (var i = 0; i < champSkillBuildData.length; i++) {
	
	let skillSequence = champSkillBuildData[i].skill_build
	let parts = skillSequence.split(','); 
	
	let skillAllSequnece = champSkillBuildData[i].skill_tree
	let skillParts = skillAllSequnece.split(','); 
	
	let skill_build_sequence_box = document.getElementsByClassName('skill-build-sequence-box')[i]; 
	let skill_bulid_all_box = document.getElementsByClassName('skill-bulid-all-box')[i];
	skill_build_sequence_box.innerHTML = '';
	skill_bulid_all_box.innerHTML = '';
	
	arrowHtml = ''
	arrowHtml += '<div class="arrow-img">'
	arrowHtml += '<img alt="" src="/resources/img/icon/arrow-icon-right.png">'
	arrowHtml += '</div>'
			
	qHtml = ''
	qHtml += '<div class="skill-build-sequence">'
	qHtml += `<img alt="" src="/resources/img/spell/\${champinfo.champion_q_img}" class="ability-img">`
	qHtml += '<div class="skill-key-icon">'
	qHtml += '<h6>Q</h6>'
	qHtml += '</div>'
	qHtml += '<div class="squence-tooltip">'
	qHtml += `<div>\${champinfo.champion_q_name}</div>`
	qHtml += '<br>'
	qHtml += `<div>\${champinfo.champion_q_desc}</div>`
	qHtml += '</div>'
	qHtml += '<div class="skill-build-sequence">'
	qHtml += '</div>'
	
 	wHtml = ''
 	wHtml += '<div class="skill-build-sequence">'
 	wHtml += `<img alt="" src="/resources/img/spell/\${champinfo.champion_w_img}" class="ability-img">`
 	wHtml += '<div class="skill-key-icon">'
 	wHtml += '<h6>W</h6>'
 	wHtml += '</div>'
 	wHtml += '<div class="squence-tooltip">'
 	wHtml += `<div>\${champinfo.champion_w_name}</div>`
 	wHtml += '<br>'
 	wHtml += `<div>\${champinfo.champion_w_desc}</div>`
 	wHtml += '</div>'
 	wHtml += '<div class="skill-build-sequence">'
 	wHtml += '</div>'

	eHtml = ''
	eHtml += '<div class="skill-build-sequence">'
	eHtml += `<img alt="" src="/resources/img/spell/\${champinfo.champion_e_img}" class="ability-img">`
	eHtml += '<div class="skill-key-icon">'
	eHtml += '<h6>E</h6>'
	eHtml += '</div>'
	eHtml += '<div class="squence-tooltip">'
	eHtml += `<div>\${champinfo.champion_e_name}</div>`
	eHtml += '<br>'
	eHtml += `<div>\${champinfo.champion_e_desc}</div>`
	eHtml += '</div>'
	eHtml += '<div class="skill-build-sequence">'
	eHtml += '</div>'													
	
	rateHtlm = ''
	rateHtlm += '<div class="skill-build-rate">'
	rateHtlm += '<div class="rate-text"><h4>승률</h4></div>'
	rateHtlm += '<div class="rate-text"><h6>'+champSkillBuildData[i].skill_build_win_rate+'%</h6></div>'
	rateHtlm += '<div class="rate-text"><h4>픽률</h4></div>'
	rateHtlm += '<div class="rate-text"><h6>'+champSkillBuildData[i].skill_build_pick_rate+'%</h6></div>'
	rateHtlm += '</div>'
	
	qBoxHtml = ''
	qBoxHtml += '<div class="q-skill">'
	qBoxHtml += '<h3>Q</h3>'
	qBoxHtml += '</div>'
	
	wBoxHtml = ''
	wBoxHtml += '<div class="w-skill">'
	wBoxHtml += '<h3>W</h3>'
	wBoxHtml += '</div>'
	
	eBoxHtml = ''
	eBoxHtml += '<div class="e-skill">'
	eBoxHtml += '<h3>E</h3>'
	eBoxHtml += '</div>'
	
	rBoxHtml = ''
	rBoxHtml += '<div class="r-skill">'
	rBoxHtml += '<h3>R</h3>'
	rBoxHtml += '</div>'
	
	let count = 0;
	for (let skill of parts) {
		if (parseInt(skill) == 1) {
			skill_build_sequence_box.innerHTML += qHtml;
		} else if (parseInt(skill) == 2) {
			skill_build_sequence_box.innerHTML += wHtml;
		} else if (parseInt(skill) == 3) {
			skill_build_sequence_box.innerHTML += eHtml;
		}
		count++;
		if (count == 3) {
			break;
		}
		skill_build_sequence_box.innerHTML += arrowHtml;
	}
	skill_build_sequence_box.innerHTML += rateHtlm;
	
	for (let skill of skillParts) {
		if(parseInt(skill) == 1){
			skill_bulid_all_box.innerHTML += qBoxHtml;
		}else if(parseInt(skill) == 2){
			skill_bulid_all_box.innerHTML += wBoxHtml;
		}else if(parseInt(skill) == 3){
			skill_bulid_all_box.innerHTML += eBoxHtml;
		}else if(parseInt(skill) == 4){
			skill_bulid_all_box.innerHTML += rBoxHtml;
		}
	}
	}
}
//--------------------------------------------------------------------------------------------------------------------------------

// 스펠 출력 
function spellSplit(champSpellData) {
	let spell_box = document.getElementsByClassName('spell-box')[0]; 
	spell_box.innerHTML = ''
	for (let i = 0; i < champSpellData.length; i++) {
		let win_rate = champSpellData[i].win_rate
		let pick_rate = champSpellData[i].pick_rate
		let first_spell = champSpellData[i]['d_spell'];
		let second_spell = champSpellData[i]['f_spell'];
		spellHtml(first_spell, second_spell, win_rate, pick_rate);
	}
}

function spellHtml(first_spell,second_spell,win_rate,pick_rate) {
	$.ajax({
	    method: 'get',
	    url: '/champion/info/spell',
	    data: { first_spell : first_spell, second_spell : second_spell },
	  }).done(res => {
		let spell_box = document.getElementsByClassName('spell-box')[0]; 
		html = ''
		html += '<div class="spells">'
		html += '<div class="spell">'
		html += '<img alt="" src="/resources/img/spell/'+res[0].spell_img+'">'
		html += '<div class="spell-desc">'
		html += '<div>'+res[0].spell_kr_name+'</div>'
		html += '<br>'
		html += '<div>'+res[0].spell_desc+'</div>'
		html += '<br>'
		html += '<div>쿹타임 '+res[0].spell_cooldown+'</div>'
		html += '</div>'
		html += '</div>'
		html += '<div class="spell" style="margin-right: 30px;">'
		html += '<img alt="" src="/resources/img/spell/'+res[1].spell_img+'">'
		html += '<div class="spell-desc">'
		html += '<div>'+res[1].spell_kr_name+'</div>'
		html += '<br>'
		html += '<div>'+res[1].spell_desc+'</div>'
		html += '<br>'
		html += '<div>쿹타임 '+res[1].spell_cooldown+'</div>'
		html += '</div>'
		html += '</div>'
		html += '<div class="spell-text"><h6>승률</h6></div>'
		html += '<div><h4>'+win_rate+'%</h4></div>'
		html += '<div class="spell-text"><h6>픽률</h6></div>'
		html += '<div><h4>'+pick_rate+'%</h4></div>'
		html += '</div>'
		spell_box.innerHTML += html
	  }).fail(err => {
	    console.log(err);
	  });
}
//--------------------------------------------------------------------------------------------------------------------------------

// 룬 빌드 출력 
function rune_full_data(main, sub, i, champRuneData) {
	let main_key = '';
	switch (main) {
	  case 8200:
		  main_key = 'Sorcery';
	    break;
	  case 8400:
		  main_key = 'Resolve';
	    break;
	  case 8000:
		  main_key = 'Precision';
	    break;
	  case 8300:
		  main_key = 'Inspiration';
	    break;
	  case 8100:
		  main_key = 'Domination';
	    break;
	  default:
	    break;
	} 
	let sub_key = '';
	switch (sub) {
	  case 8200:
		  sub_key = 'Sorcery';
	    break;
	  case 8400:
		  sub_key = 'Resolve';
	    break;
	  case 8000:
		  sub_key = 'Precision';
	    break;
	  case 8300:
		  sub_key = 'Inspiration';
	    break;
	  case 8100:
		  sub_key = 'Domination';
	    break;
	  default:
	    break;
	}
	console.log(main_key, sub_key)
	$.ajax({
	  method: 'get',
	  url: '/champion/info/rune/main',
	  data: { main_key: main_key },
	  async: false
	}).done(res => {
		console.log(res)
		let main_rune_top = document.getElementsByClassName('main-rune-top')[0];
		let main_rune_first = document.getElementsByClassName('main-rune-first')[0];
		let main_rune_second = document.getElementsByClassName('main-rune-second')[0];
		let main_rune_third = document.getElementsByClassName('main-rune-third')[0];
		let main_rune_fourth = document.getElementsByClassName('main-rune-fourth')[0];
		main_rune_top.innerHTML = ''
		main_rune_first.innerHTML = ''
		main_rune_second.innerHTML = ''
		main_rune_third.innerHTML = ''
		main_rune_fourth.innerHTML = ''
		for (let i = 0; i < res.length; i++) {
			rune_num = res[i].rune_num % res[0].rune_num
			if(rune_num == 0){
				main_rune_top.innerHTML += '<img src="/resources/img/'+res[i].rune_img+'" alt="">'
			}else if(rune_num > 0 && rune_num < 100){
				html = ''
				html += '<div class="rune">'
				html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
				html += '<div class="rune-desc">'
				html += '<div>'+res[i].rune_kr_name+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_desc+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_long_desc+'</div>'
				html += '</div>'
				html += '</div>'
				main_rune_first.innerHTML += html
			}else if(rune_num > 100 && rune_num < 200){
				html = ''
				html += '<div class="rune">'
				html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
				html += '<div class="rune-desc">'
				html += '<div>'+res[i].rune_kr_name+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_desc+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_long_desc+'</div>'
				html += '</div>'
				html += '</div>'
				main_rune_second.innerHTML += html
			}else if(rune_num > 200 && rune_num < 300){
				html = ''
				html += '<div class="rune">'
				html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
				html += '<div class="rune-desc">'
				html += '<div>'+res[i].rune_kr_name+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_desc+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_long_desc+'</div>'
				html += '</div>'
				html += '</div>'
				main_rune_third.innerHTML += html
			}else if(rune_num > 300){
				html = ''
				html += '<div class="rune">'
				html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
				html += '<div class="rune-desc">'
				html += '<div>'+res[i].rune_kr_name+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_desc+'</div>'
				html += '<br>'
				html += '<div>'+res[i].rune_long_desc+'</div>'
				html += '</div>'
				html += '</div>'
				main_rune_fourth.innerHTML += html
			}
		}
	}).fail(err => {
	  console.log(err);
	});
	
	 $.ajax({
		  method: 'get',
		  url: '/champion/info/rune/sub',
		  data: { sub_key : sub_key },
		  async: false
		}).done(res => {
			console.log(res)
			let sub_rune_top = document.getElementsByClassName('sub-rune-top')[0];
			let sub_rune_first = document.getElementsByClassName('sub-rune-first')[0];
			let sub_rune_second = document.getElementsByClassName('sub-rune-second')[0];
			let sub_rune_third = document.getElementsByClassName('sub-rune-third')[0];
			sub_rune_top.innerHTML = ''
			sub_rune_first.innerHTML = ''
			sub_rune_second.innerHTML = ''
			sub_rune_third.innerHTML = ''
			for (let i = 0; i < res.length; i++) {
				rune_num = res[i].rune_num % res[0].rune_num
				if(rune_num == 0){
					sub_rune_top.innerHTML += '<img src="/resources/img/'+res[i].rune_img+'" alt="">'
				}else if(rune_num > 100 && rune_num < 200){
					html = ''
					html += '<div class="rune">'
					html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
					html += '<div class="rune-desc">'
					html += '<div>'+res[i].rune_kr_name+'</div>'
					html += '<br>'
					html += '<div>'+res[i].rune_desc+'</div>'
					html += '<br>'
					html += '<div>'+res[i].rune_long_desc+'</div>'
					html += '</div>'
					html += '</div>'
					sub_rune_first.innerHTML += html
				}else if(rune_num > 200 && rune_num < 300){
					html = ''
					html += '<div class="rune">'
					html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
					html += '<div class="rune-desc">'
					html += '<div>'+res[i].rune_kr_name+'</div>'
					html += '<br>'
					html += '<div>'+res[i].rune_desc+'</div>'
					html += '<br>'
					html += '<div>'+res[i].rune_long_desc+'</div>'
					html += '</div>'
					html += '</div>'
					sub_rune_second.innerHTML += html
				}else if(rune_num > 300){
					html = ''
					html += '<div class="rune">'
					html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
					html += '<div class="rune-desc">'
					html += '<div>'+res[i].rune_kr_name+'</div>'
					html += '<br>'
					html += '<div>'+res[i].rune_desc+'</div>'
					html += '<br>'
					html += '<div>'+res[i].rune_long_desc+'</div>'
					html += '</div>'
					html += '</div>'
					sub_rune_third.innerHTML += html
				}
			}
			setTimeout(() => {
				main_SUB1_ID = champRuneData[i].main_sub1_id;
			  main_SUB2_ID = champRuneData[i].main_sub2_id;
			  main_SUB3_ID = champRuneData[i].main_sub3_id;
			  main_SUB4_ID = champRuneData[i].main_sub4_id;
			  sub_SUB1_ID = champRuneData[i].sub_sub1_id;
			  sub_SUB2_ID = champRuneData[i].sub_sub2_id;
				fragment1_ID = champRuneData[i].fragment1_id;
				fragment2_ID = champRuneData[i].fragment2_id;
				fragment3_ID = champRuneData[i].fragment3_id;

				console.log(main_SUB1_ID, champRuneData[i])
			  document.getElementById(main_SUB1_ID).style.filter = 'none';
			  document.getElementById(main_SUB2_ID).style.filter = 'none';
			  document.getElementById(main_SUB3_ID).style.filter = 'none';
			  document.getElementById(main_SUB4_ID).style.filter = 'none';
			  document.getElementById(sub_SUB1_ID).style.filter = 'none';
			  document.getElementById(sub_SUB2_ID).style.filter = 'none';
			  document.getElementById(main_SUB1_ID).style.opacity = '1';
			  document.getElementById(main_SUB2_ID).style.opacity = '1';
			  document.getElementById(main_SUB3_ID).style.opacity = '1';
			  document.getElementById(main_SUB4_ID).style.opacity = '1';
			  document.getElementById(sub_SUB1_ID).style.opacity = '1';
			  document.getElementById(sub_SUB2_ID).style.opacity = '1';
			  let elements = document.getElementsByClassName('fragment-img');

				for (let i = 0; i < elements.length; i++) {
				    elements[i].style.filter = "grayscale(100%)";
				    elements[i].style.filter = "0.5";
				}
				document.getElementById('first-fragment-'+fragment3_ID).style.filter = 'none'; 
				document.getElementById('second-fragment-'+fragment2_ID).style.filter = 'none'; 
				document.getElementById('third-fragment-'+fragment1_ID).style.filter = 'none'; 
				document.getElementById('first-fragment-'+fragment3_ID).style.opacity = "1";
				document.getElementById('second-fragment-'+fragment2_ID).style.opacity = "1"; 
				document.getElementById('third-fragment-'+fragment1_ID).style.opacity = "1"; 
			    
			}, 100);  // 0.1초 후에 코드 실행
		}).fail(err => {
		  console.log(err);
		}); 
}
//-------------------------------------------------------------------------------------------------------------------------------- 
</script>

</body>

</html>