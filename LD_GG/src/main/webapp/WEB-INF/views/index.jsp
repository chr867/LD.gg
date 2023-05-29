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
</head>
<style>
.main-container {
	display: flex;
	text-align: center;
	margin-top: 80px;
}

#left_container {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	box-sizing: border-box;
	margin-left: 200px;
	margin-top: 20px;
	width: 40%;
	height: 58vh;
}

#right_container {
	display: flex;
	flex-direction: column;
	box-sizing: border-box;
	margin-top: 20px;
	width: 40%;
	height: 58vh;
}

#bottom_container {
	display: flex;
	box-sizing: border-box;
	margin-left: 540px;
	width: 100%;
}


#champ_search_box input {
	width: 220px;
	border-radius: 5px;
}

#my_champion_img {
	width: 370px;
	height: 400px;
	padding-top: 20px;
	padding-bottom: 15px;
	border-radius: 70%;
}

#build_recom_box button {
	margin-top: 20px;
}

.select_lane{
	background-color: #E4E6EF;
	display: flex;
	justify-content: space-between;
	position: relative;
	left: 10%;
	width: 80%;
}

.select_lane img{
	width: 100px;
	height: 100px;
}
.select_tag{
	background-color: #E4E6EF;
	display: flex;
	width: 100%;
	height: 100px;
	margin-top: 15px;
	justify-content: space-between;
}

.select_tag div{
	width: 100px;
	height: 100px;
	line-height: 100px;
	text-align: center;
}

#right_champion_img {
	position: relative;
	left: 0%;
	width: 140px;
	height: 140px;
	border-radius: 70%;
}

#right_champion_search div{
	position: relative;
	left: 10%;
}

#right_champ_search_box {
	display: flex;
	width: 342px;
	margin-top: 20px;
}

.search_box{
	display: flex;
	position: relative;
	left: -10%;
	top: 40%;
	width: 300px;
}

.search_box div{
	margin-left: 20px;
	line-height: 140px;
}

#right_champ_search{
	position: relative;
	margin-bottom: 10px;
	background-color: #E4E6EF;
}


#recom_img_container {
	text-align: center;
	display: flex;
	position: relative;
	left: 10%;
}

#recom_champ img {
	width: 140px;
	height: 140px;
	margin-right: 20px;
	border-radius: 70%;
}

#recom_champ{
	display: flex;
}

#recom_champ_header{
	display: flex;
	flex-direction: column-reverse;
	position: relative;
	left: 2%;
	margin-top: 7%;
}

#recom_champ_header div:last-child{
	position: relative;
	top: -110%;
}

.recom_img{
	display: flex;
	flex-direction: column;
}


</style>

<style>
	.champion-container {
	position: relative;
	left: 35%;
	top: -21%;
	width: 65%;
	height: 250px;
	background-color: #fff;
	box-sizing: border-box;
}

.search-container {
	text-align: center;
	justify-content: space-between;
}

.lane-select-box {
	display: flex;
	height: 50px;
	justify-content: space-between;
	width: 90%;
	margin: auto;
	margin-top: 10px;
	background-color: #E4E6EF;
	box-sizing: border-box;
	padding: 0 50px 0 50px;
	margin-bottom: 20px;
	align-items: center;
}

.lane-img img {
	width: 40px;
	height: 40px;
}

.lane-img {
	border-radius: 0.5rem;
	transition: 0.5s;
}

.lane-img:hover, .lane-img:active {
	background-color: #fff;
}

.champion-img-container {
	width: 100%;
	background-color: #E4E6EF;
	height: 100%;
	margin: auto;
	box-sizing: border-box;
	overflow-y: auto;
}

.champions {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	text-align: center;
	box-sizing: border-box;
	flex-wrap: wrap;
	padding: 5px;
}

.champions img {
	width: 60px;
	height: 60px;
	border-radius: 1rem;
	border: 5px solid #fff;
	transition: 0.5s;
}

.champions img:hover {
	transform: scale(1.3);
	z-index: 1;
}

