<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>MateListDetails.jsp</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

  <!-- SweetAlert2 CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

  <!-- JQuery -->
  <script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>

  <!-- AJAX -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!-- SideBar CSS -->
  <link rel="stylesheet" type="text/css" href="/resources/css/main/sideBar.css">

  <!-- Header CSS -->
  <link rel="stylesheet" type="text/css" href="/resources/css/main/header.css">

  <!-- Footer CSS -->
  <link rel="stylesheet" type="text/css" href="/resources/css/main/footer.css">

  <!-- LoginModal CSS -->
  <link rel="stylesheet" type="text/css" href="/resources/css/main/loginModal.css">
  <!-- mateDetails CSS -->
  <link rel="stylesheet" type="text/css" href="/resources/css/mate/details.css">

  <!-- Login and Session-related JS -->
  <script src="/resources/js/main/loginSession.js" defer></script>


  <!-- jqGrid CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">

  <!-- Bootstrap JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

  <!-- SweetAlert2 JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

  <!-- jqGrid JavaScript -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
</head>

<style type="text/css">


</style>
</head>
<body>
	<div id="session-summoner-name" style="display: none">${sessionScope.lol_account}</div>
	<div id="session-user-type" style="display: none">${sessionScope.user_type}</div>
	<div id="session-summoner-name" style="display: none">${sessionScope.summoner_name}</div>
	<div id="session-summoner-icon" style="display: none">${sessionScope.summoner_icon}</div>
	<div id="error-check" style="display: none">${check}</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 사이드바 -->
	<div class="sidebar" style="margin-top: -110px;">
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
	<div id="title">
  <img src="/resources/img/logo/LDGG.png" style=" width: 160px; height: 160px;" alt="ldgg">
</div>

		<h3 style="text-align: center; color:red;">${errorMsg}</h3>
		<table id="info">
			<tr>
				<td width="50"></td>
				<td class="value" width="140">소환사명</td>
				<td class="value" width="140">최근전적</td>
				<td class="value" width="200">작성자</td>
				<td class="value" width="200">작성일</td>
			</tr>
			<br>
			<tr>
				<td width="50"></td>
				<td class="value" style="color: #336699; font-weight: bold;" width="140">${MateDetails.lol_account}</td>
				<td class="value" style="color: #336699; font-weight: bold; width: 140px;"><span style="color: #ff6633;">${MateDetails.win}승</span>/${MateDetails.loss}패</td>
				<td class="value" style="max-width: 200px; width: 200px;">${MateDetails.email}</td>
				<td class="value" width="200">${MateDetails.mate_date}</td>
			</tr>
		</table>
		<table id='detail-back'>
			<tr>
				<td class="label" height="50" >글 번호</td>
				<td class="value" width="480" height="50">${MateDetails.mate_id}</td>
			</tr>
			<tr>
				<td class="label" height="68">제목</td>
				<td class="value" width="480" height="50">${MateDetails.mate_title}</td>
			</tr>
			
		
			<tr >
				<td class="label" height="300" id="content-title">내용</td>
				<td class="value" width="480" height="300" >${MateDetails.mate_content}</td>
			</tr>
		</table>
		<div class="main-button-group">
			<button onclick=mateModify(${MateDetails.mate_id}) id="modifyButton" class="main-button"></button>
			<button onclick=mateDelete(${MateDetails.mate_id}) id="deleteButton" class="main-button"></button>
		</div>
		<br>
		<div id="comment-select" >

		</div>
		<br>
		<table id="comment-section">
<!-- 		<div id="input-group">
				<input type="text" placeholder="댓글을 입력해주세요" id="comment-textarea" style="border:0 solid black">
					<button id="comment-submit-btn" onclick="submitComment()"
						style="border: 0 solid black"></button>
			</div> -->
			 <tr style="height: 145px;">
		        <td id="input-group">
		            <input type="text" placeholder="댓글을 입력해주세요" id="comment-textarea" style="border:0 solid black">
		            <button id="comment-submit-btn" onclick="submitComment()" style="border: 0 solid black"></button>
		        </td>
		     
		    </tr>

			<tr id="comment-list">

			</tr>
		</table>

		</div>
	

</body>
<script type="text/javascript">
let modifyButton = document.getElementById("modifyButton")
let deleteButton = document.getElementById("deleteButton")
writeEmail="${MateDetails.email}";
myEmail='${sessionScope.email}';
if(writeEmail === myEmail){
	modifyButton.style.display = "block";
	deleteButton.style.display = "block";
}else{
	modifyButton.style.visibility = "hidden";
	deleteButton.style.visibility = "hidden";
}
function mateModify(mate_id) {
	location.href = "/mate/modify?mate_id="+mate_id;
}
function mateDelete(mate_id){
	$.ajax({
		method: 'post',
		url:'/mate/delete',
		data: {mate_id:mate_id}
		}).done(res=>{
			if(res){
			console.log('델리트 에이작스 res 값'+res);
			alert("게시물 삭제 성공");
			location.href="/mate/"
			}else{
			console.log('델리트 에이작스 실패');
			alert("게시물 삭제 실패");
			}
		}).fail(err=>{console.log(err);});
	
}

