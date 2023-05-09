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
</style>

</head>
<body>

	<!-- 부모 div가 전체적으로 감싸안고, 그 밑으로 랭킹 정보를 테이블로 표현 -->

	<div id="rank_tool">
		<div>
			<header>
				<div class="game-filter" id="all_game">
					<strong>전체</strong>
				</div>
				<div class="game-filter" id="solo_rank">
					<strong>솔로 랭크</strong>
				</div>
				<div class="game-filter" id="flex_rank">
					<strong>자유 랭크</strong>
				</div>
				<div class="game-filter" id="classic">
					<strong>일반</strong>
				</div>
			</header>

			<table id="summoner_rank_table">

			</table>

		</div>
	</div>

	<script type="text/javascript">
	
	$('#summoner_rank_table').jqGrid({
		url : "/summoner/rank/all/data.json",
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
		colNames : [ '소환사', '소환사 레벨' ,'티어', '랭크', '승리', '패배', '리그포인트', '승률' ],
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
		        return "onclick='location.href=\"/summoner_info/" + val + "\"'";
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
			name : 'division',
			index : 'division',
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
		/* loadtext : '로딩중..',
		sortable : true,
		loadonce : true,
		multiselect : false,
		pager : '#pager',
		rowNum : 100,
		sortname : 'date',
		sortorder : 'desc',
		width : 1000,
		height : 500,
		pgbuttons : true, // 이전/다음 버튼 표시 여부
		pgtext : null, // 페이징 정보(1 - 10 / 100) 표시 여부
		viewrecords : false, // 레코드 수 표시 여부
		recordpos : 'left', // 레코드 수 위치
		pagerpos : 'center', // 페이징 버튼 위치
		pginput : false, // 페이지 번호 입력칸 표시 여부 */
	});
	
	/* $.ajax({
		  method: 'get',
		  url: '/summoner/solo'
		}).done(res => {
			console.log(res);
		  // 티어 우선순위
		  const tierOrder = {
		    "challenger": 0,
		    "grandmaster": 1,
		    "master": 2,
		    "diamond": 3,
		    "platinum": 4,
		    "gold": 5,
		    "silver": 6,
		    "bronze": 7,
		    "iron": 8
		    // 다른 티어가 추가될 경우 여기에 우선순위를 추가
		  };
		  res.sort((a, b) => {
		    if (tierOrder[a.tier] < tierOrder[b.tier]) {
		      return -1;
		    } else if (tierOrder[a.tier] > tierOrder[b.tier]) {
		      return 1;
		    } else {
		      return b.lp - a.lp;
		    }
		  });
		  let sList = "";
		  let i = 1;
		  for (summoner of res) {
		    sList += '<tr class="' + summoner.summoner_name + '" onclick="info(this)">'
		    sList += '<td class="idx">' + i + '</td>'
		    sList += '<td class="icon"><img src="https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/' + summoner.profile_icon_id + '.png"></td>'
		    sList += '<td class="name">' + summoner.summoner_name + '</td>'
		    sList += '<td class="' + summoner.tier + '"><img src="https://opgg-static.akamaized.net/images/medals_new/' + summoner.tier + '.png"></td>'
		    sList += '<td class="lp">' + summoner.lp + '</td>'
		    sList += '<td class="s_level">' + summoner.s_level + '</td>'
		    sList += '<td class="main_lane"><img src="https://ditoday.com/wp-content/uploads/2022/02/ps_' + summoner.main_lane + '.png"></td>'
		    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name1 + '.png" alt="#"></td>'
		    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name2 + '.png" alt="#"></td>'
		    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name3 + '.png" alt="#"></td>'
		    sList += '<td id="winrate">'+summoner.winrate+'</td>'
		    i += 1
		  }
		  $('#summoner_rank_table').html(sList);	//소환사 랭킹 테이블 기본
		}).fail(err=>{
			console.log(err)
		}) */
		
		$('#solo_rank').click(function(){
			$.ajax({
				  method: 'get',
				  url: '/summoner/solo'
				}).done(res => {
				  // 티어 우선순위
				  const tierOrder = {
				    "challenger": 0,
				    "grandmaster": 1,
				    "master": 2,
				    "diamond": 3,
				    // 다른 티어가 추가될 경우 여기에 우선순위를 추가
				  };
				  res.sort((a, b) => {
				    if (tierOrder[a.tier] < tierOrder[b.tier]) {
				      return -1;
				    } else if (tierOrder[a.tier] > tierOrder[b.tier]) {
				      return 1;
				    } else {
				      return b.lp - a.lp;
				    }
				  });
				  let sList = "";
				  let i = 1;
				  for (summoner of res) {
				    sList += '<tr class="' + summoner.summoner_name + '" onclick="info(this)">'
				    sList += '<td class="idx">' + i + '</td>'
				    sList += '<td class="icon"><img src="https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/' + summoner.profile_icon_id + '.png"></td>'
				    sList += '<td class="name">' + summoner.summoner_name + '</td>'
				    sList += '<td class="' + summoner.tier + '"><img src="https://opgg-static.akamaized.net/images/medals_new/' + summoner.tier + '.png"></td>'
				    sList += '<td class="lp">' + summoner.lp + '</td>'
				    sList += '<td class="s_level">' + summoner.s_level + '</td>'
				    sList += '<td class="main_lane"><img src="https://ditoday.com/wp-content/uploads/2022/02/ps_' + summoner.main_lane + '.png"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name1 + '.png" alt="#"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name2 + '.png" alt="#"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name3 + '.png" alt="#"></td>'
				    sList += '<td id="winrate">'+summoner.winrate+'</td>'
				    i += 1
				  }
				  $('#summoner_rank_table').html(sList);	//솔로 랭크 버튼 클릭 시 솔랭 티어 순 정렬
				}).fail(err=>{
					console.log(err)
				})
		})
		
		$('#flex_rank').click(function() {
			$.ajax({
				method : 'get',
				url : '/summoner/flex',
			}).done(res => {
				  // 티어 우선순위
				  const tierOrder = {
				    "challenger": 0,
				    "master": 1,
				    "diamond": 2,
				    "platinum": 3,
				    "gold": 4
				    // 다른 티어가 추가될 경우 여기에 우선순위를 추가해주세요.
				  };
				  res.sort((a, b) => {
				    if (tierOrder[a.tier] < tierOrder[b.tier]) {
				      return -1;
				    } else if (tierOrder[a.tier] > tierOrder[b.tier]) {
				      return 1;
				    } else {
				      return b.lp - a.lp;
				    }
				  });
				  let sList = "";
				  let i = 1;
				  for (summoner of res) {
				    sList += '<tr class="' + summoner.summoner_name + '" onclick="info(this)">'
				    sList += '<td class="idx">' + i + '</td>'
				    sList += '<td class="icon"><img src="https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/' + summoner.profile_icon_id + '.png"></td>'
				    sList += '<td class="name">' + summoner.summoner_name + '</td>'
				    sList += '<td class="' + summoner.tier + '"><img src="https://opgg-static.akamaized.net/images/medals_new/' + summoner.tier + '.png"></td>'
				    sList += '<td class="lp">' + summoner.lp + '</td>'
				    sList += '<td class="s_level">' + summoner.s_level + '</td>'
				    sList += '<td class="main_lane"><img src="https://ditoday.com/wp-content/uploads/2022/02/ps_' + summoner.main_lane + '.png"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name1 + '.png" alt="#"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name2 + '.png" alt="#"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name3 + '.png" alt="#"></td>'
				    sList += '<td id="winrate">' + summoner.winrate + '</td>'
				    i += 1
				  }
				  $('#summoner_rank_table').html(sList);	//자유 랭크 버튼 클릭 시 랭킹 정보 자유 랭크 티어 순 정렬
				}).fail(err=>{
					console.log(err)
				})
		})
		
		$('#level').click(function() {
			$.ajax({
				method : 'get',
				url : '/summoner/level',
			}).done(res => {
				  let sList = "";
				  let i = 1;
				  for (summoner of res) {
				    sList += '<tr class="' + summoner.summoner_name + '" onclick="info(this)">'
				    sList += '<td class="idx">' + i + '</td>'
				    sList += '<td class="icon"><img src="https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/' + summoner.profile_icon_id + '.png"></td>'
				    sList += '<td class="name">' + summoner.summoner_name + '</td>'
				    sList += '<td class="' + summoner.tier + '"><img src="https://opgg-static.akamaized.net/images/medals_new/' + summoner.tier + '.png"></td>'
				    sList += '<td class="lp">' + summoner.lp + '</td>'
				    sList += '<td class="s_level">' + summoner.s_level + '</td>'
				    sList += '<td class="main_lane"><img src="https://ditoday.com/wp-content/uploads/2022/02/ps_' + summoner.main_lane + '.png"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name1 + '.png" alt="#"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name2 + '.png" alt="#"></td>'
				    sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/' + summoner.most_champ_name3 + '.png" alt="#"></td>'
				    sList += '<td id="winrate">' + summoner.winrate + '</td>'
				    i += 1
				  }
				  $('#summoner_rank_table').html(sList);	//레벨 버튼 클릭 시 랭킹 정보 레벨 순 정렬
				}).fail(err=>{
					console.log(err)
				})
		})
		
		function info(summoner){
			let summoner_name = summoner.getAttribute("summoner_name")
			location.href = "/info/?summoner_name="+summoner_name
		}
		
		 $(function(){
			if($('.tier').html() === "challenger"){
				let image = new Image();
				image.src = 'https://opgg-static.akamaized.net/images/medals_new/challenger.png';
				$('.tier').html("challenger").append(image);
			}
			if($('.tier').html() === "master"){
				let image = new Image();
				image.src = 'https://opgg-static.akamaized.net/images/medals_new/master.png';
				$('.tier').html("master").append(image);
			}
			if($('.tier').html() === "diamond"){
				let image = new Image();
				image.src = "https://opgg-static.akamaized.net/images/medals_new/diamond.png";
				$('.tier').html("diamond").append(image);
			}
			if($('.tier').html() === "platinum"){
				let image = new Image();
				image.src = 'https://opgg-static.akamaized.net/images/medals_new/platinum.png';
				$('.tier').html("platinum").append(image);
			}
		});
		
	</script>

</body>
</html>