<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>맞춤 멘토</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#content{
width: 900px;
border-radius: 10px;
box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
padding-top: 90px;
margin-top:40px;
}
section{
padding: 0 40px;
border: solid 1px;
}
#qustions{
padding: 0 90px;
}
#summoner-wrap{
background-color:#f2f2f2;
padding: 24px;
margin:24px;
}
.champ-list {
	height: 336px;
	border-radius: 12px;
	overflow-y: scroll;
	box-sizing: border-box;
	border: 1px solid #d5d5de;
}
.progress{
width: 500px;
}
.inner-contents{
min-height: 400px;
}
#tag-box{
padding-top: 70px;
padding-left: 40px;
padding-right: 40px;
}
#form-box{
padding-top: 40px;
padding-left: 40px;
padding-right: 40px;
}
#btn-check{
margin: 5px;
padding: 8px 30px;
}
#btn-box{
padding: 16px 8px;
margin: 24px 0;
}
#btn-box button{
min-width: 80px;
border-radius: 10px;
}
#position-buttons{
margin: 32px 0;
}
#position-buttons button{
width:130px;
}
#champ-info{
padding: 8px;
}
#tier-holder{
padding:16px;
margin:8px 16px;
border-radius: 20px;
}
#tier-holder img{
margin-bottom: 8px;
}
#goal-tier-selector{
margin-top:8px;
}
.gradient {
height: 120px;
background: linear-gradient(to top, #cccccc, #ffffff);
}
.tier-label{
font-size: 12px;
width: 85px;
margin-top:5px;
color: #777;
background-color:#eaeaea;
}

	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>

<body>
<div class="container d-flex align-item-center justify-content-center">
	<div id="content">
	 <div id="question">
	 	<section id="first">
			<div id="custom-header" class="text-center">
				<div>
					<div>
						<h4>나에게 딱 맞는 멘토님을 찾기위해</h4>
						<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg"><strong>목표를 설정해 볼까요?</strong></h4>
					</div>
					<div class="d-flex justify-content-center">
						<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="17" aria-valuemin="0" aria-valuemax="100">
						  <div class="progress-bar" style="width: 17%">17%</div>
						</div>
						<span>1/6</span>
					</div>
					<h4 class="profile-text2">입니다.</h4>
				</div>
		
				<div id="summoner-wrap" class="d-flex align-item-center justify-content-center">
					<!---->
					<div class="my-auto">
						<h4>
							<strong>${member.lol_account}</strong>
						</h4>
						<span>&nbsp 회원님의 현재 티어는</span>
					</div>
					<div class="d-flex align-item-center justify-content-center" summonername="${member.lol_account}">
						<div class="my-auto">
							<img style="width: 72px" src="https://online.gamecoach.pro/img/lol/emblem-UNRANKED.svg">
						</div>
						<div class="my-auto">
							<div>
								<h4>
									<strong>UNRANKED</strong>
								</h4>
								<div>
									<span>승률 0%</span>
									<span>(0승 0패)</span>
								</div>
							</div>
						</div>
						<div class="my-auto">
							<span>0LP</span>
						</div>
					</div>
					<span class="my-auto">입니다.</span>
				</div>
			</div>
			
			<div id="form-box">
				<div id="pos-box">
					<h5><strong>배우고 싶은 포지션</strong></h5>
					<div id="position-buttons" class="d-flex align-item-center justify-content-evenly">
						<button type="button" id="top-button" class="btn border">
							<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg" class="position-img">
							<span>탑</span>
						</button>
						<button type="button" id="jungle-button" class="btn border"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg" 
								class="position-img">
							<span>정글</span>
						</button>
						<button type="button" id="mid-button" class="btn border"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg"
								class="position-img">
							<span>미드</span>
						</button>
						<button type="button" id="bot-button" class="btn border"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg" 
								class="position-img">
							<span>바텀</span>
						</button>
						<button type="button" id="support-button" class="btn border"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg"
								class="position-img">
							<span>바텀</span>
						</button>
					</div>
				</div>
		
				<h5><strong>배우고 싶은 챔피언</strong></h5>
				<input type="text" id="champion_to_learn" value="">
		
				<div class="champ-selector-inner">
					<div id="champ-info">
						<span>
							<img src="" class="champ-img">
							<p class="champ-name">배우고 싶은 챔피언을 선택 해주세요</p>
						</span>
					</div>
					<img class="arrow-icon" src="https://online.gamecoach.pro/img/icon/icon-arrow-down-grey.svg">
				</div>
				<div class="filter-champ-wrap" style="display: none">
					<div class="filter-title-wrap">
						<div>
							<h4 class="filter-text">챔피언</h4>
						</div>
					</div>
					<div>
						<span class="input-champ-keyword white">
							<input placeholder="챔피언을 검색하세요" tabindex="0" type="text" class="champ-search">
						</span>
						<div class="champ-list">
						<!-- 챔피언 리스트 -->
						</div>
					</div>
				</div>
		
				<div id="goal-tier" class="d-flex">
					<h3 class="my-auto"><strong>목표 티어는</strong></h3>
					<div id="tier-holder" class="text-center shadow">
						<img style="width:72px" src="https://online.gamecoach.pro/img/lol/emblem-UNRANKED.svg">
						<div><strong>UNRANKED</strong></div>
					</div>
					<h3 class="my-auto"><strong>이상입니다.</strong></h3>
				</div>
			</div><!-- form-box -->
			
			<div id="goal-tier-selector" class="d-none d-flex align-item-center justify-content-evenly text-center">
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
							<img src="https://online.gamecoach.pro/img/lol/emblem-BRONZE.svg"
							style="margin-top: 35px">
						</div>
					</div>
					<div class="tier-label">
						<p id="BRONZE">브론즈</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
							<img src="https://online.gamecoach.pro/img/lol/emblem-SILVER.svg"
							style="margin-top: 30px">
						</div>
					</div>
					<div class="tier-label">
						<p id="SILVER">실버</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
							<img src="https://online.gamecoach.pro/img/lol/emblem-GOLD.svg"
							style="margin-top: 25px">
						</div>
					</div>
					<div class="tier-label">
						<p id="GOLD">골드</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
							<img src="https://online.gamecoach.pro/img/lol/emblem-PLATINUM.svg"
							style="margin-top: 20px">
						</div>
					</div>
					<div class="tier-label">
						<p id="PLATINUM">플래티넘</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
						<img src="https://online.gamecoach.pro/img/lol/emblem-DIAMOND.svg"
							style="margin-top: 15px">
						</div>
					</div>
					<div class="tier-label">
						<p id="DIAMOND">다이아몬드</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
						<img src="https://online.gamecoach.pro/img/lol/emblem-MASTER.svg"
							style="margin-top: 10px">
						</div>
					</div>
					<div class="tier-label">
						<p id="MASTER">마스터</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
						<img src="https://online.gamecoach.pro/img/lol/emblem-GRANDMASTER.svg"
							style="margin-top: 5px">
						</div>
					</div>
					<div class="tier-label">
						<p id="GRANDMASTER">그랜드 마스터</p>
					</div>
				</div>
				<div class="tier">
					<div class="tier-box">
						<div class="gradient">
						<img src="https://online.gamecoach.pro/img/lol/emblem-CHALLENGER.svg">
						</div>
					</div>
					<div class="tier-label">
						<p id="CHALLENGER">챌린저</p>
					</div>
				</div>
			</div>
			<div id="btn-box" class="d-flex justify-content-end">
				<button type="button" class="btn btn-dark" id="first-next">다음</button>
			</div>
		</section><!-- first -->
	
		<section id="second">
			<div class="inner-contents">
				<div class="row">
					<div class="text-center">
						<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
						어떤 목표를 가지고 있나요?</h4>
					</div>
					<div class="d-flex justify-content-center">
						<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100">
						  <div class="progress-bar" style="width: 34%">34%</div>
						</div>
						<span>2/6</span>
					</div>
				</div>
				  <div id="tag-box" class="row">
				    <c:forEach items="${target_tag}" var="target_tag">
				      <c:if test="${not empty target_tag.tag_info}">
				        <div class="d-flex align-items-center">
				         <div>
				          <input type="checkbox" class="btn-check" id="${target_tag.tag_id}" name="selected_tags" value="${target_tag.tag_id}">
				          <label class="btn btn-outline-primary btn-sm" id="btn-check" for="${target_tag.tag_id}">${target_tag.tag_info}</label>
				         </div>
				        <c:if test="${target_tag.tag_id eq 5}">
				          <div class="d-flex justify-content-center">
				        	<input type="text" class="form-control" id="target-summoner">
				        	<button type="button" id="target-check-btn" class="btn btn-dark" onclick="특정함수()">확인</button>
				          </div>
				        </c:if>
				        <c:if test="${target_tag.tag_id eq 26}">
				        	 <textarea class="form-control" id="own-goal" rows="3"></textarea>
				        </c:if>
				        </div>
				      </c:if>
				    </c:forEach>
				  </div>
			  </div>
		    <div id="btn-box" class="d-flex justify-content-between">
				<button type="button" class="btn btn-dark" id="second-prev">이전</button>
				<button type="button" class="btn btn-dark" id="second-next">다음</button>
			</div>
		</section><!-- second -->
		
		<section id="third">
			<div class="inner-contents">
			  <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 방식으로 수업을 받고 싶나요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 50%">50%</div>
					</div>
					<span>3/6</span>
				</div>
				</div>
				  <div id="tag-box" class="row">
				    <c:forEach items="${class_method_tag}" var="class_method_tag">
				      <c:if test="${not empty class_method_tag.tag_info}">
				        <div class="d-flex align-items-center">
				          <input type="checkbox" class="btn-check" id="${class_method_tag.tag_id}" name="selected_tags" value="${class_method_tag.tag_id}">
				          <label class="btn btn-outline-primary btn-sm" id="btn-check" for="${class_method_tag.tag_id}">${class_method_tag.tag_info}</label>
				        </div>
				      </c:if>
				    </c:forEach>
				  </div>
			  </div>
		  <div id="btn-box" class="d-flex justify-content-between">
				<button type="button" class="btn btn-dark" id="third-prev">이전</button>
				<button type="button" class="btn btn-dark" id="third-next">다음</button>
			</div>
		</section><!-- third -->
		
		<section id="fourth">
		<div class="inner-contents">
			  <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 스타일의 멘토님을 선호하세요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 66%">66%</div>
					</div>
					<span>4/6</span>
				</div>
			</div>
		  <div id="tag-box" class="row">
			  <div class="d-flex align-item-center justify-content-center">
			    <c:forEach items="${style_tag}" var="style_tag" varStatus="loop">
				  <c:choose>
				    <c:when test="${not empty style_tag.tag_info && (style_tag.tag_id == 10 || style_tag.tag_id == 13)}">
				      <input type="radio" class="btn-check" id="${style_tag.tag_id}" name="selected_tags" value="${style_tag.tag_id}">
				      <label class="col btn btn-outline-primary btn-sm" id="btn-check" for="${style_tag.tag_id}">${style_tag.tag_info}</label>
				      <c:if test="${loop.index == 0}">
				        <h2 class="vs-label">&nbspvs&nbsp</h2>
				      </c:if>
				    </c:when>
				  </c:choose>
				</c:forEach>
			  </div>	  
			 <div class="d-flex align-item-center justify-content-center">
			    <c:forEach items="${style_tag}" var="style_tag" varStatus="loop">
				  <c:choose>
				    <c:when test="${not empty style_tag.tag_info && (style_tag.tag_id == 11 || style_tag.tag_id == 14)}">
				      <input type="radio" class="btn-check" id="${style_tag.tag_id}" name="selected_tags2" value="${style_tag.tag_id}">
				      <label class="col btn btn-outline-primary btn-sm" id="btn-check" for="${style_tag.tag_id}">${style_tag.tag_info}</label>
				      <c:if test="${loop.index == 1}">
				        <h2 class="vs-label">&nbspvs&nbsp</h2>
				      </c:if>
				    </c:when>
				  </c:choose>
				</c:forEach>
			  </div>	  
			  <div class="d-flex align-item-center justify-content-center">
			    <c:forEach items="${style_tag}" var="style_tag" varStatus="loop">
				  <c:choose>
				    <c:when test="${not empty style_tag.tag_info && (style_tag.tag_id == 12 || style_tag.tag_id == 15)}">
				      <input type="radio" class="btn-check" id="${style_tag.tag_id}" name="selected_tags3" value="${style_tag.tag_id}">
				      <label class="col btn btn-outline-primary btn-sm" id="btn-check" for="${style_tag.tag_id}">${style_tag.tag_info}</label>
				      <c:if test="${loop.index == 2}">
				        <h2 class="vs-label">&nbspvs&nbsp</h2>
				      </c:if>
				    </c:when>
				  </c:choose>
				</c:forEach>
			  </div>
		  </div>	  
	  </div>	  
		  <div id="btn-box" class="d-flex justify-content-between">
				<button type="button" class="btn btn-dark" id="fourth-prev">이전</button>
				<button type="button" class="btn btn-dark" id="fourth-next">다음</button>
			</div>
		</section><!-- fourth -->
		
		<section id="fifth">
			<div class="inner-contents">
			  <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 스타일의 멘토님을 선호하세요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="83" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 83%">83%</div>
					</div>
					<span>5/6</span>
				</div>
			</div>
			  <div id="tag-box" class="col d-flex flex-wrap">
			    <c:forEach items="${style2_tag}" var="style2_tag">
			      <c:if test="${not empty style2_tag.tag_info}">
			        <div class="d-flex align-items-center">
			          <input type="checkbox" class="btn-check" id="${style2_tag.tag_id}" name="selected_tags" value="${style2_tag.tag_id}">
			          <label class="btn btn-outline-primary btn-sm" id="btn-check" for="${style2_tag.tag_id}">${style2_tag.tag_info}</label>
			        </div>
			      </c:if>
			    </c:forEach>
			  </div>
		  	</div>
		  	<div id="btn-box" class="d-flex justify-content-between">
				<button type="button" class="btn btn-dark" id="fifth-prev">이전</button>
				<button type="button" class="btn btn-dark" id="fifth-next">다음</button>
			</div>
		</section><!-- fifth -->
		
		<section id="sixth">
			<div class="inner-contents">
			   <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 경력의 멘토님을 선호하세요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 100%">100%</div>
					</div>
					<span>6/6</span>
				</div>
			</div>
			  <div id="tag-box" class="col d-flex flex-wrap justify-content-center">
			    <c:forEach items="${careers_tag}" var="careers_tag">
			      <c:if test="${not empty careers_tag.tag_info}">
			        <div class="d-flex justify-content-center">
			          <input type="checkbox" class="btn-check" id="${careers_tag.tag_id}" name="selected_tags" value="${careers_tag.tag_id}">
			          <label class="btn btn-outline-primary btn-sm" id="btn-check" for="${careers_tag.tag_id}">${careers_tag.tag_info}</label>
			        </div>
			      </c:if>
			    </c:forEach>
			  </div>
		  </div>
			  
		  <div id="btn-box" class="d-flex justify-content-between">
		    <button type="button" class="btn btn-dark" id="sixth-prev">이전</button>
			<button type="button" class="btn btn-outline-dark" id="done-btn">내게 딱맞는 멘토님 확인하기</button>
		  </div>
		</section><!-- sixth -->
		
		<section>
			<div id="recom_mentor_list">
			<!-- 추천멘토 정보 -->
			</div>
		</section>
		
		</div><!-- question -->
	</div><!-- content -->
</div><!-- container -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script>
	// 선택한 포지션 값을 저장
	let position = "";
	
		$(document).ready(function () {
			$("#done-btn").click(function(){
			    submitForm(function() {
			        saveMentiTag(function() {
			            recom_mentor();
			        });
			    });
			});
			
			$("form").on("keydown", function (event) {
				if (event.keyCode === 13) {
					event.preventDefault();
					// 엔터 이벤트 처리 로직
				}
			});

			$(".champ-search").on("keydown", function (event) {
				if (event.keyCode === 13) {
					event.preventDefault(); // 엔터 키 이벤트 전파 막기
					let champions = $(".champ-search").val();
					$("#champion_to_learn").val(champions);
				}
			});

			$(".champ-selector-inner").click(function () {
				if ($(".filter-champ-wrap").css('display') === 'none') {
					$(".filter-champ-wrap").css('display', 'block');
				} else {
					$(".filter-champ-wrap").css('display', 'none');
				}
			});

			$("#goal-tier").click(function () {
				if ($('#goal-tier-selector').attr("class") === "d-none d-flex align-item-center justify-content-evenly text-center") {
					$('#goal-tier-selector').attr("class","d-flex align-item-center justify-content-evenly text-center");
				}
			});

			$(".tier").click(function () {
				let tier = $(this).find("p").attr("id");
				let imgURL = $(this).find("img").attr("src");
				$("#tier-holder strong").text(tier);
				$("#tier-holder img").attr("src", imgURL);
				$("#target_tier").val(tier);
				$('#goal-tier-selector').attr("class","d-none d-flex align-item-center justify-content-evenly text-center");
			});

			$("#top-button").on("click", function () {
				// 선택한 포지션 배열에 추가
				position = "탑";
				console.log(position);
			});
			$("#jungle-button").on("click", function () {
				position = "정글";
				console.log(position);
			});
			$("#mid-button").on("click", function () {
				position = "미드";
				console.log(position);
			});
			$("#bot-button").on("click", function () {
				position = "바텀";
				console.log(position);
			});
			$("#support-button").on("click", function () {
				position = "서포터";
				console.log(position);
			});

			$.ajax({ //챔피언 목록 가져오기
				url: "/mentor/get-all-champ",
				type: "GET",
				success: function (data) {
					let championList = JSON.parse(data);
					championList.forEach(function (champion) {
						let imageUrl =
							"https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
							champion.champion_en_name + ".png?&amp;retry=0";
						let champItem = $("<div>").addClass("champ-item").click(function () {
							$("#champ-info").attr("data", champion.champion_id)
							$(".champ-name").text(champion.champion_kr_name);
							$(".champ-img").attr("src", imageUrl);
							$(".filter-champ-wrap").css('display', 'none');
							$("#champion_to_learn").val(champion.champion_id);
						});
						let championDiv = $("<div>").attr("id", "champion");
						let champImg = $("<img>").addClass("champ-icon").attr("src", imageUrl);
						let champName = $("<span>").text(champion.champion_kr_name);
						championDiv.append(champImg);
						championDiv.append(champName);
						champItem.append(championDiv);
						let rateWrap = $("<div>").addClass("rate-wrap");
						let rateBarWrap = $("<div>").addClass("rate-bar-wrap");
						let rateBarBg = $("<div>").addClass("rate-bar-bg");
						rateBarWrap.append(rateBarBg);
						rateWrap.append(rateBarWrap);
						let pickRate = $("<p>").addClass("pick-rate").text("픽률 " + 0 + "%");
						rateWrap.append(pickRate);
						champItem.append(rateWrap);
						$(".champ-list").append(champItem);
					});
				},
				error: function () {
					console.error("챔피언 정보를 불러오는데 실패했습니다.");
				}
			});
			
		});//ready


		function submitForm(callback) {
			let customMentorDTO = {
				menti_email: "${member.email}",
				position_to_learn: position,
				champion_to_learn: $("#champ-info").attr("data"),
				target_tier: $("#tier-holder strong").text()
			};
			console.log(customMentorDTO);
			$.ajax({
				url: "/mentor/save-custom-mentor/",
				type: "POST",
				contentType: "application/json;charset=UTF-8",
				data: JSON.stringify(customMentorDTO),
				success: function (data) {
					callback();
				},
				error: function (error) {
					alert("커스텀 멘토 작성 실패");
				}
			});
			return false;
		}


		function saveMentiTag(callback) {
			let tagButtons = $(".btn-check");
			let tagList = [];
			tagButtons.each(function () {
				if ($(this).prop("checked")) {
					let tag = $(this).attr("id");
					let tag_note5 = $("#target-summoner").val();
					let tag_note26 = $("#own-goal").val();
					if (tag == 5){
						let data = {
								menti_email: "${member.email}",
								tag_id: tag,
								tag_note: tag_note5
							};
						tagList.push(data);
					}else if(tag == 26){
						let data = {
								menti_email: "${member.email}",
								tag_id: tag,
								tag_note: tag_note26
							};
						tagList.push(data);
					}else{
						let data = {
								menti_email: "${member.email}",
								tag_id: tag
							};
						tagList.push(data);
					}
				}
			});
			let jsonData = JSON.stringify(tagList);
			console.log(tagList);
			$.ajax({
				url: "/mentor/save-menti-tag/",
				type: "POST",
				contentType: "application/json;charset=UTF-8",
				data: jsonData,
				success: function () {
					callback();
				},
				error: function () {
					alert("멘티 태그 저장에 실패했습니다.");
				}
			});
			return false;
		}
		
		function recom_mentor() { //추천 멘토 가져오기
			$.ajax({
				type: "GET",
				url: "/mentor/recom-mentor",
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function (data) {
					let mentorList = $("#recom_mentor_list");
					let table = $("<table>").addClass("mentor-table");
					let header = $("<tr>").append(
						$("<th>").text("멘토명"),
						$("<th>").text("멘토 소개")
					);
					table.append(header);
					for (let i = 0; i < data.length; i++) {
						let mentor = data[i];
						let row = $("<tr>").append(
							$("<td>").text(mentor.mentor_email),
							$("<td>").text(mentor.about_mentor)
						);
						table.append(row);
					}
					mentorList.empty().append(table);
					alert("멘토 추천 성공")
				},
				error: function (xhr, status, error) {
					alert("멘토 추천 실패")
					console.error(xhr.responseText);
					console.error(status);
					console.error(error);
				}
			})
		};
	</script>
</body>

</html>