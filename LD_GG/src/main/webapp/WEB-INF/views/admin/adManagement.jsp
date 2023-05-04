<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<style type="text/css">
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
	<h1>광고관리 페이지</h1>
	<div class="input-box">
		<label for="advertiser">광고주:</label> <input type="text"
			id="ad_advertiser" name="advertiser"> <label
			for="company-name">업체명:</label> <input type="text" id="ad_name"
			name="company-name"> <label for="display-period">노출기간:</label>
		<input type="date" id="ad_start" name="display-period"> ~ <input
			type="date" id="ad_end" name="display-period"> <label
			for="ad-cost">광고비:</label> <input type="number" id="ad_pay"
			name="ad-cost">

		<button id="adSubmit" onclick="adRegistration()">등록</button>
	</div>
	<br>
	<br>
	<div class="container">
		<div class="row search-container">
			<div class="col-md-6">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="광고 검색"
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

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
	<script type="text/javascript">
	function adRegistration() {
		const ad_advertiser = document.getElementById("ad_advertiser").value;
		const ad_name = document.getElementById("ad_name").value;
		const ad_start = document.getElementById("ad_start").value; 
		const ad_end = document.getElementById("ad_end").value; 
		const ad_pay = document.getElementById("ad_pay").value;

		$.ajax({
	        method: 'post',
	        url: '/userinterface/admin/ad/regist',
	        data: {ad_advertiser:ad_advertiser,
	        	   ad_name:ad_name,
	        	   ad_start:ad_start,
	        	   ad_end:ad_end,
	        	   ad_pay:ad_pay},
	        success: function (res) {
	        	console.log(res);
	        	// 처리 결과에 따라 다음 동작 수행
	        	if (res) {
	        		alert('등록되었습니다.');
	        		location.href = `/userinterface/ad/management`
	        	} else {
	        		alert('등록에 실패하였습니다.');
	        	}
	        },
	        error: function (err) {
	        	console.log(err);
	        	alert('오류가 발생하였습니다.');
	        }
	    }); 
	}
	
	$("#grid").jqGrid({
		url : "/userinterface/admin/ad/lists.json",
		datatype : "json",
		colNames : ['광고 번호','광고주', '업체명', '광고 시작일', '광고 종료일', '광고비용'],
		colModel:[
			{name:'ad_num', index:'ad_num', width:90, align: "center", key:true},
			{name:'ad_advertiser', index:'ad_advertiser', width:90, align: "center", sortable : false},
			{name:'ad_name', index:'ad_name', width:90, align: "center"},
			{name:'ad_start', index:'ad_start', width:90, align: "center"},
			{name:'ad_end', index:'ad_end', width:90, align: "center"},
			{name:'ad_pay', index:'ad_pay', width:90, align: "center"}
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
			url : "/userinterface/admin/ad/search.json",
			datatype : "json",
			postData: {keyword: keyword},
			colNames : ['광고 번호','광고주', '업체명', '광고 시작일', '광고 종료일', '광고비용'],
			colModel:[
				{name:'ad_num', index:'ad_num', width:90, align: "center", key:true},
				{name:'ad_advertiser', index:'ad_advertiser', width:90, align: "center", sortable : false},
				{name:'ad_name', index:'ad_name', width:90, align: "center"},
				{name:'ad_start', index:'ad_start', width:90, align: "center"},
				{name:'ad_end', index:'ad_end', width:90, align: "center"},
				{name:'ad_pay', index:'ad_pay', width:90, align: "center"}
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
	</script>
</body>

</html>