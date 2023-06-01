<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>LD.GG</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
    </script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--JQUERY-->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<!--AJAX-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!--JQUERY VALIDATE-->
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
<!--sideBar CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/sideBar.css">
<!--header CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/header.css">
<!--footer CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/footer.css">
<!--loginModal CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/loginModal.css">
<!--로그인 및 세션관련 JS-->
<script src="/resources/js/main/loginSession.js" defer></script>
<!-- 채팅 관련 JS-->
<script src="/resources/js/main/chat.js" defer></script>
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<style type="text/css">
.main-container{
	padding: 100px 50px 0px 100px;
	box-sizing: border-box;
	margin: auto;
	text-align: center;
}
/* 그리드 헤더 */
.ui-jqgrid .ui-jqgrid-htable th div {
  background-color: #f2f2f2;
  background-image: linear-gradient(to bottom, #f2f2f2, #d9d9d9);
  border: none;
  padding: 10px;
}

/* 그리드 셀 */
.ui-jqgrid tr.jqgrow td {
  padding: 8px;
}

/* 그리드 셀 내용 */
.ui-jqgrid tr.jqgrow td {
  color: #333;
  font-size: 14px;
}
/* 검색 버튼 */
#search {
  background-color: #f2f2f2;
  background-image: linear-gradient(to bottom, #f2f2f2, #d9d9d9);
  border: none;
  color: #333;
  padding: 8px;
  font-size: 14px;
  cursor: pointer;
}

/* 글 작성 버튼 */
a[href="/tip/write"] {
  background-color: #f2f2f2;
  background-image: linear-gradient(to bottom, #f2f2f2, #d9d9d9);
  border: none;
  color: #333;
  padding: 8px;
  font-size: 14px;
  text-decoration: none;
}
.ui-pg-table .ui-pg-button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 8px 16px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    margin-left: 10px;
}

.ui-pg-table .ui-pg-button:hover {
    background-color: #3e8e41;
}
.ui-jqgrid .ui-pg-table .ui-pg-button {
  width: 40px;
  height: 40px;
  line-height: 40px;
}
</style>
</head>

<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
	<div class="main-container">
	<h1> 회원관리 페이지 </h1>
	<br>
	<h1> 회원가입 리스트 </h1>
	<div class="container">
		<div class="row search-container">
			<div class="col-md-6">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="유저검색(이메일 or 소환사이름)"
						id="keyword"> <span class="input-group-btn">
						<button class="btn btn-default" type="button" id="search">검색</button>
					</span>
				</div>
			</div>
		</div>
		<div id="grid-wrapper">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h1> 회원 로그인 히스토리 </h1>
	<div class="container">
		<div class="row search-container">
			<div class="col-md-6">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="유저검색(이메일 or 소환사이름)"
						id="keyword2"> <span class="input-group-btn">
						<button class="btn btn-default" type="button" id="search2">검색</button>
					</span>
				</div>
			</div>
		</div>
		<div id="grid-wrapper">
			<table id="grid2"></table>
			<div id="pager2"></div>
		</div>
	</div>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
	<script type="text/javascript">

	
	$("#grid").jqGrid({
		url : "/userinterface/admin/member/lists.json",
		datatype : "json",
		colNames : ['이메일','전화번호', '소환사계정', '유저타입', '가입날짜'],
		colModel:[
			{name:'email', index:'email', width:90, align: "center", key:true},
			{name:'phone_num', index:'phone_num', width:90, align: "center", sortable : false},
			{name:'lol_account', index:'lol_account', width:90, align: "center"},
			{name:'user_type', index:'user_type', width:90, align: "center"},
			{name:'join_date', index:'join_date', width:90, align: "center"},
			],
		loadtext : '로딩중..',
		sortable : true,
		loadonce : true,
		multiselect: false,
		pager:'#pager',
		rowNum: 10,
		sortname: 'date',
		sortorder: 'desc',
		width: 1000,
		height: 500,
	    pgbuttons: true,  // 이전/다음 버튼 표시 여부
	    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
	    viewrecords: false, // 레코드 수 표시 여부
	    recordpos: 'left', // 레코드 수 위치
	    pagerpos: 'center', // 페이징 버튼 위치
	    pginput: false,     // 페이지 번호 입력칸 표시 여부
	});

 	document.getElementById("search").addEventListener("click", function() {
	let keyword = document.getElementById('keyword').value;
		
		console.log(keyword);
		
		$("#grid").jqGrid('setGridParam',{
			url : "/userinterface/admin/member/search.json",
			datatype : "json",
			postData: {keyword: keyword},
			colNames : ['이메일','전화번호', '소환사계정', '유저타입', '가입날짜'],
			colModel:[
				{name:'email', index:'email', width:90, align: "center", key:true},
				{name:'phone_num', index:'phone_num', width:90, align: "center", sortable : false},
				{name:'lol_account', index:'lol_account', width:90, align: "center"},
				{name:'user_type', index:'user_type', width:90, align: "center"},
				{name:'join_date', index:'join_date', width:90, align: "center"},
				],
				loadtext : '로딩중..',
				sortable : true,
				loadonce : true,
				multiselect: false,
				pager:'#pager',
				rowNum: 10,
				sortname: 'date',
				sortorder: 'desc',
				width: 1000,
				height: 500,
			    pgbuttons: true,  // 이전/다음 버튼 표시 여부
			    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
			    viewrecords: false, // 레코드 수 표시 여부
			    recordpos: 'left', // 레코드 수 위치
			    pagerpos: 'center', // 페이징 버튼 위치
			    pginput: false, 
		}).trigger("reloadGrid");
	});
 	
	$("#grid2").jqGrid({
		url : "/userinterface/admin/member/history/lists.json",
		datatype : "json",
		colNames : ['이메일','로그타입', 'IP', '요청URI', '요청Method','UserAgent','로그타임'],
		colModel:[
			{name:'email', index:'email', width:90, align: "center", key:true},
			{name:'logType', index:'logType', width:90, align: "center"},
			{name:'ipAddress', index:'ipAddress', width:90, align: "center", sortable : false},
			{name:'requestURI', index:'requestURI', width:90, align: "center"},
			{name:'httpMethod', index:'httpMethod', width:90, align: "center"},
			{name:'userAgent', index:'userAgent', width:90, align: "center"},
			{name:'sessionDate', index:'sessionDate', width:90, align: "center"},
			],
		loadtext : '로딩중..',
		sortable : true,
		loadonce : true,
		multiselect: false,
		pager:'#pager2',
		rowNum: 10,
		sortname: 'date',
		sortorder: 'desc',
		width: 1000,
		height: 500,
	    pgbuttons: true,  // 이전/다음 버튼 표시 여부
	    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
	    viewrecords: false, // 레코드 수 표시 여부
	    recordpos: 'left', // 레코드 수 위치
	    pagerpos: 'center', // 페이징 버튼 위치
	    pginput: false,     // 페이지 번호 입력칸 표시 여부
	});

 	document.getElementById("search2").addEventListener("click", function() {
	let keyword = document.getElementById('keyword2').value;
		
		console.log(keyword);
		
		$("#grid2").jqGrid('setGridParam',{
			url : "/userinterface/admin/member/history/search.json",
			datatype : "json",
			postData: {keyword: keyword},
			colNames : ['이메일','로그타입', 'IP', '요청URI', '요청Method','UserAgent','로그타임'],
			colModel:[
				{name:'email', index:'email', width:90, align: "center", key:true},
				{name:'logType', index:'logType', width:90, align: "center"},
				{name:'ipAddress', index:'ipAddress', width:90, align: "center", sortable : false},
				{name:'requestURI', index:'requestURI', width:90, align: "center"},
				{name:'httpMethod', index:'httpMethod', width:90, align: "center"},
				{name:'userAgent', index:'userAgent', width:90, align: "center"},
				{name:'sessionDate', index:'sessionDate', width:90, align: "center"},
				],
				loadtext : '로딩중..',
				sortable : true,
				loadonce : true,
				multiselect: false,
				pager:'#pager2',
				rowNum: 10,
				sortname: 'date',
				sortorder: 'desc',
				width: 1000,
				height: 500,
			    pgbuttons: true,  // 이전/다음 버튼 표시 여부
			    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
			    viewrecords: false, // 레코드 수 표시 여부
			    recordpos: 'left', // 레코드 수 위치
			    pagerpos: 'center', // 페이징 버튼 위치
			    pginput: false, 
		}).trigger("reloadGrid");
	});
	</script>
</body>

</html>