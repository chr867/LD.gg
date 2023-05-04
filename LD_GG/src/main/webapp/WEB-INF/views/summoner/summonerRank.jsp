<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>

<style type="text/css">
</style>

</head>
<body>

	<!-- 부모 div가 전체적으로 감싸안고, 그 밑으로 랭킹 정보를 테이블로 표현 -->

	<div id="rank_tool">
		<!-- 소환사 랭킹 정보 전체 창 -->

		<div>
			<!-- 정렬 필터 -->
			<button type="button" class="game-filter">솔로랭크</button>
			<button type="button" class="game-filter">자유랭크</button>
			<button type="button" class="game-filter">레벨</button>
		</div>

		<table>
			<thead>
				<tr>
					<th>순위</th>
					<th>소환사</th>
					<th>티어</th>
					<th>LP</th>
					<th>레벨</th>
					<th>주 포지션</th>
					<th>모스트 챔피언1</th>
					<th>모스트 챔피언2</th>
					<th>모스트 챔피언3</th>
					<th>승률</th>
				</tr>
			</thead>

			<tbody id="summoner_rank_table">

			</tbody>

		</table>

	</div>

	<script type="text/javascript">
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
		  $('#summoner_rank_table').html(sList);	//소환사 랭킹 테이블 기본
		}).fail(err=>{
			console.log(err)
		})
		
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