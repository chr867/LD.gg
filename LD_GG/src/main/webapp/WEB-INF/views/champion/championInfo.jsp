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
<!--CHAMPION INFO CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/champion/info.css">


<style type="text/css">
.top-container {
	display: flex;
	box-sizing: border-box;
	padding: 100px 50px 0px 100px;
}

.left-container {
	box-sizing: border-box;
	width: 350px;
	height: 100%;
	margin-right: 20px;
}

.middle-container {
	box-sizing: border-box;
	width: 660px;
	height: 100%;
}

.right-container {
	box-sizing: border-box;
	width: 720px;
	height: 100%;
	margin-left: 20px;
}

.bottom-container {
	padding: 20px 50px 50px 100px;
	display: flex;
	box-sizing: border-box;
}
</style>


<style type="text/css">
.mythic-common-item-container {
	width: 720px;
	height: 300px;
	display: flex;
	box-sizing: border-box;
}

.mythic-item-container {
	width: 350px;
	height: 100%;
	background-color: #fff;
	border-radius: 0.5rem;
	margin-right: 20px;
	box-sizing: border-box;
}

.common-item-container {
	width: 350px;
	height: 100%;
	background-color: #fff;
	border-radius: 0.5rem;
	box-sizing: border-box;
}

.mythic-item-title {
	text-align: center;
}

.mythic-item-title h4 {
	font-size: 20px;
	font-weight: 700;
}

.common-item-title {
	text-align: center;
}

.common-item-title h4 {
	font-size: 20px;
	font-weight: 700;
}

.mythic-recomm-box .item-img:hover .item-desc {
	visibility: visible;
	opacity: 1;
}

.common-recomm-box .item-img:hover .item-desc {
	visibility: visible;
	opacity: 1;
}

.lane-desc {
	position: absolute;
	top: 35px;
	z-index: 300;
	width: 150px;
	background-color: black;
	color: #fff;
	border-radius: 0.5rem;
	padding: 10px;
	visibility: hidden;
	opacity: 0;
	transition: visibility 0s, opacity 0.3s linear;
	font-size: 14px;
}

.lane-img:hover .lane-desc {
	visibility: visible;
	opacity: 1;
}
</style>


</head>

