<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="/resources/css/notice/notice.css">
</head>
<body>
	
<h1>notice_detail.jsp</h1>
${notice.t_b_num}
${notice.t_b_content}
${notice.t_b_views}
${notice.t_b_recom}
${notice.t_b_date}

<button onclick="modify(${notice.t_b_num})">수정</button>
<button onclick="go_list()">목록</button>


<script src="/resources/js/notice/notice_detail.js"></script>
</body>
</html>