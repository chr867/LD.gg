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

section{
padding: 90px 40px;
padding-bottom: 20px;
width: 900px;
border-radius: 10px;
box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
margin-top:40px;
}
#qustions{
padding: 0 90px;
}
#summoner-wrap{
background-color:#f2f2f2;
border-radius: 12px;
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
background-color:#fff;
border:solid 1px #dee2e6;
border-radius: 15px;
padding:8px;
width:130px;
}
#position-buttons button.selected{
font-weight: bold;
border:solid 2px black;
}
#position-buttons button.mouse-over{
font-weight: bold;
border:solid 2px black;
}
#position-buttons button img{
width:40px;
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
margin:32px 0;
}
#goal-tier{
margin-top:60px;
}
#volume{
margin-left:10px;
}
#champ-info{
margin-top:32px;
}
#champ-selector{
margin-top:60px;
}
#champ-selector-inner{
margin:32px 0;
}
#champ-name{
font-size:24px;
font-weight:bold;
}
#champ-img{
width:72px;
}
#champ-item{
padding: 18px 10px;
}
#champ-item:hover{
background-color: white;
cursor: pointer;
}
#champ-search {
    margin-top: 8px;
}
#champ-list{
margin-top:10px;
height: 370px;
border: 1px solid #dee2e6;
border-radius: 20px;
overflow: auto; /* 스크롤바를 추가하기 위해 overflow 속성 설정 */
}
#filter-champ-wrap {
  width: 430px;
  height: 500px; /* 원하는 높이로 설정 */
  top: 20px;
  right: 20px;
  background-color: #f8f9fa;
  padding: 24px;
  border-radius: 20px;
  box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
}
#select-box{
min-width:300px;
padding:8px 24px;
border:solid 1px #dee2e6;
border-radius:10px;
cursor: pointer;
}
#select-box:hover{
border:solid 2px black;
}
.gradient {
height: 120px;
background: linear-gradient(to top, #cccccc, #dee2e6 20%, #f8f9fa 50%, #ffffff 70%);
}
.target .gradient{
background: linear-gradient(to top, #ffd558, #ffe9a7 20%, #fffcf2 50%, #ffffff 70%);
}
.hover .gradient{
background: linear-gradient(to top, #ffd558, #ffe9a7 20%, #fffcf2 50%, #ffffff 70%);
}
.target p{
color: white;
font-weight:bold;
background: black;
}
.hover p{
color: white;
font-weight:bold;
background: black;
}
.tier-label{
font-size: 12px;
width: 85px;
margin-top:5px;
color: #777;
background-color:#eaeaea;
}
#target-summoner{
width: 200px;
margin-left:8px;
margin-right:3px;
}
#own-goal{
height: 98px;
width:60%;
margin-left:8px;
margin-top:10px;
}
article{
width: 100%;
margin-top: 0;
margin-right: auto;
margin-bottom: 60px;
margin-left: auto;
padding-top: 100px;
}
article #btn-box{
margin:auto;
    width: 1500px;
}
#recom_mentor_list{
padding-top:90px;
padding-bottom:60px;
}
#mentor-view-box{
padding:16px 0;
}
#mentor-item{
width: 330px;
border-radius:20px;
}
#mentor-item:hover{
border: solid 2px black;
cursor:pointer;
}
#recom-mentor-img{
width:128px;
border-radius:50%;
border: solid 8px white;
box-shadow: 0 3px 6px rgba(0, 0.5, 0, 0.5);
}
#tier-img{
width: 100px;
}
#mentor-tier{
right: 30px;
bottom: 15px;
}
#mentor-tier p{
font-size: 12px;
font-weight: bold;
}
#mentor-header{
border-top-left-radius:20px;
border-top-right-radius:20px;
background-color: #f2f2fb;
padding:0 24px;
padding-top:80px;
}
#mentor-info{
padding-top:24px;
padding-left:36px;
padding-right:36px;
padding-bottom:20px;
}
#mentor-name{
font-size:28px;
font-weight:bold;
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
						<div class="progress my-auto" role="progressbar" aria-label="Example with label" aria-valuenow="17" aria-valuemin="0" aria-valuemax="100">
						  <div class="progress-bar" style="width: 17%">17%</div>
						</div>
						<span id="volume">1/6</span>
					</div>
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
							<img id="member-tier-img" class="mx-2" style="width: 72px" src="https://online.gamecoach.pro/img/lol/emblem-UNRANKED.svg">
						</div>
						<div class="my-auto">
							<div>
								<h4>
									<strong id="member-tier">UNRANKED</strong>
								</h4>
								<div id="member-stat">
									<strong>승률 0%</strong>
									<span>(0승 0패)</span>
								</div>
							</div>
						</div>
						<div class="my-auto">
							<span id="member-lp" class="mx-2">0LP</span>
						</div>
					</div>
					<span class="my-auto">입니다.</span>
				</div>
			</div>
			
			<div id="form-box">
				<div id="pos-box">
					<h3><strong>배우고 싶은 포지션</strong></h3>
					<div id="position-buttons" class="d-flex align-item-center justify-content-evenly">
						<button type="button" id="top-button">
							<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg" class="position-img">
							<span>탑</span>
						</button>
						<button type="button" id="jungle-button"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg" 
								class="position-img">
							<span>정글</span>
						</button>
						<button type="button" id="mid-button"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg"
								class="position-img">
							<span>미드</span>
						</button>
						<button type="button" id="bot-button"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg" 
								class="position-img">
							<span>바텀</span>
						</button>
						<button type="button" id="support-button"><img
								src="https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg"
								class="position-img">
							<span>서포터</span>
						</button>
					</div>
				</div>
		
				<div id="champ-selector">
					<h3><strong>배우고 싶은 챔피언</strong></h3>
					<div id="champ-selector-inner" class="d-flex">
						<div id="select-box" class="d-flex align-item-center justify-content-between">
						<div id="champ-info" class="d-flex my-auto">
						<div class="my-auto mx-3">
							<span id="champ-name">챔피언 선택</span>
						</div>
						</div>
						<img id="arrow-icon" class="my-auto" style="width:40px" src="/resources/img/icon/arrow-icon-down.png">
						</div>
					</div>
				</div>
				
				<div id="filter-champ-wrap" style="display: none">
					<div class="d-flex justify-content-between">
						<h5><strong>챔피언</strong></h5>
						<button type="button" class="btn-close" id="champ-wrap-close" aria-label="Close"></button>
					</div>
					<div>
						<div>
							<input placeholder="챔피언을 검색하세요" class="form-control" type="text" id="champ-search">
						</div>
						<div id="champ-list">
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
				<button type="button" class="btn btn-dark d-none" id="first-next">다음</button>
			</div>
		</section><!-- first -->
	
		<section id="second" class="d-none">
			<div class="inner-contents">
				<div class="row">
					<div class="text-center">
						<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
						어떤 부분을 배우고 싶으신가요?</h4>
					</div>
					<div class="d-flex justify-content-center">
						<div class="progress my-auto" role="progressbar" aria-label="Example with label" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100">
						  <div class="progress-bar" style="width: 34%">34%</div>
						</div>
						<span id="volume">2/6</span>
					</div>
				</div>
				  <div id="tag-box" class="row">
				    <c:forEach items="${target_tag}" var="target_tag">
				      <c:if test="${not empty target_tag.tag_info}">
				        <div class="d-flex align-items-center">
				         <div>
				          <input type="checkbox" class="btn-check" id="${target_tag.tag_id}" name="selected_tags" value="${target_tag.tag_id}">
				          <label class="btn btn-outline-primary" id="btn-check" for="${target_tag.tag_id}">${target_tag.tag_info}</label>
				         </div>
				        <c:if test="${target_tag.tag_id eq 5}">
				          <div class="d-flex d-none">
				        	<input type="text" class="form-control" id="target-summoner">
				        	<button type="button" id="target-check-btn" class="btn btn-dark d-flex" onclick="특정함수()">확인</button>
				          </div>
				        </c:if>
				        <c:if test="${target_tag.tag_id eq 26}">
				        	 <textarea class="form-control d-none" id="own-goal" rows="3"></textarea>
				        </c:if>
				        </div>
				      </c:if>
				    </c:forEach>
				  </div>
			  </div>
		    <div id="btn-box" class="d-flex justify-content-between">
				<button type="button" class="btn btn-dark" id="second-prev">이전</button>
				<button type="button" class="btn btn-dark d-none" id="second-next">다음</button>
			</div>
		</section><!-- second -->
		
		<section id="third" class="d-none">
			<div class="inner-contents">
			  <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 방식으로 수업을 받고 싶나요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress my-auto" role="progressbar" aria-label="Example with label" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 50%">50%</div>
					</div>
					<span id="volume">3/6</span>
				</div>
				</div>
				  <div id="tag-box" class="row">
				    <c:forEach items="${class_method_tag}" var="class_method_tag">
				      <c:if test="${not empty class_method_tag.tag_info}">
				        <div class="d-flex align-items-center">
				          <input type="checkbox" class="btn-check" id="${class_method_tag.tag_id}" name="selected_tags" value="${class_method_tag.tag_id}">
				          <label class="btn btn-outline-primary" id="btn-check" for="${class_method_tag.tag_id}">${class_method_tag.tag_info}</label>
				        </div>
				      </c:if>
				    </c:forEach>
				  </div>
			  </div>
		  <div id="btn-box" class="d-flex justify-content-between">
				<button type="button" class="btn btn-dark" id="third-prev">이전</button>
				<button type="button" class="btn btn-dark d-none" id="third-next">다음</button>
			</div>
		</section><!-- third -->
		
		<section id="fourth" class="d-none">
		<div class="inner-contents">
			  <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 스타일의 멘토님을 선호하세요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress my-auto" role="progressbar" aria-label="Example with label" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 66%">66%</div>
					</div>
					<span id="volume">4/6</span>
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
				<button type="button" class="btn btn-dark d-none" id="fourth-next">다음</button>
			</div>
		</section><!-- fourth -->
		
		<section id="fifth" class="d-none">
			<div class="inner-contents">
			  <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 스타일의 멘토님을 선호하세요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress my-auto" role="progressbar" aria-label="Example with label" aria-valuenow="83" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 83%">83%</div>
					</div>
					<span id="volume">5/6</span>
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
				<button type="button" class="btn btn-dark d-none" id="fifth-next">다음</button>
			</div>
		</section><!-- fifth -->
		
		<section id="sixth" class="d-none">
			<div class="inner-contents">
			   <div class="row">
				<div class="text-center">
					<h4><img src="https://online.gamecoach.pro/img/coaching/emoji-star.svg">
					어떤 경력의 멘토님을 선호하세요?</h4>
				</div>
				<div class="d-flex justify-content-center">
					<div class="progress my-auto" role="progressbar" aria-label="Example with label" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
					  <div class="progress-bar" style="width: 100%">100%</div>
					</div>
					<span id="volume">6/6</span>
				</div>
			</div>
			  <div id="tag-box" class="col d-flex flex-wrap justify-content-center">
			    <c:forEach items="${careers_tag}" var="careers_tag">
			      <c:if test="${not empty careers_tag.tag_info}">
			        <div class="d-flex justify-content-center">
			          <input type="checkbox" class="btn-check" id="${careers_tag.tag_id}" name="selected_tags" value="${careers_tag.tag_id}">
			          <label class="btn btn-outline-primary" id="btn-check" for="${careers_tag.tag_id}">${careers_tag.tag_info}</label>
			        </div>
			      </c:if>
			    </c:forEach>
			  </div>
		  </div>
			  
		  <div id="btn-box" class="d-flex justify-content-between">
		    <button type="button" class="btn btn-dark" id="sixth-prev">이전</button>
			<button type="button" class="btn btn-outline-dark d-none" id="done-btn">
			<img src="https://online.gamecoach.pro/img/coaching/emoji-twinkle.svg">
			내게 딱맞는 멘토님 확인하기</button>
		  </div>
		</section><!-- sixth -->
		</div><!-- question -->
	</div><!-- content -->
