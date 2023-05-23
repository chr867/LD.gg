<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${summoner.summoner_name} - 소환사 전적</title>

<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>

<link  href = "/resources/css/summoner/summonerInfo.css" rel = "stylesheet">

</head>
<body>

	<div id="flex_div">
	
		<div id="background-profile">
			<div id="summoner-profile">
				<div id="profile-icon">
					<img class = "flex-profile-img" alt="#" src="https://ddragon.leagueoflegends.com/cdn/13.8.1/img/profileicon/${summoner.profile_icon_id}.png">
					<div class = "flex-summoner-level"> <p id="summoner-level">${summoner.s_level}</p> </div>
				</div>
				<button id="renewal" value="전적 갱신">전적 갱신</button>
			</div>
		</div>

		<div id="solo-rank">
			<img class = "flex-tier" alt="#" src="https://opgg-static.akamaized.net/images/medals_new/${summoner.tier}.png">
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

			<div id="record"></div><!-- 소환사 전적 -->

		</div>
	<!-- 전체 -->

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
	
	$('#renewal').click(function(){
		location.reload();
	})
	
 	$.ajax({//소환사의 챔피언 통계 필터 버튼 생성(포지션별 픽률 높은 순으로 생성)
		method : 'get',
		url : '/summoner/get_champ_position_filter',
		data : {summoner_name : '${summoner.summoner_name}'}
	}).done(res=>{
		console.log(res);
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
	})
	
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

	
 	 $.ajax({//최근 20전적 요약본
		method : 'get',
		url : '/summoner/get_20games_summary',
		data : {summoner_name : '${summoner.summoner_name}'}
	}).done(res=>{
		console.log(res);
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
				let champ_winrate1 = $('<p>'+res.top_champ1_winrate+'%</p>');
				let champ_win1 = $('<span>'+res.top_champ1_wins+'승</span>');
				let champ_lose1 = $('<span>'+res.top_champ1_losses+'패</span>');
				champ_winrate1.append(champ_win1,champ_lose1);
				champ1.append(champ_img1,champ_winrate1);
				champ.append(champ1);
			}

			if(res.top_champ2 != null){
				let champ_img2 = $('<img class = "flex-top-champ-img" src = "/resources/img/champion_img/square/'+res.top_champ2+'.png"/>');
				let champ_winrate2 = $('<p>'+res.top_champ2_winrate+'%</p>');
				let champ_win2 = $('<span>'+res.top_champ2_wins+'승</span>');
				let champ_lose2 = $('<span>'+res.top_champ2_losses+'패</span>');
				champ_winrate2.append(champ_win2,champ_lose2);
				champ2.append(champ_img2,champ_winrate2);	
				champ.append(champ2);
			}
		
			if(res.top_champ3 != null){
				let champ_img3 = $('<img class = "flex-top-champ-img" src = "/resources/img/champion_img/square/'+res.top_champ3+'.png"/>');
				let champ_winrate3 = $('<p>'+res.top_champ3_winrate+'%</p>');
				let champ_win3 = $('<span>'+res.top_champ3_wins+'승</span>');
				let champ_lose3 = $('<span>'+res.top_champ3_losses+'패</span>');
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
		console.log(res);
		
		$.ajax({
			method : 'get',
			url : '/summoner/getMachUpPlayer',
			data : {summoner_name : '${summoner.summoner_name}' , match_id : 'res.match_id'}
		}).done(result=>{
			console.log(result);
		}).fail(error=>{
			console.log(error);
		})
		
		let div = $('<div></div>');
		$.each(res, function (i, record){
			let record_div = $('<div class = "record_div"></div>');	//전적 정보가 담길 div
			
			let record_win_lose_div = $('<div class = "record_win_lose_div"></div>');	//해당 전적의 승패 정보
			let record_champ_div = $('<div class = "record_champ_div"></div>');	//해당 전적에서 사용한 챔피언/룬/스펠 정보
			let record_kda_div = $('<div class = "record_kda_div"></div>');	//KDA 정보
			let record_cs_sight_div = $('<div class = "record_cs_sight_div"></div>');	//CS,시야점수,핑크 와드 설치 수,킬관여율
			let record_item_div = $('<div class = "record_item_div"></div>');	//아이템 정보
			let record_player_div = $('<div class + "record_plyaer_div"></div>');	//해당 전적에서 매칭된 플레이어 목록(챔피언 아이콘 + 소환사 이름)
			
			if(record.win === 1){//승패 여부에 따라 승리 div 패배 div 생성
				let record_win_div = $('<div class = "record_win_div"></div>');
				let record_win_strong = $('<strong class = "record_win_strong"></strong>');
				let record_win_span = $('<span class = "record_win_span">승리</span>');
				record_win_strong.append(record_win_span);
				let record_game_mode = $('<span class = "record_game_mode">'+record.game_mode+'</span>');
				let record_game_duration = $('<span class = "record_game_duration">'+record.game_duration+'</span>');
				record_win_div.append(record_win_strong,record_game_mode,record_game_duration);
			}else{
				let record_lose_div = $('<div class = "record_lose_div"></div>');
				let record_lose_strong = $('<strong class = "record_lose_strong"></strong>');
				let record_lose_span = $('<span class = "record_lose_span">패배</span>');
				record_lose_strong.append(record_lose_span);
				let record_game_mode = $('<span class = "record_game_mode">'+record.game_mode+'</span>');
				let record_game_duration = $('<span class = "record_game_duration">'+record.game_duration+'</span>');
				record_lose_div.append(record_lose_strong,record_game_mode,record_game_duration);
			}
			
			let record_champ_sub_div = $('<div class = "record_chamnp_sub_div"></div>');//챔피언 정보 담을 서브 div
			let record_champ_img = $('<div class = "record_champ_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name+'.png")"></div>');//챔피언 이미지를 div로 만들기
			let record_champ_level = $('<span class = "record_champ_level">'+record.champ_level+'</span>');//챔피언 레벨을 이미지 위에 띄우기
			record_champ_img.append(record_champ_level);//레벨을 이미지 위에 띄우기 위해 append
			
			let record_spell_div = $('<div class = "record_spell_div"></div>');//스펠 정보 담을 서브 div
			let record_spell_img1 = $('<div class = "record_spell_img1" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/spell/'+record.spell1+'.png")"></div>');//스펠 이미지 div로 생성
			let record_spell_img2 = $('<div class = "record_spell_img2" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/spell/'+record.spell2+'.png")"></div>');
			record_spell_div.append(record_spell_img1,record_spell_img2);//만들어진 스펠 이미지들을 서브 div에 append
			
			let record_rune_div = $('<div class = "record_rune_div"></div>');//룬 정보 담을 서브 div
			let record_rune_img1 = $('<div class = "record_rune_img1" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/img/'+record.main_rune+'")"></div>');//룬 이미지를 div로 생성
			let record_rune_img2 = $('<div class = "record_rune_img2" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/img/'+record.sub_rune1+'")"></div>');
			record_rune_div.append(record_rune_img1,record_rune_img2);//서브 div에 룬 이미지들 append
			record_champ_sub_div.append(record_champ_div_mini,record_spell_div,record_rune_div)//이미지 정보들을 담은 서브 div를 챔피언 정보를 담는 div에 append
			
			let record_kda_sub_div = $('<div class = "record_kda_sub_div"></div>');//kda 정보를 담을 서브 div
			let record_kda_strong = $('<strong class = "record_kda_strong"></strong>');//kda 정보(span태그)를 감싸서 강조 표현
			let record_kda = $('<span>'+record.kills+'/</span><span>'+record.deaths+'/</span><span>'+record.assists+'</span>');//k/d/a 값
			record_kda_strong.append(record_kda);//k/d/a의 span 태그 strong 태그 안으로 append
			record_kda_sub_div.append(record_kda_strong);//만들어진 kda 정보를 서브 div에 append
			
			let record_cs_sight_sub_div = $('<div class = "record_cs_sight_sub_div"></div>');//cs,시야점수,핑와 설치 점수를 담을 서브 div
			let record_cs = $('<span class = "record_text">킬 관여 '+record.cs+'</span>');//cs점수
			let record_sight_point = $('<span class = "record_text">시야 점수 '+record.sight_point+'</span>');//시야점수
			let record_red_wards_img = $('<div class = "record_res_wards_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/2055.png")"></div>');//제어와드 이미지
			let record_red_wards = $('<span class = "record_red_wards">'+record.red_wards+'</span>');//제어와드 설치 수
			record_cs_sight_sub_div.append(record_cs,record_sight_point,record_red_wards_img,record_red_wards);//만들어진 정보 서브 div에 append
			record_cs_sight_div.append(record_cs_sight_sub_div);//서브 div를 정보를 담을 div에 append
			
			let record_item_sub_div = $('<div class = "record_item_sub_div"></div>');//아이템 이미지 정보를 담을 서브 div
			let record_item_img1 = $('<div class = "record_item_img1" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item1.png+'")"></div>');//아이템1 이미지
			let record_item_img2 = $('<div class = "record_item_img2" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item2.png+'")"></div>');//아이템2 이미지
			let record_item_img3 = $('<div class = "record_item_img3" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item3.png+'")"></div>');//아이템3 이미지
			let record_item_img4 = $('<div class = "record_item_img4" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item4.png+'")"></div>');//아이템4 이미지
			let record_item_img5 = $('<div class = "record_item_img5" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item5.png+'")"></div>');//아이템5 이미지
			let record_item_img6 = $('<div class = "record_item_img6" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item6.png+'")"></div>');//아이템6 이미지
			let record_item_img7 = $('<div class = "record_item_img7" role = "img" style = "background-image : url("http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item7.png+'")"></div>');//아이템7 이미지
			record_item_sub_div.append(record_item_img1,record_item_img2,record_item_img3,record_item_img4,record_item_img5,record_item_img6,record_item_img7);//만들어진 이미지 정보들을 서브 div에 apend
			record_item_div.append(record_item_sub_div);//서브 div를 아이템 정보를 담을 div에 append
			
			let record_team1_div = $('<div class = "record_team1_div"></div>');//팀 아이디 값이 100인 팀
			let record_team2_div = $('<div class = "record_team2_div"></div>');//팀 아이디 값이 200인 팀
			
			let record_player1_div = $('<div class = "record_player_div"></div>');//플레이어1의 정보를 담을 서브 div
			let record_player1_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name1+'.png")"></div>');//플레이어1이 플레이한 챔피언의 이미지
			let record_player1_name = $('<span class = "record_player_name">'+record.player_name1+'</span>');//플레이어1의 이름
			record_player1_div.append(record_player1_img,record_player1_name);//만들어진 플레이어1의 정보를 플레이어1의 서브 div에 append
			
			let record_player2_div = $('<div class = "record_player_div"></div>');//플레이어2의 정보를 담을 서브 div
			let record_player2_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name2+'.png")"></div>');//플레이어2이 플레이한 챔피언의 이미지
			let record_player2_name = $('<span class = "record_player_name">'+record.player_name2+'</span>');//플레이어1의 이름
			record_player2_div.append(record_player2_img,record_player2_name);//만들어진 플레이어2의 정보를 플레이어2의 서브 div에 append
			
			let record_player3_div = $('<div class = "record_player_div"></div>');//플레이어3의 정보를 담을 서브 div
			let record_player3_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name3+'.png")"></div>');//플레이어3이 플레이한 챔피언의 이미지
			let record_player3_name = $('<span class = "record_player_name">'+record.player_name3+'</span>');//플레이어3의 이름
			record_player3_div.append(record_player3_img,record_player3_name);//만들어진 플레이어3의 정보를 플레이어3의 서브 div에 append
			
			let record_player4_div = $('<div class = "record_player_div"></div>');//플레이어4의 정보를 담을 서브 div
			let record_player4_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name4+'.png")"></div>');//플레이어4이 플레이한 챔피언의 이미지
			let record_player4_name = $('<span class = "record_player_name">'+record.player_name4+'</span>');//플레이어5의 이름
			record_player4_div.append(record_player4_img,record_player4_name);//만들어진 플레이어4의 정보를 플레이어4의 서브 div에 append
			
			let record_player5_div = $('<div class = "record_player_div"></div>');//플레이어5의 정보를 담을 서브 div
			let record_player5_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name5+'.png")"></div>');//플레이어5이 플레이한 챔피언의 이미지
			let record_player5_name = $('<span class = "record_player_name">'+record.player_name5+'</span>');//플레이어5의 이름
			record_player5_div.append(record_player5_img,record_player5_name);//만들어진 플레이어5의 정보를 플레이어5의 서브 div에 append
			
			let record_player6_div = $('<div class = "record_player_div"></div>');//플레이어6의 정보를 담을 서브 div
			let record_player6_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name6+'.png")"></div>');//플레이어6이 플레이한 챔피언의 이미지
			let record_player6_name = $('<span class = "record_player_name">'+record.player_name6+'</span>');//플레이어6의 이름
			record_player6_div.append(record_player6_img,record_player6_name);//만들어진 플레이어6의 정보를 플레이어6의 서브 div에 append
			
			let record_player7_div = $('<div class = "record_player_div"></div>');//플레이어7의 정보를 담을 서브 div
			let record_player7_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name7+'.png")"></div>');//플레이어7이 플레이한 챔피언의 이미지
			let record_player7_name = $('<span class = "record_player_name">'+record.player_name7+'</span>');//플레이어7의 이름
			record_player7_div.append(record_player7_img,record_player7_name);//만들어진 플레이어7의 정보를 플레이어7의 서브 div에 append
			
			let record_player8_div = $('<div class = "record_player_div"></div>');//플레이어8의 정보를 담을 서브 div
			let record_player8_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name8+'.png")"></div>');//플레이어8이 플레이한 챔피언의 이미지
			let record_player8_name = $('<span class = "record_player_name">'+record.player_name8+'</span>');//플레이어8의 이름
			record_player8_div.append(record_player8_img,record_player8_name);//만들어진 플레이어8의 정보를 플레이어8의 서브 div에 append
			
			let record_player9_div = $('<div class = "record_player_div"></div>');//플레이어9의 정보를 담을 서브 div
			let record_player9_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name9+'.png")"></div>');//플레이어9이 플레이한 챔피언의 이미지
			let record_player9_name = $('<span class = "record_player_name">'+record.player_name9+'</span>');//플레이어9의 이름
			record_player9_div.append(record_player9_img,record_player9_name);//만들어진 플레이어9의 정보를 플레이어9의 서브 div에 append
			
			let record_player10_div = $('<div class = "record_player_div"></div>');//플레이어10의 정보를 담을 서브 div
			let record_player10_img = $('<div class = "record_player_img" role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name10+'.png")"></div>');//플레이어10이 플레이한 챔피언의 이미지
			let record_player10_name = $('<span class = "record_player_name">'+record.player_name10+'</span>');//플레이어10의 이름
			record_player10_div.append(record_player10_img,record_player10_name);//만들어진 플레이어10의 정보를 플레이어10의 서브 div에 append
			
			record_team1_div.append(record_player1_div,record_player2_div,record_player3_div,record_player4_div,record_player5_div);
			record_team2_div.append(record_player6_div,record_player7_div,record_player8_div,record_player9_div,record_player10_div);
			
			record_player_div.append(record_team1_div,record_team2_div);
			
			let button_div = $('<div class = "button_div"></div>');
			let button = $('<button type = "button" onclick = "function info(record.match_id)"></button>');
			
			record_div.append(record_win_lose_div,record_champ_div,record_champ_div,record_kda_div,record_cs_sight_div,record_item_div,record_player_div);
			div.append(record_div);
		})
		$('#record').html(div);
	}).fail(err=>{
		console.log(err)
	});
	
	/* function info(match_id){
		getRecordDetail(match_id);
	} */
	
	/* function getRecordDetail(match_id){
		$.ajax({
			  method: 'get',
			  url: 'summoner/get_record_detail',
			  data: { match_id: match_id }
			}).done(res => {
			  console.log(res);
			  // 1. div 태그 생성. class 속성에 "whole" 부여
		      let whole = $('<div class="whole"></div>');

		      // 2. header와 div 태그 생성
		      let header = $('<header class="data_header"></header>');
		      let data = $('<div class="data"></div>');
			  whole.append(header, data); // 2. 생성된 태그들을 whole 태그 내부에 추가
			  
			  // 3. 'data_header' 내부에 div 태그 3개 생성
			  let synthesis = $('<div class="synthesis" onclick="synthesis(match_id)"><p>종합</p></div>');
			  let build = $('<div class="build" onclick="build(match_id,${summoner.summoner_name})"><p>빌드</p></div>');
			  let ranking = $('<div class="ranking" onclick="ranking(match_id, summoner_name)"><p>랭킹</p></div>');
			  header.append(synthesis, build, ranking);
			  
			  // 4. 'data' 내부에 새로운 div 태그 두 개를 생성
			  let win = $('<div class="win"><header class="win_header"></header></div>');
			  let lose = $('<div class="lose"><header class="lose_header"></header></div>');
			  data.append(win, lose);
			  
			  $.each(res, function (i, record) {
			    if (record.win) {
			      // 5. 'win' 내부에 res의 win 값이 true 인 데이터 수 만큼 div 태그 생성
			      let winTeam = $('<div class="win_team"></div>');
			      // 7. 각 'win_team' 내부에 작업할 내용
			      // 7-1. div 태그 4개 생성. 각 div 태그의 class 속성에 'champ_info','kda_info','cs_ward_info','item_info' 부여.
			      let champInfo = $('<div class="champ_info"></div>');
			      let kdaInfo = $('<div class="kda_info"></div>');
			      let csWardInfo = $('<div class="cs_ward_info"></div>');
			      let itemInfo = $('<div class="item_info"></div>');
			      winTeam.append(champInfo,kdaInfo,csWardInfo,itemInfo);
			      
			      let champion = $('<div class="champion"><div role = "img" class = "champ_img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name+'.png")"></div></div>');
			      let champLevel = $('<span class="champ_level">${record.champ_level}</span>');
			      champion.append(champLevel);
			      let spell = $('<div class = "spell"><div class="spell1" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/spell/'+record.spell1+'.png")"></div> <div class="spell2" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/spell/'+record.spell2+'.png")"></div></div>');
			      let rune = $('<div class = "rune"><div class="rune_primary" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/img/'+record.rune_img1+'")></div> <div class="rune_sub" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/img/'+record.rune_img2+'")></div></div>');
			      let summonerName = $('<div class="summoner_name"></div>');
			      let tierBox = $('<span class = "tier_box"></span>');
			      switch (record.tier) {
			      case 'challenger':
			        $tierBox.text('C');
			        break;
			      case 'grandmaster':
			    	  $tierBox.text('GM');
			        break;
			      case 'master':
			    	  $tierBox.text('M');
			        break;
			      case 'diamond':
			    	  $tierBox.text('D');
			        break;
			      case 'platinum':
			    	  $tierBox.text('P');
			        break;
			      case 'gold':
			    	  $tierBox.text('G');
			        break;
			      case 'silver':
			    	  $tierBox.text('S');
			        break;
			      case 'bronze':
			    	  $tierBox.text('B');
			        break;
			      case 'iron':
			    	  $tierBox.text('I');
			        break;
			    }
			      let name = $('<span class = "name">${record.summoner_name}</span>');
			      summonerName.append(tierBox, name);
			      champInfo.append(champion,spell,rune,summonerName);
			      
			      let kdaInfoText = $('<strong class = "kda_info_text"></strong>');
			      let kdaText = $('<strong class = "kda_text"></strong>');
			      let kills = $('<span>${record.kills}/ </span>');
			      let deaths = $('<span>${record.deaths}/ </span>');
			      let assists = $('<span>${record.assists}</span>');
			      kdaInfoText.append(kills,deaths,assists);
			      let kda = $('<span>${record.kda}</span>');
			      kdaText.append(kda);
			      kdaInfo.append(kdaInfoText,kdaText);
			      
			      let csWard = $('<span class = "cs_ward"></span>');
			      let cs = $('<span>${record.cs}/ </span>');
			      let redWards = $('<span>${record.red_wards_placed}</span>');
			      csWard.append(cs,redWards);
			      csWardInfo.append(csWard);
			      
			      let itemImg1 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img1 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item1.png+'" alt = "#">');
				      itemImg.append(img1);
			      }
			      itemInfo.append(itemImg1);
			      
			      let itemImg2 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img2 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item2.png+'" alt = "#">');
				      itemImg.append(img2);
			      }
			      itemInfo.append(itemImg2);
			      
			      let itemImg3 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img3 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item3.png+'" alt = "#">');
				      itemImg.append(img3);
			      }
			      itemInfo.append(itemImg3);
			      
			      let itemImg4 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img4 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item4.png+'" alt = "#">');
				      itemImg.append(img4);
			      }
			      itemInfo.append(itemImg4);
			      
			      let itemImg5 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img5 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item5.png+'" alt = "#">');
				      itemImg.append(img5);
			      }
			      itemInfo.append(itemImg5);
			      
			      let itemImg6 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img6 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item6.png+'" alt = "#">');
				      itemImg.append(img6);
			      }
			      itemInfo.append(itemImg6);
			      
			      let itemImg7 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img7 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item7.png+'" alt = "#">');
				      itemImg.append(img7);
			      }
			      itemInfo.append(itemImg7);
			      
			      winTeam.append(champInfo,kdaInfo,csWardInfo,itemInfo);
			      
			      win.append(winTeam);
			    } else {
			      // 6. 'lose' 내부에 res의 win 값이 false 인 데이터 수 만큼 div 태그 생성
			      let loseTeam = $('<div class = "lose_team"></div>');
			      
			      let champInfo = $('<div class="champ_info"></div>');
			      let kdaInfo = $('<div class="kda_info"></div>');
			      let csWardInfo = $('<div class="cs_ward_info"></div>');
			      let itemInfo = $('<div class="item_info"></div>');
			      winTeam.append(champInfo,kdaInfo,csWardInfo,itemInfo);
			      
			      let champion = $('<div class="champion"><div role = "img" class = "champ_img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+record.champ_name+'.png")"></div></div>');
			      let champLevel = $('<span class="champ_level">${record.champ_level}</span>');
			      champion.append(champLevel);
			      let spell = $('<div class = "spell"><div class="spell1" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/spell/'+record.spell1+'.png")"></div> <div class="spell2" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/spell/'+record.spell2+'.png")"></div></div>');
			      let rune = $('<div class = "rune"><div class="rune_primary" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/img/'+record.rune_img1+'")></div> <div class="rune_sub" role="img" style="background-image: url("https://ddragon.leagueoflegends.com/cdn/img/'+record.rune_img2+'")></div></div>');
			      let summonerName = $('<div class="summoner_name"></div>');
			      let tierBox = $('<span class = "tier_box"></span>');
			      switch (record.tier) {
			      case 'challenger':
			        $tierBox.text('C');
			        break;
			      case 'grandmaster':
			    	  $tierBox.text('GM');
			        break;
			      case 'master':
			    	  $tierBox.text('M');
			        break;
			      case 'diamond':
			    	  $tierBox.text('D');
			        break;
			      case 'platinum':
			    	  $tierBox.text('P');
			        break;
			      case 'gold':
			    	  $tierBox.text('G');
			        break;
			      case 'silver':
			    	  $tierBox.text('S');
			        break;
			      case 'bronze':
			    	  $tierBox.text('B');
			        break;
			      case 'iron':
			    	  $tierBox.text('I');
			        break;
			    }
			      let name = $('<span class = "name">${record.summoner_name}</span>');
			      summonerName.append(tierBox, name);
			      champInfo.append(champion,spell,rune,summonerName);
			      
			      let kdaInfoText = $('<strong class = "kda_info_text"></strong>');
			      let kdaText = $('<strong class = "kda_text"></strong>');
			      let kills = $('<span>${record.kills}/ </span>');
			      let deaths = $('<span>${record.deaths}/ </span>');
			      let assists = $('<span>${record.assists}</span>');
			      kdaInfoText.append(kills,deaths,assists);
			      let kda = $('<span>${record.kda}</span>');
			      kdaText.append(kda);
			      kdaInfo.append(kdaInfoText,kdaText);
			      
			      let csWard = $('<span class = "cs_ward"></span>');
			      let cs = $('<span>${record.cs}/ </span>');
			      let redWards = $('<span>${record.red_wards_placed}</span>');
			      csWard.append(cs,redWards);
			      csWardInfo.append(csWard);
			      
			      let itemImg1 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img1 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item1.png+'" alt = "#">');
				      itemImg.append(img1);
			      }
			      itemInfo.append(itemImg1);
			      
			      let itemImg2 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img2 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item2.png+'" alt = "#">');
				      itemImg.append(img2);
			      }
			      itemInfo.append(itemImg2);
			      
			      let itemImg3 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img3 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item3.png+'" alt = "#">');
				      itemImg.append(img3);
			      }
			      itemInfo.append(itemImg3);
			      
			      let itemImg4 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img4 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item4.png+'" alt = "#">');
				      itemImg.append(img4);
			      }
			      itemInfo.append(itemImg4);
			      
			      let itemImg5 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img5 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item5.png+'" alt = "#">');
				      itemImg.append(img5);
			      }
			      itemInfo.append(itemImg5);
			      
			      let itemImg6 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img6 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item6.png+'" alt = "#">');
				      itemImg.append(img6);
			      }
			      itemInfo.append(itemImg6);
			      
			      let itemImg7 = $('<div class = "item_img"></div>');
			      if(record.item !== null){
			    	  img7 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+record.item7.png+'" alt = "#">');
				      itemImg.append(img7);
			      }
			      itemInfo.append(itemImg7);
			      
			      loseTeam.append(champInfo,kdaInfo,csWardInfo,itemInfo);
			      
			      lose.append(loseTeam);
			    }
			  });
			}).fail(err => {
			  console.log(err);
			});
	} */
		
	/* getRecordDetail();
	
	$('#champ_all').click(function(){
		$.ajax({//소환사의 챔피언 통계
			method : 'get',
			url : '/summoner/get_champ_record',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			console.log(res)
			let champ_div = $('<div></div>');
			let winrate_div = $('<div></div>');
			let games_div = $('<div><div>');
			let wins_div = $('<div></div>');
			let losses_div = $('<div></div>');
			let kda_div = $('<div></div>');
			let kills_div = $('<div></div>');
			let deaths_div = $('<div></div>');
			let assists_div = $('<div><div>');
			let cs_div = $('<div></div>');
			let cs_pm_div = $('<div></div>');
			$.each(res.champ_name, function (i, champ_name){
				let champ_img = $('<div role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+champ_name+'.png")"></div>');
				let champ_name_text = $('<span>'+champ_name+'</span>');
				champ_div.append(champ_img,champ_name_text);
			})
			$.each(res.winrate, function(i, winrate){
				let winrate_text = $('<strong>'+winrate+'%</strong>');
				winrate_div.append(winrate_text);
			})
			$.each(res.games, function(i, games){
				let games_text = $('<p>'+games+'</p>');
				games_div.append(games_text);
			})
			$.each(res.wins, function(i, wins){
				let win_text = $('<span>'+wins+'</span>');
				wins_div.append(win_text);
			})
			$.each(res.losses, function(i, losses){
				let losses_text = $('<span>'+losses+'</span>');
				losses_div.append(losses_text);
			})
			$.each(res.kda, function(i, kda){
				let kda_text = $('<strong>'+kda+'</strong>');
				kda_div.append(kda_text);
			})
			$.each(res.kills, function(i, kills){
				let kills_text = $('<span>'+kills+'</span>');
				kills_div.append(kills_text);
			})
			$.each(res.deaths, function(i, deaths){
				let deaths_text = $('<span>'+deaths+'</span>');
				deaths_div.append(deaths_text);
			})
			$.each(res.assists, function(i, assists){
				let assists_text = $('<span>'+assists+'</span>');
				assists_div.append(assists_text);
			})
			$.each(res.cs, function(i, cs){
				let cs_text = $('<strong>'+cs+'</strong>');
				cs_div.append(cs_text);
			})
			$.each(res.cs_pm, function(i, cs_pm){
				let cs_pm_text = $('<span>'+cs_pm+'<span>');
				cs_pm_div.append(cs_pm_text);
			})
			$('.champ_data').html(champ_div);
			$('.winrate_data').html(winrate_div);
			$('.games_data').html(games_div);
			$('.wins_data').html(wins_div);
			$('.losses_data').html(losses_div);
			$('.kda_data').html(kda_div);
			$('.kills_data').html(kills_div);
			$('.deaths_data').html(deaths_div);
			$('.assists_data').html(assists_div);
			$('.cs_data').html(cs_div);
			$('.cs_pm_data').html(cs_pm_div);
		}).fail(err=>{
			console.log(err)
		})
	}) */
	
	/* $('#champ_solo').click(function(){
		$.ajax({//소환사의 챔피언 통계
			method : 'get',
			url : '/summoner/get_champ_solo',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			console.log(res)
			let champ_div = $('<div></div>');
			let winrate_div = $('<div></div>');
			let games_div = $('<div><div>');
			let wins_div = $('<div></div>');
			let losses_div = $('<div></div>');
			let kda_div = $('<div></div>');
			let kills_div = $('<div></div>');
			let deaths_div = $('<div></div>');
			let assists_div = $('<div><div>');
			let cs_div = $('<div></div>');
			let cs_pm_div = $('<div></div>');
			$.each(res.champ_name, function (i, champ_name){
				let champ_img = $('<div role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+champ_name+'.png")"></div>');
				let champ_name_text = $('<span>'+champ_name+'</span>');
				champ_div.append(champ_img,champ_name_text);
			})
			$.each(res.winrate, function(i, winrate){
				let winrate_text = $('<strong>'+winrate+'%</strong>');
				winrate_div.append(winrate_text);
			})
			$.each(res.games, function(i, games){
				let games_text = $('<p>'+games+'</p>');
				games_div.append(games_text);
			})
			$.each(res.wins, function(i, wins){
				let win_text = $('<span>'+wins+'</span>');
				wins_div.append(win_text);
			})
			$.each(res.losses, function(i, losses){
				let losses_text = $('<span>'+losses+'</span>');
				losses_div.append(losses_text);
			})
			$.each(res.kda, function(i, kda){
				let kda_text = $('<strong>'+kda+'</strong>');
				kda_div.append(kda_text);
			})
			$.each(res.kills, function(i, kills){
				let kills_text = $('<span>'+kills+'</span>');
				kills_div.append(kills_text);
			})
			$.each(res.deaths, function(i, deaths){
				let deaths_text = $('<span>'+deaths+'</span>');
				deaths_div.append(deaths_text);
			})
			$.each(res.assists, function(i, assists){
				let assists_text = $('<span>'+assists+'</span>');
				assists_div.append(assists_text);
			})
			$.each(res.cs, function(i, cs){
				let cs_text = $('<strong>'+cs+'</strong>');
				cs_div.append(cs_text);
			})
			$.each(res.cs_pm, function(i, cs_pm){
				let cs_pm_text = $('<span>'+cs_pm+'<span>');
				cs_pm_div.append(cs_pm_text);
			})
			$('.champ_data').html(champ_div);
			$('.winrate_data').html(winrate_div);
			$('.games_data').html(games_div);
			$('.wins_data').html(wins_div);
			$('.losses_data').html(losses_div);
			$('.kda_data').html(kda_div);
			$('.kills_data').html(kills_div);
			$('.deaths_data').html(deaths_div);
			$('.assists_data').html(assists_div);
			$('.cs_data').html(cs_div);
			$('.cs_pm_data').html(cs_pm_div);
		}).fail(err=>{
			console.log(err)
		})
	}) */
	
	/* $('#champ_flex').click(function(){
		$.ajax({//소환사의 챔피언 통계
			method : 'get',
			url : '/summoner/get_champ_flex',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			console.log(res)
			let champ_div = $('<div></div>');
			let winrate_div = $('<div></div>');
			let games_div = $('<div><div>');
			let wins_div = $('<div></div>');
			let losses_div = $('<div></div>');
			let kda_div = $('<div></div>');
			let kills_div = $('<div></div>');
			let deaths_div = $('<div></div>');
			let assists_div = $('<div><div>');
			let cs_div = $('<div></div>');
			let cs_pm_div = $('<div></div>');
			$.each(res.champ_name, function (i, champ_name){
				let champ_img = $('<div role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+champ_name+'.png")"></div>');
				let champ_name_text = $('<span>'+champ_name+'</span>');
				champ_div.append(champ_img,champ_name_text);
			})
			$.each(res.winrate, function(i, winrate){
				let winrate_text = $('<strong>'+winrate+'%</strong>');
				winrate_div.append(winrate_text);
			})
			$.each(res.games, function(i, games){
				let games_text = $('<p>'+games+'</p>');
				games_div.append(games_text);
			})
			$.each(res.wins, function(i, wins){
				let win_text = $('<span>'+wins+'</span>');
				wins_div.append(win_text);
			})
			$.each(res.losses, function(i, losses){
				let losses_text = $('<span>'+losses+'</span>');
				losses_div.append(losses_text);
			})
			$.each(res.kda, function(i, kda){
				let kda_text = $('<strong>'+kda+'</strong>');
				kda_div.append(kda_text);
			})
			$.each(res.kills, function(i, kills){
				let kills_text = $('<span>'+kills+'</span>');
				kills_div.append(kills_text);
			})
			$.each(res.deaths, function(i, deaths){
				let deaths_text = $('<span>'+deaths+'</span>');
				deaths_div.append(deaths_text);
			})
			$.each(res.assists, function(i, assists){
				let assists_text = $('<span>'+assists+'</span>');
				assists_div.append(assists_text);
			})
			$.each(res.cs, function(i, cs){
				let cs_text = $('<strong>'+cs+'</strong>');
				cs_div.append(cs_text);
			})
			$.each(res.cs_pm, function(i, cs_pm){
				let cs_pm_text = $('<span>'+cs_pm+'<span>');
				cs_pm_div.append(cs_pm_text);
			})
			$('.champ_data').html(champ_div);
			$('.winrate_data').html(winrate_div);
			$('.games_data').html(games_div);
			$('.wins_data').html(wins_div);
			$('.losses_data').html(losses_div);
			$('.kda_data').html(kda_div);
			$('.kills_data').html(kills_div);
			$('.deaths_data').html(deaths_div);
			$('.assists_data').html(assists_div);
			$('.cs_data').html(cs_div);
			$('.cs_pm_data').html(cs_pm_div);
		}).fail(err=>{
			console.log(err)
		})
	}) */
	
	/* $('#champ_classic').click(function(){
		$.ajax({//소환사의 챔피언 통계
			method : 'get',
			url : '/summoner/get_champ_classic',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			console.log(res)
			let champ_div = $('<div></div>');
			let winrate_div = $('<div></div>');
			let games_div = $('<div><div>');
			let wins_div = $('<div></div>');
			let losses_div = $('<div></div>');
			let kda_div = $('<div></div>');
			let kills_div = $('<div></div>');
			let deaths_div = $('<div></div>');
			let assists_div = $('<div><div>');
			let cs_div = $('<div></div>');
			let cs_pm_div = $('<div></div>');
			$.each(res.champ_name, function (i, champ_name){
				let champ_img = $('<div role = "img" style = "background-image : url("https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/'+champ_name+'.png")"></div>');
				let champ_name_text = $('<span>'+champ_name+'</span>');
				champ_div.append(champ_img,champ_name_text);
			})
			$.each(res.winrate, function(i, winrate){
				let winrate_text = $('<strong>'+winrate+'%</strong>');
				winrate_div.append(winrate_text);
			})
			$.each(res.games, function(i, games){
				let games_text = $('<p>'+games+'</p>');
				games_div.append(games_text);
			})
			$.each(res.wins, function(i, wins){
				let win_text = $('<span>'+wins+'</span>');
				wins_div.append(win_text);
			})
			$.each(res.losses, function(i, losses){
				let losses_text = $('<span>'+losses+'</span>');
				losses_div.append(losses_text);
			})
			$.each(res.kda, function(i, kda){
				let kda_text = $('<strong>'+kda+'</strong>');
				kda_div.append(kda_text);
			})
			$.each(res.kills, function(i, kills){
				let kills_text = $('<span>'+kills+'</span>');
				kills_div.append(kills_text);
			})
			$.each(res.deaths, function(i, deaths){
				let deaths_text = $('<span>'+deaths+'</span>');
				deaths_div.append(deaths_text);
			})
			$.each(res.assists, function(i, assists){
				let assists_text = $('<span>'+assists+'</span>');
				assists_div.append(assists_text);
			})
			$.each(res.cs, function(i, cs){
				let cs_text = $('<strong>'+cs+'</strong>');
				cs_div.append(cs_text);
			})
			$.each(res.cs_pm, function(i, cs_pm){
				let cs_pm_text = $('<span>'+cs_pm+'<span>');
				cs_pm_div.append(cs_pm_text);
			})
			$('.champ_data').html(champ_div);
			$('.winrate_data').html(winrate_div);
			$('.games_data').html(games_div);
			$('.wins_data').html(wins_div);
			$('.losses_data').html(losses_div);
			$('.kda_data').html(kda_div);
			$('.kills_data').html(kills_div);
			$('.deaths_data').html(deaths_div);
			$('.assists_data').html(assists_div);
			$('.cs_data').html(cs_div);
			$('.cs_pm_data').html(cs_pm_div);
		}).fail(err=>{
			console.log(err)
		})
	}) */
	
	//종합 버튼 클릭 시
	/* function synthesis(match_id){
		getRecordDetail();
	} */
	
	//빌드 버튼 클릭 시
	/* function build(match_id){
		$.ajax({
			method : 'get',
			url : '/summoner/info/getBuild',
			data : {match_id : match_id, summoner_name : summoner_name}
		}).done(res=>{
			console.log(res)
			let data_div = $('<div></div>');
			let item_build_div = $('<div class = "item_build_div"></div>');
			let skill_build_div = $('<div class = "skill_build_div"></div>');
			let rune_build_div = $('<div class = "rune_build_div"></div>');
			
			let item_div = $('<div></div>');
			$.each(res.timeline, function(i,timeline){
				let item = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/item/'+timeline.item.png+'">');
				item_div.append(item);
			})
			item_build_div.append(item_div);
			
			let skill_div = $('<div></div>');
			$.each(res.timeline, function(i, timeline){
				let skill1 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/spell/'+timeline.skill1+'.png">');
				let skill2 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/spell/'+timeline.skill2+'.png">');
				let skill3 = $('<img src = "http://ddragon.leagueoflegends.com/cdn/13.9.1/img/spell/'+timeline.skill3+'.png">');
				skill_div.append(skill1,skill2,skill3);
			})
			skill_build_div.append(skill_div);
			
			let rune_div1 = $('<div></div>');
			let rune_div2 = $('<div></div>');
			let rune_stat = $('<div></div>');
			
			let main_rune = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.main_rune+'.png">');
			let main1 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.main_rune1+'.png">');
			let main2 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.main_rune2+'.png">');
			let main3 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.main_rune3+'.png">');
			let main4 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.main_rune4+'.png">');
			rune_div1.append(main_rune,main1,main2,main3,main4);
			
			let sub_rune = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.main_rune+'.png">');
			let sub1 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.sub_rune1+'.png">');
			let sub2 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.sub_rune2+'.png">');
			let sub3 = $('<img src = "https://ddragon.leagueoflegends.com/cdn/img/'+res.sub_rune3+'.png">');
			rune_div2.append(sub_rune,sub1,sub2,sub3);
			
			let stat1 = $('<img src = "">');
			let stat2 = $('<img src = "">');
			let stat3 = $('<img src = "">');
			
			rune_stat.append(stat1,stat2,stat3);
			
			rune_build_div.append(rune_div1,rune_div2,rune_stat);	
			
			data_div.append(item_build_div,skill_build_div,rune_build_div);
			$('.build_info').html(data_div);
		}).fail(err=>{
			console.log(err)
		})
	} */
	
	//랭킹 버튼 클릭 시
