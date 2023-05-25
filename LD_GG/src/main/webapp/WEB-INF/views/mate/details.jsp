<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MateListDetails.jsp</title>

</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<style type="text/css">
/*  게시글 확인용으로 GPT로 작성된 CSS입니다 프론트페이지 작업시 삭제해주세요*/
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

#title img{

}
h2 {
	font-weight: bold;
	font-size: 24px;
	color: #333;
	margin-top: 20px;
	margin-bottom: 10px;
	padding-left: 50px;
}

.container {
	display: flex;
	flex-direction: column;
	justify-content: start;
 	align-items: center;
	width: 1192px;
	min-width: 1192px;
	height: 1500px;
	background-image: url("/resources/img/mate/detailback.png");
 	background-position: top;
    background-repeat: no-repeat; 
    background-size: 100%;
	margin: 0 auto;
	padding: 20px;
	
}



td {
	padding: 10px;
	text-align: center;
	font-size:20px;
}


.label {
	width: 120px;
	text-align: center;
	
	font-weight: bold;
	color: #6f8c9b;
	font-size:20px;
}

.value {
	color: #333;
}

#comment-form {
	min-width: 600px;
	margin-top: 20px;
	padding: 10px;
	border-radius: 10px;
	background-color: #f2f2f2;
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
}

#comment-form input[type="submit"]:hover {
	background-color: #023e8a;
}

#comment-submit-btn {
  height: 64px;
  width:94px;
  display: inline-block;
  padding: 25px 15px;
  margin: 28px 0px 25px 12px;
  background-color: transparent;
  background-size: 100%;
  color: #333;
  text-decoration: none;
}

#comment-submit-btn:hover {
  background-image: url("/resources/img/mate/writebt.png");
  background-position: center;
  background-repeat: no-repeat; 
}

.modifyBox {
	width: 380px;
	height: 70px;
}
#content-title {
 line-height : 270px;
}

#info {
	flex-direction: column; 
}
#comment-select {
  display:flex;
  flex-direction: row;
  align-items: center;
}

#info tr,#comment-select{

	font-weight: bold;
	color: #333;
	font-size:20px;
}
#info tr td{
	text-align: center;

}
#select-title{
	width: 140px;
	height: 130px;
	text-align: center;
}
#input-group{
  display:flex;
  justify-content: flex-start;
  align-items: center;
  background-image: url("/resources/img/mate/cc.png");
  background-position: center;  
  width: 546px; /* 버튼 이미지의 너비 */

}
input:focus {outline: 2px solid #d50000;} /* outline 테두리 속성 수정 */
input:focus {outline: none;} /* outline 테두리 없애기 */
#comment-textarea {
	
	width: 388px;
	height: 70px;
    text-align: start;
    cursor: text;
    background: none;
    margin: 30px 0px 25px 30px;

}
#comment-textarea::placeholder {
  color: #0099ff; /* 원하는 색상으로 변경 */
  font-size: 25px;
}
.main-button-group {
  display:flex;
  align-items: center;
}
.main-button {
  height: 40px;
  width: 40px;
  background-position: center;
  padding: 25px 15px;
  background-color: transparent;
  color: #333;
  text-decoration: none;
  cursor: pointer;
  font-size: 14px;
  border:none;
}
#modifyButton {
  background-image: url("/resources/img/mate/detailMainModify.png");
  background-repeat: no-repeat; 
}
#deleteButton {
  background-image: url("/resources/img/mate/detailMainDelete.png");
  background-repeat: no-repeat; 
}
#modifyButton:hover {
  background-image: url("/resources/img/mate/detailMainModify2.png");
  background-repeat: no-repeat; 
}
#deleteButton:hover {
  background-image: url("/resources/img/mate/detailMainDelete2.png");
  background-repeat: no-repeat; 
}
.reply-button {
  height: 25px;
  width: 25px;
  background-position: center;
  background-color: transparent;
  color: #333;
  text-decoration: none;
  cursor: pointer;
  font-size: 14px;
  border:none;
}
#select-btn {
  background-image: url("/resources/img/mate/detailReplySelect.png");
  background-repeat: no-repeat; 
}
#delete-btn {
  background-image: url("/resources/img/mate/detailReplyDelete.png");
  background-repeat: no-repeat; 
}
#select-btn:hover {
  background-image: url("/resources/img/mate/detailReplySelect2.png");
  background-repeat: no-repeat; 
}
#delete-btn:hover {
  background-image: url("/resources/img/mate/detailReplyDelete2.png");
  background-repeat: no-repeat; 
}



</style>
</head>
<body>
	<div class="container">
		<div id="title"><img src="/resources/img/logo/LDGG.png" width="160" height="160" alt="ldgg"></div>
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
				<td class="value" style="color: #336699; font-weight: bold;" width="140">"최근승률 자리"</td>
				<td class="value" width="200">${MateDetails.email}</td>
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
			
		<table>
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
		<div id="comment-select">

		</div>
		<br>
		<div id="comment-section">
			<div id="input-group">
				<input type="text" placeholder="댓글을 입력해주세요" id="comment-textarea" style="border:0 solid black">
					<button id="comment-submit-btn" onclick="submitComment()"
						style="border: 0 solid black"></button>
				</div>


			<table id="comment-list">

			</table>

		</div>
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
	modifyButton.style.display = "none";
	deleteButton.style.display = "none";
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
        	replyList += '<tr height="35" align="center" id="reply_box_'+reply.mate_r_id+'">'
        	replyList += '<td width="200">'+reply.lol_account+'</td>'
        	replyList += '<td width="300" id="content_num_'+reply.mate_r_id+'">'+reply.mate_r_content+'</td>'
        	replyList += '<td width="100">최근승률 자리</td>'
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
        	selectList += '<div><tr><td id="select-title">감다뒤</td></tr></div>'
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
        	selectList += '<td width="140">최근승률 자리</td>'
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