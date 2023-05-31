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
	display: flex;
	justify-content: center;
} 

.title-box{
	text-align: center;
	background-color: #202B46;
	color: #fff;
	margin: auto;
	width: 300px;
	height: 70px;
	display: flex;
	margin-bottom: 30px;
	border-radius: 3rem;
	justify-content: center;
	align-items: center;
}

.champion-container{
	margin-top: 90px;
	width: 25%;
	height: 80vh;
	background-color: #fff;
	margin-right: 20px;
	margin-left: 60px;
	box-sizing: border-box;
}
.tip-list-container{
	margin-top: 90px;
	width: 68%;
	height: 80vh;
	background-color: #fff;
	box-sizing: border-box;
	padding: 50px 30px 0 30px;
}
.jqGrid_wrapper {
    display: flex;
    justify-content: center;
}
/* 그리드 헤더 */
.ui-jqgrid .ui-jqgrid-htable th div {
/*   background-color: #f2f2f2; */
/*   border: none; */
/*   padding: 10px; */
}
.ui-jqgrid .ui-jqgrid-btable td {
    text-align: center; /* 셀 안의 텍스트를 중앙에 위치시킵니다. */
}

.ui-jqgrid .ui-jqgrid-htable th {
	background: #202B46;
	color: #fff;
	border: 3px solid #fff ;
    text-align: center; /* 헤더 셀 안의 텍스트를 중앙에 위치시킵니다. */
}

.ui-jqgrid .ui-jqgrid-btable tr {
    background: #E4E6EF; /* 행의 배경색을 설정합니다. */
    border: 3px solid #fff ;
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

.ui-jqgrid .ui-jqgrid-btable tr:hover {
    background: #DCDDE4; /* 마우스 오버시 행의 배경색을 설정합니다. */
}
.ui-jqgrid .ui-jqgrid-btable td,
.ui-jqgrid .ui-jqgrid-htable th {
    padding: 10px 15px; /* 셀 안의 패딩을 설정합니다. */
}
/* 검색 버튼 */
#search {
  background-color: #202B46;
  color: #fff;
  padding: 8px;
  font-size: 14px;
  cursor: pointer;
}

/* 글 작성 버튼 */
a[href="/tip/write"] {
  background-color: #202B46;
  border: none;
  color: #fff;
  padding: 8px;
  font-size: 14px;
  text-decoration: none;
  position: relative;
  left: 250px;
}
/* 페이징 버튼 */
.ui-pg-table .ui-pg-button {
    background-color: #202B46;
    border: none;
    color: white;
    padding: 8px 16px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 10px;
    margin-left: 10px;
}

.ui-pg-table .ui-pg-button:hover {
    background-color: #52618A;
}
.ui-jqgrid .ui-pg-table .ui-pg-button {
  width: 40px;
  height: 40px;
  line-height: 40px;
}
.ui-jqgrid-view{
	margin-top: 20px;
}
.search-container{
	text-align: center;
	justify-content: space-between;
}

 .lane-select-box {
    display: flex;
    height: 50px;
    justify-content: space-between;
    width: 90%;
    margin: auto;
    margin-top: 10px;
    background-color: #E4E6EF;
    box-sizing: border-box;
    padding: 0 50px 0 50px;
    margin-bottom: 20px;
    align-items: center;
}

.lane-img img {
    width: 40px;
    height: 40px;
}

.lane-img {
    border-radius: 0.5rem;
    transition: 0.5s;
}

.lane-img:hover,
.lane-img:active {
    background-color: #fff;
}

.champion-img-container {
    width: 90%;
    background-color: #E4E6EF;
    height: 600px;
    margin: auto;
    box-sizing: border-box;
    overflow-y: auto;
    max-height: 600px;
}

.champions {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    text-align: center;
    box-sizing: border-box;
    flex-wrap: wrap;
    padding: 5px;
}

