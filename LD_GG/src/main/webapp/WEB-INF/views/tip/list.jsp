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
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<body>
	<h1>공략 게시판 메인 페이지</h1>
	<div>
		<div class="grid full-height full-height-strict">
			<table id="grid" class="full-size-jq-grid"></table>
		</div>
		<div id="pager" style="height: 35px;"></div>
	</div>
		<input type="text" id="keyword" name="keyword">
		<input type="button" id="search">
	<a href="/tip/write">글작성</a>
</body>
<script type="text/javascript">
$("#grid").jqGrid({
	url : "/tip/list.json",
	datatype : "json",
	colNames : ['번호', '제목', '조회수', '추천 수', '날짜'],
	colModel:[
		{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
		{name:'t_b_title', index:'t_b_num', width:90, align: "center", sortable : false},
		{name:'t_b_views', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_recom', index:'t_b_num', width:90, align: "center"},
		{name:'t_b_date', index:'t_b_num', width:90, align: "center"}
		],
	loadtext : '로딩중..',
	sortable : true,
	loadonce : true,
	autowidth: true,
	multiselect: true,
	pager:'#pager',
	rowNum: 20,
	rowList: [10,30,50,80,100],
	sortname: 'date',
	sortorder: 'desc',
	/* pgtext : "Page {0} of {1}", */
	height: 700,
	onSelectRow: function(rowid){
		location.href = `/tip/details?t_b_num=\${rowid}`
	}
})

document.getElementById("search").addEventListener("click", function() {
let keyword = document.getElementById('keyword').value;
	
	console.log(keyword);
	
	$("#grid").jqGrid('setGridParam',{
		url : "/tip/search.json",
		datatype : "json",
		postData: {keyword: keyword},
		colNames : ['번호', '제목', '조회수', '추천 수', '날짜'],
		colModel:[
			{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
			{name:'t_b_title', index:'t_b_num', width:90, align: "center"},
			{name:'t_b_views', index:'t_b_num', width:90, align: "center"},
			{name:'t_b_recom', index:'t_b_num', width:90, align: "center"},
			{name:'t_b_date', index:'t_b_num', width:90, align: "center"}
			],
	 	autowidth: true,
		multiselect: true,
		pager:'#pager',
		rowNum: 10,
		rowList: [10, 20, 50],
		sortname: 'date',
		sortorder: 'desc',
		height: 250, 
		onSelectRow: function(rowid){
			location.href = `/tip/details?t_b_num=\${rowid}`
		}
	}).trigger("reloadGrid");
})

/*  document.getElementById("search").addEventListener("click", function() {
	let keyword = document.getElementById('keyword').value;
	
	$.ajax({
        method: 'get',
        url: '/member/change_usertype',
        data: {email:'${sessionScope.email}',password:password, user_type:changeType},
      }).done(res=>{
        console.log(res);
        if (res) {
        	  console.log()
        	  location.href = '/member/testMain';
        	} else {
        	  console.log(res)
        	  document.getElementById("result").innerHTML = "유저타입 변경 실패";
        	  document.getElementById("result").style.color = "red";
        	} 
      }).fail(err=>{
        console.log(err);
      }); 
});  */
</script>
</html>