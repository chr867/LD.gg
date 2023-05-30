<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>mate/list.jsp</title>
<!--BOOTSTRAP CSS-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">

<!--BOOTSTRAP JavaScript-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
</script>

<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!-- jqGrid JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>


</head>

<style type="text/css">
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
 font-family: 'NanumSquareNeo-Variable';
}

body {
      image-rendering: -webkit-optimize-contrast; /* chrome */
      background-image: url("/resources/img/mate/back.png");
      background-size: 100%;
      min-width: 1312px;
      overflow-x: hidden;
   
    }
.container {
   margin-top:60px;
}

/*그리드 제목 */
.ui-jqgrid .ui-jqgrid-htable .ui-jqgrid-labels th div {
    overflow: hidden;
    position: relative;
    height: auto;
    margin: 2px 2px;
	font-size: 30px;
	font-weight: bold;
	color: #6f8c9b;
}
#grid-wrapper {
  width: 1310px;
  display: flex;
  flex-direction: column;
  background-image: url("/resources/img/mate/matetable.png");
  background-repeat: no-repeat;
  justify-content: center;
  align-items: center;
  height:1085px; 

}
#grid-wrapper img{
margin-top:40px
}
/* 그리드 헤더 */
.ui-jqgrid .ui-jqgrid-htable th div {
}

/* 그리드 셀 내용 */
.ui-jqgrid .ui-jqgrid-bdiv tr.ui-row-ltr>td{
	border:none;
	padding: 22px;
	color: #333;
	font-size: 20px;
}
/* 검색창 */
#input-group{
  background-image: url("/resources/img/mate/sc.png");
  background-position: center;  
  width: 546px; /* 버튼 이미지의 너비 */
  display: flex;

}
.sc-button {
  height: 64px;
  width:71px;
  background-position: center;
  display: inline-block;
  padding: 25px 15px;
  margin: 33px 0px 25px 8px;
  background-color: transparent;
  color: #333;
  text-decoration: none;

  cursor: pointer;
  font-size: 14px;
}

.sc-button:hover {
  background-image: url("/resources/img/mate/scbt.png");
}
.wt-button {
  height: 64px;
  width:94px;
  display: inline-block;
  padding: 25px 15px;
  margin: 33px 0px 25px 12px;
  background-color: transparent;
  color: #333;
  text-decoration: none;
  cursor: pointer;
  font-size: 14px;
}

.wt-button:hover {
  background-image: url("/resources/img/mate/writebt.png");
  
}
#keyword {
	
	width: 310px;
	height: 70px;
    text-align: start;
    cursor: text;
    background: none;
    margin: 30px 0px 25px 30px;

}
input:focus {outline: 2px solid #d50000;} /* outline 테두리 속성 수정 */
input:focus {outline: none;} /* outline 테두리 없애기 */
#keyword::placeholder {
  color: #0099ff; /* 원하는 색상으로 변경 */
  font-size: 25px;
}

/* 푸터 그리드 페이지 버튼  */
.ui-pg-table .ui-pg-button {
	background-color: #6699ff;
	border: none;
	color: white;
	padding: 8px 16px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	margin-left: 10px;
}
#first_pager,#last_pager {
	background-color: #99ccff;
	border: none;
	color: white;
	padding: 8px 16px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
}

.ui-pg-table .ui-pg-button:hover {
	background-color: #cccccc;
}
#last_pager:hover, #first_pager:hover{
	background-color: #cccccc;
}

.ui-jqgrid .ui-pg-table .ui-pg-button,#last_pager:hover, #first_pager {
	width: 20px;
	height: 20px;
	line-height: 40px;
} 

/*북마크 모달*/
.bookmark-modal {
  position: fixed;
  z-index: 200;
  width: 200px; /* 가로 크기 */
  height: auto; /* 높이 */
  background-image: url("/resources/img/mate/bookmarkModalBack.png");
  background-repeat: no-repeat;
  background-position: top;
  background-size:contain;
  opacity: 0;
  transition: opacity 1s;
  margin-left:-50px;
  margin-top:4 px;
}
#bookmark-flex{
  display:flex;
  justify-content: center;
  align-items: center;
}

.bookmark-icon-box:hover + .bookmark-modal {
  display: block;
  opacity: 1; 
}

/* 북마크 버튼 */
.bookmarkBt {
  width: 50px; 
  height: 50px;
  text-decoration: none;
  padding: 0.5rem 1rem;
  cursor: pointer;
  background: none;
  border:none;
 
}
#bookmarkicon {
	width: 40px; /* 버튼 이미지의 너비 */
	height: 40px; /* 버튼 이미지의 높이 */
}
</style>
<body>
	<div id="session-summoner-name" style="display: none">${sessionScope.lol_account}</div>
	<div id="session-user-type" style="display: none">${sessionScope.user_type}</div>
	<div id="session-summoner-name" style="display: none">${sessionScope.summoner_name}</div>
	<div id="session-summoner-icon" style="display: none">${sessionScope.summoner_icon}</div>
	<div id="error-check" style="display: none">${check}</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 사이드바 -->
