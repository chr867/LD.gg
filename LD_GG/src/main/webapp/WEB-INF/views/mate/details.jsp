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

.modifyBox {
	width: 380px;
	height: 70px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>메이트 게시판 상세페이지</h1>
		<table>
			<tr>
				<th class="label">글 번호</th>
				<td class="value">${MateDetails.mate_id}</td>
			</tr>
			<tr>
				<th class="label">제목</th>
				<td class="value">${MateDetails.mate_title}</td>
			</tr>
			<tr>
				<th class="label">내용</th>
				<td class="value">${MateDetails.mate_content}</td>
			</tr>

			<tr>
				<th class="label">소환사명</th>
				<td class="value">${MateDetails.lol_account}</td>
			</tr>
			<tr>
				<th class="label">최근전적</th>
				<td class="value">"최근승률 자리"</td>
			</tr>
			<tr>
				<th class="label">작성자</th>
				<td class="value">${MateDetails.email}</td>
			</tr>
			<tr>
				<th class="label">작성일</th>
				<td class="value">${MateDetails.mate_date}</td>
			</tr>
		</table>
		<button onclick=mateModify(${MateDetails.mate_id}) id="modifyButton">게시물
			수정하기</button>
		<button onclick=deleteTip(${MateDetails.mate_id}) id="deleteButton">게시물
			삭제하기</button>
		<br>
		<h2>댓글</h2>
		<div id="comment-section">
			<div id="comment-form">
				<input type="text" placeholder="댓글을 입력해주세요" id="comment-textarea">
				<button id="comment-submit-btn" onclick="submitComment()">등록</button>
			</div>

			<table id="select-list">

			</table>
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
        	if(myEmail===reply.email){
        		selectButton = '<td><button id="comment-select-btn onclick="selectComment())">선택</button></td>'
        		deleteButton = '<td><button id="comment-delete-btn-'+reply.mate_r_id+'" onclick="deleteComment('+reply.t_r_num+')">삭제</button></td>'
        		modifyButton = '<td><button id="comment-modify-btn-'+reply.mate_r_id+'" onclick="modifyReplyBtn('+reply.t_r_num+')">수정</button></td>'
        	}
        	replyList += '<tr height="35" align="center" id="reply_box_'+reply.mate_r_id+'">'
        	replyList += '<td width="100">'+reply.lol_account+'</td>'
        	replyList += '<td width="300" id="content_num_'+reply.mate_r_id+'">'+reply.mate_r_content+'</td>'
        	replyList += '<td width="100">최근승률 자리</td>'
        	replyList += '<td width="100">'+reply.mate_r_date+'</td>'
        	replyList += selectButton
        	replyList += deleteButton
        	replyList += modifyButton
        	replyList += '</tr>'
        });
        console.log(replyList);
        $('#comment-list').html(replyList)
    }).fail(err => {
        console.log(err);
    }); 
}
function selectComment(){
	
//모디파이 스타일로 바꿔서 만들기 선택하면 값변경 디비로 올리는 식
	
}
loadComments();
</script>
</html>