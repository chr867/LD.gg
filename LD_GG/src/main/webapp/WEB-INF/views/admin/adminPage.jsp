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
<script	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<body>
	<h1>관리자 페이지</h1>
<div>
	<div>
		<a href="/userinterface/member/management">회원관리 페이지</a>
		<a href="/userinterface/ad/management">광고관리 페이지</a>
	</div>
	<div class="grid full-height full-height-strict">
		<span>공지사항 목록</span>
		<table id="grid" class="full-size-jq-grid"></table>
	</div>
	<div id="pager" style="height: 35px;"></div>
	
	<div class="search_box">
		<div class="element">
			<input type="text" id="keyword" name="keyword">
			<button id='search'>검색</button>
			<button id='notice_del' onclick='notice_del()'>공지 삭제</button>
			<a href="/userinterface/notice/write">작성</a>
		</div>
	</div>
	
	<span id="msg" style="display: none;">${msg}</span>
</div>

<div id="user_type" style="display: none;">${sessionScope.user_type}</div>
</body>
<script src="/resources/js/admin/admin.js"></script>
</html>