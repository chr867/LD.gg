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
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
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