<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>

	<!----------------------------------------------------------------------------------------------------------------->
	<div class="top-container">
		<div class="left-container">
			<div class="lane-select-box"></div>
			<div class="champion-info-box">
				<table class="champion-table">
					<tr>
						<td rowspan="2"><img alt=""
							src="/resources/img/champion_img/square/${chamInfo.champion_img}"
							class="champion-img"></td>
						<td colspan="5"><h3 class="champion_name">${chamInfo.champion_kr_name}</h3></td>
					</tr>
					<tr>
						<td><img alt=""
							src="/resources/img/passive/${chamInfo.champion_p_img}"
							class="ability-img">
							<div class="skill-key-icon">
								<h6>P</h6>
							</div>
							<div class="tooltip">
								<div>${chamInfo.champion_p_name}</div>
								<br>
								<div>${chamInfo.champion_p_desc}</div>
							</div></td>
						<td><img alt=""
							src="/resources/img/spell/${chamInfo.champion_q_img}"
							class="ability-img">
							<div class="skill-key-icon">
								<h6>Q</h6>
							</div>
							<div class="tooltip">
								<div>${chamInfo.champion_q_name}</div>
								<br>
								<div>${chamInfo.champion_q_desc}</div>
							</div></td>
						<td><img alt=""
							src="/resources/img/spell/${chamInfo.champion_w_img}"
							class="ability-img">
							<div class="skill-key-icon">
								<h6>W</h6>
							</div>
							<div class="tooltip">
								<div>${chamInfo.champion_w_name}</div>
								<br>
								<div>${chamInfo.champion_w_desc}</div>
							</div></td>
						<td><img alt=""
							src="/resources/img/spell/${chamInfo.champion_e_img}"
							class="ability-img">
							<div class="skill-key-icon">
								<h6>E</h6>
							</div>
							<div class="tooltip">
								<div>${chamInfo.champion_e_name}</div>
								<br>
								<div>${chamInfo.champion_e_desc}</div>
							</div></td>
						<td><img alt=""
							src="/resources/img/spell/${chamInfo.champion_r_img}"
							class="ability-img">
							<div class="skill-key-icon">
								<h6>R</h6>
							</div>
							<div class="tooltip">
								<div>${chamInfo.champion_r_name}</div>
								<br>
								<div>${chamInfo.champion_r_desc}</div>
							</div></td>
					</tr>
				</table>
			</div>
			<div class="champion-twpb-box">
				<table>
					<tr>
						<th class="champion-twpb">Ai-Tier</th>
						<th class="champion-twpb">Ai-Score</th>
						<th class="champion-twpb">승률</th>
						<th class="champion-twpb">픽률</th>
						<th class="champion-twpb">밴률</th>
					</tr>
					<tr>
						<td class="champion-tier" id="tier"></td>
						<td class="champion-tier" id="ai-score"></td>
						<td class="champion-tier" id="win-rate"></td>
						<td class="champion-tier" id="pick-rate"></td>
						<td class="champion-tier" id="ban-rate"></td>
					</tr>
				</table>
			</div>
			<div class="champion-easy-box">
				<caption>상대하기 쉬운 챔피언</caption>
				<table>
					<tr>
						<th class="easy-champ-img"></th>
						<th class="easy-champ-img"></th>
						<th class="easy-champ-img"></th>
						<th class="easy-champ-img"></th>
						<th class="easy-champ-img"></th>
					</tr>
					<tr>
						<td class="easy-champ-win-rate"></td>
						<td class="easy-champ-win-rate"></td>
						<td class="easy-champ-win-rate"></td>
						<td class="easy-champ-win-rate"></td>
						<td class="easy-champ-win-rate"></td>
					</tr>
				</table>
			</div>
			<div class="champion-hard-box">
				<caption>상대하기 힘든 챔피언</caption>
				<table>
					<tr>
						<th class="hard-champ-img"></th>
						<th class="hard-champ-img"></th>
						<th class="hard-champ-img"></th>
						<th class="hard-champ-img"></th>
						<th class="hard-champ-img"></th>
					</tr>
					<tr>
						<td class="hard-champ-win-rate"></td>
						<td class="hard-champ-win-rate"></td>
						<td class="hard-champ-win-rate"></td>
						<td class="hard-champ-win-rate"></td>
						<td class="hard-champ-win-rate"></td>
					</tr>
				</table>
			</div>
			<div class="spell-container">
				<div class="spell-title">
					<h4>추천 스펠</h4>
					<div class="spell-box"></div>
				</div>
			</div>
		</div>
		<div class="middle-container">
			<div class="rune-select-box"></div>
			<div class="rune-title">
				<h4>추천 룬</h4>
			</div>
			<div class="rune-container">
				<div class="rune-box main-runes">
					<div class="first-rune main-rune-top" style="margin: 0 auto"></div>
					<div class="runes main-rune-first"></div>
					<div class="runes main-rune-second"></div>
					<div class="runes main-rune-third"></div>
					<div class="runes main-rune-fourth"></div>
				</div>
				<div class="rune-box sub-runes">
					<div class="first-rune sub-rune-top" style="margin: 10px auto"></div>
					<div class="runes sub-rune-first"></div>
					<div class="runes sub-rune-second"></div>
					<div class="runes sub-rune-third"></div>
				</div>
				<div class="rune-box sub-ability">
					<div class="runes sub-ability-first">
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsAdaptiveForceIcon.png"
								alt="" id="first-fragment-5008" class="fragment-img">
							<div class="rune-desc">
								<div>OFFENSE</div>
								<br>
								<div>적응형 능력치 +9</div>
							</div>
						</div>
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsAttackSpeedIcon.png"
								alt="" id="first-fragment-5005" class="fragment-img">
							<div class="rune-desc">
								<div>OFFENSE</div>
								<br>
								<div>공격속도 10%</div>
							</div>
						</div>
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsCDRScalingIcon.png"
								alt="" id="first-fragment-5007" class="fragment-img">
							<div class="rune-desc">
								<div>OFFENSE</div>
								<br>
								<div>스킬 가속 +8</div>
							</div>
						</div>
					</div>
					<div class="runes sub-ability-second">
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsAdaptiveForceIcon.png"
								alt="" id="second-fragment-5008" class="fragment-img">
							<div class="rune-desc">
								<div>OFFENSE</div>
								<br>
								<div>적응형 능력치 +9</div>
							</div>
						</div>
						<div class="rune  fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsArmorIcon.png"
								alt="" id="second-fragment-5002" class="fragment-img">
							<div class="rune-desc">
								<div>FLEX</div>
								<br>
								<div>방어력 +6</div>
							</div>
						</div>
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsMagicResIcon.png"
								alt="" id="second-fragment-5003" class="fragment-img">
							<div class="rune-desc">
								<div>FLEX</div>
								<br>
								<div>마법저항력 +8</div>
							</div>
						</div>
					</div>
					<div class="runes sub-ability-third">
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsHealthScalingIcon.png"
								alt="" id="third-fragment-5001" class="fragment-img">
							<div class="rune-desc">
								<div>DEFFENSE</div>
								<br>
								<div>체력 +15 ~ 140</div>
							</div>
						</div>
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsArmorIcon.png"
								alt="" id="third-fragment-5002" class="fragment-img">
							<div class="rune-desc">
								<div>FLEX</div>
								<br>
								<div>방어력 +6</div>
							</div>
						</div>
						<div class="rune fragment">
							<img
								src="/resources/img/perk-images/StatMods/StatModsMagicResIcon.png"
								alt="" id="third-fragment-5003" class="fragment-img">
							<div class="rune-desc">
								<div>FLEX</div>
								<br>
								<div>마법저항력 +8</div>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="skill-build-container">
				<div class="skill-build-title">
					<h4>추천 스킬 빌드</h4>
				</div>
				<div class="skill-build-sequence-box"></div>
				<div class="skill-bulid-all-box"></div>
				<div class="skill-build-sequence-box"></div>
				<div class="skill-bulid-all-box"></div>
			</div>
		</div>
		<div class="right-container">
			<div class="start-item-shoes-container">
				<div class="start-item-box">
					<div class="start-item-title">
						<h4>시작 아이템 추천</h4>
						<div class="start-item-build-box"></div>

					</div>
				</div>
				<div class="shoes-box">
					<div class="shoes-title">
						<h4>신발 추천</h4>
						<div class="shoes-recom-box"></div>
					</div>
				</div>
			</div>


			<div class="item-build-container">
				<h4 class="item-build-title">아이템 빌드 추천</h4>
				<div class="item-build-stack"></div>
			</div>


		</div>
	</div>

	<div class="bottom-container">
		<!-- match_up_conatiner start -->
		<div class="match_up_container">
			<!-- match_up_chart start -->
			<div class="match_up_chart">
				<div id="match_up_left"></div>
				<!-- chartdiv start -->
				<div id="chartdiv">
					<div class="bar_block">
						<div class="bar_title lane_kill_rate">
							<div class="bar_title_left lane_kill_rate"></div>
							<div class="bar_title_content">라인킬 확률</div>
							<div class="bar_title_right enemy_lane_kill_rate"></div>
						</div>

						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 46%;"
								aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

					<div class="bar_block">
						<div class="bar_title kill_participation">
							<div class="bar_title_left kill_participation"></div>
							<div class="bar_title_content">킬 관여율</div>
							<div class="bar_title_right enemy_kill_participation"></div>
						</div>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 25%"
								aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

					<div class="bar_block">
						<div class="bar_title kda">
							<div class="bar_title_left kda"></div>
							<div class="bar_title_content">평점</div>
							<div class="bar_title_right enemy_kda"></div>
						</div>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 50%"
								aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

					<div class="bar_block">
						<div class="bar_title tower_kill_time">
							<div class="bar_title_left tower_kill_time"></div>
							<div class="bar_title_content">라인 첫 타워 파괴 시간</div>
							<div class="bar_title_right enemy_tower_kill_time"></div>
						</div>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 75%"
								aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

					<div class="bar_block">
						<div class="bar_title win_rate">
							<div class="bar_title_left win_rate"></div>
							<div class="bar_title_content">포지션 승률</div>
							<div class="bar_title_right enemy_win_rate"></div>
						</div>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 100%"
								aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

					<div class="bar_block">
						<div class="bar_title pick_rate">
							<div class="bar_title_left pick_rate"></div>
							<div class="bar_title_content">포지션 픽률</div>
							<div class="bar_title_right enemy_pick_rate"></div>
						</div>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 100%"
								aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

					<div class="bar_block">
						<div class="bar_title ban_rate">
							<div class="bar_title_left ban_rate"></div>
							<div class="bar_title_content">밴률</div>
							<div class="bar_title_right enemy_ban_rate"></div>
						</div>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 100%"
								aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
							<div class="progress-bar bg-danger" role="progressbar"
								style="width: 100%" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100"></div>
						</div>
					</div>

				</div>
				<!-- chartdiv end -->

				<div id="match_up_right"></div>
			</div>
			<div id="match_up_table_container">

				<div class="match_up_table_header">
					<!-- 				<div>#</div> -->
					<div>챔피언</div>
					<div>라인킬 확률</div>
				</div>

				<div class="match_up_table"></div>
			</div>
			<!-- match_up_conatiner end -->
		</div>

		<div class="mythic-common-item-container">
			<div class="mythic-item-container">
				<div class="mythic-item-title">
					<h4>신화 아이템 추천</h4>
					<div class="mythic-recomm-box"></div>
				</div>
			</div>
			<div class="common-item-container">
				<div class="common-item-title">
					<h4>일반 아이템 추천</h4>
					<div class="common-recomm-box"></div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function() {
	championLaneInfo(${chamInfo.champion_id});
	get_match_up(${chamInfo.champion_id});	

});

