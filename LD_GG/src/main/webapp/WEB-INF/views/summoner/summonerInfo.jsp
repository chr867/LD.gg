<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${summoner.summoner_name} - 소환사 전적</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>

<link  href = "/resources/css/summoner/summonerInfo.css?after" rel = "stylesheet">

</head>
<body>

	<div id="flex_div">
	
		<div id="background-profile">
			<div id="summoner-profile">
				<div id="profile-icon">
					<img class = "flex-profile-img" alt="#" src="/resources/img/profileicon/${summoner.profile_icon_id}.png">
					<div class = "flex-summoner-level"> <p id="summoner-level">${summoner.s_level}</p> </div>
				</div>
				<button id="renewal" value="전적 갱신">전적 갱신</button>
			</div>
		</div>

		<div id="solo-rank">
			<img class = "flex-tier" alt="#" src="/resources/img/ranked-emblem/emblem-${summoner.tier}.png">
		</div>

		<div id="tier-graph"></div>

		<div id="champ-stat">

			<div id="champ_rank_filter"></div>

			<div id="champ_position_filter"></div>

			<div class = "flex-champ-div">
				<header class = "flex-header">챔피언 통계</header>
				<div class = "flex-category">
						<div class = "champion_category">챔피언</div>
						
						<div class = "winrate_category">승률</div>
						
						<div class = "games_category">게임 수</div>
						
						<div class = "wins_category">승리	</div>
						
						<div class = "losses_category">패배</div>
						
						<div class = "kda_category">KDA</div>
						
						<div class = "kills_category">킬	</div>
						
						<div class = "deaths_category">데스</div>
						
						<div class = "assists_category">어시스트</div>
						
						<div class = "cs_category">CS</div>
						
						<div class = "cs_pm_category">분당 CS	</div>
				</div>
			</div>
			
			<div class = "flex-champ-record"></div>

		</div>

			<div id="match_history">
				<span id="history">매치 히스토리</span>
			</div>
			<!-- 전적 정보 필터 -->

			<div id="record_filter">
				<button type="button" class = "record-filter-btn" value = "all">전체</button>
				<button type="button" class = "record-filter-btn" value = "solo">솔로 랭크</button>
				<button type="button" class = "record-filter-btn" value = "flex">자유 랭크</button>
				<button type="button" class = "record-filter-btn" value = "classic">일반</button>
			</div>

			<div class = "flex-summary-table">
				<header class = "flex-summary-header">
					<span>최근 20게임 전적 요약</span>
				</header>
			</div>
			
			<div class = "flex-summary-category">
				
				<div class = "header-winrate-category">승률</div>
				
				<div class = "header-kda-category">평점</div>
				
				<div class = "header-KDA-category">최고평점</div>
				
				<div class = "header-lane-category">포지션별 픽률</div>
				
				<div class = "header-mostChamp-category">자주 플레이한 챔피언</div>
					
			</div>
			
			<div id = "recent_20games"></div>

			<div id="record"></div>

		</div>

 	<script type="text/javascript">
 	let Sessiontier = '${summoner.tier}';
 	let tier = "";
	if(Sessiontier === 'challenger'){
		tier = "Challenger";
	}else if('${summonmer.tier}' === 'grandmaster'){
		tier = "Grandmaster"
	}else if('${summonmer.tier}' === 'master'){
		tier = "Master"
	}else if('${summonmer.tier}' === 'platinum'){
		tier = "Plat"
	}else if('${summonmer.tier}' === 'gold'){
		tier = "Gold"
	}else if('${summonmer.tier}' === 'silver'){
		tier = "Silver"
	}else if('${summonmer.tier}' === 'bronze'){
		tier = "Bronze"
	}
	let champOffset = 0;
	let recordOffset = 0;
	
	$('#renewal').click(function(){
		location.reload();
	})
	
 	$.ajax({//소환사의 챔피언 통계 필터 버튼 생성(포지션별 픽률 높은 순으로 생성)
		method : 'get',
		url : '/summoner/get_champ_position_filter',
		data : {summoner_name : '${summoner.summoner_name}'}
	}).done(res=>{
		let lane1 = "";
		let lane2 = "";
		let lane3 = "";
		let filterBtnDiv = $('<div class = "filterBtnDiv"></div>');
		let filterBtnAll = $('<button class = "champRecrodFilterBtn" type = "button" value = "all-btn">전체</button>');
		filterBtnDiv.append(filterBtnAll);
		$.each(res, function(i, res){
			if(res.lane1 != null){
				if(res.lane1 === 'top'){
					lane1 = "Top";
				}else if(res.lane1 === 'middle'){
					lane1 = "Mid";
				}else if(res.lane1 === 'jungle'){
					lane1 = "Jungle";
				}else if(res.lane1 === 'bottom'){
					lane1 = "Bot";
				}else if(res.lane1 === 'utility'){
					lane1 = 'Support';
				}
				let filterBtn1 = $('<button class = "champRecordFilterBtn" type = "button" value = "'+res.lane1+'"><img class = "flex-'+res.lane1+'" src = "/resources/img/ranked-positions/Position_'+tier+'-'+lane1+'.png"></button>');
				filterBtnDiv.append(filterBtn1);
			}
			if(res.lane2 != null){
				if(res.lane2 === 'top'){
					lane2 = "Top";
				}else if(res.lane2 === 'middle'){
					lane2 = "Mid";
				}else if(res.lane2 === 'jungle'){
					lane2 = "Jungle";
				}else if(res.lane2 === 'bottom'){
					lane2 = "Bot";
				}else if(res.lane2 === 'utility'){
					lane2 = 'Support';
				}
				let filterBtn2 = $('<button class = "champRecordFilterBtn" type = "button" value = "'+res.lane2+'"><img class = "flex-'+res.lane2+'" src = "/resources/img/ranked-positions/Position_'+tier+'-'+lane2+'.png"></button>');
				filterBtnDiv.append(filterBtn2);
			}
			if(res.lane3 != null){
				if(res.lane3 === 'top'){
					lane3 = "Top";
				}else if(res.lane3 === 'middle'){
					lane3 = "Mid";
				}else if(res.lane3 === 'jungle'){
					lane3 = "Jungle";
				}else if(res.lane3 === 'bottom'){
					lane3 = "Bot";
				}else if(res.lane3 === 'utility'){
					lane3 = 'Support';
				}
				let filterBtn3 = $('<button class = "champRecordFilterBtn" type = "button" value = "'+res.lane3+'"><img class = "flex-'+res.lane3+'" src = "/resources/img/ranked-positions/Position_'+tier+'-'+lane3+'.png"></button>');
				filterBtnDiv.append(filterBtn3);
			}
		})
	$('#champ_position_filter').html(filterBtnDiv);
	}).fail(err=>{
		console.log(err);
	});
	
	$.ajax({//소환사의 챔피언 통계
		method: 'get',
		url: '/summoner/get_champ_record',
		data: { summoner_name: '${summoner.summoner_name}' }
	}).done(res => {
		let champ_div = $('<div class = "flex-champ"></div>');
		let winrate_div = $('<div class = "flex-champ-winrate"></div>');
		let games_div = $('<div class = "flex-champ-games"></div>');
		let wins_div = $('<div class = "flex-champ-wins"></div>');
		let losses_div = $('<div class = "flex-champ-losses"></div>');
		let kda_div = $('<div class = "flex-champ-kda"></div>');
		let kills_div = $('<div class = "flex-champ-kills"></div>');
		let deaths_div = $('<div class = "flex-champ-deaths"></div>');
		let assists_div = $('<div class = "flex-champ-assists"></div>');
		let cs_div = $('<div class = "flex-champ-cs"></div>');
		let cs_pm_div = $('<div class = "flex-champ-cs-pm"></div>');
		$.each(res, function (i, champ) {
			let champ_box = $('<div class = "champ-div"></div>')
			let champ_img = $('<img class = "champ-img" alt="#" src="/resources/img/champion_img/square/'+champ.champ_name+'.png"><span class = "champ-name">' + champ.champ_name + '</span>');
			champ_box.append(champ_img);
			champ_div.append(champ_box);
		});
		$.each(res, function (i, winrate) {
			let winrate_text = $('<strong class = "champ-winrate">' + winrate.winrate + '%</strong>');
			winrate_div.append(winrate_text);
		});
		$.each(res, function (i, games) {
			let games_text = $('<span class = "champ-games">' + games.games + '</span>');
			games_div.append(games_text);
		});
		$.each(res, function (i, wins) {
			let win_text = $('<span class = "champ-wins">' + wins.wins + '</span>');
			wins_div.append(win_text);
		});
		$.each(res, function (i, losses) {
			let losses_text = $('<span class = "champ-losses">' + losses.losses + '</span>');
			losses_div.append(losses_text);
		});
		$.each(res, function (i, kda) {
			let kda_text = $('<strong class = "champ-kda">' + kda.kda + '</strong>');
			kda_div.append(kda_text);
		});
		$.each(res, function (i, kills) {
			let kills_text = $('<span class = "champ-kills">' + kills.kills + '</span>');
			kills_div.append(kills_text);
		});
		$.each(res, function (i, deaths) {
			let deaths_text = $('<span class = "champ-deaths">' + deaths.deaths + '</span>');
			deaths_div.append(deaths_text);
		});
		$.each(res, function (i, assists) {
			let assists_text = $('<span class = "champ-assists">' + assists.assists + '</span>');
			assists_div.append(assists_text);
		});
		$.each(res, function (i, cs) {
			let cs_text = $('<strong class = "champ-cs">' + cs.cs + '</strong>');
			cs_div.append(cs_text);
		});
		$.each(res, function (i, cs_pm) {
			let cs_pm_text = $('<span class = "champ-cs-pm">' + cs_pm.cs_per_minute + '<span>');
			cs_pm_div.append(cs_pm_text);
		});
		let champRecordDiv = $('<div class = "flex-champ-table"></div>');
		champRecordDiv.append(champ_div, winrate_div, games_div, wins_div, losses_div, kda_div, kills_div, deaths_div, assists_div, cs_div, cs_pm_div);
		$('.flex-champ-record').html(champRecordDiv);
		if(res.length >= 20){
			let moreBtn = $('<button class = "moreBtn">더 보기</button>');
			$('.flex-champ-record').append(moreBtn);
		}
	}).fail(err => {
		console.log(err);
	});
	
	$('.champRecordFilterBtn').click(function(){
		if($(this).val() === 'all-btn'){
			$.ajax({//소환사의 챔피언 통계
				method: 'get',
				url: '/summoner/get_champ_record',
				data: { summoner_name: '${summoner.summoner_name}' }
			}).done(res => {
				let champ_div = $('<div class = "flex-champ"></div>');
				let winrate_div = $('<div class = "flex-champ-winrate"></div>');
				let games_div = $('<div class = "flex-champ-games"></div>');
				let wins_div = $('<div class = "flex-champ-wins"></div>');
				let losses_div = $('<div class = "flex-champ-losses"></div>');
				let kda_div = $('<div class = "flex-champ-kda"></div>');
				let kills_div = $('<div class = "flex-champ-kills"></div>');
				let deaths_div = $('<div class = "flex-champ-deaths"></div>');
				let assists_div = $('<div class = "flex-champ-assists"></div>');
				let cs_div = $('<div class = "flex-champ-cs"></div>');
				let cs_pm_div = $('<div class = "flex-champ-cs-pm"></div>');
				$.each(res, function (i, champ) {
					let champ_box = $('<div class = "champ-div"></div>')
					let champ_img = $('<img class = "champ-img" alt="#" src="/resources/img/champion_img/square/'+champ.champ_name+'.png"><span class = "champ-name">' + champ.champ_name + '</span>');
					champ_box.append(champ_img);
					champ_div.append(champ_box);
				});
				$.each(res, function (i, winrate) {
					let winrate_text = $('<strong class = "champ-winrate">' + winrate.winrate + '%</strong>');
					winrate_div.append(winrate_text);
				});
				$.each(res, function (i, games) {
					let games_text = $('<span class = "champ-games">' + games.games + '</span>');
					games_div.append(games_text);
				});
				$.each(res, function (i, wins) {
					let win_text = $('<span class = "champ-wins">' + wins.wins + '</span>');
					wins_div.append(win_text);
				});
				$.each(res, function (i, losses) {
					let losses_text = $('<span class = "champ-losses">' + losses.losses + '</span>');
					losses_div.append(losses_text);
				});
				$.each(res, function (i, kda) {
					let kda_text = $('<strong class = "champ-kda">' + kda.kda + '</strong>');
					kda_div.append(kda_text);
				});
				$.each(res, function (i, kills) {
					let kills_text = $('<span class = "champ-kills">' + kills.kills + '</span>');
					kills_div.append(kills_text);
				});
				$.each(res, function (i, deaths) {
					let deaths_text = $('<span class = "champ-deaths">' + deaths.deaths + '</span>');
					deaths_div.append(deaths_text);
				});
				$.each(res, function (i, assists) {
					let assists_text = $('<span class = "champ-assists">' + assists.assists + '</span>');
					assists_div.append(assists_text);
				});
				$.each(res, function (i, cs) {
					let cs_text = $('<strong class = "champ-cs">' + cs.cs + '</strong>');
					cs_div.append(cs_text);
				});
				$.each(res, function (i, cs_pm) {
					let cs_pm_text = $('<span class = "champ-cs-pm">' + cs_pm.cs_per_minute + '<span>');
					cs_pm_div.append(cs_pm_text);
				});
				let champRecordDiv = $('<div class = "flex-champ-table"></div>');
				champRecordDiv.append(champ_div, winrate_div, games_div, wins_div, losses_div, kda_div, kills_div, deaths_div, assists_div, cs_div, cs_pm_div);
				$('.flex-champ-record').html(champRecordDiv);
			}).fail(err => {
				console.log(err);
			});
		}else{
			let paramLane = $(this).val();
			paramLane = paramLane.toUpperCase();
			$.ajax({//소환사의 챔피언 통계
				method: 'get',
				url: '/summoner/getChampRecordLane',
				data: { summoner_name: '${summoner.summoner_name}', lane : paramLane }
			}).done(res => {
				let champ_div = $('<div class = "flex-champ"></div>');
				let winrate_div = $('<div class = "flex-champ-winrate"></div>');
				let games_div = $('<div class = "flex-champ-games"></div>');
				let wins_div = $('<div class = "flex-champ-wins"></div>');
				let losses_div = $('<div class = "flex-champ-losses"></div>');
				let kda_div = $('<div class = "flex-champ-kda"></div>');
				let kills_div = $('<div class = "flex-champ-kills"></div>');
				let deaths_div = $('<div class = "flex-champ-deaths"></div>');
				let assists_div = $('<div class = "flex-champ-assists"></div>');
				let cs_div = $('<div class = "flex-champ-cs"></div>');
				let cs_pm_div = $('<div class = "flex-champ-cs-pm"></div>');
				$.each(res, function (i, champ) {
					let champ_box = $('<div class = "champ-div"></div>')
					let champ_img = $('<img class = "champ-img" alt="#" src="/resources/img/champion_img/square/'+champ.champ_name+'.png"><span class = "champ-name">' + champ.champ_name + '</span>');
					champ_box.append(champ_img);
					champ_div.append(champ_box);
				});
				$.each(res, function (i, winrate) {
					let winrate_text = $('<strong class = "champ-winrate">' + winrate.winrate + '%</strong>');
					winrate_div.append(winrate_text);
				});
				$.each(res, function (i, games) {
					let games_text = $('<span class = "champ-games">' + games.games + '</span>');
					games_div.append(games_text);
				});
				$.each(res, function (i, wins) {
					let win_text = $('<span class = "champ-wins">' + wins.wins + '</span>');
					wins_div.append(win_text);
				});
				$.each(res, function (i, losses) {
					let losses_text = $('<span class = "champ-losses">' + losses.losses + '</span>');
					losses_div.append(losses_text);
				});
				$.each(res, function (i, kda) {
					let kda_text = $('<strong class = "champ-kda">' + kda.kda + '</strong>');
					kda_div.append(kda_text);
				});
				$.each(res, function (i, kills) {
					let kills_text = $('<span class = "champ-kills">' + kills.kills + '</span>');
					kills_div.append(kills_text);
				});
				$.each(res, function (i, deaths) {
					let deaths_text = $('<span class = "champ-deaths">' + deaths.deaths + '</span>');
					deaths_div.append(deaths_text);
				});
				$.each(res, function (i, assists) {
					let assists_text = $('<span class = "champ-assists">' + assists.assists + '</span>');
					assists_div.append(assists_text);
				});
				$.each(res, function (i, cs) {
					let cs_text = $('<strong class = "champ-cs">' + cs.cs + '</strong>');
					cs_div.append(cs_text);
				});
				$.each(res, function (i, cs_pm) {
					let cs_pm_text = $('<span class = "champ-cs-pm">' + cs_pm.cs_per_minute + '<span>');
					cs_pm_div.append(cs_pm_text);
				});
				let champRecordDiv = $('<div class = "flex-champ-table"></div>');
				champRecordDiv.append(champ_div, winrate_div, games_div, wins_div, losses_div, kda_div, kills_div, deaths_div, assists_div, cs_div, cs_pm_div);
				$('.flex-champ-record').html(champRecordDiv);
			}).fail(err => {
				console.log(err);
			});
		}
	});
	
 	 $.ajax({//최근 20전적 요약본
		method : 'get',
		url : '/summoner/get_20games_summary',
		data : {summoner_name : '${summoner.summoner_name}'}
	}).done(res=>{
		let champDataDiv = $('<div class = "champDataDiv"></div>');
		let kdaAvgDiv = $('<div class = "kdaAvgDiv"></div>');
		let bestKdaDiv = $('<div class = "bestKdaDiv"></div>');
		let positionDIV = $('<div class = "positionDiv"></div>');
		let champ1 = $('<div class = "mostChamp"></div>');
		let champ2 = $('<div class = "mostChamp"></div>');
		let champ3 = $('<div class = "mostChamp"></div>');
		let champ = $('<div class = "mostChampDiv"></div>')
		
		$.each(res, function(i, res){
			let winrate_strong = $('<strong class = "strong-winrate">'+res.winrate+'%</strong><br>');//승률
			let win_data_span = $('<span class = "span-winrate">' + res.wins+ '승 ' + res.losses + '패</span>');//승리,패뱃 수 데이터
			champDataDiv.append(winrate_strong, win_data_span);
			
			let kdaAvg = $('<strong class = "strong-kda-avg">'+res.kda_avg+'</strong><br>');//평점(kda의 평균) 데이터
			let k_d_a_Avg = $('<span class = "span-kda-avg">'+res.kill_avg+'/<span>'+res.deaths_avg+'/</span>'+res.assists_avg+'</span>');//평점(kda > 아마 제일 못한 판 / 중간 치 / 제일 잘한 판의 kda인듯)
			kdaAvgDiv.append(kdaAvg, k_d_a_Avg);
			
			let bestKda = $('<strong class = "strong-max-kda">'+res.max_kda+'</strong><br>');//최고 평점(kda) 데이터
			let bestK_D_A = $('<span class = "span-max-kda">'+res.max_kills+'/<span>'+res.max_deaths+'/</span>'+res.max_assists+'</span>');//최고 평점(kda)
			bestKdaDiv.append(bestKda, bestK_D_A);
			
			
			if(res.most_lane1 != null){
				if(res.most_lane1 === 'top'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg1 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Top.png" alt = "#">');
					let positionPick1 = $('<p>'+res.most_lane_pickrate1+'%</p>');
					position_div.append(positionImg1, positionPick1);
					positionDIV.append(position_div);
				}
				if(res.most_lane1 === 'jungle'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg1 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Jungle.png" alt = "#">');
					let positionPick1 = $('<p>'+res.most_lane_pickrate1+'%</p>');
					position_div.append(positionImg1, positionPick1);
					positionDIV.append(position_div);
				}
				if(res.most_lane1 === 'middle'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg1 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Mid.png" alt = "#">');
					let positionPick1 = $('<p>'+res.most_lane_pickrate1+'%</p>');
					position_div.append(positionImg1, positionPick1);
					positionDIV.append(position_div);
				}
				if(res.most_lane1 === 'bottom'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg1 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Bot.png" alt = "#">');
					let positionPick1 = $('<p>'+res.most_lane_pickrate1+'%</p>');
					position_div.append(positionImg1, positionPick1);
					positionDIV.append(position_div);
				}
				if(res.most_lane1 === 'utility'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg1 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Support.png" alt = "#">');
					let positionPick1 = $('<p>'+res.most_lane_pickrate1+'%</p>');
					position_div.append(positionImg1, positionPick1);
					positionDIV.append(position_div);
				}
			}
				
			if(res.most_lane2 != null){
				if(res.most_lane2 === 'top'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg2 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Top.png" alt = "#">');
					let positionPick2 = $('<p>'+res.most_lane_pickrate2+'%</p>');
					position_div.append(positionImg2, positionPick2);
					positionDIV.append(position_div);
				}
				if(res.most_lane2 === 'jungle'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg2 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Jungle.png" alt = "#">');
					let positionPick2 = $('<p>'+res.most_lane_pickrate2+'%</p>');
					position_div.append(positionImg2, positionPick2);
					positionDIV.append(position_div);
				}
				if(res.most_lane2 === 'middle'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg2 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Mid.png" alt = "#">');
					let positionPick2 = $('<p>'+res.most_lane_pickrate2+'%</p>');
					position_div.append(positionImg2, positionPick2);
					positionDIV.append(position_div);
				}
				if(res.most_lane2 === 'bottom'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg2 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Bot.png" alt = "#">');
					let positionPick2 = $('<p>'+res.most_lane_pickrate2+'%</p>');
					position_div.append(positionImg2, positionPick2);
					positionDIV.append(position_div);
				}
				if(res.most_lane2 === 'utility'){
					let position_div = $('<div class = "position_div"></div>');
					let positionImg2 = $('<img src = "/resources/img/ranked-positions/Position_'+tier+'-Support.png" alt = "#">');
					let positionPick2 = $('<p>'+res.most_lane_pickrate2+'%</p>');
					position_div.append(positionImg2, positionPick2);
					positionDIV.append(position_div);
				}
			}
			
			if(res.top_champ1 != null){
				let champ_img1 = $('<img class = "flex-top-champ-img" src = "/resources/img/champion_img/square/'+res.top_champ1+'.png"/>');
				let champ_winrate1 = $('<p>'+res.top_champ1_winrate+'% </p>');
				let champ_win1 = $('<span>('+res.top_champ1_wins+'승</span>');
				let champ_lose1 = $('<span>'+res.top_champ1_losses+'패)</span>');
				champ_winrate1.append(champ_win1,champ_lose1);
				champ1.append(champ_img1,champ_winrate1);
				champ.append(champ1);
			}

			if(res.top_champ2 != null){
				let champ_img2 = $('<img class = "flex-top-champ-img" src = "/resources/img/champion_img/square/'+res.top_champ2+'.png"/>');
				let champ_winrate2 = $('<p>'+res.top_champ2_winrate+'% </p>');
				let champ_win2 = $('<span>('+res.top_champ2_wins+'승</span>');
				let champ_lose2 = $('<span>'+res.top_champ2_losses+'패)</span>');
				champ_winrate2.append(champ_win2,champ_lose2);
				champ2.append(champ_img2,champ_winrate2);	
				champ.append(champ2);
			}
		
			if(res.top_champ3 != null){
				let champ_img3 = $('<img class = "flex-top-champ-img" src = "/resources/img/champion_img/square/'+res.top_champ3+'.png"/>');
				let champ_winrate3 = $('<p>'+res.top_champ3_winrate+'% </p>');
				let champ_win3 = $('<span>('+res.top_champ3_wins+'승</span>');
				let champ_lose3 = $('<span>'+res.top_champ3_losses+'패)</span>');
				champ_winrate3.append(champ_win3,champ_lose3);
				champ3.append(champ_img3,champ_winrate3);	
				champ.append(champ3);
			}
		})
		let div = $('<div class = "flex-summary-div0"></div>');
		div.append(champDataDiv, kdaAvgDiv, bestKdaDiv, positionDIV, champ);
		$('#recent_20games').html(div);
	}).fail(err=>{
		console.log(err)
	});
	
	$.ajax({//전적 정보 가져오기
		method : 'get',
		url : '/summoner/get_summoner_record',
		data : {summoner_name : '${summoner.summoner_name}'}
	}).done(res=>{
		let div = $('<div class = "flex-record-div"></div>');
		$.each(res, function (i, record){
			
			let record_div = $('<div class = "record_div"></div>');	//전적 정보가 담길 div
			
			let record_win_lose_div = $('<div class = "record_win_lose_div"></div>');	//해당 전적의 승패 정보
			let record_champ_div = $('<div class = "record_champ_div"></div>');	//해당 전적에서 사용한 챔피언/룬/스펠 정보
			let record_kda_div = $('<div class = "record_kda_div"></div>');	//KDA 정보
			let record_cs_sight_div = $('<div class = "record_cs_sight_div"></div>');	//CS,시야점수,핑크 와드 설치 수,킬관여율
			let record_item_div = $('<div class = "record_item_div"></div>');	//아이템 정보
			let record_player_div = $('<div class = "record_player_div"></div>');	//해당 전적에서 매칭된 플레이어 목록(챔피언 아이콘 + 소환사 이름)
			let record_team1_div = $('<div class = "record_team1_div"></div>');//팀 아이디 값이 100인 팀
			let record_team2_div = $('<div class = "record_team2_div"></div>');//팀 아이디 값이 200인 팀
			
			let playerName = "";
			
			$.ajax({
				method : 'get',
				url : '/summoner/getMatchUpPlayer',
				data : {match_id : record.match_id}
			}).done(result=>{
				$.each(result, function(j, player){
					let player_div = $('<div class = "playerDiv"></div>');
					if(player.team_id === 100){
						if(player.player === '${summoner.summoner_name}'){
							playerName = $('<strong class = "thisPlayer">'+player.player+'</strong>');
						}else{
							playerName = $('<span class = "playerName">'+player.player+'</span>');
						}
						let playerImg = $('<img class = "playerImg" src = "/resources/img/champion_img/square/'+player.champ_name+'.png">');
						player_div.append(playerImg, playerName);
						record_team1_div.append(player_div);
					}else{
						if(player.player === '${summoner.summoner_name}'){
							playerName = $('<strong class = "thisPlayer">'+player.player+'</strong>');
						}else{
							playerName = $('<span class = "playerName">'+player.player+'</span>');
						}
						let playerImg = $('<img class = "playerImg" src = "/resources/img/champion_img/square/'+player.champ_name+'.png">');
						player_div.append(playerImg, playerName);
						record_team2_div.append(player_div);
					}
				});
				record_player_div.append(record_team1_div, record_team2_div);
			}).fail(error=>{
				console.log(error);
			})
			
			if(record.win === 1){//승패 여부에 따라 승리 div 패배 div 생성
				let record_win_div = $('<div class = "record_win_div"></div>');
				let record_win_strong = $('<strong class = "record_win_strong"></strong>');
				let record_win_span = $('<span class = "record_win_span">승리</span>');
				record_win_strong.append(record_win_span);
				//let record_game_mode = $('<span class = "record_game_mode">'+record.game_mode+'</span>');
				let gameDuration = (record.game_duration / 60).toFixed(2);
				let [minutes, seconds] = gameDuration.split(".");
				let formatedTime = minutes + " : " + seconds.padStart(2, "0");
				let record_game_duration = $('<span class = "record_game_duration">'+formatedTime+'</span>');
				record_win_div.append(record_win_strong,record_game_duration);
				record_win_lose_div.append(record_win_div);
			}else{
				let record_lose_div = $('<div class = "record_lose_div"></div>');
				let record_lose_strong = $('<strong class = "record_lose_strong"></strong>');
				let record_lose_span = $('<span class = "record_lose_span">패배</span>');
				record_lose_strong.append(record_lose_span);
				//let record_game_mode = $('<span class = "record_game_mode">'+record.game_mode+'</span>');
				let gameDuration = (record.game_duration / 60).toFixed(2);
				let [minutes, seconds] = gameDuration.split(".");
				let formatedTime = minutes + " : " + seconds.padStart(2, "0");
				let record_game_duration = $('<span class = "record_game_duration">'+formatedTime+'</span>');
				record_lose_div.append(record_lose_strong,record_game_duration);
				record_win_lose_div.append(record_lose_div);
			}
			
			let record_champ_sub_div = $('<div class = "record_champ_sub_div"></div>');//챔피언 정보 담을 서브 div
			let record_champ_img = $('<img class = "recordChampImg" src = "/resources/img/champion_img/square/'+record.champ_name+'.png">');//챔피언 이미지를 div로 만들기
			let record_champ_level = $('<span class = "record_champ_level">'+record.champ_level+'</span>');//챔피언 레벨을 이미지 위에 띄우기
			record_champ_sub_div.append(record_champ_img,record_champ_level);//레벨을 이미지 위에 띄우기 위해 append
			
			let record_spell_div = $('<div class = "record_spell_div"></div>');//스펠 정보 담을 서브 div
			let record_spell_img1 = $('<img class = "record_spell_img1" src = "/resources/img/spell/'+record.spell1+'.png">');//스펠 이미지 div로 생성
			let record_spell_img2 = $('<img class = "record_spell_img2" src = "/resources/img/spell/'+record.spell2+'.png">');
			record_spell_div.append(record_spell_img1,record_spell_img2);//만들어진 스펠 이미지들을 서브 div에 append
			
			let record_rune_div = $('<div class = "record_rune_div"></div>');//룬 정보 담을 서브 div
			let record_rune_img1 = $('<div class = "runRadiosDiv1"><img class = "record_rune_img1" src = "/resources/img/'+record.main_rune1+'"></div>');//룬 이미지를 div로 생성
			let record_rune_img2 = $('<div class = "runeRadiosDiv2"><img class = "record_rune_img2" src = "/resources/img/'+record.sub_rune+'"></div>');
			record_rune_div.append(record_rune_img1,record_rune_img2);//서브 div에 룬 이미지들 append
			record_champ_div.append(record_champ_sub_div, record_spell_div, record_rune_div);
			
			let record_kda_sub_div = $('<div class = "record_kda_sub_div"></div>');//kda 정보를 담을 서브 div
			let record_kda_strong = $('<strong class = "record_kda_strong"></strong>');//kda 정보(span태그)를 감싸서 강조 표현
			let record_kda = $('<span>'+record.kills+'/</span><span>'+record.deaths+'/</span><span>'+record.assists+'</span>');//k/d/a 값
			record_kda_strong.append(record_kda);//k/d/a의 span 태그 strong 태그 안으로 append
			record_kda_sub_div.append(record_kda_strong);//만들어진 kda 정보를 서브 div에 append
			record_kda_div.append(record_kda_sub_div);
			
			let record_cs_sight_sub_div = $('<div class = "record_cs_sight_sub_div"></div>');//cs,시야점수,핑와 설치 점수를 담을 서브 div
			let record_kill_involve = $('<span class = "record_kill_involve">킬 관여율 '+record.kill_involve+'%</span>')
			let record_cs = $('<span class = "record_cs">CS '+record.cs+'</span>');//cs점수
			let record_sight_point = $('<span class = "record_sight_point">시야 점수 '+record.sight_point+'</span>');//시야점수
			let record_red_wards_img = $('<img class = "record_res_wards_img" src = "/resources/img/item/2055.png"><span class = "record_red_wards">'+record.red_ward_placed+'</span>');//제어와드 이미지
			record_cs_sight_sub_div.append(record_kill_involve,record_cs,record_sight_point,record_red_wards_img);//만들어진 정보 서브 div에 append
			record_cs_sight_div.append(record_cs_sight_sub_div);//서브 div를 정보를 담을 div에 append
			
			let record_item_sub_div = $('<div class = "record_item_sub_div"></div>');//아이템 이미지 정보를 담을 서브 div
			if(record.item1 != 0){
				let record_item_img1 = $('<img class = "record-item" src = "/resources/img/item/'+record.item1+'.png">');//아이템1 이미지
				record_item_sub_div.append(record_item_img1);
			}
			if(record.item2 != 0){
				let record_item_img2 = $('<img class = "record-item" src = "/resources/img/item/'+record.item2+'.png">');//아이템2 이미지
				record_item_sub_div.append(record_item_img2);
			}
			if(record.item3 != 0){
				let record_item_img3 = $('<img class = "record-item" src = "/resources/img/item/'+record.item3+'.png">');//아이템3 이미지
				record_item_sub_div.append(record_item_img3);
			}
			if(record.item4 != 0){
				let record_item_img4 = $('<img class = "record-item" src = "/resources/img/item/'+record.item4+'.png">');//아이템4 이미지
				record_item_sub_div.append(record_item_img4);
			}
			if(record.item5 !=0){
				let record_item_img5 = $('<img class = "record-item" src = "/resources/img/item/'+record.item5+'.png">');//아이템5 이미지
				record_item_sub_div.append(record_item_img5);
			}
			if(record.item6 != 0){
				let record_item_img6 = $('<img class = "record-item" src = "/resources/img/item/'+record.item6+'.png">');//아이템6 이미지
				record_item_sub_div.append(record_item_img6);
			}
			if(record.item7 != 0){
				let record_item_img7 = $('<img class = "record-item" src = "/resources/img/item/'+record.item7+'.png">');//아이템7 이미지
				record_item_sub_div.append(record_item_img7);
			}
			record_item_div.append(record_item_sub_div);//서브 div를 아이템 정보를 담을 div에 append
			let button_div = $('<button>').addClass('button_div').attr({
				  type: 'button',
				  value: record.match_id,
				  onclick: "getRecordDetail('" + record.match_id + "',$(this))"
				});
			let hiddenDiv = $('<div id = "'+record.match_id+'" class = "hidden_div" style = "display : none"></div>');
			
			record_div.append(record_win_lose_div,record_champ_div,record_champ_div,record_kda_div,record_cs_sight_div,record_item_div,record_player_div,button_div);
			div.append(record_div,hiddenDiv);
			
			$.ajax({
		        method: 'get',
		        url: '/summoner/get_record_detail',
		        data: { match_id: record.match_id }
		    }).done(response => {
		    	let summoner_name = '${summoner.summoner_name}'
		    	
		        // 1. div 태그 생성. class 속성에 "whole" 부여
		        let whole = $('<div class="whole"></div>');

		        // 2. header와 div 태그 생성
		        let header = $('<header class="data_header"></header>');
		        let data = $('<div class="data"></div>');
		        whole.append(header, data); // 2. 생성된 태그들을 whole 태그 내부에 추가
		        // 3. 'data_header' 내부에 div 태그 3개 생성
		        let synthesis = $('<div class = "synthesis" onclick = "synthesis('+record.match_id+', this)">종합</div>');
		        let build = $('<div class="build" onclick="build(\'' + record.match_id + '\', \'' + summoner_name + '\', this)">빌드</div>');
		        let ranking = $('<div class="ranking" onclick="ranking(\'' + record.match_id + '\', \'' + summoner_name + '\', this)">랭킹</div>');
		        header.append(synthesis, build, ranking);

		        // 4. 'data' 내부에 새로운 div 태그 두 개를 생성
		        let win = $('<div class="win"><header class="win_header"></header></div>');
		        let lose = $('<div class="lose"><header class="lose_header"></header></div>');
		        data.append(win, lose);

		        $.each(response, function (i, syn) {
		            if (syn.win === 1) {
		                // 5. 'win' 내부에 res의 win 값이 true 인 데이터 수 만큼 div 태그 생성
		                let winTeam = $('<div class="win_team"></div>');
		                // 7. 각 'win_team' 내부에 작업할 내용
		                // 7-1. div 태그 4개 생성. 각 div 태그의 class 속성에 'champ_info','kda_info','cs_ward_info','item_info' 부여.
		                let champInfo = $('<div class="champ_info"></div>');
		                let kdaInfo = $('<div class="kda_info"></div>');
		                let csInfo = $('<div class="cs_info"></div>');
		                let itemInfo = $('<div class="item_info"></div>');
		                winTeam.append(champInfo,kdaInfo,csInfo,itemInfo);

		                let champion = $('<div class="champion"><img class="flex-champion" src="/resources/img/champion_img/square/'+syn.champ_name+'.png"></div>');
		                let champLevel = $('<span class="champ_level">'+syn.champ_level+'</span>');
		                champion.append(champLevel);
		                let spell = $('<div class="spell"><img class="flex-spell1" src="/resources/img/spell/'+syn.spell1+'.png"><img class="flex-spell2" src="/resources/img/spell/'+syn.spell2+'.png"></div>');
		                let rune = $('<div class="rune"><img class="flex-rune1" src="/resources/img/'+syn.main_rune1+'"><img class="flex-rune2" src="/resources/img/'+syn.sub_rune+'"></div>');
		                let kda = $('<div class="kda"><span class = "syn-kda-text">'+syn.kills+'/</span><span class = "syn-kda-text">'+syn.deaths+'/</span><span class = "syn-kda-text">'+syn.assists+'</span></div>');
		                let cs = $('<div class="cs"><span class = "syn-cs-text">CS '+syn.cs+'</span><span class = "syn-cs-text">킬 관여율 '+syn.kills_participation+'%</span></div>');

		                let summonerInfo = $('<div class = "syn-summoner-info"></div>');
		                let summonerSpan = $('<span class = "syn-summoner-span"></span>');
		                if(syn.tier === "challenger"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">C</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "grandmaster"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">GM</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "master"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">M</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "diamond"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">D</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "platinum"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">P</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "gold"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">G</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "silver"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">S</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "bronze"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">B</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                
		                
		                // 6. 'champ_info', 'kda_info', 'cs_ward_info', 'item_info' 내부에 작업할 내용 추가
		                // 6-1. champion, spell, rune, kda, csWard를 각 div 태그 내부에 추가
		                champInfo.append(champion,spell,rune,summonerInfo);
		                kdaInfo.append(kda);
		                csInfo.append(cs);

		                // 8. item_info 내부에 작업할 내용
		                let itemImgDiv = $('<div class = "itemImgDiv"></div>');
		                if(syn.item1 != 0){
		                	let itemImg1 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item1+'.png">');
		                	itemImgDiv.append(itemImg1);
		                }
		                if(syn.item2 != 0){
		                	let itemImg2 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item2+'.png">');
		                	itemImgDiv.append(itemImg2);
		                }
		                if(syn.item3 != 0){
		                	let itemImg3 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item3+'.png">');
		                	itemImgDiv.append(itemImg3);
		                }
		                if(syn.item4 != 0){
		                	let itemImg4 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item4+'.png">');
		                	itemImgDiv.append(itemImg4);
		                }
		                if(syn.item5 != 0){
		                	let itemImg5 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item5+'.png">');
		                	itemImgDiv.append(itemImg5);
		                }
		                if(syn.item6 != 0){
		                	let itemImg6 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item6+'.png">');
		                	itemImgDiv.append(itemImg6);
		                }
		                if(syn.item7 != 0){
		                	let itemImg7 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item7+'.png">');
		                	itemImgDiv.append(itemImg7);
		                }
		                itemInfo.append(itemImgDiv);
		                win.append(winTeam);
		            } else {
		                // 9. 'lose' 내부에 res의 win 값이 false 인 데이터 수 만큼 div 태그 생성 (위와 동일한 작업)
		                let loseTeam = $('<div class="lose_team"></div>');
		                let champion = $('<div class="champion"><img class="flex-champion" src="/resources/img/champion_img/square/'+syn.champ_name+'.png"></div>');
		                let champLevel = $('<span class="champ_level">'+syn.champ_level+'</span>');
		                champion.append(champLevel);
		                let spell = $('<div class="spell"><img class="flex-spell1" src="/resources/img/spell/'+syn.spell1+'.png"><img class="flex-spell2" src="/resources/img/spell/'+syn.spell2+'.png"></div>');
		                let rune = $('<div class="rune"><img class="flex-rune1" src="/resources/img/'+syn.main_rune1+'"><img class="flex-rune2" src="/resources/img/'+syn.sub_rune+'"></div>');
		                let kda = $('<div class="kda"><span class = "syn-kda-text">'+syn.kills+'/</span><span class = "syn-kda-text">'+syn.deaths+'/</span><span class = "syn-kda-text">'+syn.assists+'</span></div>');
		                let cs = $('<div class="cs"><span class = "syn-cs-text">CS '+syn.cs+'</span><span class = "syn-cs-text">킬 관여율 '+syn.kills_participation+'%</span></div>');

		                let champInfo = $('<div class="champ_info"></div>');
		                let kdaInfo = $('<div class="kda_info"></div>');
		                let csInfo = $('<div class="cs_info"></div>');
		                let itemInfo = $('<div class="item_info"></div>');
		                loseTeam.append(champInfo,kdaInfo,csInfo,itemInfo);
		                
		                let summonerInfo = $('<div class = "syn-summoner-info"></div>');
		                let summonerSpan = $('<span class = "syn-summoner-span"></span>');
		                if(syn.tier === "challenger"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">C</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "grandmaster"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">GM</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "master"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">M</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "diamond"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">D</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "platinum"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">P</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "gold"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">G</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "silver"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">S</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }
		                if(syn.tier === "bronze"){
		                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">B</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
		                	summonerSpan.append(summonerTierName);
		                	summonerInfo.append(summonerSpan);
		                }

		                champInfo.append(champion,spell,rune,summonerInfo);
		                kdaInfo.append(kda);
		                csInfo.append(cs);

		                let itemImgDiv = $('<div class = "itemImgDiv"></div>');
		                if(syn.item1 != 0){
		                	let itemImg1 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item1+'.png">');
		                	itemImgDiv.append(itemImg1);
		                }
		                if(syn.item2 != 0){
		                	let itemImg2 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item2+'.png">');
		                	itemImgDiv.append(itemImg2);
		                }
		                if(syn.item3 != 0){
		                	let itemImg3 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item3+'.png">');
		                	itemImgDiv.append(itemImg3);
		                }
		                if(syn.item4 != 0){
		                	let itemImg4 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item4+'.png">');
		                	itemImgDiv.append(itemImg4);
		                }
		                if(syn.item5 != 0){
		                	let itemImg5 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item5+'.png">');
		                	itemImgDiv.append(itemImg5);
		                }
		                if(syn.item6 != 0){
		                	let itemImg6 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item6+'.png">');
		                	itemImgDiv.append(itemImg6);
		                }
		                if(syn.item7 != 0){
		                	let itemImg7 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item7+'.png">');
		                	itemImgDiv.append(itemImg7);
		                }
						itemInfo.append(itemImgDiv);
		                lose.append(loseTeam);
		            }
		        });
		        $('#'+record.match_id).html(whole);
		    });
			
		})
		$('#record').html(div);
		if(res.length >= 20){
			let moreBtn = $('<button class = "recordMoreBtn">더 보기</button>');
			$('.flex-record-div').append(moreBtn);
		}
	}).fail(err=>{
		console.log(err);
	});
	
	function getRecordDetail(match_id, thisBtn) {
	    let value = thisBtn.val();
	    if (!thisBtn.hasClass('clicked')) {
	        $('#' + value).show();
	        thisBtn.addClass('clicked');
	    } else {
	        $('#' + value).hide();
	        thisBtn.removeClass('clicked');
	    }
	}
	
	//종합 버튼 클릭 시
	function synthesis(matchId,thisDiv){
		let divId = $(matchId).attr('id');
		$.ajax({
	        method: 'get',
	        url: '/summoner/get_record_detail',
	        data: { 'match_id' : divId }
	    }).done(response => {
			let data = $('<div class = "dataDiv"></div>');
	        // 4. 'data' 내부에 새로운 div 태그 두 개를 생성
	        let win = $('<div class="win"><header class="win_header"></header></div>');
	        let lose = $('<div class="lose"><header class="lose_header"></header></div>');
	        data.append(win, lose);

	        $.each(response, function (i, syn) {
	            if (syn.win === 1) {
	                // 5. 'win' 내부에 res의 win 값이 true 인 데이터 수 만큼 div 태그 생성
	                let winTeam = $('<div class="win_team"></div>');
	                // 7. 각 'win_team' 내부에 작업할 내용
	                // 7-1. div 태그 4개 생성. 각 div 태그의 class 속성에 'champ_info','kda_info','cs_ward_info','item_info' 부여.
	                let champInfo = $('<div class="champ_info"></div>');
	                let kdaInfo = $('<div class="kda_info"></div>');
	                let csInfo = $('<div class="cs_info"></div>');
	                let itemInfo = $('<div class="item_info"></div>');
	                winTeam.append(champInfo,kdaInfo,csInfo,itemInfo);

	                let champion = $('<div class="champion"><img class="flex-champion" src="/resources/img/champion_img/square/'+syn.champ_name+'.png"></div>');
	                let champLevel = $('<span class="champ_level">'+syn.champ_level+'</span>');
	                champion.append(champLevel);
	                let spell = $('<div class="spell"><img class="flex-spell1" src="/resources/img/spell/'+syn.spell1+'.png"><img class="flex-spell2" src="/resources/img/spell/'+syn.spell2+'.png"></div>');
	                let rune = $('<div class="rune"><img class="flex-rune1" src="/resources/img/'+syn.main_rune1+'"><img class="flex-rune2" src="/resources/img/'+syn.sub_rune+'"></div>');
	                let kda = $('<div class="kda"><span class = "syn-kda-text">'+syn.kills+'/</span><span class = "syn-kda-text">'+syn.deaths+'/</span><span class = "syn-kda-text">'+syn.assists+'</span></div>');
	                let cs = $('<div class="cs"><span class = "syn-cs-text">CS '+syn.cs+'</span><span class = "syn-cs-text">킬 관여율 '+syn.kills_participation+'%</span></div>');

	                let summonerInfo = $('<div class = "syn-summoner-info"></div>');
	                let summonerSpan = $('<span class = "syn-summoner-span"></span>');
	                if(syn.tier === "challenger"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">C</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "grandmaster"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">GM</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "master"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">M</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "diamond"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">D</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "platinum"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">P</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "gold"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">G</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "silver"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">S</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "bronze"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">B</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                
	                
	                // 6. 'champ_info', 'kda_info', 'cs_ward_info', 'item_info' 내부에 작업할 내용 추가
	                // 6-1. champion, spell, rune, kda, csWard를 각 div 태그 내부에 추가
	                champInfo.append(champion,spell,rune,summonerInfo);
	                kdaInfo.append(kda);
	                csInfo.append(cs);

	                // 8. item_info 내부에 작업할 내용
	                let itemImgDiv = $('<div class = "itemImgDiv"></div>');
	                if(syn.item1 != 0){
	                	let itemImg1 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item1+'.png">');
	                	itemImgDiv.append(itemImg1);
	                }
	                if(syn.item2 != 0){
	                	let itemImg2 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item2+'.png">');
	                	itemImgDiv.append(itemImg2);
	                }
	                if(syn.item3 != 0){
	                	let itemImg3 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item3+'.png">');
	                	itemImgDiv.append(itemImg3);
	                }
	                if(syn.item4 != 0){
	                	let itemImg4 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item4+'.png">');
	                	itemImgDiv.append(itemImg4);
	                }
	                if(syn.item5 != 0){
	                	let itemImg5 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item5+'.png">');
	                	itemImgDiv.append(itemImg5);
	                }
	                if(syn.item6 != 0){
	                	let itemImg6 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item6+'.png">');
	                	itemImgDiv.append(itemImg6);
	                }
	                if(syn.item7 != 0){
	                	let itemImg7 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item7+'.png">');
	                	itemImgDiv.append(itemImg7);
	                }
	                itemInfo.append(itemImgDiv);
	                win.append(winTeam);
	            } else {
	                // 9. 'lose' 내부에 res의 win 값이 false 인 데이터 수 만큼 div 태그 생성 (위와 동일한 작업)
	                let loseTeam = $('<div class="lose_team"></div>');
	                let champion = $('<div class="champion"><img class="flex-champion" src="/resources/img/champion_img/square/'+syn.champ_name+'.png"></div>');
	                let champLevel = $('<span class="champ_level">'+syn.champ_level+'</span>');
	                champion.append(champLevel);
	                let spell = $('<div class="spell"><img class="flex-spell1" src="/resources/img/spell/'+syn.spell1+'.png"><img class="flex-spell2" src="/resources/img/spell/'+syn.spell2+'.png"></div>');
	                let rune = $('<div class="rune"><img class="flex-rune1" src="/resources/img/'+syn.main_rune1+'"><img class="flex-rune2" src="/resources/img/'+syn.sub_rune+'"></div>');
	                let kda = $('<div class="kda"><span class = "syn-kda-text">'+syn.kills+'/</span><span class = "syn-kda-text">'+syn.deaths+'/</span><span class = "syn-kda-text">'+syn.assists+'</span></div>');
	                let cs = $('<div class="cs"><span class = "syn-cs-text">CS '+syn.cs+'</span><span class = "syn-cs-text">킬 관여율 '+syn.kills_participation+'%</span></div>');

	                let champInfo = $('<div class="champ_info"></div>');
	                let kdaInfo = $('<div class="kda_info"></div>');
	                let csInfo = $('<div class="cs_info"></div>');
	                let itemInfo = $('<div class="item_info"></div>');
	                loseTeam.append(champInfo,kdaInfo,csInfo,itemInfo);
	                
	                let summonerInfo = $('<div class = "syn-summoner-info"></div>');
	                let summonerSpan = $('<span class = "syn-summoner-span"></span>');
	                if(syn.tier === "challenger"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">C</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "grandmaster"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">GM</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "master"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">M</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "diamond"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">D</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "platinum"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">P</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "gold"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">G</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "silver"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">S</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }
	                if(syn.tier === "bronze"){
	                	let summonerTierName = $('<span class = "syn-summoner-text"><span class = "syn-summoner-tier">B</span><span class = "syn-summoner-name"> '+syn.summoner_name+'</span></span>');
	                	summonerSpan.append(summonerTierName);
	                	summonerInfo.append(summonerSpan);
	                }

	                champInfo.append(champion,spell,rune,summonerInfo);
	                kdaInfo.append(kda);
	                csInfo.append(cs);

	                let itemImgDiv = $('<div class = "itemImgDiv"></div>');
	                if(syn.item1 != 0){
	                	let itemImg1 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item1+'.png">');
	                	itemImgDiv.append(itemImg1);
	                }
	                if(syn.item2 != 0){
	                	let itemImg2 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item2+'.png">');
	                	itemImgDiv.append(itemImg2);
	                }
	                if(syn.item3 != 0){
	                	let itemImg3 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item3+'.png">');
	                	itemImgDiv.append(itemImg3);
	                }
	                if(syn.item4 != 0){
	                	let itemImg4 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item4+'.png">');
	                	itemImgDiv.append(itemImg4);
	                }
	                if(syn.item5 != 0){
	                	let itemImg5 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item5+'.png">');
	                	itemImgDiv.append(itemImg5);
	                }
	                if(syn.item6 != 0){
	                	let itemImg6 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item6+'.png">');
	                	itemImgDiv.append(itemImg6);
	                }
	                if(syn.item7 != 0){
	                	let itemImg7 = $('<img class = "syn-item-img" src = "/resources/img/item/'+syn.item7+'.png">');
	                	itemImgDiv.append(itemImg7);
	                }
					itemInfo.append(itemImgDiv);
	                lose.append(loseTeam);
	            }
	        });
	        $(thisDiv).parent().siblings('div').filter('.data').html(data);
	    });
	}
	
	//빌드 버튼 클릭 시
	 function build(match_id, summoner_name ,thisDiv){
		$.ajax({
			method : 'get',
			url : '/summoner/info/getBuild',
			data : {match_id : match_id, summoner_name : summoner_name}
		}).done(res=>{
			console.log(res);
			let runeBuildDiv = $('<div class = "runeBuildDiv"></div>');
			
			let mainRuneDiv = $('<div class = "mainRuneDiv"></div>');
			let subRuneDiv = $('<div class = "subRuneDiv"></div>');
			let runeStatsDiv = $('<div class = "runeStatsDiv"></div>');
			
			let mainRuneType = $('<div class = "mainRuneType"></div>');
			let mainRune1 = $('<div class = "mainRune1"></div>');
			let mainRune2 = $('<div class = "mainRune2"></div>');
			let mainRune3 = $('<div class = "mainRune3"></div>');
			let mainRune4 = $('<div class = "mainRune4"></div>');
			
			let subRuneType = $('<div class = "subRuneType"></div>');
			let subRune1 = $('<div class = "subRune1"></div>');
			let subRune2 = $('<div class = "subRune2"></div>');
			let subRune3 = $('<div class = "subRune3"></div>');
			
			let runeStat1 = $('<div class = "runeStat1"></div>');
			let runeStat2 = $('<div class = "runeStat2"></div>');
			let runeStat3 = $('<div class = "runeStat3"></div>');
			
			//runeMaking(res.main_rune, res.sub_rune);
			
			//$(thisDiv).parent().siblings('div').filter('.data').html(data_div);
		}).fail(err=>{
			console.log(err)
		})
	}
	
	//랭킹 버튼 클릭 시
 	function ranking(matchId, summoner_name, thisDiv){
		let data_div = $('<div class = "RankingDataDiv"></div>');
		$.ajax({
			method : 'get',
			url : '/summoner/getRanking',
			data : {match_id : matchId, summoner_name : summoner_name}
		}).done(res=>{
			$.ajax({
				method : 'get',
				url : '/summoner/getTeamData',
				data : {match_id : matchId, summoner_name : summoner_name}
			}).done(response=>{
				
				let playersDamage = [];
				let playersTaken = [];
				let playersKills = [];
				let playersDeaths = [];
				let playersAssists = [];
				let playersRedWards = [];
				let playersCS = [];
				
				playersDamage.push({dealtDamage : res.self_dealt});
				$.each(response, function(i, team){
					playersDamage.push({dealtDamage : team.team_dealt});
				});
				playersDamage.sort((a, b) => b.dealtDamage - a.dealtDamage);
				let playersDamageRank = playersDamage.findIndex(player => player.dealtDamage === res.self_dealt) + 1;
				
				playersTaken.push({takenDamage : res.self_taken});
				$.each(response, function(i, taken){
					playersTaken.push({takenDamage : taken.team_taken})
				});
				playersTaken.sort((a, b) => a.takenDamage - b.takenDamage);
				let playersTakenRank = playersTaken.findIndex(player => player.takenDamage === res.self_taken) + 1;
				
				playersKills.push({kills : res.self_kills});
				$.each(response, function(i, kills){
					playersKills.push({kills : kills.team_kills});
				});
				playersKills.sort((a, b) => b.kills - a.kills);
				let playersKillsRank = playersKills.findIndex(player => player.kills === res.self_kills) + 1;
				
				playersDeaths.push({deaths : res.self_deaths})
				$.each(response, function(i, deaths){
					playersDeaths.push({deaths : deaths.team_deaths});
				});
				playersDeaths.sort((a, b) => a.deaths - b.deaths);
				let playersDeathsRank = playersDeaths.findIndex(player => player.deaths === res.self_deaths) + 1;
				
				
				playersAssists.push({assists : res.self_assists});
				$.each(response, function(i, assists){
					playersAssists.push({assists : assists.team_assists});
				});
				playersAssists.sort((a, b) => b.assists - a.assists);
				let playersAssistsRank = playersAssists.findIndex(player => player.assists === res.self_assists) + 1;
				
				playersRedWards.push({redWards : res.self_red_ward_placed});
				$.each(response, function(i, redWards){
					playersRedWards.push({redWards : redWards.team_red_ward_placed});
				});
				playersRedWards.sort((a, b) => b.redWards - a.redWards);
				let playersRedWardsRank = playersRedWards.findIndex(player => player.redWards === res.self_red_ward_placed) + 1;
				
				playersCS.push({CS : res.self_cs});
				$.each(response, function(i, CS){
					playersCS.push({CS : CS.team_cs});
				});
				playersCS.sort((a, b) => b.CS - a.CS);
				let playersCSRank = playersCS.findIndex(player => player.CS === res.self_cs) + 1;
				
				let myDealt = res.self_dealt;
				let totalDealt = res.total_dealt;
				let myTaken = res.self_taken;
				let totalTaken = res.total_taken;
				let myKills = res.self_kills;
				let totalKills = res.team_champion_kills;
				let myDeaths = res.self_deaths;
				let totalDeaths = res.team_champion_deaths;
				let myAssists = res.self_assists;
				let totalAssists = res.team_champion_assists;
				let myRedWard = res.self_red_ward_placed;
				let totalRedWard = res.team_total_red_ward;
				let myCs = res.self_cs;
				let totalCs = res.team_total_cs;
				
				let dealtDiv = $('<div class = "delatDiv"></div>');
				let takenDiv = $('<div class = "takenDiv"></div>');
				let killsDiv = $('<div class = "killsDiv"></div>');
				let deathsDiv = $('<div class = "deathsDiv"></div>');
				let assistsDiv = $('<div class = "assistsDiv"></div>');
				let redWardsDiv = $('<div class = "redWardsDiv"></div>');
				let csDiv = $('<div class = "csDiv"></div>');
				
				let dealtTitle = $('<div class = "dealtTitleDiv"><span>피해량</span></div>');
				let dealtRank = $('<div class = "dealtRankDiv">'+playersDamageRank+'위</div>');
				let dealtGraph = $('<div class = "dealtGraphDiv"></div>');
				
				let canvas = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx = canvas[0].getContext('2d');
				let myChart = new Chart(ctx, {
				  type: 'bar',
				  data: {
				    labels: ['피해량'],
				    datasets: [{
				      label: '내가 가한 피해량',
				      data: [myDealt],
				      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
				      borderColor: ['rgba(54, 162, 235, 0.5)'],
				      borderWidth: 1
				    }, {
				      label: '내가 가하지 않은 피해량',
				      data: [totalDealt - myDealt],
				      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
				      borderColor: ['rgba(255, 0, 0, 0.5)'],
				      borderWidth: 1
				    }]
				  },
				  options: {
				    indexAxis: 'y',
				    scales: {
				      x: {
				        ticks: { display: false },
				        grid: { display: false },
				        stacked:true
				      },
				      y: { display: false, grid: { display: false }, stacked:true }
				    },
				    plugins: {
				      legend: { display: false }
				    }
				  }
				});
				dealtGraph.append(canvas);
				let dealtText = $('<div class = "dealtTextDiv"><span><strong>'+res.self_dealt+'</strong><span>/'+res.total_dealt+'</span></span></div>');
				dealtDiv.append(dealtTitle,dealtRank,dealtGraph,dealtText);
				
				let takenTitle = $('<div class = "takenTitleDiv"><span>받은 피해량</span></div>');
				let takenRank = $('<div class = "takenRankDiv">'+playersTakenRank+'위</div>');
				let takenGraph = $('<div class = "takenGraph"></div>');
				let canvas2 = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas2).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx2 = canvas2[0].getContext('2d');
				let myChart2 = new Chart(ctx2, {
					  type: 'bar',
					  data: {
					    labels: ['받은 피해량'],
					    datasets: [{
					      label: '내가 받은 피해량',
					      data: [myTaken],
					      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
					      borderColor: ['rgba(54, 162, 235, 0.5)'],
					      borderWidth: 1
					    }, {
					      label: '내가 받지 않은 피해량',
					      data: [totalTaken - myTaken],
					      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
					      borderColor: ['rgba(255, 0, 0, 0.5)'],
					      borderWidth: 1
					    }]
					  },
					  options: {
					    indexAxis: 'y',
					    scales: {
					      x: {
					        ticks: { display: false },
					        grid: { display: false },
					        stacked:true
					      },
					      y: { display: false, grid: { display: false }, stacked:true }
					    },
					    plugins: {
					      legend: { display: false }
					    }
					  }
					});
				takenGraph.append(canvas2);
				let takenText = $('<div class = "takenTextDiv"><span><strong>'+res.self_taken+'</strong><span>/'+res.total_taken+'</span></span></div>');
				takenDiv.append(takenTitle,takenRank,takenGraph,takenText);
				
				let killsTitle = $('<div class = "killsTitleDiv"><span>킬</span></div>');
				let killsRank = $('<div class = "killsRankDiv">'+playersKillsRank+'위</div>');
				let killsGraph = $('<div class = "killsGraphDiv"></div>');
				let canvas3 = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas3).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx3 = canvas3[0].getContext('2d');
				let myChart3 = new Chart(ctx3, {
					  type: 'bar',
					  data: {
					    labels: ['킬수'],
					    datasets: [{
					      label: '내 킬수',
					      data: [myKills],
					      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
					      borderColor: ['rgba(54, 162, 235, 0.5)'],
					      borderWidth: 1
					    }, {
					      label: '팀 킬수',
					      data: [totalKills - myKills],
					      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
					      borderColor: ['rgba(255, 0, 0, 0.5)'],
					      borderWidth: 1
					    }]
					  },
					  options: {
					    indexAxis: 'y',
					    scales: {
					      x: {
					        ticks: { display: false },
					        grid: { display: false },
					        stacked:true
					      },
					      y: { display: false, grid: { display: false }, stacked:true }
					    },
					    plugins: {
					      legend: { display: false }
					    }
					  }
					});
				killsGraph.append(canvas3);
				let killsText = $('<div class = "killsTextDiv"><span><strong>'+res.self_kills+'</strong><span>/'+res.team_champion_kills+'</span></span></div>');
				killsDiv.append(killsTitle,killsRank,killsGraph,killsText);
				
				let deathsTitle = $('<div class = "deathsTitleDiv"><span>데스</span></div>');
				let deathsRank = $('<div class = "deathsRankDiv">'+playersDeathsRank+'위</div>');
				let deathsGraph = $('<div class = "deathsGraphDiv"></div>');
				let canvas4 = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas4).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx4 = canvas4[0].getContext('2d');
				let myChart4 = new Chart(ctx4, {
					  type: 'bar',
					  data: {
					    labels: ['데스'],
					    datasets: [{
					      label: '내 데스',
					      data: [myDeaths],
					      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
					      borderColor: ['rgba(54, 162, 235, 0.5)'],
					      borderWidth: 1
					    }, {
					      label: '팀 데스',
					      data: [totalDeaths - myDeaths],
					      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
					      borderColor: ['rgba(255, 0, 0, 0.5)'],
					      borderWidth: 1
					    }]
					  },
					  options: {
					    indexAxis: 'y',
					    scales: {
					      x: {
					        ticks: { display: false },
					        grid: { display: false },
					        stacked:true
					      },
					      y: { display: false, grid: { display: false }, stacked:true }
					    },
					    plugins: {
					      legend: { display: false }
					    }
					  }
					});
				deathsGraph.append(canvas4);
				let deathsText = $('<div deathsTextDiv><span><strong>'+res.self_deaths+'</strong><span>/'+res.team_champion_deaths+'</span></span></div>');
				deathsDiv.append(deathsTitle,deathsRank,deathsGraph,deathsText);
				
				let assistsTitle = $('<div class = "assistsTitleDiv"><span>어시스트</span></div>');
				let assistsRank = $('<div class = "assistsRankDiv">'+playersAssistsRank+'위</div>');
				let assistsGraph = $('<div class = "assistsGraphDiv"></div>');
				let canvas5 = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas5).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx5 = canvas5[0].getContext('2d');
				let myChart5 = new Chart(ctx5, {
					  type: 'bar',
					  data: {
					    labels: ['어시스트'],
					    datasets: [{
					      label: '내 어시스트킬수',
					      data: [myAssists],
					      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
					      borderColor: ['rgba(54, 162, 235, 0.5)'],
					      borderWidth: 1
					    }, {
					      label: '팀 어시스트',
					      data: [totalAssists - myAssists],
					      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
					      borderColor: ['rgba(255, 0, 0, 0.5)'],
					      borderWidth: 1
					    }]
					  },
					  options: {
					    indexAxis: 'y',
					    scales: {
					      x: {
					        ticks: { display: false },
					        grid: { display: false },
					        stacked:true
					      },
					      y: { display: false, grid: { display: false }, stacked:true }
					    },
					    plugins: {
					      legend: { display: false }
					    }
					  }
					});
				assistsGraph.append(canvas5);
				let assistsText = $('<div class = "assistsTextDiv"><span><strong>'+res.self_assists+'</strong><span>/'+res.team_champion_assists+'</span></span></div>');
				assistsDiv.append(assistsTitle,assistsRank,assistsGraph,assistsText);
				
				let redWardsTitle = $('<div class = "redWardsTitleDiv"><span>제어와드</span></div>');
				let redWardsRank = $('<div class = "redWardsRankDiv">'+playersRedWardsRank+'위</div>');
				let redWardsGraph = $('<div class = "redWardsGraphDiv"></div>');
				let canvas6 = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas6).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx6 = canvas6[0].getContext('2d');
				let myChart6 = new Chart(ctx6, {
					  type: 'bar',
					  data: {
					    labels: ['레드 와드 설치'],
					    datasets: [{
					      label: '내 레드 와드 설치 수',
					      data: [myRedWard],
					      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
					      borderColor: ['rgba(54, 162, 235, 0.5)'],
					      borderWidth: 1
					    }, {
					      label: '팀 레드 와드 설치 수',
					      data: [totalRedWard - myRedWard],
					      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
					      borderColor: ['rgba(255, 0, 0, 0.5)'],
					      borderWidth: 1
					    }]
					  },
					  options: {
					    indexAxis: 'y',
					    scales: {
					      x: {
					        ticks: { display: false },
					        grid: { display: false },
					        stacked:true
					      },
					      y: { display: false, grid: { display: false }, stacked:true }
					    },
					    plugins: {
					      legend: { display: false }
					    }
					  }
					});
				redWardsGraph.append(canvas6);
				let redWardsText = $('<div class = "redWardsTextDiv"><span><strong>'+res.self_red_ward_placed+'</strong><span>/'+res.team_total_red_ward+'</span></span></div>');
				redWardsDiv.append(redWardsTitle,redWardsRank,redWardsGraph,redWardsText);
				
				let CSTitle = $('<div class = "CSTitleDiv"><span>CS</span></div>');
				let CSRank = $('<div class = "CSRankDiv">'+playersCSRank+'위</div>');
				let CSGraph = $('<div class = "CSGraphDiv"></div>');
				let canvas7 = $('<canvas></canvas>');
				// canvas 요소의 스타일 설정
				$(canvas7).css({
				  'max-width': '250px',
				  'max-height': '25px'
				});
				let ctx7 = canvas7[0].getContext('2d');
				let myChart7 = new Chart(ctx7, {
					  type: 'bar',
					  data: {
					    labels: ['CS'],
					    datasets: [{
					      label: '내 CS',
					      data: [myCs],
					      backgroundColor: ['rgba(54, 162, 235, 0.5)'],
					      borderColor: ['rgba(54, 162, 235, 0.5)'],
					      borderWidth: 1
					    }, {
					      label: '팀 CS',
					      data: [totalCs - myCs],
					      backgroundColor: ['rgba(255, 0, 0, 0.5)'],
					      borderColor: ['rgba(255, 0, 0, 0.5)'],
					      borderWidth: 1
					    }]
					  },
					  options: {
					    indexAxis: 'y',
					    scales: {
					      x: {
					        ticks: { display: false },
					        grid: { display: false },
					        stacked:true
					      },
					      y: { display: false, grid: { display: false }, stacked:true }
					    },
					    plugins: {
					      legend: { display: false }
					    }
					  }
					});
				CSGraph.append(canvas7);
				let CSText = $('<div class = "CSTextDiv"><span><strong>'+res.self_cs+'</strong><span>/ '+res.team_total_cs+'</span></span></div>');
				csDiv.append(CSTitle,CSRank,CSGraph,CSText);
				
				let firstDiv = $("<div class = 'firstDiv'></div>");
				let secondDiv = $('<div class = "secondDiv"></div>');
				firstDiv.append(dealtDiv, takenDiv, killsDiv, deathsDiv);
				secondDiv.append(assistsDiv, redWardsDiv, csDiv);
				data_div.append(firstDiv, secondDiv);
				
			})
			$(thisDiv).parent().siblings('div').filter('.data').html(data_div);
		}).fail(err=>{
			console.log(err);
		});
	};
	
	/* function runeMaking(mainRune, subRune){
		let main = '';
		switch (mainRune) {
		case 8000 :
			main = 'Precision';
			break;
		case 8100 :
			main = 'Domination';
		case 8200 :
			main = 'Sorcery';
		case 8300 :
			main = 'Inspiration';
		case 8400 :
			main = 'Resolve';
		default:
			break;
		}
		
		let sub = '';
		switch (subRune) {
		case 8000 :
			sub = 'Precision';
			break;
		case 8100 :
			sub = 'Domination';
		case 8200 :
			sub = 'Sorcery';
		case 8300 :
			sub = 'Inspiration';
		case 8400 :
			sub = 'Resolve';
		default:
			break;
		}
		
		$.ajax({
			  method: 'get',
			  url: '/summoner/getMainMaking',
			  data: { main : main },
			  async: false
			}).done(res => {
				console.log(res);
				for (let i = 0; i < res.length; i++) {
					rune_num = res[i].rune_num % res[0].rune_num
					if(rune_num == 0){
						main_rune_top.innerHTML += '<img src="/resources/img/'+res[i].rune_img+'" alt="">'
					}else if(rune_num > 0 && rune_num < 100){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_first.innerHTML += html
					}else if(rune_num > 100 && rune_num < 200){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_second.innerHTML += html
					}else if(rune_num > 200 && rune_num < 300){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_third.innerHTML += html
					}else if(rune_num > 300){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_fourth.innerHTML += html
					}
				}
			}).fail(err => {
			  console.log(err);
			});
		
		$.ajax({
			  method: 'get',
			  url: '/champion/info/rune/main',
			  data: { main_key: main_key },
			  async: false
			}).done(res => {
				console.log(res)
				let main_rune_top = document.getElementsByClassName('main-rune-top')[0];
				let main_rune_first = document.getElementsByClassName('main-rune-first')[0];
				let main_rune_second = document.getElementsByClassName('main-rune-second')[0];
				let main_rune_third = document.getElementsByClassName('main-rune-third')[0];
				let main_rune_fourth = document.getElementsByClassName('main-rune-fourth')[0];
				main_rune_top.innerHTML = ''
				main_rune_first.innerHTML = ''
				main_rune_second.innerHTML = ''
				main_rune_third.innerHTML = ''
				main_rune_fourth.innerHTML = ''
				for (let i = 0; i < res.length; i++) {
					rune_num = res[i].rune_num % res[0].rune_num
					if(rune_num == 0){
						main_rune_top.innerHTML += '<img src="/resources/img/'+res[i].rune_img+'" alt="">'
					}else if(rune_num > 0 && rune_num < 100){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_first.innerHTML += html
					}else if(rune_num > 100 && rune_num < 200){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_second.innerHTML += html
					}else if(rune_num > 200 && rune_num < 300){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_third.innerHTML += html
					}else if(rune_num > 300){
						html = ''
						html += '<div class="rune">'
						html += '<img src="/resources/img/'+res[i].rune_img+'" alt="" id="'+res[i].rune_id+'">'
						html += '<div class="rune-desc">'
						html += '<div>'+res[i].rune_kr_name+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_desc+'</div>'
						html += '<br>'
						html += '<div>'+res[i].rune_long_desc+'</div>'
						html += '</div>'
						html += '</div>'
						main_rune_fourth.innerHTML += html
					}
				}
			}).fail(err => {
			  console.log(err);
			});
		
	} */
	
	
	$('.rank_filter').click(function(){
		$('.rank_filter').not(this).prop('checked', false)
	})
	
	</script>

</body>
</html>