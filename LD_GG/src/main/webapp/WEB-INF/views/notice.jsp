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
	
<a href="/userinterface/notice/write">작성</a>

<form action="/userinterface/notice/search">
	<input type="text" name="t_b_content">
</form>

<script type="text/javascript">

$("#grid").jqGrid({
	url : "/userinterface/notice/histroy.json",
	datatype : "json",
	colNames : ['번호', '내용', '조회수', '추천 수', '날짜'],
	colModel:[
		{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
		{name:'t_b_content', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_views', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_recom', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_date', index:'t_b_num', width:90, align: "center"}
		],
/* 	autowidth: true,
	multiselect: true,
	pager:'#pager',
	rowNum: 10,
	rowList: [10, 20, 50],
	sortname: 'date',
	sortorder: 'desc',
	height: 250, */
	onSelectRow: function(rowid){
		location.href = `/userinterface/notice/detail?t_b_num=\${rowid}`
	}
})
</script>
</div>
</body>
</html>