.champion {
	display: flex;
	align-items: center;
	flex-direction: column;
	margin: 5px;
	flex-grow: 1;
}

::-webkit-scrollbar {
	width: 5px;
	/* 스크롤바의 너비 */
}

::-webkit-scrollbar-track {
	background-color: #f1f1f1;
	/* 스크롤바의 트랙(배경) 색상 */
}

::-webkit-scrollbar-thumb {
	background-color: #888;
	/* 스크롤바의 썸(막대) 색상 */
}
</style>
<body>
	<%@ include file="./header.jsp"%>
	<%@ include file="./sidebar.jsp"%>
	<%@ include file="./footer.jsp"%>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<br> <br> <br> <br> <br> <br> <br>
		<br>

		<div id="left_container">
			<div id="my_champion">
				<div id="champ_search_box">
					<form id=champ_search>
						<input id='champion_name_input' type="text"
							name="champion_name" placeholder="내 챔피언 검색">
					</form>
					<img id="my_champion_img" alt="#"
						src="/resources/img/profileicon/29.png">
				</div>
				<div id="build_recom_box">
					<span></span>
					<button onclick="recom_build()">추천 빌드</button>
				</div>
			</div>
		</div>

		<div id="right_container">
			<div id="counter_champion">
				<div class="select_lane lane_button">
					<img src="/resources/img/ranked-positions/Position_Silver-Top.png" onclick="selectLane('TOP')" class="TOP" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" onclick="selectLane('JUNGLE')" class="JUNGLE" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Mid.png" onclick="selectLane('MIDDLE')" class="MIDDLE" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Bot.png" onclick="selectLane('BOTTOM')" class="BOTTOM" alt="">
					<img src="/resources/img/ranked-positions/Position_Silver-Support.png" onclick="selectLane('UTILITY')" class="UTILITY" alt="">
				</div>

				<div class="select_tag">
					<div class="all">전체</div>
					<div class="Assassin">암살자</div>
					<div class="Fighter">전사</div>
					<div class="Mage">마법사</div>
					<div class="Marksman">원거리 딜러</div>
					<div class="Controller">서포터</div>
					<div class="Tank">탱커</div>
				</div>

				<div id="right_champ_search_box">
					<div>
						<div class="search_box">
							<img id="right_champion_img" alt="#"
								src="/resources/img/profileicon/29.png" onclick="right_champion_img_click(this)"> <div></div>
						</div>
					</div>
				</div>
				
				<div class="champion-container">
					<form id=right_champ_search>
						<input id='right_champ_name_input' type="text"
							name="champion_name" placeholder="상대 챔피언 검색">
					</form>
					
					<div class="champion-img-container">
						<div class="champions"></div>
					</div>
				</div>
				
			</div>
		</div>
	</div>


	<div id="bottom_container">
		<div id="recom_champ_header">
			<div>승률</div>
			<div>라인킬 확률</div>
			<div>추천 챔피언</div>
		</div>
		
		<div id="recom_champ">
			<div id="recom_img_container">
				<div class="recom_img">
					<img src="/resources/img/profileicon/29.png" class="champ1" alt=""
					id="recom_champ_0" onclick="recom_click(this)">
					<div></div>
					<div></div>
					<div></div>
				</div>

				<div class="recom_img">
					<img
					src="/resources/img/profileicon/29.png" class="champ2" alt=""
					id="recom_champ_1" onclick="recom_click(this)">
					<div></div>
					<div></div>
					<div></div>
				</div>

				<div class="recom_img">
					<img
					src="/resources/img/profileicon/29.png" class="champ3" alt=""
					id="recom_champ_2" onclick="recom_click(this)">
					<div></div>
					<div></div>
					<div></div>
				</div>

				<div class="recom_img">
					<img
					src="/resources/img/profileicon/29.png" class="champ4" alt=""
					id="recom_champ_3" onclick="recom_click(this)"> 
					<div></div>
					<div></div>
					<div></div>
				</div>

				<div class="recom_img">
					<img
					src="/resources/img/profileicon/29.png" class="champ5" alt=""
					id="recom_champ_4" onclick="recom_click(this)">
					<div></div>
					<div></div>
					<div></div>
				</div>

			</div>
			
			</div>
		</div>
	</div>
	<!-- 추천 빌드 모달 -->

	<script type="text/javascript">
	let selected_lane;
	let selected_tag;
	let selected_left_champion;
	let selected_right_champion;


	function go_mypage(){
		location.href="/member/mypage"
	}

	// 라인 선택 start
	let select_lane_imgs = document.querySelectorAll('.select_lane img')
	select_lane_imgs.forEach(lane=>{
		lane.addEventListener('click', function(){
			$('.select_lane img').css('background-color', '#E4E6EF');
			lane.style.backgroundColor = "black";
			selected_lane = lane.className;
			console.log(selected_lane);
			if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
			}
		})
	})
	// 라인 선택 end

	// 역할군 선택 start
	let select_tag_divs = document.querySelectorAll('.select_tag div')
	select_tag_divs.forEach(tag=>{
		tag.addEventListener('click', function(){
			$('.select_tag div').css('background-color', '#E4E6EF');
			tag.style.backgroundColor = "black";
			selected_tag = tag.className;
			console.log(selected_lane, selected_tag, selected_right_champion);
			if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
			}
		})
	})
	// 역할군 선택 end

	// 추천 챔피언 선택 start
	function recom_click(champ){
		$('#my_champion_img').attr('src', champ.src);
		$('#build_recom_left_val').attr('value', $(champ).attr('class'));
		$.ajax({
			url: "/champion/search-eng.json",
			type: 'POST',
			data: {champion_en_name: $(champ).attr('class')},
		}).done(res=>{
			selected_left_champion = res // champion_kr_name
			$('#build_recom_box span').text(res);
		}).fail(err=>{
			$('#build_recom_box span').text('챔피언을 선택해 주세요');
		})
	}
	// 추천 챔피언 선택 end

	// 챔피언 추천 start
	function recom_champ(lane, tag, right_champion){
		console.log('recom', lane, tag, right_champion)
		$.ajax({
			url: "/champion/champ-recom.json",
			type: 'POST',
			data: {lane: lane, tag: tag, right_champion: right_champion}
		}).done(res=>{
			let recom_divs = document.querySelectorAll('.recom_img div')
			let slice_index = 0;
			res.forEach(champ=>{
				let idx = res.indexOf(champ)
				let champ_name = champ.cm.champion_name
				let path = `/resources/img/champion_img/tiles/\${champ_name}_0.jpg`
				$(`#recom_champ_\${idx}`).attr('src', path);
				$(`#recom_champ_\${idx}`).attr('class', champ_name);
				let sliced = Array.from(recom_divs).slice(slice_index, slice_index+3);
				sliced[0].textContent = champ.name
				sliced[1].textContent = champ.cm.lane_kill_rate
				sliced[2].textContent = champ.cm.match_up_win_rate
				slice_index +=3;
			})
		}).fail(err=>{
			console.log(err)
		})
	}
	// 챔피언 추천 end

