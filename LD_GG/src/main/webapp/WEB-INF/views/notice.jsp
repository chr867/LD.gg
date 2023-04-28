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
</head>
<body>
<h1>공지사항</h1>

<div>
	<div class="grid full-height full-height-strict">
		<table id="grid" class="full-size-jq-grid"></table>
	</div>
	<div id="pager" style="height: 35px;"></div>
	
<script type="text/javascript">

$("#grid").jqGrid({
	url : "/userinterface/notice/histroy.json",
	datatype : "json",
	colNames : ['번호', '내용', '조회수', '추천 수', '날짜'],
	colModel:[
		{name:'t_b_num', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_content', index:'t_b_content', width:90, align: "center"},
		{name:'t_b_view', index:'t_b_view', width:90, align: "center"},
		{name:'t_b_recom', index:'t_b_recom', width:90, align: "center"},
		{name:'t_b_date', index:'t_b_date', width:90, align: "center"}
	]
})
</script>
</div>
</body>
</html>