function championLaneInfo(champion_id) {
	  $.ajax({
	    method: 'get',
	    url: '/champion/info/lane',
	    data: { champion_id: champion_id },
	  }).done(res => {
	    let laneSelectBox = document.querySelector('.lane-select-box');
	    laneSelectBox.innerHTML = ''; // 기존 내용 초기화
	    console.log(res)

	    for (let i = 0; i < res.length; i++) {
	      let team_position = res[i].team_position;
	      let html = '';

	      if (team_position === 'TOP') {
	    	  html += '<div class="lane-img lane-top" onclick="selectLane(\'TOP\')">';
	    	  html += '<img src="/resources/img/ranked-positions/Position_Silver-Top.png" alt="로그인 이미지">';
	    	  html += '<div class="lane-desc">';
	    	  html += '<div>승률 : ' + res[i].win_rate + '%</div>';
	    	  html += '<div>픽률 : ' + res[i].pick_rate + '%</div>';
	    	  html += '</div>';
	    	  html += '</div>';
	    	} else if (team_position === 'JUNGLE') {
	    	  html += '<div class="lane-img lane-jungle" onclick="selectLane(\'JUNGLE\')">';
	    	  html += '<img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" alt="로그인 이미지">';
	    	  html += '<div class="lane-desc">';
	    	  html += '<div>승률 : ' + res[i].win_rate + '%</div>';
	    	  html += '<div>픽률 : ' + res[i].pick_rate + '%</div>';
	    	  html += '</div>';
	    	  html += '</div>';
	    	} else if (team_position === 'MIDDLE') {
	    	  html += '<div class="lane-img lane-middle" onclick="selectLane(\'MIDDLE\')">';
	    	  html += '<img src="/resources/img/ranked-positions/Position_Silver-Mid.png" alt="로그인 이미지">';
	    	  html += '<div class="lane-desc">';
	    	  html += '<div>승률 : ' + res[i].win_rate + '%</div>';
	    	  html += '<div>픽률 : ' + res[i].pick_rate + '%</div>';
	    	  html += '</div>';
	    	  html += '</div>';
	    	} else if (team_position === 'BOTTOM') {
	    	  html += '<div class="lane-img lane-bottom" onclick="selectLane(\'BOTTOM\')">';
	    	  html += '<img src="/resources/img/ranked-positions/Position_Silver-Bot.png" alt="로그인 이미지">';
	    	  html += '<div class="lane-desc">';
	    	  html += '<div>승률 : ' + res[i].win_rate + '%</div>';
	    	  html += '<div>픽률 : ' + res[i].pick_rate + '%</div>';
	    	  html += '</div>';
	    	  html += '</div>';
	    	} else if (team_position === 'UTILITY') {
	    	  html += '<div class="lane-img lane-support" onclick="selectLane(\'UTILITY\')">';
	    	  html += '<img src="/resources/img/ranked-positions/Position_Silver-Support.png" alt="로그인 이미지">';
	    	  html += '<div class="lane-desc">';
	    	  html += '<div>승률 : ' + res[i].win_rate + '%</div>';
	    	  html += '<div>픽률 : ' + res[i].pick_rate + '%</div>';
	    	  html += '</div>';
	    	  html += '</div>';
	    	}

	      laneSelectBox.innerHTML += html;
	    }
	    champion_position = res[0].team_position
	    championBuildInfo(res[0].champion_id, res[0].team_position);
	  }).fail(err => {
	    console.log(err);
	  });
	}

function selectLane(team_position) {
	championBuildInfo(${chamInfo.champion_id}, team_position);
	chart_lane(${chamInfo.champion_id}, team_position)
}

