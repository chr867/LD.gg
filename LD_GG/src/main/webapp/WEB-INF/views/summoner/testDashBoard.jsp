<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 대시보드</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
</head>
<body>
	<div class = "flex-dashboard"> <!--  -->
		<div class = "flex-my-profile">
			<img alt="#" src="https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/${summoner.profile_icon_id}.png" class = "flex-profile-icon">
			<p class = "flex-summonerName">${summoner.summoner_name}</p>
		</div>
		<div class = "flex-filter">
			<button type = "button" class = "flex-game-statistics" id = "gameStatistics">게임 통계</button>
			<button type = "button" class = "flex-cite-statistics" id = "citeStatistics">사이트 이용 통계</button>
		</div>
		
		<div class = "flex-tier">
			<div class = "flex-tier-title">솔로랭크</div>
			<div class = " flex-tier-info">
				<div class = "flex-tier-icon">
					<img alt="#" src="https://opgg-static.akamaized.net/images/medals_new/${summoner.tier}.png">
				</div>
				<div class = "flex-tier-data">
					<strong class = "flex-tier-text">${summoner.tier}</strong>
					<strong class = "flex-lp">${summoner.lp} LP</strong>
				</div>
				<div class = "flex-winrate">
					<span class = "flex-win/lose">${summoner.wins}승 ${summoner.losses}패</span>
					<span class = "flex-winrate-data">승률 ${summoner.winrate}%</span>
				</div>
			</div>
		</div>
		<div class = "flex-rank-data">
			<div class = "flex-20Games">
				<div class = "flex-20Games-win/lose-div">
					<p class = "flex-20Games-win/lose"></p>
				</div>
			</div>
			<div class = "flex-kda">
				<%-- <span class = "flex-kda-data">${summoner.middle_kda}/ <span class = "flex-kda-data">${summoner.lower_kda}/</span> <span class = "flex-kda-data">${summoner.max_kda}</span> </span>
				<strong class = "flex-kda-average">${summoner.average_kda}</strong> --%>
			</div>
			<div class = "flex-prefer-position">
				<%-- <img alt="#" src="https://ditoday.com/wp-content/uploads/2022/02/${summoner.position}.png"> --%>
			</div>
		</div>
		<div class = "flex-rank-winrate">
			<div class = "flex-winrate-title">최근 20게임간의 승률</div>
			<div class = "flex-winrate-subtitle">
				<p class = "flex-champion">챔피언</p>
				<p class = "flex-champion-winrate">승률</p>
			</div>
			
			<div class = "flex-champion-data">
				<div class = "flex-champion-image"></div>
				<div class = "flex-champion-name"></div>
				<div class = "flex-champion-wins"></div>
				<div class = "flex-champion-winrate"></div>
			</div>
			
		</div>
		<div class = "tier-graph">?</div>
		<div class = "flex-matchup-summoner">
			<div class = "flex-matchup-title">
				<p class = "flex-matchup-text">함께 플레이한 소환사</p>
			</div>
			<div class = "flex-matchup-categories">
				<div class = "category">소환사 이름</div>
				<div class = "category">솔로 랭크</div>
				<div class = "category">게임 수</div>
				<div class = "category">승리</div>
				<div class = "category">패배</div>
				<div class = "category">승률</div>
			</div>
			<div class = "flex-matchup-data"></div>
		</div>
	</div>
	
	<script type="text/javascript">
/* 	function loadingKdaData(){
		$.ajax({
			method : 'get',
			url : '/summoner/dashboard/kda',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			console.log(res);
		}).fail(err=>{
			console.log(err);
		})
	}
	
	function loadingMatchUpData(){
		$.ajax({
			method : 'get',
			url : '/summoner/dashboard/matchup',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			let div = $('<div class = "flex-matchup-data"></div>');
			console.log(res);
		}).fail(err=>{
			console.log(err);
		})
	}
	
	function loadingRecentWinrate(){
		$.ajax({
			method : 'get',
			url : '/summoner/dashboard/recent',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			console.log(res);
		}).fail(err=>{
			console.log(err);
		})
	} */
	</script>
	
</body>
</html>