// 빌드 추천 start
	function recom_build(){
		if(selected_lane && selected_left_champion && selected_right_champion){
			$.ajax({
			url: "/champion/build-recom.json",
			type: 'POST',
			data: {
				left_champion: selected_left_champion,
				right_champion: selected_right_champion,
				team_position: selected_lane
			},
			}).done(res=>{
			console.log(res);
						
			}).fail(err=>{
			console.log(err)
			})
		}
	}
// 빌드 추천 end

// left 챔피언 검색 start
	$('#champ_search').submit(function(event){		
		event.preventDefault();
		let formData = $(this).serialize();		
		
		$('#build_recom_box span').text($('#champion_name_input').val());
		$('#champion_name_input').val('');
		
		$.ajax({
			url: "/champion/search.json",
			type: 'POST',
			data: formData,
		}).done(res=>{
			if(res){
				selected_left_champion = res.champion_en_name  // champion_en_name
				console.log(selected_left_champion)
				$('#my_champion_img').attr('src', `/resources/img/champion_img/tiles/\${res.champion_en_name}_0.jpg`);
				$('#build_recom_left_val').attr('value', res);
			}else{
				selected_left_champion = null;
				$('#my_champion_img').attr('src', '/resources/img/profileicon/29.png');
				$('#build_recom_box span').text('챔피언 이름을 확인해주세요');
			}
			
		}).fail(err=>{
			console.log(err)
		})
		
	})