function championBuildInfo(champion_id, team_position) {
	$.ajax({
		  method: 'get',
		  url: '/champion/info/build',
		  data: { champion_id: champion_id, team_position: team_position},
		  async: false
		}).done(res => {
			let championBuildInfo = res;
			let champRuneData = championBuildInfo.champRuneData;
			let champItemData = championBuildInfo.champItemData;
			let champMythicItemData = championBuildInfo.champMythicItemData;
			let champItemBuildData = championBuildInfo.champItemBuildData;
			let champShoesData = championBuildInfo.champShoesData;
			let champSpellData = championBuildInfo.champSpellData;
			let champSkillBuildData = championBuildInfo.champSkillBuildData;
			let champAccessoriesData = championBuildInfo.champAccessoriesData;
			let champTierData = championBuildInfo.champTierData;
			let champEasyChampData = championBuildInfo.champEasyChampData;
			let champHardChampData = championBuildInfo.champHardChampData;
			let champStartItemData = championBuildInfo.champStartItemData;

			  console.log(champRuneData);
			  console.log(champItemData);
			  console.log(champMythicItemData);
			  console.log(champItemBuildData);
			  console.log(champShoesData);
			  console.log(champSpellData);
			  console.log(champSkillBuildData);
			  console.log(champAccessoriesData);
			  console.log(champEasyChampData);
			  console.log(champHardChampData);
			  console.log(champStartItemData);
			  //-----------------------------------------------------------------------------------
			  //챔피언 티어 승률 픽률 밴률 
			  if(champTierData[0].tier == 0){
				  document.getElementById('tier').textContent = 'OP';
			  }else{
				  document.getElementById('tier').textContent = champTierData[0].tier;  
			  }
			  document.getElementById('ai-score').textContent = champTierData[0].ai_score;
			  document.getElementById('win-rate').textContent = champTierData[0].win_rate+'%';
			  document.getElementById('pick-rate').textContent = champTierData[0].pick_rate+'%';
			  document.getElementById('ban-rate').textContent = champTierData[0].ban_rate+'%';
			  //-----------------------------------------------------------------------------------
			  // 상대하기 쉬운 챔피언 
			  let easyTableHeaders = document.getElementsByClassName('easy-champ-img');
			  for (let i = 0; i < easyTableHeaders.length; i++) {
				  easyTableHeaders[i].innerHTML = '';
				  easyTableHeaders[i].innerHTML = '<img alt="" src="/resources/img/champion_img/square/'+champEasyChampData[i].champion_img+'" class="champion-img" id="'+ champEasyChampData[i].enemy_champ_id +'">';
			  }
			  let hardEasyTableData = document.getElementsByClassName('easy-champ-win-rate');

			  for (let i = 0; i < hardEasyTableData.length; i++) {
				  hardEasyTableData[i].innerHTML = '';
				  hardEasyTableData[i].innerHTML = champEasyChampData[i].match_up_win_rate+'%';
			  }
			  //-----------------------------------------------------------------------------------
			  // 상대하기 어려운 챔피언 
			  let hardTableHeaders = document.getElementsByClassName('hard-champ-img');
			  for (let i = 0; i < hardTableHeaders.length; i++) {
				  hardTableHeaders[i].innerHTML = '';
				  hardTableHeaders[i].innerHTML = '<img alt="" src="/resources/img/champion_img/square/'+champHardChampData[i].champion_img+'" class="champion-img" id="'+ champHardChampData[i].enemy_champ_id +'">';
			  }
			  var hardTableData = document.getElementsByClassName('hard-champ-win-rate');

			  for (let i = 0; i < hardTableData.length; i++) {
				  hardTableData[i].innerHTML = '';
				  hardTableData[i].innerHTML = champHardChampData[i].match_up_win_rate+'%';
			  }
			  
			  let champ_img = document.querySelectorAll('.champion-img')
			  champ_img.forEach(champion=>{
				champion.addEventListener('click', function(){
					if(champion.id){
						location.href = `info?champion=\${champion.id}`
					}
				})
			  })
			  //-----------------------------------------------------------------------------------
			  rune_full_data(champRuneData[0].main_KEYSTONE_ID,champRuneData[0].sub_KEYSTONE_ID,0,champRuneData);
			  
			  let rune_select_box = document.getElementsByClassName('rune-select-box')[0]; 
			  rune_select_box.innerHTML = ''
			  for (let i = 0; i < champRuneData.length; i++) {
				html = ''
				html += '<div class="rune-select-button">'
				html += '<div class="rune-select-main">'
				html += '<img src="/resources/img/'+champRuneData[i].main_KEYSTONE_ID_img+'" alt="">'
				html += '</div>'
				html += '<div class="rune-select-mainStyle rune-combination">'
				html += '<img src="/resources/img/'+champRuneData[i].main_SUB1_ID_img+'" alt="">'
				html += '</div>'
				html += '<div class="rune-select-sub rune-combination">'
				html += '<img src="/resources/img/'+champRuneData[i].sub_KEYSTONE_ID_img+'" alt="">'
				html += '</div>'
				html += '<div class="rune-combination-desc">'
				html += '<div>승률 : '+champRuneData[i].win_rate+'%</div>'
				html += '<div>픽률 : '+champRuneData[i].pick_rate+'%</div>'
				html += '</div>'
				html += '</div>'
				rune_select_box.innerHTML += html
				}
			  
			  let rune_select_buttons = document.getElementsByClassName('rune-select-button');
			  for (let i = 0; i < rune_select_buttons.length; i++) {
				    rune_select_buttons[i].addEventListener('click', function() {
				        rune_full_data(champRuneData[i].main_KEYSTONE_ID, champRuneData[i].sub_KEYSTONE_ID, i, champRuneData);
				    });
				}

				
				spellSplit(champSpellData);
				skillSplit(champSkillBuildData);
				startItemSplit(champStartItemData);
				shoesSplit(champShoesData);
				itmeBuildSplit(champItemBuildData);
				mythicItemSplit(champMythicItemData);
				commonItemSplit(champItemData);
		}).fail(err => {
		  console.log(err);
		});	
}
//--------------------------------------------------------------------------------------------------------------------------------
// 일반 아이템 출력 
function commonItemSplit(champItemData) {
	let common_recomm_box = document.getElementsByClassName('common-recomm-box')[0];
	common_recomm_box.innerHTML = ''; // 기존 내용 초기화
	
	for (let i = 0; i < champItemData.length; i++) {
		let item_id = champItemData[i].item_id;

		$.ajax({
			method: 'get',
			url: '/champion/info/item',
			data: { item_id: item_id },
			async: false
		}).done(res => {
			for (let item of res) {
				let html = '<div class="shoes">';
				html += '<div class="item-img">'
				html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
				html += '<div class="item-desc">'
				html += '<div>' + item.item_kr_name + '</div>'
				html += '<br>'
				html += '<div>' + item.item_ability + '</div>'
				html += '<br>'
				html += '<div>' + item.item_desc + '</div>'
				html += '<br>'
				html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
				html += '</div>'
				html += '</div>'
				html += '<div class="rate-text"><h4>승률</h4></div>'
				html += '<div class="rate-text"><h6>' + champItemData[i].win_rate + '%</h6></div>'
				html += '<div class="rate-text"><h4>픽률</h4></div>'
				html += '<div class="rate-text"><h6>' + champItemData[i].pick_rate + '%</h6></div>'
				common_recomm_box.innerHTML += html;
			}


		}).fail(err => {
			console.log(err);
		});
	}
}
//--------------------------------------------------------------------------------------------------------------------------------
// 신화 아이템 출력 
function mythicItemSplit(champMythicItemData) {
	let mythic_recomm_box = document.getElementsByClassName('mythic-recomm-box')[0];
	mythic_recomm_box.innerHTML = ''; // 기존 내용 초기화
	
	for (let i = 0; i < champMythicItemData.length; i++) {
		let item_id = champMythicItemData[i].mythic_item;

		$.ajax({
			method: 'get',
			url: '/champion/info/item',
			data: { item_id: item_id },
			async: false
		}).done(res => {
			for (let item of res) {
				let html = '<div class="shoes">';
				html += '<div class="item-img">'
				html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
				html += '<div class="item-desc">'
				html += '<div>' + item.item_kr_name + '</div>'
				html += '<br>'
				html += '<div>' + item.item_ability + '</div>'
				html += '<br>'
				html += '<div>' + item.item_desc + '</div>'
				html += '<br>'
				html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
				html += '</div>'
				html += '</div>'
				html += '<div class="rate-text"><h4>승률</h4></div>'
				html += '<div class="rate-text"><h6>' + champMythicItemData[i].win_rate + '%</h6></div>'
				html += '<div class="rate-text"><h4>픽률</h4></div>'
				html += '<div class="rate-text"><h6>' + champMythicItemData[i].pick_rate + '%</h6></div>'
				mythic_recomm_box.innerHTML += html;
			}


		}).fail(err => {
			console.log(err);
		});
	}
}
//--------------------------------------------------------------------------------------------------------------------------------
// 아이템 빌드 출력 

