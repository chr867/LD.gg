<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="/resources/css/notice/notice_detail.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<p style="display: none;" id="email">${sessionScope.email}</p>

<div class="container">
	<h1>공지사항 상세</h1>
	<div>
			<table>
			<tr>
				<th class="label">글 번호</th>
				<td id="t_b_num" class="value">${notice.t_b_num}</td>
			</tr>
			<tr>
				<th class="label">제목</th>
				<td class="value">${notice.t_b_title}</td>
			</tr>
			
			<tr>
				<th class="label">내용</th>
				<td class="value">${notice.t_b_content}</td>
			</tr>
			<tr>
				<th class="label">조회수</th>
				<td class="value">${notice.t_b_views}</td>
			</tr>
			<tr>
				<th class="label">추천수</th>
				<td class="value">${notice.t_b_recom}</td>
			</tr>
			<tr>
				<th class="label">작성일</th>
				<td class="value">${notice.t_b_date}</td>
			</tr>
		</table>
			
		<!-- <button onclick="modify(${notice.t_b_num})">수정</button> -->
		<button onclick="go_list()">목록</button>
	</div>

	<div>
		<div id="comment-form">
			<input type="text" placeholder="댓글을 입력해주세요" id="comment-textarea">
			<button id="comment-submit-btn" onclick="submitComment()">등록</button>
		</div>

		<table id="reply_table"/>
	</div>

</div>


<script src="/resources/js/notice/notice_detail.js"></script>
</body>
</html>