/* 	$('#ranking').click(function(match_id,summoner_name){
		$.ajax({
			method : 'get',
			url : '/summoner/getRanking',
			data : {match_id : match_id, summoner_name : summoner_name}
		}).done(res=>{
			console.log(res)
			let plyaersDamage = [];
			let playersTaken = [];
			let playersKills = [];
			let playersDeaths = [];
			let playersAssists = [];
			let playersGolds = [];
			let playersRedWards = [];
			let playersCS = [];
			
			$.each(res.dealtDamage, function(i, dealt){
				playersDamage.push({name : res.summoner_name, dealtDamage : dealt});
			});
			playersDamage.sort((a, b) => b.dealtDamage - a.dealtDamage);
			let playersDamageRank = playersDamage.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerDealt = playersDamage.findIndex(player => player.name === summoner_name);
			
			$.each(res.takenDamage, function(i, taken){
				playersTaken.push({name : res.summoner_name, takenDamage : taken});
			});
			playersTaken.sort((a, b) => b.takenDamage - a.takenDamage);
			let playersTakenRank = playersTaken.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerTaken = playersTaken.findIndex(player => player.name === summoner_name);
			
			$.each(res.kills, function(i, kills){
				playersKills.push({name : res.summoner_name, Kills : kills});
			});
			playersKills.sort((a, b) => b.Kills - a.Kills);
			let playersKillsRank = playersKills.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerKills = playersKills.findIndex(player => player.name === summoner_name);
			
			$.each(res.deaths, function(i, deaths){
				playersDeaths.push({name : res.summoner_name, deaths : deaths});
			});
			playersDeaths.sort((a, b) => b.deaths - a.deaths);
			let playersDeathsRank = playersDeaths.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerDeaths = playersDeaths.findIndex(player => player.name === summoner_name);
			
			$.each(res.assists, function(i, assists){
				playersAssists.push({name : res.summoner_name, assists : dealt});
			});
			playersAssists.sort((a, b) => b.assists - a.assists);
			let playersAssistsRank = playersAssists.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerAssists = playersAssists.findIndex(player => player.name === summoner_name);
			
			$.each(res.golds, function(i, golds){
				playersGolds.push({name : res.summoner_name, golds : golds});
			});
			playersGolds.sort((a, b) => b.golds - a.golds);
			let playersGoldsRank = playersGolds.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerGolds = playersGolds.findIndex(player => player.name === summoner_name);
			
			$.each(res.redWards, function(i, redWards){
				playersRedWards.push({name : res.summoner_name, redWards : redWards});
			});
			playersRedWards.sort((a, b) => b.redWards - a.redWards);
			let playersRedWardsRank = playersRedWards.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerRedWards = playersRedWards.findIndex(player => player.name === summoner_name);
			
			$.each(res.CS, function(i, CS){
				playersCS.push({name : res.summoner_name, CS : CS});
			});
			playersDamage.sort((a, b) => b.dealtDamage - a.dealtDamage);
			let playersCSRank = playersCS.findIndex(player => player.name === summoner_name) + 1;
			let thisSummonerCS = playersCS.findIndex(player => player.name === summoner_name)
			
			let dealtDiv = $('<div></div>');
			let takenDiv = $('<div></div>');
			let killsDiv = $('<div></div>');
			let deathsDiv = $('<div></div>');
			let assistsDiv = $('<div></div>');
			let goldsDiv = $('<div></div>');
			let redWardsDiv = $('<div></div>');
			let csDiv = $('<div></div>');
			
			let dealtTitle = $('<div><p>피해량</p></div>');
			let dealtRank = $('<div>'+playersDamageRank+'위</div>');
			let dealtGraph = $('<div></div>');
			let dealtText = $('<div><span><strong>'+thisSummonerDealt+'</strong><span>/'+res.team_dealt+'</span></span></div>');
			dealtDiv.append(dealtTitle,dealtRank,dealtGraph,dealtText);
			
			let takenTitle = $('<div><p>받은 피해량</p></div>');
			let takenRank = $('<div>'+playersTakenRank+'위</div>');
			let takenGraph = $('<div></div>');
			let takenText = $('<div><span><strong>'+thisSummonerTanken+'</strong><span>/'+res.team_taken+'</span></span></div>');
			takenDiv.append(takenTitle,takenRank,takenGraph,takenText);
			
			let killsTitle = $('<div><p>킬</p></div>');
			let killsRank = $('<div>'+playersKillsRank+'위</div>');
			let killsGraph = $('<div></div>');
			let killsText = $('<div><span><strong>'+thisSummonerKills+'</strong><span>/'+res.team_kills+'</span></span></div>');
			killsDiv.append(killsTitle,killsRank,killsGraph,killsText);
			
			let deathsTitle = $('<div><p>데스</p></div>');
			let deathsRank = $('<div>'+playersDeathsRank+'위</div>');
			let deathsGraph = $('<div></div>');
			let deathsText = $('<div><span><strong>'+thisSummonerDeaths+'</strong><span>/'+res.team_deaths+'</span></span></div>');
			deathsDiv.append(deathsTitle,deathsRank,deathsGraph,deathsText);
			
			let assistsTitle = $('<div><p>어시스트</p></div>');
			let asssitsRank = $('<div>'+playersAssistsRank+'위</div>');
			let assistsGraph = $('<div></div>');
			let assistsText = $('<div><span><strong>'+thisSummonerAssists+'</strong><span>/'+res.team_assists+'</span></span></div>');
			assistsDiv.append(assistsTitle,assistsRank,assistsGraph,assistsText);
			
			let goldsTitle = $('<div><p>골드 획득량</p></div>');
			let goldsRank = $('<div>'+playersGoldsRank+'위</div>');
			let goldsGraph = $('<div></div>');
			let goldsText = $('<div><span><strong>'+thisSummonerGolds+'</strong><span>/'+res.team_golds+'</span></span></div>');
			goldsDiv.append(goldsTitle,goldsRank,goldsGraph,goldsText);
			
			let redWardsTitle = $('<div><p>제어와드</p></div>');
			let redWardsRank = $('<div>'+playersRedWardsRank+'위</div>');
			let redWardsGraph = $('<div></div>');
			let redWardsText = $('<div><span><strong>'+thisSummonerRedWards+'</strong><span>/'+res.team_redWards+'</span></span></div>');
			redWardsDiv.append(redWardsTitle,redWardsRank,redWardsGraph,redWardsText);
			
			let CSTitle = $('<div><p>CS</p></div>');
			let CSRank = $('<div>'+playersCSRank+'위</div>');
			let CSGraph = $('<div></div>');
			let CSText = $('<div><span><strong>'+thisSummonerCS+'</strong><span>/'+res.team_CS+'</span></span></div>');
			CSDiv.append(CSTitle,CSRank,CSGraph,CSText);
			
			let data_div = $('<div></div>');
			data_div.append(dealtDiv, takenDiv, killsDiv, deathsDiv, assistsDiv, goldsDiv, redWardsDiv, CSDiv);
			
			$('.build_info').html(data_div);
		}).fail(err=>{
			console.log(err)
		});
	}); */
	
	
	$('.rank_filter').click(function(){
		$('.rank_filter').not(this).prop('checked', false)
	})
	
	</script>

</body>
</html>