.champions img {
    width: 60px;
    height: 60px;
    border-radius: 1rem;
    border: 5px solid #fff;
    transition : 0.5s;
}
.champions img:hover{
    transform: scale(1.3);
    z-index: 1;
}

.champion {
    display: flex;
    align-items: center;
    flex-direction: column;
    margin: 5px;
    flex-grow: 1;
}
::-webkit-scrollbar {
  width: 5px; /* 스크롤바의 너비 */
}

::-webkit-scrollbar-track {
  background-color: #f1f1f1; /* 스크롤바의 트랙(배경) 색상 */
}

::-webkit-scrollbar-thumb {
  background-color: #888; /* 스크롤바의 썸(막대) 색상 */
}
</style>
<body>
<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<div class="champion-container">
			<div class="lane-select-box">
				<div class="lane-img lane-top" onclick="selectLane('TOP')"><img src="/resources/img/ranked-positions/Position_Silver-Top.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-jungle" onclick="selectLane('JUNGLE')"><img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-middle" onclick="selectLane('MIDDLE')"><img src="/resources/img/ranked-positions/Position_Silver-Mid.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-bottom" onclick="selectLane('BOTTOM')"><img src="/resources/img/ranked-positions/Position_Silver-Bot.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-support" onclick="selectLane('UTILITY')"><img src="/resources/img/ranked-positions/Position_Silver-Support.png" alt="로그인 이미지"></div>
			</div>
			<div class="champion-img-container">
				<div class="champions">

				</div>
			</div>
		</div>
		<div class="tip-list-container">
						<div class="title-box">
				<h3 class="text-center">공략 게시판</h3>
			</div>
				<div class="row search-container">
					<div class="col-md-6">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="제목 검색" id="keyword">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" id="search">검색</button>
							</span>
						</div>
					</div>
					<div class="col-md-6 text-right">
						<a href="/tip/write" class="btn btn-primary">글 작성</a>
					</div>
				</div>
				<div id="grid-wrapper">
					<table id="grid"></table>
					<div id="pager"></div>
				</div>
		 </div>
	</div>
</body>
<script type="text/javascript">
 $("#grid").jqGrid({
	url : "/tip/list.json",
	datatype : "json",
	colNames : ['번호', '챔피언','제목', '조회수', '추천 수', '날짜'],
    colModel:[
        {name:'t_b_num', index:'t_b_num', width: 50, align: "center", key:true},
        {name:'champion_kr_name', index:'t_b_num', width: 100, align: "center"},
        {name:'t_b_title', index:'t_b_num', width:600, align: "center", sortable : false},
        {name:'t_b_views', index:'t_b_num', width:50, align: "center"},
        {name:'t_b_recom', index:'t_b_num', width:50, align: "center"},
        {name:'t_b_date', index:'t_b_num', width:150, align: "center"}
    ],
	loadtext : '로딩중..',
	sortable : true,
	loadonce : true,
	multiselect: false,
	pager:'#pager',
	rowNum: 10,
	sortname: 'date',
	sortorder: 'desc',
	width: 1150,
	height: 400,
    pgbuttons: true,  // 이전/다음 버튼 표시 여부
    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
    viewrecords: false, // 레코드 수 표시 여부
    recordpos: 'left', // 레코드 수 위치
    pagerpos: 'center', // 페이징 버튼 위치
    pginput: false,     // 페이지 번호 입력칸 표시 여부
	onSelectRow: function(rowid){
		location.href = `/tip/details?t_b_num=\${rowid}`
	}
});

