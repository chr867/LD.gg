<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소환사 랭킹</title>
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

img{
	width:80px;
	height:80px;
}

.game-filter:hover{
	
}
</style>

</head>
<body>

	<!-- 부모 div가 전체적으로 감싸안고, 그 밑으로 랭킹 정보를 테이블로 표현 -->

	<div id="rank_tool">
		<div>
			<header>
				<div class="game-filter" id="solo_rank">
					<strong style = "cursor:pointer">솔로 랭크</strong>
				</div>
				<div class="game-filter" id="flex_rank">
					<strong style = "cursor:pointer">자유 랭크</strong>
				</div>
				<div class="game-filter" id="level">
					<strong style = "cursor:pointer">레벨</strong>
				</div>
			</header>
			
		<div id = "grid-wrapper">
			<table id="summoner_rank_table"></table>
			<div id = "pager"></div>
		</div>

		</div>
	</div>

	<script type="text/javascript">
	
	$('#summoner_rank_table').jqGrid({
		url : "/summoner/rank/solo/loading/data.json",
		datatype : "json",
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
		pginput : false, // 페이지 번호 입력칸 표시 여부,
		colNames : [ '소환사', '소환사 레벨' ,'티어', '승리', '패배', '리그포인트', '승률' ],
		colModel : [ {
			name: 'summoner_name',
			index: 'summoner_name',
			width: 90,
			align: "center",
			key: true,
			formatter: function(cellvalue, options, rowObject) {
				return "<img src='https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/" + rowObject.profile_icon_id + ".png'/>" + cellvalue;
			},
			cellattr: function(rowId, val, rawObject) {
		        return "onclick=\"location.href='/summoner/info/?'+val\"";
		    }
		}, {
			name : 's_level',
			index : 's_level',
			width : 90,
			align : "center"
		}, {
			name : 'tier',
			index : 'tier',
			width : 90,
			align : "center"
		}, {
			name : 'wins',
			index : 'wins',
			width : 90,
			align : "center"
		}, {
			name : 'losses',
			index : 'losses',
			width : 90,
			align : "center"
		}, {
			name : 'lp',
			index : 'lp',
			width : 90,
			align : "center"
		}, {
			name : 'winrate',
			index : 'winrate',
			width : 90,
			align : "center"
		} ]
	});
	
		$('#solo_rank').click(function(){
			$('#summoner_rank_table').jqGrid({
				url : "/summoner/rank/solo/data.json",
				datatype : "json",
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
				pginput : false, // 페이지 번호 입력칸 표시 여부,
				colNames : [ '소환사', '소환사 레벨' ,'티어', '승리', '패배', '리그포인트', '승률' ],
				colModel : [ {
					name: 'summoner_name',
					index: 'summoner_name',
					width: 90,
					align: "center",
					key: true,
					formatter: function(cellvalue, options, rowObject) {
						return "<img src='https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/" + rowObject.profile_icon_id + ".png'/>" + cellvalue;
					},
					cellattr: function(rowId, val, rawObject) {
				        return "onclick=\"location.href='/summoner/info/?'+val\"";
				    }
				}, {
					name : 's_level',
					index : 's_level',
					width : 90,
					align : "center"
				}, {
					name : 'tier',
					index : 'tier',
					width : 90,
					align : "center"
				}, {
					name : 'wins',
					index : 'wins',
					width : 90,
					align : "center"
				}, {
					name : 'losses',
					index : 'losses',
					width : 90,
					align : "center"
				}, {
					name : 'lp',
					index : 'lp',
					width : 90,
					align : "center"
				}, {
					name : 'winrate',
					index : 'winrate',
					width : 90,
					align : "center"
				} ]
			});
		})
		
		$('#flex_rank').click(function() {
			$('#summoner_rank_table').jqGrid({
				url : "/summoner/rank/flex/data.json",
				datatype : "json",
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
				pginput : false, // 페이지 번호 입력칸 표시 여부,
				colNames : [ '소환사', '소환사 레벨' ,'티어', '승리', '패배', '리그포인트', '승률' ],
				colModel : [ {
					name: 'summoner_name',
					index: 'summoner_name',
					width: 90,
					align: "center",
					key: true,
					formatter: function(cellvalue, options, rowObject) {
						return "<img src='https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/" + rowObject.profile_icon_id + ".png'/>" + cellvalue;
					},
					cellattr: function(rowId, val, rawObject) {
				        return "onclick=\"location.href='/summoner/info/?'+val\"";
				    }
				}, {
					name : 's_level',
					index : 's_level',
					width : 90,
					align : "center"
				}, {
					name : 'tier',
					index : 'tier',
					width : 90,
					align : "center"
				}, {
					name : 'wins',
					index : 'wins',
					width : 90,
					align : "center"
				}, {
					name : 'losses',
					index : 'losses',
					width : 90,
					align : "center"
				}, {
					name : 'lp',
					index : 'lp',
					width : 90,
					align : "center"
				}, {
					name : 'winrate',
					index : 'winrate',
					width : 90,
					align : "center"
				} ]
			});
		});
		
		$('#level').click(function() {
			$('#summoner_rank_table').jqGrid({
				url : "/summoner/rank/level/data.json",
				datatype : "json",
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
				pginput : false, // 페이지 번호 입력칸 표시 여부,
				colNames : [ '소환사', '소환사 레벨' ,'티어', '승리', '패배', '리그포인트', '승률' ],
				colModel : [ {
					name: 'summoner_name',
					index: 'summoner_name',
					width: 90,
					align: "center",
					key: true,
					formatter: function(cellvalue, options, rowObject) {
						return "<img src='https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/" + rowObject.profile_icon_id + ".png'/>" + cellvalue;
					},
					cellattr: function(rowId, val, rawObject) {
				        return "onclick=\"location.href='/summoner/info/?'+val\"";
				    }
				}, {
					name : 's_level',
					index : 's_level',
					width : 90,
					align : "center"
				}, {
					name : 'tier',
					index : 'tier',
					width : 90,
					align : "center"
				}, {
					name : 'wins',
					index : 'wins',
					width : 90,
					align : "center"
				}, {
					name : 'losses',
					index : 'losses',
					width : 90,
					align : "center"
				}, {
					name : 'lp',
					index : 'lp',
					width : 90,
					align : "center"
				}, {
					name : 'winrate',
					index : 'winrate',
					width : 90,
					align : "center"
				} ]
			})
		})
	</script>

</body>
</html>