function itmeBuildSplit(champItemBuildData) {
	let item_build_stack = document.getElementsByClassName('item-build-stack')[0];
	item_build_stack.innerHTML = ''; // 기존 내용 초기화
	for (let i = 0; i < champItemBuildData.length; i++) {
		
		let itemBuild = champItemBuildData[i].item_build;
		let parts = itemBuild.split(',');
		
		let html = '<div class="item-build-box">';
		html += '<div class="item-build">';
		let ajaxCounter = 0;

		for (let item_id of parts) {
			$.ajax({
				method: 'get',
				url: '/champion/info/item',
				data: { item_id: item_id },
				async: false
			}).done(res => {
				for (let item of res) {
					html += '<div class="item">'
					html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
					html += '<div class="item-desc">'
					html += '<div>' + item.item_kr_name + '</div>'
					html += '<br>'
					html += '<div>' + item.item_ability + '</div>'
					html += '<br>'
					html += '<div>' + item.item_desc + '</div>'
					html += '<br>'
					html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
					html += '</div>'
					html += '</div>'
				
				}
				ajaxCounter++;
				
				if (ajaxCounter != parts.length) {
					html += '<div class="arrow-img">'
					html += '<img alt="" src="/resources/img/icon/arrow-icon-right.png">'
					html += '</div>'
				}
			
				if (ajaxCounter === parts.length) {
					html += '</div>'
					html += '<div class="rate-text-box">'
					html += '<div class="rate-text"><h4>승률</h4></div>'
					html += '<div class="rate-text"><h6>' + champItemBuildData[i].win_rate + '%</h6></div>'
					html += '<div class="rate-text"><h4>픽률</h4></div>'
					html += '<div class="rate-text"><h6>' + champItemBuildData[i].pick_rate + '%</h6></div>'
					html += '</div>'
					item_build_stack.innerHTML += html;
				}
			}).fail(err => {
				console.log(err);
			});
		}
	}

}
//--------------------------------------------------------------------------------------------------------------------------------
// 신발 출력 
function shoesSplit(champShoesData) {
	let shoes_recom_box = document.getElementsByClassName('shoes-recom-box')[0];
	shoes_recom_box.innerHTML = ''; // 기존 내용 초기화
	
	for (let i = 0; i < champShoesData.length; i++) {
		let item_id = champShoesData[i].item_id;

		$.ajax({
			method: 'get',
			url: '/champion/info/item',
			data: { item_id: item_id },
			async: false
		}).done(res => {
			for (let item of res) {
				let html = '<div class="shoes">';
				html += '<div class="item-img">'
				html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
				html += '<div class="item-desc">'
				html += '<div>' + item.item_kr_name + '</div>'
				html += '<br>'
				html += '<div>' + item.item_ability + '</div>'
				html += '<br>'
				html += '<div>' + item.item_desc + '</div>'
				html += '<br>'
				html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
				html += '</div>'
				html += '</div>'
				html += '<div class="rate-text"><h4>승률</h4></div>'
				html += '<div class="rate-text"><h6>' + champShoesData[i].win_rate + '%</h6></div>'
				html += '<div class="rate-text"><h4>픽률</h4></div>'
				html += '<div class="rate-text"><h6>' + champShoesData[i].pick_rate + '%</h6></div>'
				shoes_recom_box.innerHTML += html;
			}


		}).fail(err => {
			console.log(err);
		});
	}
	
}
// --------------------------------------------------------------------------------------------------------------------------------
// 시작 아이템 출력 
function startItemSplit(champStartItemData) {
	let start_item_build_box = document.getElementsByClassName('start-item-build-box')[0];
	start_item_build_box.innerHTML = ''; // 기존 내용 초기화

	for (let i = 0; i < champStartItemData.length; i++) {
		let startItemBuild = champStartItemData[i].item_id;
		let parts = startItemBuild.split(',');

		let html = '<div class="start-item">';
		let ajaxCounter = 0;

		for (let item_id of parts) {
			$.ajax({
				method: 'get',
				url: '/champion/info/item',
				data: { item_id: item_id },
				async: false
			}).done(res => {
				for (let item of res) {
					html += '<div class="item-img">'
					html += '<img alt="" src="/resources/img/item/' + item.item_img + '">'
					html += '<div class="item-desc">'
					html += '<div>' + item.item_kr_name + '</div>'
					html += '<br>'
					html += '<div>' + item.item_ability + '</div>'
					html += '<br>'
					html += '<div>' + item.item_desc + '</div>'
					html += '<br>'
					html += '<div>가격: ' + item.item_pur_gold + '   판매가격: ' + item.item_sell_gold + '</div>'
					html += '</div>'
					html += '</div>'
				}

				ajaxCounter++;
				if (ajaxCounter === parts.length) {
					html += '</div>'
					html += '<div class="start-item-rate">'
					html += '<div class="rate-text"><h4>승률</h4></div>'
					html += '<div class="rate-text"><h6>' + champStartItemData[i].win_rate + '%</h6></div>'
					html += '<div class="rate-text"><h4>픽률</h4></div>'
					html += '<div class="rate-text"><h6>' + champStartItemData[i].pick_rate + '%</h6></div>'
					start_item_build_box.innerHTML += html;
				}
			}).fail(err => {
				console.log(err);
			});
		}
	}
}