// left 챔피언 검색 end

// right 챔피언 검색 start
	$('#right_champ_search').submit(function(evt){
		event.preventDefault();
		let formData = $(this).serialize();		
		let right_champ_name = $('#right_champ_name_input').val()
		$('.search_box div').text(right_champ_name);
		$('#right_champ_name_input').val('');
		
		$.ajax({
			url: "/champion/search.json",
			type: 'POST',
			data: formData,
		}).done(res=>{
			if(res){
				selected_right_champion = res.champion_en_name  // champion_en_name
				console.log(selected_right_champion)
				$('#right_champion_img').attr('src', `/resources/img/champion_img/square/\${res.champion_img}`);
				document.getElementById('right_champion_img').className = res.champion_id

				if(selected_lane && selected_tag && selected_right_champion){
					recom_champ(selected_lane, selected_tag, selected_right_champion)
				}
			}else{
				selected_right_champion = null;
				$('#right_champion_img').attr('src', '/resources/img/profileicon/29.png')
				$('.search_box div').text('챔피언 이름을 확인해주세요');
			}
			
		}).fail(err=>{
			console.log(err)
		})
		
	})
// right 챔피언 검색 end

function right_champion_img_click(right_img){
	if(right_img.className){
		location.href = `/champion/info?champion=\${right_img.className}`		
	}
}

// champion-container
	// 챔피언 리스트
function championList() {
	$.ajax({
		method: 'get',
		url: '/champion/list.json'
	}).done(res => {
		let championHTML = '';
		res.forEach(function (champion) {
			championHTML += '<div class="champion">';
			championHTML += '<img alt="' + champion.champion_kr_name +
				'" class="bg-image champion-img" src="/resources/img/champion_img/square/' +
				champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_en_name + '\', \'' + champion.champion_img + '\', \'' +
			    champion.champion_kr_name + '\')">';
			championHTML += '</div>';
		});

		$('.champions').html(championHTML);
	}).fail(err => {
		console.log(err);
	});
}
championList();
// 챔피언 리스트 끝

// 라인 선택
function selectLane(team_position) {
	$('.champions').empty();
	$.ajax({
		method: 'get',
		url: '/tip/champion/lane',
		data: {
			team_position: team_position
		},
	}).done(res => {
		let championHTML = '';
		res.forEach(function (champion) {
			championHTML += '<div class="champion">';
			championHTML += '<img alt="' + champion.champion_kr_name +
				'" class="bg-image champion-img" src="/resources/img/champion_img/square/' +
				champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_en_name + '\', \'' + champion.champion_img + '\', \'' +
			    champion.champion_kr_name + '\', \'' + champion.champion_id + '\')">';
			championHTML += '</div>';
		});

		if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
			}

		$('.champions').html(championHTML);
	}).fail(err => {
		console.log(err);
	})
}

function selectChampion(champion_en_name, champion_img, champion_kr_name, champion_id){
	selected_right_champion = champion_en_name
	$('#right_champion_img').attr('src', `/resources/img/champion_img/square/\${champion_img}`);
	document.getElementById('right_champion_img').className = champion_id
	$('.search_box div').text(champion_kr_name);

	if(selected_lane && selected_tag && selected_right_champion){
				recom_champ(selected_lane, selected_tag, selected_right_champion)
	}

}
// 라인 선택 끝
</script>

</body>

</html>