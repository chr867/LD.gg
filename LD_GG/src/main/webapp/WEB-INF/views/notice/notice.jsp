<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/notice/notice.css">
</head>
<body>
<h1>공지사항</h1>

<div>

	<div class="grid full-height full-height-strict">
		<table id="grid" class="full-size-jq-grid"></table>
	</div>
	<div id="pager" style="height: 35px;"></div>
	
	<div class="search_box">
		<div class="element">
			<input type="text" id="keyword" name="keyword">
			<button id='search'>검색</button>
			<a href="/userinterface/notice/write">작성</a>
		</div>
	</div>
<span id="msg" style="display:none;">${msg}</span>
</div>

<script src="/resources/js/notice/notice.js"></script>
</body>
</html>