//--------------------------------------------------------------------------------------------------------------------------------
// 스킬 빌드 출력 
function skillSplit(champSkillBuildData) {
	for (var i = 0; i < champSkillBuildData.length; i++) {
		
	
	let skillSequence = champSkillBuildData[i].mastery_sequence
	let parts = skillSequence.split(','); 
	
	let skillAllSequnece = champSkillBuildData[i].skill_build
	let skillParts = skillAllSequnece.split(','); 
	
	let skill_build_sequence_box = document.getElementsByClassName('skill-build-sequence-box')[i]; 
	let skill_bulid_all_box = document.getElementsByClassName('skill-bulid-all-box')[i];
	skill_build_sequence_box.innerHTML = '';
	skill_bulid_all_box.innerHTML = '';
	
	arrowHtml = ''
	arrowHtml += '<div class="arrow-img">'
	arrowHtml += '<img alt="" src="/resources/img/icon/arrow-icon-right.png">'
	arrowHtml += '</div>'
			
	qHtml = ''
	qHtml += '<div class="skill-build-sequence">'
	qHtml += '<img alt="" src="/resources/img/spell/${chamInfo.champion_q_img}" class="ability-img">'
	qHtml += '<div class="skill-key-icon">'
	qHtml += '<h6>Q</h6>'
	qHtml += '</div>'
	qHtml += '<div class="squence-tooltip">'
	qHtml += '<div>${chamInfo.champion_q_name}</div>'
	qHtml += '<br>'
	qHtml += "<div>${chamInfo.champion_q_desc}</div>"
	qHtml += '</div>'
	qHtml += '<div class="skill-build-sequence">'
	qHtml += '</div>'
	
 	wHtml = ''
 	wHtml += '<div class="skill-build-sequence">'
 	wHtml += '<img alt="" src="/resources/img/spell/${chamInfo.champion_w_img}" class="ability-img">'
 	wHtml += '<div class="skill-key-icon">'
 	wHtml += '<h6>W</h6>'
 	wHtml += '</div>'
 	wHtml += '<div class="squence-tooltip">'
 	wHtml += '<div>${chamInfo.champion_w_name}</div>'
 	wHtml += '<br>'
 	wHtml += "<div>${chamInfo.champion_w_desc}</div>"
 	wHtml += '</div>'
 	wHtml += '<div class="skill-build-sequence">'
 	wHtml += '</div>'

	eHtml = ''
	eHtml += '<div class="skill-build-sequence">'
	eHtml += '<img alt="" src="/resources/img/spell/${chamInfo.champion_e_img}" class="ability-img">'
	eHtml += '<div class="skill-key-icon">'
	eHtml += '<h6>E</h6>'
	eHtml += '</div>'
	eHtml += '<div class="squence-tooltip">'
	eHtml += '<div>${chamInfo.champion_e_name}</div>'
	eHtml += '<br>'
	eHtml += "<div>${chamInfo.champion_e_desc}</div>"
	eHtml += '</div>'
	eHtml += '<div class="skill-build-sequence">'
	eHtml += '</div>'													
	
	rateHtlm = ''
	rateHtlm += '<div class="skill-build-rate">'
	rateHtlm += '<div class="rate-text"><h4>승률</h4></div>'
	rateHtlm += '<div class="rate-text"><h6>'+champSkillBuildData[i].win_rate+'%</h6></div>'
	rateHtlm += '<div class="rate-text"><h4>픽률</h4></div>'
	rateHtlm += '<div class="rate-text"><h6>'+champSkillBuildData[i].pick_rate+'%</h6></div>'
	rateHtlm += '</div>'
	
	qBoxHtml = ''
	qBoxHtml += '<div class="q-skill">'
	qBoxHtml += '<h3>Q</h3>'
	qBoxHtml += '</div>'
	
	wBoxHtml = ''
	wBoxHtml += '<div class="w-skill">'
	wBoxHtml += '<h3>W</h3>'
	wBoxHtml += '</div>'
	
	eBoxHtml = ''
	eBoxHtml += '<div class="e-skill">'
	eBoxHtml += '<h3>E</h3>'
	eBoxHtml += '</div>'
	
	rBoxHtml = ''
	rBoxHtml += '<div class="r-skill">'
	rBoxHtml += '<h3>R</h3>'
	rBoxHtml += '</div>'
	
	let count = 0;
	for (let skill of parts) {
		if (parseInt(skill) == 1) {
			skill_build_sequence_box.innerHTML += qHtml;
		} else if (parseInt(skill) == 2) {
			skill_build_sequence_box.innerHTML += wHtml;
		} else if (parseInt(skill) == 3) {
			skill_build_sequence_box.innerHTML += eHtml;
		}
		count++;
		if (count == 3) {
			break;
		}
		skill_build_sequence_box.innerHTML += arrowHtml;
	}
	skill_build_sequence_box.innerHTML += rateHtlm;
	
	for (let skill of skillParts) {
		if(parseInt(skill) == 1){
			skill_bulid_all_box.innerHTML += qBoxHtml;
		}else if(parseInt(skill) == 2){
			skill_bulid_all_box.innerHTML += wBoxHtml;
		}else if(parseInt(skill) == 3){
			skill_bulid_all_box.innerHTML += eBoxHtml;
		}else if(parseInt(skill) == 4){
			skill_bulid_all_box.innerHTML += rBoxHtml;
		}
	}
	}
}
//--------------------------------------------------------------------------------------------------------------------------------
// 스펠 출력 
function spellSplit(champSpellData) {
	let spell_box = document.getElementsByClassName('spell-box')[0]; 
	spell_box.innerHTML = ''
	for (let i = 0; i < champSpellData.length; i++) {
		let spells = champSpellData[i].spells
		let win_rate = champSpellData[i].win_rate
		let pick_rate = champSpellData[i].pick_rate
		let parts = spells.split(','); 
		let first_spell = parseInt(parts[0]);
		let second_spell = parseInt(parts[1]);
		spellHtml(first_spell,second_spell,win_rate,pick_rate);
	}
}