</div><!-- container -->

<article id="recom-section" class="d-none">
	<div id="top-wrap" class="text-center">
		<h3>
			<img src="https://online.gamecoach.pro/img/coaching/emoji-eyes-star.svg">
			 <strong>결과를 분석하여 최적의 멘토님을 찾았습니다!</strong> 
		 </h3>
		<p>원하시는 멘토님의 프로필을 확인하고 상담신청을 해보세요.</p>
		<span id="top-wrap--hint">(멘토님이 오프라인이거나 이미 수업중일 경우, 답변이 늦어질 수 있습니다.)</span>
	</div>
	
	<div id="recom_mentor_list" class="d-flex align-item-center justify-content-evenly">
	<!-- 추천멘토 정보 -->
	</div>
	
	<div id="coach-finder" class="text-center">
		<p id="coach-finder-text">더 많은 멘토님을 알고 싶다면 <a href="/mentor/list">멘토 찾기</a>로 이동해보세요!</p>
	</div>
	
	<div id="btn-box" class="d-flex justify-content-between">
    <button type="button" class="btn btn-dark" id="seventh-prev">이전</button>
  </div>
</article>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script>
	// 선택한 포지션 값을 저장
	let position = "";
	let learnChamp = "";
	let targetTier = "";
	
	
		$(document).ready(function () {
			
			$("#first-next").click(function(){
				$("#first").addClass("d-none");
				$("#second").removeClass("d-none");
			});
			$("#second-next").click(function(){
				$("#second").addClass("d-none");
				$("#third").removeClass("d-none");
			});
			$("#third-next").click(function(){
				$("#third").addClass("d-none");
				$("#fourth").removeClass("d-none");
			});
			$("#fourth-next").click(function(){
				$("#fourth").addClass("d-none");
				$("#fifth").removeClass("d-none");
			});
			$("#fifth-next").click(function(){
				$("#fifth").addClass("d-none");
				$("#sixth").removeClass("d-none");
			});
			//완료버튼
			$("#done-btn").click(function(){
			    submitForm(function() {
			        saveMentiTag(function() {
			            recom_mentor();
			            $("#sixth").addClass("d-none");
						$("#recom-section").removeClass("d-none");
			        });
			    });
			});
			
			$("#seventh-prev").click(function(){
				$("#recom-section").addClass("d-none");
				$("#sixth").removeClass("d-none");
				$("#recom_mentor_list").text("");
			});
			$("#sixth-prev").click(function(){
				$("#sixth").addClass("d-none");
				$("#fifth").removeClass("d-none");
			});
			$("#fifth-prev").click(function(){
				$("#fifth").addClass("d-none");
				$("#fourth").removeClass("d-none");
			});
			$("#fourth-prev").click(function(){
				$("#fourth").addClass("d-none");
				$("#third").removeClass("d-none");
			});
			$("#third-prev").click(function(){
				$("#third").addClass("d-none");
				$("#second").removeClass("d-none");
			});
			$("#second-prev").click(function(){
				$("#second").addClass("d-none");
				$("#first").removeClass("d-none");
			});
			
			
			$(".btn-check").click(function(){
				if ($('#5').prop('checked')) {
					$('#target-summoner').parent().removeClass("d-none");
				} else {
					$('#target-summoner').parent().addClass("d-none");
				}
				
				if ($('#26').prop('checked')) {
					$('#own-goal').removeClass("d-none");
				} else {
					$('#own-goal').addClass("d-none");
				}
			})
			
			$('#first div').click(function() {
				if (position !== "" && learnChamp !== "" && targetTier !== ""){
					$('#first-next').removeClass("d-none");
				}else{
					$('#first-next').addClass("d-none");
				}
			});
			
			$("#second .btn-check").click(function(){
				let btnCnt = 0;
				btnCnt = $('#second .btn-check:checked').length;
				if (btnCnt > 0) {
				    $("#second-next").removeClass("d-none")
				} else {
					$("#second-next").addClass("d-none")
				}
			});
			
			$("#third .btn-check").click(function(){
				let btnCnt = 0;
				btnCnt = $('#third .btn-check:checked').length;
				if (btnCnt > 0) {
				    $("#third-next").removeClass("d-none")
				} else {
					$("#third-next").addClass("d-none")
				}
			});
			
			$("#fourth .btn-check").click(function(){
				let btnCnt = 0;
				btnCnt = $('#fourth .btn-check:checked').length;
				if (btnCnt > 0) {
				    $("#fourth-next").removeClass("d-none")
				} else {
					$("#fourth-next").addClass("d-none")
				}
			});
			
			$("#fifth .btn-check").click(function(){
				let btnCnt = 0;
				btnCnt = $('#fifth .btn-check:checked').length;
				if (btnCnt > 0) {
				    $("#fifth-next").removeClass("d-none")
				} else {
					$("#fifth-next").addClass("d-none")
				}
			});
			
			$("#sixth .btn-check").click(function(){
				let btnCnt = 0;
				btnCnt = $('#sixth .btn-check:checked').length;
				if (btnCnt > 0) {
				    $("#done-btn").removeClass("d-none")
				} else {
					$("#done-btn").addClass("d-none")
				}
			});

			
			
						
			//접속한 회원의 소환사 정보 확인
			$.ajax({
				   url: "/mentor/get-summoner-info",
				   type: "GET",
				   data: {
				      summoner_name: "${member.lol_account}"
				   },
				   success: function(response) {
				      let summoner = JSON.parse(response);
				      $("#member-tier-img").attr("src","https://online.gamecoach.pro/img/lol/emblem-"+summoner.tier+".svg");
				      
				      if(summoner.tier == "MASTER" || summoner.tier == "GRANDMASTER" || summoner.tier == "CHALLENGER"){
				    	 $("#member-tier").text(summoner.tier);
				      }else{
				    	 $("#member-tier").text(summoner.tier+" "+summoner.ranking);
				      }
				      
				      let winRate = (summoner.wins/summoner.games)*100
				      winRate = winRate.toFixed(1);
						if (winRate == "NaN"){
							winRate=0;
						}
						
				      $("#member-stat strong").text("승률 "+winRate+"%")
				      $("#member-lp").text(summoner.lp+"LP")
				      $("#member-stat span").text("("+summoner.wins+"승 "+summoner.losses+"패)")
				   },
				   error: function(xhr, status, error) {
				      console.log(error);
				   }
				});

			$(".champ-search").on("keydown", function (event) {
				if (event.keyCode === 13) {
					event.preventDefault(); // 엔터 키 이벤트 전파 막기
					let champions = $(".champ-search").val();
					$("#champion_to_learn").val(champions);
				}
			});

			$("#select-box").click(function () {
				if ($("#filter-champ-wrap").css('display') === 'none') {
					$("#filter-champ-wrap").css('display', 'block');
				} else {
					$("#filter-champ-wrap").css('display', 'none');
				}
			});
			$(".btn-close").click(function () {
				$("#filter-champ-wrap").css('display', 'none');
			})

			$("#goal-tier").click(function () {
				if ($('#goal-tier-selector').hasClass("d-none")) {
					$('#goal-tier-selector').removeClass("d-none");
				}
			});

			$(".tier").click(function () {
				let tier = $(this).find("p").attr("id");
				let imgURL = $(this).find("img").attr("src");
				$("#tier-holder strong").text(tier);
				$("#tier-holder img").attr("src", imgURL);
				$('#goal-tier-selector').addClass("d-none");
				targetTier = tier;
				console.log(targetTier);
			});
			
			 // 클릭된 포지션 버튼에 "selected" 클래스 추가
			$("#position-buttons button").click(function () {
			  $("#position-buttons button").removeClass("selected");
			  $(this).addClass("selected");
			  position = $(this).find("span").text();
			  console.log(position);
			  laneImgChange();
			  $("#1").next("label").text("["+position +"] 라인전 이후의 운영방식을 배우고 싶어요");
			  if(position=="정글"){
				  $("#1").parent().parent().addClass("d-none");
				  $("#3").parent().parent().removeClass("d-none");
			  }else{
				  $("#1").parent().parent().removeClass("d-none");
				  $("#3").parent().parent().addClass("d-none");
			  }
			});
			//포지션 버튼 마우스오버 시
			$("#position-buttons button").hover(function () {
				$(this).addClass("mouse-over");
				laneImgChange();
			}, function () {
				$(this).removeClass("mouse-over");
				laneImgChange();
			});
			
			 // 클릭된 티어 버튼에 "selected" 클래스 추가
			$(".tier").click(function () {
			  $(".tier").removeClass("target");
			  $(this).addClass("target");
		      const clickedIndex = $('.tier').index(this);
		      $('.tier:lt(' + clickedIndex + ')').addClass('target');
			});
			//티어 버튼 마우스오버 시
			$(".tier").hover(function () {
				$(this).addClass("hover");
				const clickedIndex = $('.tier').index(this);
			      $('.tier:lt(' + clickedIndex + ')').addClass('hover');
			}, function () {
				$(".tier").removeClass("hover");
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
						let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between").attr("id","champ-item").click(function () {
							$("#0").next("label").text(champion.champion_kr_name +"의 상황별 룬, 아이템을 배우고 싶어요");
							$("#champ-info").attr("data", champion.champion_id)
							$("#champ-name").text(champion.champion_kr_name);
							if ($("#champ-info").find("img").length === 0) {
							    $("#champ-info").prepend($("<img>").attr("id", "champ-img").attr("src", imageUrl).css("border-radius","15px"));
							  }else{
								  $("#champ-img").attr("src", imageUrl);
							  }
							$("#filter-champ-wrap").css('display', 'none');
							learnChamp = champion.champion_id
							console.log(learnChamp);
						});
						let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
						let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						let champName = $("<div>").addClass("my-auto mx-3")
										.append($("<span>").text(champion.champion_kr_name));
						championDiv.append(champImg);
						championDiv.append(champName);
						champItem.append(championDiv);
						let rateWrap = $("<div>").addClass("rate-wrap");
						let rateBarWrap = $("<div>").addClass("rate-bar-wrap");
						let rateBarBg = $("<div>").addClass("rate-bar-bg");
						rateBarWrap.append(rateBarBg);
						rateWrap.append(rateBarWrap);
						let pickRate = $("<span>").addClass("pick-rate").text("픽률 " + 0 + "%");
						let pickMeter = $("<meter>").addClass("pick-meter").attr("min", 0).attr("max", 100)
            								.attr("low", 30).attr("high", 65).attr("optimum", 90).val(11);
						rateWrap.append(pickMeter);
						rateWrap.append(pickRate);
						champItem.append(rateWrap);
						$("#champ-list").append(champItem);
					});
				},
				error: function () {
					console.error("챔피언 정보를 불러오는데 실패했습니다.");
				}
			});
			
		});//ready
		
		// 이미지 경로 업데이트 및 선택 해제 시 원래 이미지로 복원
		function laneImgChange(){
		  $("#position-buttons button").each(function() {
		    const position = $(this).find("span").text();
		    if (position === "탑") {
		      const imageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_top.svg" ;
		      if ($(this).hasClass("selected") || $(this).hasClass("mouse-over")) {
		        // 이미지 경로 업데이트
		        $(this).find("img").attr("src", imageUrl);
		      } else {
		        // 선택 해제 시 원래 이미지로 복원
		        const originalImageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg" ;
		        $(this).find("img").attr("src", originalImageUrl);
		      }
		    }
		    if (position === "정글") {
			      const imageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_jg.svg" ;
			      if ($(this).hasClass("selected") || $(this).hasClass("mouse-over")) {
			        // 이미지 경로 업데이트
			        $(this).find("img").attr("src", imageUrl);
			      } else {
			        // 선택 해제 시 원래 이미지로 복원
			        const originalImageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg" ;
			        $(this).find("img").attr("src", originalImageUrl);
			      }
		    }
		    if (position === "미드") {
			      const imageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_mid.svg" ;
			      if ($(this).hasClass("selected") || $(this).hasClass("mouse-over")) {
			        // 이미지 경로 업데이트
			        $(this).find("img").attr("src", imageUrl);
			      } else {
			        // 선택 해제 시 원래 이미지로 복원
			        const originalImageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg" ;
			        $(this).find("img").attr("src", originalImageUrl);
			      }
		    }
		    if (position === "바텀") {
			      const imageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_ad.svg" ;
			      if ($(this).hasClass("selected") || $(this).hasClass("mouse-over")) {
			        // 이미지 경로 업데이트
			        $(this).find("img").attr("src", imageUrl);
			      } else {
			        // 선택 해제 시 원래 이미지로 복원
			        const originalImageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg" ;
			        $(this).find("img").attr("src", originalImageUrl);
			      }
		    }
		    if (position === "서포터") {
			      const imageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_sup.svg" ;
			      if ($(this).hasClass("selected") || $(this).hasClass("mouse-over")) {
			        // 이미지 경로 업데이트
			        $(this).find("img").attr("src", imageUrl);
			      } else {
			        // 선택 해제 시 원래 이미지로 복원
			        const originalImageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg" ;
			        $(this).find("img").attr("src", originalImageUrl);
			      }
		    }
		  })
		}


		function submitForm(callback) {
			let customMentorDTO = {
				menti_email: "${member.email}",
				position_to_learn: position,
				champion_to_learn: learnChamp,
				target_tier: targetTier
			};
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
					 const mentorList = $("#recom_mentor_list");
	            $.each(data, function(i, mentor) {
	            	if(mentor.mentor_email=="${member.email}"){
	            		console.log("자기자신은 제외됩니다");
	            	}else{
		            	const mentorDiv = $("<div></div>").appendTo(mentorList); //멘토 div
	                    mentorDiv
	                        .addClass("card position-relative")
	                        .attr("id","mentor-item")
	                        .attr('data-href', '/mentor/profile/' + mentor.lol_account)
	                        .on('click', function(event) {
	                            event.preventDefault();
	                            window.location.href = $(this).attr('data-href');
	                        });
	                    let grade = mentor.total_grade/mentor.num_of_reviews;
						grade = grade.toFixed(1);
						if (grade == "NaN"){
							grade=0;
						}
	                        
	                    const mentorHeader = $("<div>").attr("id",'mentor-header');
	                    const mentorImg = $("<img>").attr("id",'recom-mentor-img')
	                    		.addClass("position-absolute top-0 start-50 translate-middle")
	                    		.attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/"+mentor.profile_icon_id+".png")
	                    const mentorName = $("<div>").attr('id','mentor-name').addClass("text-center");
	                    const aboutMentor =$("<div>").attr('id','about-mentor');
	                    
	                    mentorHeader.appendTo(mentorDiv); //멘토 프로필 헤더
	                    mentorHeader.append(mentorImg); 
	                    mentorHeader.append(mentorName); 
	                    
	                    const mentorTier =$("<div>").addClass("position-absolute").attr('id','mentor-tier');
	                    mentorTier.append($("<img>")
	                    		.attr('id','tier-img')
	                    		.attr('src',"https://online.gamecoach.pro/img/lol/emblem-"+mentor.tier+".svg"));
	                    mentorTier.append($("<p>").addClass("text-center").text(mentor.tier));
	                    
	                    mentorName.append($("<span></span>").text(mentor.lol_account));
	                    aboutMentor.append($("<dd>").text(mentor.about_mentor));
							                	
		                	const mentorViewBox = $("<div>").addClass("d-flex text-center align-item-center justify-content-evenly")
		                							.attr('id','mentor-view-box')
		                							.appendTo(mentorHeader);
			                	
			                	const mentorReview = $("<div>")
														.attr('id','mentor-review')
			                							.appendTo(mentorViewBox)
									                	.append($("<dt>").text('후기'))
														.append($("<dd>").text(mentor.num_of_reviews+'개')); //멘토 리뷰 횟수
								const mentorGrade = $("<div>")
														.attr('id','mentor-grade')
			                							.appendTo(mentorViewBox)
									                	.append($("<dt>").text('평점'))
														.append($("<dd>").text(grade+'점')); //멘토 리뷰 점수
			                	const mentorLesson = $("<div>")
														.attr('id','mentor-lesson')
			                							.appendTo(mentorViewBox)
									                	.append($("<dt>").text('멘토링'))
														.append($("<dd>").text(mentor.num_of_lessons+'건')); //멘토 수업 횟수
			                	const mentorLikes = $("<div>")
														.attr('id','mentor-likes')
			                							.appendTo(mentorViewBox)
			                							.append($("<dt>").text('찜'))
			                							.append($("<dd>").text(mentor.num_of_likes));
	                	const mentorInfo = $("<div>")
	                	.attr('id','mentor-info')
	                	.appendTo(mentorDiv);//멘토 정보div
	                	
						mentorInfo.append(mentorTier);
	                	
						const mentorLevel = $("<div>")
						.attr('id','mentor-level')
						.appendTo(mentorInfo)
						.append($("<h5>").text('레벨: '+mentor.s_level)); //멘토 레벨
						const mentorLp = $("<div>")
						.attr('id','mentor-lp')
						.appendTo(mentorInfo)
						.append($("<h5>").text('LP:  '+mentor.lp)); //멘토 lp
						const mentorGames = $("<div>")
						.attr('id','mentor-games')
						.appendTo(mentorInfo)
						.append($("<h5>").text('게임수:  '+mentor.games+"회")); //멘토 게임수

						let mentor_winrate = (mentor.wins/mentor.games)*100;
						mentor_winrate = mentor_winrate.toFixed(1);
						if(mentor_winrate == "NaN"){
							mentor_winrate = 0
						}
						const mentorWinrate = $("<div>")
						.attr('id','mentor-winrate')
						.appendTo(mentorInfo)
						.append($("<h5>").text('승률:  '+mentor_winrate+"%")); //멘토 승률
	            	}
		            })
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