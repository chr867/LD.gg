<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/notice/notice.css">
<style>
#main_container{
	padding-top : 100px;
	padding-left : 200px;
	width: 80%;
}

@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
 font-family: 'NanumSquareNeo-Variable';
}
#bookmarkicon {
	width: 40px; /* 버튼 이미지의 너비 */
	height: 40px; /* 버튼 이미지의 높이 */
}

body {
      image-rendering: -webkit-optimize-contrast; /* chrome */
      background-image: url("/resources/img/mate/back.png");
      background-size: 100%;
      min-width: 1312px;
      overflow-x: hidden;
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
	padding-left: 0px;
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
	
	width: 240px;
	height: 40px;
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
  display: none;
  z-index: 200;
  top: 10%;
  left: 60%;
  width: 40%;
  background: white;
  padding: 1rem;
  border: 1px solid #ccc;
  box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);
  opacity: 0;
  transition: opacity 1s;
}
.bookmark-icon-box:hover + .bookmark-modal {
  display: block;
  opacity: 1; 
}
.bookmark-title {
  text-align: center;
  margin: 0 0 1rem 0;
}

.bookmark-actions {
  text-align: center;
}

/* 북마크 버튼 */
.bookmarkBt {
  border: 1px solid #0e4f1f;
  background: #0e4f1f;
  text-decoration: none;
  color: white;
  font: inherit;
  padding: 0.5rem 1rem;
  cursor: pointer;
}

</style>

</head>
<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
  
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

<div id="main_container">
	<div class="grid full-height full-height-strict" style="width: auto;">
		<table id="grid" class="full-size-jq-grid"></table>
	</div>
	<div id="pager" style="height: 150px; display: flex;">
		<div class="search_box">
			<div class="element">
				<input type="text" id="keyword" name="keyword">
				<button id='search'>검색</button>
			</div>
		</div>
	</div>
	
	<span id="msg" style="display:none;">${msg}</span>
</div>

<script src="/resources/js/notice/notice.js"></script>
</body>
</html>