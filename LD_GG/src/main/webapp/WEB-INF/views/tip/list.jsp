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
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

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
.tip-list-container{
	margin-top: 90px;
	width: 68%;
	height: 80vh;
	background-color: #fff;
	box-sizing: border-box;
}
/* 그리드 헤더 */
.ui-jqgrid .ui-jqgrid-htable th div {
  background-color: #f2f2f2;
  background-image: linear-gradient(to bottom, #f2f2f2, #d9d9d9);
  border: none;
  padding: 10px;
}

/* 그리드 셀 */
.ui-jqgrid tr.jqgrow td {
  padding: 8px;
}

/* 그리드 셀 내용 */
.ui-jqgrid tr.jqgrow td {
  color: #333;
  font-size: 14px;
}
/* 검색 버튼 */
#search {
  background-color: #f2f2f2;
  background-image: linear-gradient(to bottom, #f2f2f2, #d9d9d9);
  border: none;
  color: #333;
  padding: 8px;
  font-size: 14px;
  cursor: pointer;
}

/* 글 작성 버튼 */
a[href="/tip/write"] {
  background-color: #f2f2f2;
  background-image: linear-gradient(to bottom, #f2f2f2, #d9d9d9);
  border: none;
  color: #333;
  padding: 8px;
  font-size: 14px;
  text-decoration: none;
}
.ui-pg-table .ui-pg-button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 8px 16px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    margin-left: 10px;
}

.ui-pg-table .ui-pg-button:hover {
    background-color: #3e8e41;
}
.ui-jqgrid .ui-pg-table .ui-pg-button {
  width: 40px;
  height: 40px;
  line-height: 40px;
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
		<div class="tip-list-container">
			<h1>공략 게시판</h1>
				<div class="row search-container">
					<div class="col-md-6">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="제목 검색" id="keyword">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" id="search">검색</button>
							</span>
						</div>
					</div>
					<div class="col-md-6 text-right">
						<a href="/tip/write" class="btn btn-primary">글 작성</a>
					</div>
				</div>
				<div id="grid-wrapper">
					<table id="grid"></table>
					<div id="pager"></div>
				</div>
		 </div>
	</div>
</body>
<script type="text/javascript">
 $("#grid").jqGrid({
	url : "/tip/list.json",
	datatype : "json",
	colNames : ['번호', '제목', '조회수', '추천 수', '날짜'],
	colModel:[
		{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
		{name:'t_b_title', index:'t_b_num', width:90, align: "center", sortable : false},
		{name:'t_b_views', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_recom', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_date', index:'t_b_num', width:90, align: "center"}
		],
	loadtext : '로딩중..',
	sortable : true,
	loadonce : true,
	multiselect: false,
	pager:'#pager',
	rowNum: 10,
	sortname: 'date',
	sortorder: 'desc',
	width: 1000,
	height: 500,
    pgbuttons: true,  // 이전/다음 버튼 표시 여부
    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
    viewrecords: false, // 레코드 수 표시 여부
    recordpos: 'left', // 레코드 수 위치
    pagerpos: 'center', // 페이징 버튼 위치
    pginput: false,     // 페이지 번호 입력칸 표시 여부
	onSelectRow: function(rowid){
		location.href = `/tip/details?t_b_num=\${rowid}`
	}
});

document.getElementById("search").addEventListener("click", function() {
let keyword = document.getElementById('keyword').value;
	
	console.log(keyword);
	
	$("#grid").jqGrid('setGridParam',{
		url : "/tip/search.json",
		datatype : "json",
		postData: {keyword: keyword},
		colNames : ['번호', '제목', '조회수', '추천 수', '날짜'],
		colModel:[
			{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
			{name:'t_b_title', index:'t_b_num', width:90, align: "center"},
			{name:'t_b_views', index:'t_b_num', width:90, align: "center"},
			{name:'t_b_recom', index:'t_b_num', width:90, align: "center"},
			{name:'t_b_date', index:'t_b_num', width:90, align: "center"}
			],
			loadtext : '로딩중..',
			sortable : true,
			loadonce : true,
			multiselect: false,
			pager:'#pager',
			rowNum: 10,
			sortname: 'date',
			sortorder: 'desc',
			width: 1000,
			height: 500,
		    pgbuttons: true,  // 이전/다음 버튼 표시 여부
		    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
		    viewrecords: false, // 레코드 수 표시 여부
		    recordpos: 'left', // 레코드 수 위치
		    pagerpos: 'center', // 페이징 버튼 위치
		    pginput: false, 
		onSelectRow: function(rowid){
			location.href = `/tip/details?t_b_num=\${rowid}`
		}
	}).trigger("reloadGrid");
})

function championList() {
    $.ajax({
        method: 'get',
        url: '/tip/champion/list'
    }).done(res => {
        var championHTML = '';
        res.forEach(function(champion) {
        	championHTML += '<div class="champion">';
        	championHTML += '<img alt="' + champion.champion_kr_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/' + champion.champion_img + '"/>';
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
        	championHTML += '<img alt="' + champion.champion_kr_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/' + champion.champion_img + '"/>';
        	championHTML += '</div>';
        });

        $('.champions').html(championHTML);
	}).fail(err=>{
		console.log(err);
	})
} 

</script>
</html>