function spellHtml(first_spell,second_spell,win_rate,pick_rate) {
	$.ajax({
	    method: 'get',
	    url: '/champion/info/spell',
	    data: { first_spell : first_spell, second_spell : second_spell },
	  }).done(res => {
		let spell_box = document.getElementsByClassName('spell-box')[0]; 
		html = ''
		html += '<div class="spells">'
		html += '<div class="spell">'
		html += '<img alt="" src="/resources/img/spell/'+res[0].spell_img+'">'
		html += '<div class="spell-desc">'
		html += '<div>'+res[0].spell_kr_name+'</div>'
		html += '<br>'
		html += '<div>'+res[0].spell_desc+'</div>'
		html += '<br>'
		html += '<div>쿹타임 '+res[0].spell_cooldown+'</div>'
		html += '</div>'
		html += '</div>'
		html += '<div class="spell" style="margin-right: 30px;">'
		html += '<img alt="" src="/resources/img/spell/'+res[1].spell_img+'">'
		html += '<div class="spell-desc">'
		html += '<div>'+res[1].spell_kr_name+'</div>'
		html += '<br>'
		html += '<div>'+res[1].spell_desc+'</div>'
		html += '<br>'
		html += '<div>쿹타임 '+res[1].spell_cooldown+'</div>'
		html += '</div>'
		html += '</div>'
		html += '<div class="spell-text"><h6>승률</h6></div>'
		html += '<div><h4>'+win_rate+'%</h4></div>'
		html += '<div class="spell-text"><h6>픽률</h6></div>'
		html += '<div><h4>'+pick_rate+'%</h4></div>'
		html += '</div>'
		spell_box.innerHTML += html
	  }).fail(err => {
	    console.log(err);
	  });
}
//--------------------------------------------------------------------------------------------------------------------------------
// 룬 빌드 출력 
function rune_full_data(main,sub,i,champRuneData) {
	let main_key = '';
	switch (main) {
	  case '8200':
		  main_key = 'Sorcery';
	    break;
	  case '8400':
		  main_key = 'Resolve';
	    break;
	  case '8000':
		  main_key = 'Precision';
	    break;
	  case '8300':
		  main_key = 'Inspiration';
	    break;
	  case '8100':
		  main_key = 'Domination';
	    break;
	  default:
	    break;
	} 
	let sub_key = '';
	switch (sub) {
	  case '8200':
		  sub_key = 'Sorcery';
	    break;
	  case '8400':
		  sub_key = 'Resolve';
	    break;
	  case '8000':
		  sub_key = 'Precision';
	    break;
	  case '8300':
		  sub_key = 'Inspiration';
	    break;
	  case '8100':
		  sub_key = 'Domination';
	    break;
	  default:
	    break;
	}
	
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
	
	 $.ajax({
		  method: 'get',
		  url: '/champion/info/rune/sub',
		  data: { sub_key : sub_key },
		  async: false
		}).done(res => {
			console.log(res)
			let sub_rune_top = document.getElementsByClassName('sub-rune-top')[0];
			let sub_rune_first = document.getElementsByClassName('sub-rune-first')[0];
			let sub_rune_second = document.getElementsByClassName('sub-rune-second')[0];
			let sub_rune_third = document.getElementsByClassName('sub-rune-third')[0];
			sub_rune_top.innerHTML = ''
			sub_rune_first.innerHTML = ''
			sub_rune_second.innerHTML = ''
			sub_rune_third.innerHTML = ''
			for (let i = 0; i < res.length; i++) {
				rune_num = res[i].rune_num % res[0].rune_num
				if(rune_num == 0){
					sub_rune_top.innerHTML += '<img src="/resources/img/'+res[i].rune_img+'" alt="">'
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
					sub_rune_first.innerHTML += html
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
					sub_rune_second.innerHTML += html
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
					sub_rune_third.innerHTML += html
				}
			}
			setTimeout(() => {
			    main_SUB1_ID = champRuneData[i].main_SUB1_ID;
			    main_SUB2_ID = champRuneData[i].main_SUB2_ID;
			    main_SUB3_ID = champRuneData[i].main_SUB3_ID;
			    main_SUB4_ID = champRuneData[i].main_SUB4_ID;
			    sub_SUB1_ID = champRuneData[i].sub_SUB1_ID;
			    sub_SUB2_ID = champRuneData[i].sub_SUB2_ID;
				 fragment1_ID = champRuneData[i].fragment1_ID;
				 fragment2_ID = champRuneData[i].fragment2_ID;
				 fragment3_ID = champRuneData[i].fragment3_ID;

			    document.getElementById(main_SUB1_ID).style.filter = 'none';
			    document.getElementById(main_SUB2_ID).style.filter = 'none';
			    document.getElementById(main_SUB3_ID).style.filter = 'none';
			    document.getElementById(main_SUB4_ID).style.filter = 'none';
			    document.getElementById(sub_SUB1_ID).style.filter = 'none';
			    document.getElementById(sub_SUB2_ID).style.filter = 'none';
			    document.getElementById(main_SUB1_ID).style.opacity = '1';
			    document.getElementById(main_SUB2_ID).style.opacity = '1';
			    document.getElementById(main_SUB3_ID).style.opacity = '1';
			    document.getElementById(main_SUB4_ID).style.opacity = '1';
			    document.getElementById(sub_SUB1_ID).style.opacity = '1';
			    document.getElementById(sub_SUB2_ID).style.opacity = '1';
			    let elements = document.getElementsByClassName('fragment-img');

				 for (let i = 0; i < elements.length; i++) {
				     elements[i].style.filter = "grayscale(100%)";
				     elements[i].style.filter = "0.5";
				 }
				 document.getElementById('first-fragment-'+fragment3_ID).style.filter = 'none'; 
				 document.getElementById('second-fragment-'+fragment2_ID).style.filter = 'none'; 
				 document.getElementById('third-fragment-'+fragment1_ID).style.filter = 'none'; 
				 document.getElementById('first-fragment-'+fragment3_ID).style.opacity = "1";
				 document.getElementById('second-fragment-'+fragment2_ID).style.opacity = "1"; 
				 document.getElementById('third-fragment-'+fragment1_ID).style.opacity = "1"; 
			    
			  }, 100);  // 0.1초 후에 코드 실행
		}).fail(err => {
		  console.log(err);
		}); 
}
//-------------------------------------------------------------------------------------------------------------------------------- 
// right_container
let response;
let left;
let right;
let cid;

	// get_match_up
	function get_match_up(champion_id){
		$.ajax({
			url: '/champion/match-up.json',
			type: 'POST',
			data: {champion_id: champion_id}
		}).done(res=>{
			response = res;
			cid = champion_id;
			console.log(res)
			left = res['champion']
			right = res['enemy']
			make_chart(left[0], right[0])
			make_table(left, right)
		}).fail(err=>{
			console.log(err)
		})
	}
	// get_match_up 끝
	
