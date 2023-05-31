<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 대시보드</title>
<!-- 차트 JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<link href = "/resources/css/summoner/DashBoard.css?after" rel = "stylesheet">
</head>
<body>
	<div class = "flex-dashboard">
		<div class = "flex-my-profile">
			<img alt="#" src="/resources/img/profileicon/${summoner.profile_icon_id}.png" class = "flex-profile-icon">
			<p class = "flex-summonerName">${summoner.summoner_name}</p>
		</div>
		
		<div class = "flex-summoner">
		
			<div class = "flex-tier">
				
					<div class = "flex-tier-title">
						
						<span class = "flex-text">솔로랭크</span>
						
						<div class = "flex-css">
						
							<img class = "flex-tier-emblem" src="/resources/img/ranked-emblem/emblem-${summoner.tier}.png">
					
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
				
			</div>
			
			<div class = "flex-kda"></div>
		
		</div>
		
		<div class = "flex-rank-winrate">
		
			<div class = "flex-winrate-title">최근 10게임간의 승률</div>
			
				<div class = "flex-winrate-subtitle">
					<p class = "flex-champion">챔피언</p>
					<p class = "flex-champion-winrate">승률</p>
				</div>
			
			<div class = "flex-champion-data">
			
			</div>
			
		</div>
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
 	function loadingKdaData(){
		$.ajax({
			method : 'get',
			url : '/summoner/dashboard/kda',
			data : {summoner_name : '${summoner.summoner_name}'}
		}).done(res=>{
			let winrateDiv = $('<div class = "flex-winrateDiv"></div>');
			let record = $('<span class = "record">20전 '+res.wins+'승 '+res.losses+'패</span>');
			let canvas = $('<canvas></canvas>')[0];
			let chartId = 'winrateChart';
			canvas.id = chartId;
			let ctx = canvas.getContext('2d');
			$(canvas).css({
				  'max-width': '70px',
				  'max-height': '70px'
				});
			let myChart = new Chart(ctx,{
				type : 'doughnut',
				data : {
					labels : ['승률'],
					datasets : [{label : '승률' , data : [res.wins, res.losses],
		    			  backgroundColor : ['rgba(54, 162, 235, 0.5)','rgba(255, 99, 132, 0.5)',],
		    			  borderColor : ['rgba(54, 162, 235, 0.5)','rgba(255, 99, 132, 0.5)',],
		    			  borderWidth : 1
		    		  }]
				},
				options:{
					sclaes : {
						x : {
							ticks : {
								display : false
							},
							grid : {
								display : false
							},
						},
						y : {
							display : false,
							grid : {
								display : false
							}
						}
					},
					plugins : {
						legend : {
							display : false
						}
					}
				}
			})
			let div = $('<div class = "Div"></div>');
			div.append(record, canvas);
			let Div = $('<div class = "classDiv"></div>');
			
			let kdaDiv = $('<div class = "kdaDiv"></div>');
			let kdaText = $('<span class = "kdaText">'+res.kills_avg+'<strong>/'+res.deaths_avg+'</strong><span>/'+res.assists_avg+'</span></span>');
			let kdaAvg = $('<strong class = "kdaAvg">평점 : '+res.kda_avg+'</strong>');
			let killInv = $('<span class = "killInvs">킬 관여율 <strong class = "killInvS">'+res.kill_involve+'%</strong></span>');
			kdaDiv.append(kdaText, kdaText, kdaAvg);
			Div.append(div, kdaDiv)
			$('.flex-kda').html(Div);
		}).fail(err=>{
			console.log(err);
		})
	}
 	
 	function loadingRecentWinrate() {
 		  $.ajax({
 		    method: 'get',
 		    url: '/summoner/dashboard/recent',
 		    data: { summoner_name: '${summoner.summoner_name}' }
 		  }).done(res => {
 		    let champData = $('<div class="champData"></div>');
 		    let champDiv = $('<div class="champDiv"></div>');
 		    let winrateDiv = $('<div class="winrateDiv"></div>');

 		    $.each(res, function (i, res) {
 		      let champImg = $('<img class="champImg" src="/resources/img/champion_img/square/' + res.champ_name + '.png">');
 		      let champName = $('<span class="champName">' + res.champ_name + '</span>');
 		      champDiv.append(champImg, champName);
 		      
 		      let winrate = 0;
 		      if(res.wins === 0){
 		    	  winrate = 0;
 		      }else if(res.wins > 0 & res.losses > 0){
 		    	  winrate = ((res.wins / res.losses) * 100).toFixed(2);
 		      }else if(res.wins > 0 & res.losses === 0){
 		    	  winrate = 100;
 		      }

 		      let winrateText = $('<span class="winrateText">' + winrate + '%</span>');

 		      // 그래프 그리기
 		      let canvas = $('<canvas></canvas>')[i];
 		      let chartId = 'chart' + i; // 각 그래프를 구분하기 위한 고유 ID
 		      canvas.id = chartId;
 		      let ctx = canvas.getContext('2d');
 		      
 		     let myWins = res.wins;
 		     let myLosses = res.losses;

 		     let winLabel = res.wins + '승';
 		     let lossLabel = res.losses + '패';
 		      
 		     $(canvas).css({
 		    	  'max-width': '700px',
 		    	  'max-height': '40px'
 		    	});
 		      let myChart = new Chart(ctx,{
 		    	  type : 'bar',
 		    	  data : {
 		    		  labels : ['승률'],
 		    		  datasets : [
 		    			  {label : '승리' , data : [myWins],
 		    			  backgroundColor : ['rgba(54, 162, 235, 0.5)'],
 		    			  borderColor : ['rgba(54, 162, 235, 0.5)'],
 		    			  borderWidth : 1
 		    		  }, {
 		    			 label : '패배' , data : [myLosses],
		    			  backgroundColor : ['rgba(255, 99, 132, 0.5)'],
		    			  borderColor : ['rgba(255, 99, 132, 0.5)',],
		    			  borderWidth : 1
 		    		  }
 		    		  ]
 		    	  },
 		    	  options : {
 		    		  indexAxis : 'y',
 		    		  scales : {
 		    			  x : {
 		    				  ticks : {
 		    					  display : false
 		    				  },
 		    				  grid : {
 		    					  display : false
 		    				  },
 		    				  stacked : true
 		    			  },
 		    			  y : {
 		    				  display : false,
 		    				  grid : {
 		    					  display : false
 		    				  },
 		    				  stacked : true
 		    			  }
 		    		  },
 		    		  plugins : {
 		    			  legend : {
 		    				  display : false
 		    			  }
 		    		  }
 		    	  }
 		      });
 		      winrateDiv.append(canvas, winrateText);
 		      champData.append(champDiv, winrateDiv);
    	  });
 		    // 그래프를 표시할 영역에 추가
 		  $('.flex-champion-data').html(champData);
 		  }).fail(err => {
 		    console.log(err);
 		  });
 		}
 	let allDataDiv = $('<div class = "allDataDiv"></div>');
 	function loadingMatchUpData() {
 		let matchIdList = [];

 		$.ajax({
 		  method: 'get',
 		  url: '/summoner/dashboard/matchup',
 		  data: { summoner_name: '${summoner.summoner_name}' }
 		}).done(res => {
 		  $.each(res, function(i, res) {
 		  matchIdList[i] = res.match_id;
 		});
 		    
 		getPlayer(matchIdList);
 		    
 		$('.flex-matchup-data').html(allDataDiv);
 		}).fail(err => {
		  console.log(err);
		});
 	}
 	
 	function getPlayer(matchIdList){
 		let summonerStats = [];
 		$.each(matchIdList, function(i, ing) {
		    matchId = matchIdList[i];
   	        $.ajax({
		        method: 'get',
		        url: '/summoner/dashboard/getPlayer',
		        data: { match_id: matchId, summoner_name: '${summoner.summoner_name}' }
		      }).done(response => {
		        $.each(response, function(j, summoner) {
		          let sName = summoner.summoner_name;
		          let sWin = summoner.win;

		          let existingSummoner = summonerStats.find(s => s.summonerName === sName);
		          if (existingSummoner) {
		            existingSummoner.games++;
		            if (sWin === 1) {
		              existingSummoner.wins++;
		            } else {
		              existingSummoner.losses++;
		            }
		          } else {
		            if (sName.trim() !== "") {
		              summonerStats.push({ summonerName: sName, games: 1, wins: sWin === 1 ? 1 : 0, losses: sWin === 0 ? 1 : 0 });
		            }
		          }
		          
		          getMaking(sName, summonerStats[j]);
		        });
		        
		      }).fail(error => {
		        console.log(error);
		      });
		      
		 });
 	}
 	
 	function getMaking(sName, summonerStats){
 		$.ajax({
      	  method : 'get',
      	  url : '/summoner/dashboard/profile',
      	  data : {summoner_name : sName}
        }).done(o=>{
  		  let fullSummonerData = $('<div class = "fullSummonerData"></div>');
  		  let summonerNameDiv = $('<div class = "summonerNameDiv"></div>');
  		  let soloRankTierDiv = $('<div class = "soloRankTierDiv"></div>');
  		  let gamesDiv = $('<div class = "gamesDiv"></div>');
  		  let winsDiv = $('<div class = "winsDiv"></div>');
  		  let lossesDiv = $('<div class = "lossesDiv"></div>');
  		  let winrateDiv = $('<div class = "allWinrateDiv"></div>');
  		 if(o.tier != undefined){
  			let profileImg = $('<img class = "profileImg" src = "/resources/img/profileicon/'+o.profile_icon_id+'.png">');
    		  let summonerNameText = $('<span class = "summonerNameText">'+sName+'</span>');
    		  summonerNameDiv.append(profileImg, summonerNameText);
    		  
    		  let rankTierImg = $('<img class = "rankTierImg" src = "/resources/img/ranked-emblem/emblem-'+o.tier+'.png">');
    		  let rankTierText = $('<span class = "rankTierText">'+o.tier+'</span>');
    		  soloRankTierDiv.append(rankTierImg, rankTierText);
    		  
    		  let gamesText = $('<span class = "gamesText">'+summonerStats.games+'</span>');
    		  gamesDiv.append(gamesText);
    		  
    		  let winsText = $('<span class = "winsText">'+summonerStats.wins+'</span>');
    		  winsDiv.append(winsText);
    		  
    		  let lossesText = $('<span class = "lossesText">'+summonerStats.losses+'</span>');
    		  lossesDiv.append(lossesText);
    		  
    		  let winrate = (summonerStats.wins / summonerStats.games) * 100; 
    		  let winrateText = $('<span class = "winrateText">'+winrate+'%</span>');
    		  winrateDiv.append(winrateText);
    		  fullSummonerData.append(summonerNameDiv, soloRankTierDiv, gamesDiv, winsDiv, lossesDiv, winrateDiv);
    		  allDataDiv.append(fullSummonerData);
  		  }
        }).fail(x=>{
      	  console.log(x);
        });
 	}
 	
 	loadingKdaData();
 	loadingRecentWinrate();
 	loadingMatchUpData();
	</script>
	
</body>
</html>