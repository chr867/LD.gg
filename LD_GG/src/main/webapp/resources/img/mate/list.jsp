<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>mate/list.jsp</title>
<link href="${pageContext.request.contextPath}/resources/css/mate/reset.css" rel="stylesheet">
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
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
 font-family: 'NanumSquareNeo-Variable';
}

body {
      image-rendering: -webkit-optimize-contrast; /* chrome */
      background-image: url("/resources/img/mate/back.png");
      background-size: 100%;
      min-width: 1312px;
      overflow-x: hidden;
    }

#bookmarkicon {
	width: 10px; /* 버튼 이미지의 너비 */
	height: 10px; /* 버튼 이미지의 높이 */
}

#input-group{
  background-image: url("/resources/img/mate/sc.png");
  background-position: center;  
  width: 546px; /* 버튼 이미지의 너비 */
  display: flex;

}
/*그리드 제목 */
.ui-jqgrid .ui-jqgrid-htable .ui-jqgrid-labels th div {
    overflow: hidden;
    position: relative;
    height: auto;
    margin: 2px 2px;
	font-size: 30px;
	font-weight: bold;
	color: #6f8c9b;
}

/* 그리드 헤더 */
.ui-jqgrid .ui-jqgrid-htable th div {
}

/* 그리드 셀 내용 */
.ui-jqgrid .ui-jqgrid-bdiv tr.ui-row-ltr>td{
	border:none;
	padding: 20px;
	color: #333;
	font-size: 20px;
}

.sc-button {
  height: 64px;
  width:71px;
  background-position: center;
  display: inline-block;
  padding: 25px 15px;
  margin: 33px 0px 25px 8px;
  background-color: transparent;
  color: #333;
  text-decoration: none;

  cursor: pointer;
  font-size: 14px;
}

.sc-button:hover {
  background-image: url("/resources/img/mate/scbt.png");
}
.wt-button {
  height: 64px;
  width:94px;
  display: inline-block;
  padding: 25px 15px;
  margin: 33px 0px 25px 12px;
  background-color: transparent;
  color: #333;
  text-decoration: none;
  cursor: pointer;
  font-size: 14px;
}

.wt-button:hover {
  background-image: url("/resources/img/mate/writebt.png");
  
}
#keyword {
	
	width: 310px;
	height: 70px;
    text-align: start;
    cursor: text;
    background: none;
    margin: 30px 0px 25px 30px;

}
input:focus {outline: 2px solid #d50000;} /* outline 테두리 속성 수정 */
input:focus {outline: none;} /* outline 테두리 없애기 */
#keyword::placeholder {
  color: #0099ff; /* 원하는 색상으로 변경 */
  font-size: 25px;
}
#grid-wrapper {
  width: 1310px;
  display: flex;
  flex-direction: column;
  background-image: url("/resources/img/mate/matetable.png");
  background-repeat: no-repeat;
  justify-content: center;
  align-items: center;
  height:1085px; 
}
#grid-wrapper img{
margin-top:40px
}
/* 글 작성 버튼 */
/* #write {
	background-color: none;
	width: 70px;
	height: 70px;
	border:red solid 1px;
	color: #333;
	padding: 8px;
	font-size: 14px;
	text-decoration: none;
} */

.ui-pg-table .ui-pg-button {
	background-color: #6699ff;
	border: none;
	color: white;
	padding: 8px 16px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	margin-left: 10px;
}
#first_pager,#last_pager {
	background-color: #99ccff;
	border: none;
	color: white;
	padding: 8px 16px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
}

.ui-pg-table .ui-pg-button:hover {
	background-color: #cccccc;
}
#last_pager:hover, #first_pager:hover{
	background-color: #cccccc;
}

.ui-jqgrid .ui-pg-table .ui-pg-button,#last_pager:hover, #first_pager {
	width: 20px;
	height: 20px;
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
		<div class="bookmark"></div>
		<div id="row search-container">
			<div id="col-md-6">
				<div id="input-group">
					<div>
						<input type="text"placeholder="제목 검색" id="keyword" style="border:0 solid black"> 
					</div>
					<div>
						<a class="sc-button" id="search"></a>
					</div>
					<div>
						<a href="/mate/write" class="wt-button" id="write"></a>
					</div>
				</div>
			</div>
		</div>
		<div id="grid-wrapper">
			<table id="grid"></table>
			<div id="pager"></div>
		<img id="logo" src="/resources/img/logo/LDGG.png" width="110" height="110" alt="ldgg">
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
			width : 100,
			align : "center",
			key : true

		}, {
			name : 'mate_title',
			index : 'mate_id',
			width : 300,
			align : "center",
			sortable : false
		}, {
			name : 'lol_account',
			index : 'mate_id',
			width : 300,
			align : "center"
		}, {
			name : 'mate_date',
			index : 'mate_id',
			width : 300,
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
		autowidth:true,    // jQgrid width 자동100% 채워지게
		shrinkToFit:false,  // width를 자동설정 해주는 기능
		width : 1300,
		height : 735,
		pgbuttons : true, // 이전/다음 버튼 표시 여부
		pgtext: "페이지 {1}", // 페이지 번호 텍스트 설정
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
			{name:'mate_id', index:'mate_id', width:100, align: "center", key:true},
			{name:'mate_title', index:'mate_id', width:300, align: "center"},
			{name:'lol_account', index:'mate_id', width:300, align: "center"},
			{name:'mate_date', index:'mate_id', width:300, align: "center"},
			],
			loadtext : '로딩중..',
			sortable : true,
			loadonce : true,
			multiselect: false,
			pager:'#pager',
			rowNum: 10,
			sortname: 'date',
			sortorder: 'desc',
			width: 1300,
			height: 735,
		    pgbuttons: true,  // 이전/다음 버튼 표시 여부
		    pgtext: "페이지 {1}",    // 페이징 정보(1 - 10 / 100) 표시 여부
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