function submitComment(){
	let mate_id = ${MateDetails.mate_id}
	let mate_r_content = document.getElementById("comment-textarea").value;
	
	$.ajax({
		method: 'post',
		url:'/mate/reply/insert',
		data: {mate_id:mate_id,mate_r_content:mate_r_content}
		}).done(res =>{
			if (res){
				console.log(res);
				document.getElementById("comment-textarea").value=null
				loadComments();
			}else{
				 console.log(res);
				alert("댓글 등록 실패");
				
			}
		}).fail(err=>{console.log(err);});	
}
function loadComments() {
    $.ajax({
        method: 'get',
        url: '/mate/reply/list',
        data: {mate_id: ${MateDetails.mate_id}},
    }).done(res => {
    	console.log(res);
    	let replyList = "";
        res.forEach(reply => {
        	let selectButton = '';
        	let deleteButton = '';
        	let modifyButton = '';
        	if(myEmail===reply.email && myEmail !=reply.mate_apply &&reply.mate_select===0){
        		selectButton = '<td><button class="reply-button" id="select-btn" onclick="selectCommentModify('+reply.mate_id+','+reply.mate_r_id+')"></button></td>'
        	}else if(myEmail===reply.mate_apply){
        		selectButton = '<td><button class="reply-button" id="delete-btn" onclick="deleteComment('+reply.mate_id+','+reply.mate_r_id+')"></button></td>'
        	}
        	replyList += '<tr height="35" align="center" id="reply_box">'
        	replyList += '<td width="200" style="font-weight: bold;">'+reply.lol_account+'</td>'
        	replyList += '<td width="300" id="content_num">'+reply.mate_r_content+'</td>'
        	replyList += '<td width="160">최근<span style="color: #ff6633; font-weight: bold;">'+reply.win+'승</span>/'+reply.loss+'패</td>'
        	replyList += '<td width="200">'+reply.mate_r_date+'</td>'
        	replyList += selectButton
        	replyList += deleteButton
        	replyList += '</tr>'
        });
        console.log(replyList);
        $('#comment-list').html(replyList)
    }).fail(err => {
        console.log(err);
    }); 
}	
//모디파이 스타일로 바꿔서 만들기 선택하면 값변경 디비로 올리는 식
	
function selectCommentModify(mate_id,mate_r_id) {
	
	$.ajax({
        method: 'post',
        url: '/mate/reply/modify',
        data: {mate_id:mate_id,mate_r_id:mate_r_id}
    }).done(res => {
    	if (res){
    		console.log(res);
    		alert("메이트 메칭 성공");
    		selectComment();
    	}else{
    		console.log(res)
    		alert("메이트 메칭 실패")
    		
    		}
		}).fail(err=>{
			console.log(err);
		});
}
function selectComment() {
	let mate_id=${MateDetails.mate_id}
	
    $.ajax({
        method: 'get',
        url: '/mate/reply/select',
        data: {mate_id:mate_id},
    }).done(res => {
    	console.log(res);
    	if(res){
    	let selectList="";
        	selectList += '<table>'
        	selectList += '<div><tr><td id="select-title" style="color: #336699; font-weight: bold;">선택된 소환사</td></tr></div>'
        	selectList += '</table>'
        	selectList += '<table id="select-group">'
        	selectList += '<tr>'
        	selectList += '<td width="200">소환사명</td>'
        	selectList += '<td width="200" id="content_num">내용</td>'
        	selectList += '<td width="140">최근승률</td>'
        	selectList += '</tr>'
        	selectList += '<tr>'
        	selectList += '<td width="200" style="color:#336699;">'+res.lol_account+'</td>'
        	selectList += '<td width="200" height="80" id="content_num">'+res.mate_r_content+'</td>'
        	selectList += '<td width="160">최근<span style="color: #ff6633; font-weight: bold;">'+res.win+'승</span>/'+res.loss+'패</td>'
        	selectList += '</tr>'
        	selectList += '</table>'
        	console.log(selectList);
        	loadComments();
        $('#comment-select').html(selectList)
    	}
    }).fail(err => {
        console.log(err);
    }); 
}
function deleteComment(mate_id,mate_r_id) {
		$.ajax({
	        method: 'post',
	        url: '/mate/reply/delete',
	        data: {mate_id : mate_id, mate_r_id : mate_r_id}
	    }).	done(res=>{
	    	if(res){
	    		console.log("res"+res)
	    		alert("댓글 삭제 성공");
    			location.href = "/mate/details?mate_id="+mate_id;
	    	}else{
	    		alert("댓글 삭제 실패");
    			location.href = "/mate/details?mate_id="+mate_id;
	    	}
	    }).fail(err => {
	        console.log(err);
	    });
	
	
}
loadComments();
selectComment();
</script>
</html>