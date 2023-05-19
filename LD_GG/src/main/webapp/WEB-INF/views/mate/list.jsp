<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mate/list.jsp</title>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<style type="text/css">
#bookmarkicon {
	width: 50px; /* 버튼 이미지의 너비 */
	height: 50px; /* 버튼 이미지의 높이 */
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
a[href="/mate/write"] {
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
<body>
	<div id="bookmark">
		<img id="bookmarkicon" src="/resources/img/bf-bookmark.png"
			onclick="insertBookmark()" alt="이미지 버튼">
		<table id="bookmark-list">

		</table>
	</div>
	<div class="container">
		<h1>메이트 게시판</h1>
		<div class="bookmark"></div>
		<div class="row search-container">
			<div class="col-md-6">
				<div class="input-group">
					<br> <input type="text" class="form-control"
						placeholder="제목 검색" id="keyword"> <span
						class="input-group-btn">
						<button class="btn btn-default" type="button" id="search">검색</button>
					</span>
				</div>
			</div>
			<div class="col-md-6 text-right">
				<a href="/mate/write" class="btn btn-primary">글 작성</a>
			</div>
		</div>
		<div id="grid-wrapper">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
</body>
<script type="text/javascript">

	$("#grid").jqGrid({
		url : "/mate/list.json",
		datatype : "json",
		colNames : [ '번호', '제목', '소환사명', '날짜' ],
		colModel : [ {
			name : 'mate_id',
			index : 'mate_id',
			width : 90,
			align : "center",
			key : true
		}, {
			name : 'mate_title',
			index : 'mate_id',
			width : 90,
			align : "center",
			sortable : false
		}, {
			name : 'lol_account',
			index : 'mate_id',
			width : 90,
			align : "center"
		}, {
			name : 'mate_date',
			index : 'mate_id',
			width : 90,
			align : "center"
		}

		],
		loadtext : '로딩중..',
		sortable : true,
		loadonce : true,
		multiselect : false,
		pager : '#pager',
		rowNum : 10,
		sortname : 'date',
		sortorder : 'desc',
		width : 1000,
		height : 500,
		pgbuttons : true, // 이전/다음 버튼 표시 여부
		pgtext : null, // 페이징 정보(1 - 10 / 100) 표시 여부
		viewrecords : false, // 레코드 수 표시 여부
		recordpos : 'left', // 레코드 수 위치
		pagerpos : 'center', // 페이징 버튼 위치
		pginput : false, // 페이지 번호 입력칸 표시 여부
		onSelectRow : function(rowid) {
			location.href = `/mate/details?mate_id=\${rowid}`
		}
	});

document.getElementById("search").addEventListener("click", function() {
	let keyword = document.getElementById('keyword').value;

	console.log(keyword);
	$("#grid").jqGrid('setGridParam',{
		url : "/mate/search.json",
		datatype : "json",
		postData: {keyword: keyword},
		colNames : [ '번호', '제목', '소환사명', '날짜' ],
		colModel:[
			{name:'mate_id', index:'mate_id', width:90, align: "center", key:true},
			{name:'mate_title', index:'mate_id', width:90, align: "center"},
			{name:'lol_account', index:'mate_id', width:90, align: "center"},
			{name:'mate_date', index:'mate_id', width:90, align: "center"},
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
		onSelectRow: function(rowid){
			location.href = `/mate/details?mate_id=\${rowid}`
		}
	}).trigger("reloadGrid");
});

function insertBookmark(){
	console.log("click bookmark");
     let button = document.getElementById("bookmarkicon");
     let currentSrc = button.getAttribute("src");
     val=0;
     if (currentSrc === "/resources/img/bf-bookmark.png") {
    	 button.setAttribute("src", "/resources/img/af-bookmark.png");
    	 bookmark_val=1;
    	 //alert(bookmark_val);
   		} else {
         button.setAttribute("src", "/resources/img/bf-bookmark.png");
         bookmark_val=0;
    	 //alert(bookmark_val);
            }
    	 modifybookmark(bookmark_val);
}	
function modifybookmark(bookmark_val) {
	email='${sessionScope.email}';
	let bookmark_page = window.location.pathname;
	console.log(bookmark_page+"현화면 유알엘");
	console.log(email+"현화면 email");
	console.log(bookmark_val+"현화면 bookmark_val");
	$.ajax({
        method: 'post',
        url: '/mate/bookmark/modify',
        data: {email:email,bookmark_page:bookmark_page,bookmark_val:bookmark_val}
    }).done(res => {
    	if (res){
    		console.log(res);
    		//alert("북마크 성공");
    		loadBookmark();
    	}else{
    		console.log(res)
    		//alert("북마크 성공")
    		
    		}
		}).fail(err=>{
			console.log(err);
		});
}
function loadBookmark() {
	let email='${sessionScope.email}';
	let now_page = window.location.pathname;
        	console.log("now_page"+now_page)
    $.ajax({
        method: 'post',
        url: '/mate/bookmark',
        data: {email:email},
    }).done(res => {
    	console.log("res북마크"+res);
    	console.log(res);
    	let bookmarkList = "";
        	let my_page = '';
        	let tip_page = '';
        	let mate_page = '';
        	console.log("res.my_page"+res.my_page)
        	console.log("res.tip_page"+res.tip_page)
        	console.log("res.mate_page"+res.mate_page)
        	
        	  if (now_page === '/member/myPage') {
        		  if(res.tip_page ===1){
    				tip_page = '<td><button class="bookmarkBt" onclick="goUrl(\'/tip/\')">tip_page로 이동</button></td>';
        		  }if(res.mate_page === 1){
     			 	mate_page = '<td><button class="bookmarkBt" onclick="goUrl(\'/mate/\')">mate_page로 이동</button></td>';  
        		  }
        	  }
        	  else if (now_page === '/tip/') {
        		  if(res.my_page ===1){
    				my_page = '<td><button class="bookmarkBt" onclick="goUrl(\'/member/myPage)">my_page로 이동</button></td>';
        		  }if(res.mate_page === 1){
     			 	mate_page = '<td><button class="bookmarkBt" onclick="goUrl(\'/mate/\')">mate_page로 이동</button></td>';  
        		  }
        	  }
        	  else if (now_page === '/mate/') {
        		  if(res.my_page ===1){
    				my_page = '<td><button class="bookmarkBt" onclick="goUrl(\'/member/myPage)">my_page로 이동</button></td>';
        		  }if(res.tip_page === 1){
    				tip_page = '<td><button class="bookmarkBt" onclick="goUrl(\'/tip/\')">tip_page로 이동</button></td>';
        		  }
        	  }
        	bookmarkList += '<tr>'
        	bookmarkList += my_page
        	bookmarkList += tip_page
        	bookmarkList += mate_page
        	bookmarkList += '</tr>'
        	checkBookmark(now_page,res);
        console.log(bookmarkList);
        $('#bookmark-list').html(bookmarkList)
    }).fail(err => {
        console.log(err);
    }); 
    }
    function goUrl(url) {
    	location.href = url;
    }
    function checkBookmark(now_page,res) {
        let button = document.getElementById("bookmarkicon");
        
        if (now_page === '/member/myPage' && res.my_page === 1) {
            button.setAttribute("src", "/resources/img/af-bookmark.png");
        } else if (now_page === '/tip/' && res.tip_page === 1) {
            button.setAttribute("src", "/resources/img/af-bookmark.png");
        } else if (now_page === '/mate/' && res.mate_page === 1) {
            button.setAttribute("src", "/resources/img/af-bookmark.png");
        } else {
            button.setAttribute("src", "/resources/img/bf-bookmark.png");
        }
    }
    loadBookmark();
	/* 	document.getElementById("search") */
</script>


</html>