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
</head>
<body>

	<!-- 부모 div가 전체적으로 감싸안고, 그 밑으로 랭킹 정보를 테이블로 표현 -->

	<div id="rank_tool">
		<!-- 소환사 랭킹 정보 전체 창 -->

		<div>
			<!-- 정렬 필터 -->
			<button type = "button" id="solo_rank">솔로랭크</button>
			<button type = "button"  id="flex_rank">자유랭크</button>
			<button type = "button" id="level">레벨</button>
		</div>

		<table id="summnoner_rank_table">
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
		</table>

	</div>

	<script type="text/javascript">
		$.ajax({
			method : 'get',
			url : '/summoner/ranking'
		}).done(res=>{
			let i = 1;
			let sList = '<tbody>'
			for(summoner of res){
				sList += '<tr id = "'+summoner.summoner_name+'" onclick = "info(this)">'
				sList += '<td id = "idx">'+i+'</td>'
				sList += '<td id = "icon"><img src = "https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/'+summoner.profile_icon_id+'.png"></td>'
				sList += '<td id = "name">'+summoner.summoner_name+'</td>'
				sList += '<td id = "tier"><img alt="#" src="https://opgg-static.akamaized.net/images/medals/'+summoner.tier+"_"+summoner.ranking+'.png"></td>'
				sList += '<td id = "lp">'+summoner.lp+'</td>'
				sList += '<td id = "s_level">'+summoner.s_level+'</td>'
				sList += '<td id = lane><img src = "https://ditoday.com/wp-content/uploads/2022/02/ps_'+summoner.main_lane+'.png"></td>'
				sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id1+'.png" alt="#"></td>'
				sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id2+'.png" alt="#"></td>'
				sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id3+'.png" alt="#"></td>'
				sList += '<td id = winrate>'+summoner.winrate+'</td>'
				i += 1
			}
			sList += '</tbody>'
			$('#summoner_rank_table').html(sList)	//소환사 랭킹 테이블 기본
		}).fail(err=>{
			console.log(err)
		})
		
		/* $('#solo_rank').click(function() {
			$.ajax({
				method : 'get',
				url : '/solo',
			}).done(res=>{
				let i = 1
				let sList = '<tbody>'
				for(summoner of res){
					sList += '<tr id = "'summoer.summoner_name'" onclick = "info(this)">'
					sList += '<td id = "idx">'i'</td>'
					sList += '<td id = "icon"><img src = "https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/'+summoner.profile_icon_id'.png"></td>'
					sList += '<td id = "name">'summoner.summoner_name'</td>'
					sList += '<td id = "tier">'summoer.tier'</td>'
					sList += '<td id = "lp">'summoner.lp'</td>'
					sList += '<td id = "s_level">'summoer.s_level'</td>'
					sList += '<td id = lane><img src = "https://ditoday.com/wp-content/uploads/2022/02/ps_'summoner.main_lane'.png"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id1+'.png" alt="#"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id2+'.png" alt="#"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id3+'.png" alt="#"></td>'
					sList += '<td id = winrate>'summoner.winrate'</td>'
				sList += '</tbody>'
				$('#summoner_rank_table').html(sList)
				}
			}).fail(err=>{
				console.log(err)
			})
		})
		
		$('#flex_rank').click(function() {
			$.ajax({
				method : 'get',
				url : '/flex',
			}).done(res=>{
				let i = 1
				let sList = '<tbody>'
				for(summoner of res){
					sList += '<tr id = "'summoner.summoner_name'" onclick = "info(this)">'
					sList += '<td id = "idx">'i'</td>'
					sList += '<td id = "icon"><img src = "https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/'+summoner.profile_icon_id'.png"></td>'
					sList += '<td id = "name">'summoner.summoner_name'</td>'
					sList += '<td id = "tier">'summoner.tier'</td>'
					sList += '<td id = "lp">'summoner.lp'</td>'
					sList += '<td id = "s_level">'summoer.s_level'</td>'
					sList += '<td id = lane><img src = "https://ditoday.com/wp-content/uploads/2022/02/ps_'summoner.main_lane'.png"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id1+'.png" alt="#"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id2+'.png" alt="#"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id3+'.png" alt="#"></td>'
					sList += '<td id = winrate>'summoner.winrate'</td>'
				sList += '</tbody>'
				$('#summoner_rank_table').html(sList)
				}
			}).fail(err=>{
				console.log(err)
			})
		})
		
		$('#level').click(function() {
			$.ajax({
				method : 'get',
				url : '/level',
			}).done(res=>{
				let i = 1
				let sList = '<tbody>'
				for(summoner of res){
					sList += '<tr id = "'summoer.summoner_name'" onclick = "info(this)">'
					sList += '<td id = "idx">'i'</td>'
					sList += '<td id = "icon"><img src = "https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/'+summoner.profile_icon_id'.png"></td>'
					sList += '<td id = "name">'summoner.summoner_name'</td>'
					sList += '<td id = "tier">'summoer.tier'</td>'
					sList += '<td id = "lp">'summoner.lp'</td>'
					sList += '<td id = "s_level">'summoer.s_level'</td>'
					sList += '<td id = lane><img src = "https://ditoday.com/wp-content/uploads/2022/02/ps_'summoner.main_lane'.png"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id1+'.png" alt="#"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id2+'.png" alt="#"></td>'
					sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id3+'.png" alt="#"></td>'
					sList += '<td id = winrate>'summoner.winrate'</td>'
				sList += '</tbody>'
				$('#summoner_rank_table').html(sList)
				}
			}).fail(err=>{
				console.log(err)
			})
		})
		
		function info(summoner){
			let summoner_name = summoner.getAttribute("summoner_name")
			location.href = "/info/?summoner_name="+summoner_name
		} */
		
	</script>

</body>
</html>