function make_chart(left, right){
	let titles = document.querySelectorAll('.bar_title')
	let keys = Object.keys(left)
	
	titles.forEach(title=>{
		keys.forEach(key=>{
			let class_name = title.className.split('bar_title')[1].trim();
			if(key == class_name){
				if(key == 'tower_kill_time'){
					let left_time = new Date(left[key] * 1000);
					let left_minutes = left_time.getMinutes();
					let left_seconds = left_time.getSeconds();
					let left_time_string = `\${left_minutes}'\${left_seconds}"`
					console.log(left_time_string)
					title.querySelector('.bar_title_left').textContent = left_time_string;

					let right_time = new Date(right[key] * 1000);
					let right_minutes = right_time.getMinutes();
					let right_seconds = right_time.getSeconds();
					let right_time_string = `\${right_minutes}'\${right_seconds}"`
					title.querySelector('.bar_title_right').textContent = right_time_string;
					
				}else{
					title.querySelector('.bar_title_left').textContent = left[key];
					title.querySelector('.bar_title_right').textContent = right[key];

				}

				let key_sum = left[key] + right[key];
				let high_key_percent = (Math.max(left[key], right[key]) / key_sum) * 100;
				let low_key_percent = (Math.min(left[key], right[key]) / key_sum) * 100;
				let bar_block = title.nextElementSibling;
				
				if (left[key] > right[key]) {
				  bar_block.querySelector('.progress-bar').style.width = high_key_percent + '%';
				  bar_block.querySelector('.bg-danger').style.width = low_key_percent + '%';
				} else {
				  bar_block.querySelector('.progress-bar').style.width = low_key_percent + '%';
				  bar_block.querySelector('.bg-danger').style.width = high_key_percent + '%';
				}

			}
		})
	})
	
	let left_html_list = '<img src="/resources/img/champion_img/square/'+ left.champion_img +'" alt="'+ left.champion_name +'" class="champion_img" id="'+ left.champion_id +'"">'
	left_html_list += '<div>' + left.champion_name + '</div>'
	left_html_list += '<div>' + left.match_up_win_rate + '%</div>'

	let right_html_list = '<img src="/resources/img/champion_img/square/'+ right.champion_img +'" alt="'+ right.champion_name +'" class="champion_img2" id="'+ right.champion_id +'">'
	right_html_list += '<div>' + right.champion_name + '</div>'
	right_html_list += '<div>' + right.match_up_win_rate + '%</div>'

	document.getElementById('match_up_left').innerHTML = left_html_list
	document.getElementById('match_up_right').innerHTML = right_html_list

	let right_champ = document.querySelector('.champion_img2')
	
	right_champ.addEventListener('click', function(){
		location.href = `info?champion=\${this.id}`
	})
	
	right_champ.style.cursor = 'pointer';
}
	
function make_table(left, enemys){
	console.log(enemys)
	let table_index = 1;
	let match_up_table_html = '';
	enemys.forEach(enemy=>{
		let lane_kill_rate
		left.forEach(lef=>{
			if(lef['enemy_champ_id'] == enemy.champion_id){
				lane_kill_rate = lef['lane_kill_rate']
			}
		})
		match_up_table_html += '<div class="champion">';
		match_up_table_html += '<div>'+ table_index +'</div>';
		match_up_table_html += '<div class="champion_name_container">'
		match_up_table_html += '<img alt="' + enemy.champion_name +
				'" class="bg-image table-img" src="/resources/img/champion_img/square/' +
				enemy.champion_img + '">';
		match_up_table_html += '<div class="table-champion-name">'+ enemy.champion_name +'</div>'
		match_up_table_html += '</div>'
		match_up_table_html += '<div>'+ lane_kill_rate + '%</div>'
		match_up_table_html += '</div>';
		table_index ++;
	})
	document.querySelector('.match_up_table').innerHTML = match_up_table_html
	document.querySelectorAll('.champion').forEach(cmp=>{
		cmp.addEventListener('click', function(){
			let array_index = cmp.firstChild.textContent - 1
			console.log(array_index)
			make_chart(left[array_index], right[array_index])
		})
	})
}

let chart_lane_response;
function chart_lane(champion_id, team_position){
	$.ajax({
		url: '/champion/chart-lane.json',
		type: 'POST',
		data: {champion_id: champion_id, team_position: team_position}
	}).done(res=>{
		console.log('chart', res)
		chart_lane_response = res;
		left = res['champion']
		right = res['enemy']
		make_chart(left[0], right[0])
		make_table(left, right)
	}).fail(err=>{
		console.log(err)
	})
	
}
// right_container

</script>

</html>