<div class="sidebar" style="margin-top: -60px;">
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
	<div class="header-container" style="z-index: 2;">
		<header >

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
<!-- 북마크 영역시작 -->
				<div class="bookmark-icon-box" id="bookmark">
					<img src="/resources/img/icon/free-icon-bookmark-white-25667.png" onclick="insertBookmark()" alt="이미지 버튼" id="bookmarkicon" class="bookmark-icon-img">
					<div class="bookmark-modal" id="bookmark-modal">
						<div id ="bookmark-flex">
							<table id="bookmark-list">
					
							</table>
						</div>
					</div>
				</div>
<!-- 북마크 영역끝 -->
	
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
	
	

	<div class="container">
		<div class="bookmark"></div>
		<div id="row search-container">
			<div id="col-md-6">
				<div id="input-group">
					<div>
						<input type="text"placeholder="제목 검색" id="keyword" style="border:0 solid black"> 
					</div>
					<div>
						<a class="sc-button" id="search"></a>
					</div>
					<div>
						<a href="/mate/write" class="wt-button" id="write"></a>
					</div>
				</div>
			</div>
		</div>
		<div id="grid-wrapper">
			<table id="grid"></table>
			<div id="pager"></div>
		<img id="logo" src="/resources/img/logo/LDGG.png" width="110" height="110" alt="ldgg">
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
</body>
<script type="text/javascript">
document.querySelector('.bookmark-icon-box').addEventListener('mouseover', function() {
	  var modal = document.getElementById('bookmark-modal');
	  modal.style.opacity = '1';
	  modal.style.display = 'block';

	  setTimeout(function() {
	    modal.style.opacity = '0';
	    setTimeout(function() {
	      modal.style.display = 'none';
	    }, 2000); // 1초 후에 모달 숨기기
	  }, 3000); // 3초 후에 투명도 감소 시작
	});

	$("#grid").jqGrid({
		url : "/mate/list.json",
		datatype : "json",
		colNames : [ '번호', '제목', '소환사명', '날짜' ],
		colModel : [ {
			name : 'mate_id',
			index : 'mate_id',
			width : 100,
			align : "center",
			key : true

		}, {
			name : 'mate_title',
			index : 'mate_id',
			width : 300,
			align : "center",
			sortable : false
		}, {
			name : 'lol_account',
			index : 'mate_id',
			width : 300,
			align : "center"
		}, {
			name : 'mate_date',
			index : 'mate_id',
			width : 300,
			align : "center"
		}

		],
		loadtext : '로딩중..',
		sortable : true,
		loadonce : true,
		multiselect : false,
		pager : '#pager',
		rowNum : 10,
		sortname : 'date',
		sortorder : 'desc',
		autowidth:true,    // jQgrid width 자동100% 채워지게
		shrinkToFit:false,  // width를 자동설정 해주는 기능
		width : 1300,
		height : 735,
		pgbuttons : true, // 이전/다음 버튼 표시 여부
		pgtext: "페이지 {1}", // 페이지 번호 텍스트 설정
		viewrecords : false, // 레코드 수 표시 여부
		recordpos : 'left', // 레코드 수 위치
		pagerpos : 'center', // 페이징 버튼 위치
		pginput : false, // 페이지 번호 입력칸 표시 여부
		onSelectRow : function(rowid) {
			location.href = `/mate/details?mate_id=\${rowid}`
		}
	});

