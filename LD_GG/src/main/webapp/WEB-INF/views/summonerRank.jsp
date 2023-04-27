<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script src="/resources/js/jquery.serializeObject.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'
	crossorigin='anonymous'></script>
</head>
<body>

	<!-- 부모 div가 전체적으로 감싸안고, 그 안에서 상단부에 검색창, 그 밑으로 랭킹 정보를 테이블로 표현 -->
	
	<div class = "div" id = "rank_tool">	<!-- 소환사 랭킹 정보 전체 창 -->
		
		<div class = "div" id = "summoner_search">
			<form action="/summoner/search" method = "GET">
				<input type = "text" id = "search_summoner">
			</form>
			
		</div>	<!-- 소환사 검색창 -->
		
		<table id = "summnoner_rank_table">
			<tr>
				<th>순위</th>
				<th>소환사</th>
				<th>티어</th>
				<th>LP</th>
				<th>레벨</th>
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
			url : '/ranking'
		}).done(res=>{
			let i = 1;
			let slist = '<tbody>';
			for(summoner of res){
				sList += '<tr id = "'summoer.summoner_name'" onclick = "detail(this)">'
				sList += '<td id = "idx">'i'</td>'
				sList += '<td id = "icon">'summoner.profile_icon_id'</td>'
				sList += '<td id = "name">'summoner.summoner_name'</td>'
				sList += '<td id = "tier">'summoer.tier'</td>'
				sList += '<td id = "lp">'summoner.lp'</td>'
				sList += '<td id = "level">'summoer.s_level'</td>'
				sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id1+'.png" alt="#"></td>'
				sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id2+'.png" alt="#"></td>'
				sList += '<td><img src="https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+summoner.most_champ_id3+'.png" alt="#"></td>'
				sList += '<td id = winrate>'summoner.winrate'</td>'
			}
		}).fail(err=>{
			console.log(err)
		})
	
	</script>
	
</body>
</html>