document.getElementById("search").addEventListener("click", function() {
let keyword = document.getElementById('keyword').value;
	
	console.log(keyword);
	
	$("#grid").jqGrid('setGridParam',{
		url : "/tip/search.json",
		datatype : "json",
		postData: {keyword: keyword},
		colNames : ['번호', '챔피언','제목', '조회수', '추천 수', '날짜'],
	    colModel:[
	        {name:'t_b_num', index:'t_b_num', width: 50, align: "center", key:true},
	        {name:'champion_kr_name', index:'t_b_num', width: 100, align: "center"},
	        {name:'t_b_title', index:'t_b_num', width:600, align: "center", sortable : false},
	        {name:'t_b_views', index:'t_b_num', width:50, align: "center"},
	        {name:'t_b_recom', index:'t_b_num', width:50, align: "center"},
	        {name:'t_b_date', index:'t_b_num', width:150, align: "center"}
	    ],
			loadtext : '로딩중..',
			sortable : true,
			loadonce : true,
			multiselect: false,
			pager:'#pager',
			rowNum: 10,
			sortname: 'date',
			sortorder: 'desc',
			width: 1150,
			height: 400,
		    pgbuttons: true,  // 이전/다음 버튼 표시 여부
		    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
		    viewrecords: false, // 레코드 수 표시 여부
		    recordpos: 'left', // 레코드 수 위치
		    pagerpos: 'center', // 페이징 버튼 위치
		    pginput: false, 
		onSelectRow: function(rowid){
			location.href = `/tip/details?t_b_num=\${rowid}`
		}
	}).trigger("reloadGrid");
})

function selectChampion(champion) {
	
	$("#grid").jqGrid('setGridParam',{
		url : "/tip/searchId.json",
		datatype : "json",
		postData: {keyword: champion},
		colNames : ['번호', '챔피언','제목', '조회수', '추천 수', '날짜'],
	    colModel:[
	        {name:'t_b_num', index:'t_b_num', width: 50, align: "center", key:true},
	        {name:'champion_kr_name', index:'t_b_num', width: 100, align: "center"},
	        {name:'t_b_title', index:'t_b_num', width:600, align: "center", sortable : false},
	        {name:'t_b_views', index:'t_b_num', width:50, align: "center"},
	        {name:'t_b_recom', index:'t_b_num', width:50, align: "center"},
	        {name:'t_b_date', index:'t_b_num', width:150, align: "center"}
	    ],
			loadtext : '로딩중..',
			sortable : true,
			loadonce : true,
			multiselect: false,
			pager:'#pager',
			rowNum: 10,
			sortname: 'date',
			sortorder: 'desc',
			width: 1150,
			height: 400,
		    pgbuttons: true,  // 이전/다음 버튼 표시 여부
		    pgtext: null,      // 페이징 정보(1 - 10 / 100) 표시 여부
		    viewrecords: false, // 레코드 수 표시 여부
		    recordpos: 'left', // 레코드 수 위치
		    pagerpos: 'center', // 페이징 버튼 위치
		    pginput: false, 
		onSelectRow: function(rowid){
			location.href = `/tip/details?t_b_num=\${rowid}`
		}
	}).trigger("reloadGrid");
}

function championList() {
    $.ajax({
        method: 'get',
        url: '/tip/champion/list'
    }).done(res => {
        var championHTML = '';
        res.forEach(function(champion) {
        	championHTML += '<div class="champion">';
        	championHTML += '<img alt="' + champion.champion_kr_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/'
        	+ champion.champion_img + '"/ onclick="selectChampion(' + champion.champion_id + ')">';
        	championHTML += '</div>';
        });

        $('.champions').html(championHTML);
    }).fail(err => {
        console.log(err);
    });
}

championList();


function selectLane(team_position) {
	$('.champions').empty();
	$.ajax({
		method: 'get',
		url: '/tip/champion/lane',
		data: {team_position:team_position},
	}).done(res=>{
        var championHTML = '';
        res.forEach(function(champion) {
        	championHTML += '<div class="champion">';
        	championHTML += '<img alt="' + champion.champion_kr_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/'
            + champion.champion_img + '"/ onclick="selectChampion(\'' + champion.champion_id + '\')">'; 
        	championHTML += '</div>';
        });

        $('.champions').html(championHTML);
	}).fail(err=>{
		console.log(err);
	})
} 

</script>
</html>