document.getElementById("search").addEventListener("click", function() {
	let keyword = document.getElementById('keyword').value;

	console.log(keyword);
	$("#grid").jqGrid('setGridParam',{
		url : "/mate/search.json",
		datatype : "json",
		postData: {keyword: keyword},
		colNames : [ '번호', '제목', '소환사명', '날짜' ],
		colModel:[
			{name:'mate_id', index:'mate_id', width:100, align: "center", key:true},
			{name:'mate_title', index:'mate_id', width:300, align: "center"},
			{name:'lol_account', index:'mate_id', width:300, align: "center"},
			{name:'mate_date', index:'mate_id', width:300, align: "center"},
			],
			loadtext : '로딩중..',
			sortable : true,
			loadonce : true,
			multiselect: false,
			pager:'#pager',
			rowNum: 10,
			sortname: 'date',
			sortorder: 'desc',
			width: 1300,
			height: 735,
		    pgbuttons: true,  // 이전/다음 버튼 표시 여부
		    pgtext: "페이지 {1}",    // 페이징 정보(1 - 10 / 100) 표시 여부
		    viewrecords: false, // 레코드 수 표시 여부
		    recordpos: 'left', // 레코드 수 위치
		    pagerpos: 'center', // 페이징 버튼 위치
		    pginput: false, 
		onSelectRow: function(rowid){
			location.href = `/mate/details?mate_id=\${rowid}`
		}
	}).trigger("reloadGrid");
});
function insertBookmark(){
	console.log("click bookmark");
     let button = document.getElementById("bookmarkicon");
     let currentSrc = button.getAttribute("src");
     val=0;
     if (currentSrc === "/resources/img/icon/free-icon-bookmark-white-25667.png") {
    	 button.setAttribute("src", "/resources/img/icon/free-icon-bookmark-white-256672.png");
    	 bookmark_val=1;
   		} else {
         button.setAttribute("src", "/resources/img/icon/free-icon-bookmark-white-25667.png");
         bookmark_val=0;
            }
    	 modifybookmark(bookmark_val);
}	
function modifybookmark(bookmark_val) {
	email='${sessionScope.email}';
	let bookmark_page = window.location.pathname;
	console.log(bookmark_page+"현화면 유알엘");
	console.log(email+"현화면 email");
	console.log(bookmark_val+"현화면 bookmark_val");
	$.ajax({
        method: 'post',
        url: '/mate/bookmark/modify',
        data: {email:email,bookmark_page:bookmark_page,bookmark_val:bookmark_val}
    }).done(res => {
    	if (res){
    		console.log(res);
    		//alert("북마크 성공");
    		loadBookmark();
    	}else{
    		console.log(res)
    		//alert("북마크 성공")
    		
    		}
		}).fail(err=>{
			console.log(err);
		});
}
function loadBookmark() {
	let email='${sessionScope.email}';
	let now_page = window.location.pathname;
        	console.log("now_page"+now_page)
    $.ajax({
        method: 'post',
        url: '/mate/bookmark',
        data: {email:email},
    }).done(res => {
    	console.log("res북마크"+res);
    	console.log(res);
    	let bookmarkList = "";
        	let my_page = '';
        	let tip_page = '';
        	let mate_page = '';
        	console.log("res.my_page"+res.my_page)
        	console.log("res.tip_page"+res.tip_page)
        	console.log("res.mate_page"+res.mate_page)
        	
        	  if (now_page === '/member/myPage') {
        		  if(res.tip_page ===1){
    				tip_page = '<td><button class="bookmarkBt" id="tip-b-bt " onclick="goUrl(\'/tip/\')" style="background-image: url(\'/resources/img/mate/tip.png\'); background-repeat: no-repeat; background-position: top; background-size: contain;"></button></td>';
        		  }if(res.mate_page === 1){
     			 	mate_page = '<td><button class="bookmarkBt" id="mate-b-bt" onclick="goUrl(\'/mate/\')" style="background-image: url(\'/resources/img/mate/mate.png\'); background-repeat: no-repeat; background-position: top; background-size: contain;"></button></td>';  
        		  }
        	  }
        	  else if (now_page === '/tip/') {
        		  if(res.my_page ===1){
        			  my_page = '<td><button class="bookmarkBt" id="my-b-bt" onclick="goUrl(\'/summoner/testDashBoard\')" style="background-image: url(\'/resources/img/mate/my.png\'); background-repeat: no-repeat; background-position: top; background-size: contain;"></button></td>';
        		  }if(res.mate_page === 1){
     			 	mate_page = '<td><button class="bookmarkBt" id="mate-b-bt" onclick="goUrl(\'/mate/\')" style="background-image: url(\'/resources/img/mate/mate.png\'); background-repeat: no-repeat; background-position: top; background-size: contain;"></button></td>';  
        		  }
        	  }
        	  else if (now_page === '/mate/') {
        		  if(res.my_page ===1){
        			  my_page = '<td><button class="bookmarkBt" id="my-b-bt" onclick="goUrl(\'/summoner/testDashBoard\')" style="background-image: url(\'/resources/img/mate/my.png\'); background-repeat: no-repeat; background-position: top; background-size: contain;"></button></td>';
        		  }if(res.tip_page === 1){
    				tip_page = '<td><button class="bookmarkBt" id="tip-b-bt " onclick="goUrl(\'/tip/\')" style="background-image: url(\'/resources/img/mate/tip.png\'); background-repeat: no-repeat; background-position: top; background-size: contain;"></button></td>';
        		  }
        	  }
        	bookmarkList += '<tr>'
        	bookmarkList += my_page
        	bookmarkList += tip_page
        	bookmarkList += mate_page
        	bookmarkList += '</tr>'
        	checkBookmark(now_page,res);
        console.log(bookmarkList);
        $('#bookmark-list').html(bookmarkList)
    }).fail(err => {
        console.log(err);
    }); 
    }
    function goUrl(url) {
    	location.href = url;
    }
    function checkBookmark(now_page,res) {
        let button = document.getElementById("bookmarkicon");
        
        if (now_page === '/member/myPage' && res.my_page === 1) {
            button.setAttribute("src", "/resources/img/icon/free-icon-bookmark-white-256672.png");
        } else if (now_page === '/tip/' && res.tip_page === 1) {
            button.setAttribute("src", "/resources/img/icon/free-icon-bookmark-white-256672.png");
        } else if (now_page === '/mate/' && res.mate_page === 1) {
            button.setAttribute("src", "/resources/img/icon/free-icon-bookmark-white-256672.png");
        } else {
            button.setAttribute("src", "/resources/img/icon/free-icon-bookmark-white-25667.png");
        }
    }
    loadBookmark();

	/* 	document.getElementById("search") */
</script>


</html>