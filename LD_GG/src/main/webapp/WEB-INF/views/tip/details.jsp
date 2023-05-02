<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.btn {
	display: inline-block;
	background-color: #4CAF50;
	color: #fff;
	padding: 8px 12px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

.btn:hover {
	background-color: #3e8e41;
}
</style>
</head>
<body>
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
				<td class="value">${tipDetails.champion_id}</td>
			</tr>
			<tr>
				<th class="label">작성자</th>
				<td class="value">${tipDetails.email}</td>
			</tr>
		</table>
		<button onclick=tipRecom(${tipDetails.t_b_num})>게시물 추천하기</button>
	</div>
</body>
<script type="text/javascript">
function tipRecom(t_b_num) {
	$.ajax({
		method: 'post',
		url: '/tip/recom',
		data: {t_b_num:t_b_num},
	}).done(res=>{
		console.log(res);
		if(res == 1){
			alert("추천 성공")
			location.href = "/tip/details?t_b_num="+${tipDetails.t_b_num};
		}else if(res == 2){
			alert("추천 취소 성공")
			location.href = "/tip/details?t_b_num="+${tipDetails.t_b_num};
		}else{
			alert("추천오류 실패")
		}
		
	}).fail(err=>{
		console.log(err);
	})
}
</script>
</html>