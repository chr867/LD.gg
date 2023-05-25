<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>멘토 프로필 작성</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#container{
width:800px;
}
.position-buttons button.selected {
  background-color: #ced4da;
  color: black;
  border: 3px solid #6c757d;
  font-weight: bold;
}
.position-buttons button{
	width:100px;
	height:70px;
	border-radius: 10px;
}
.position-buttons{
margin: 16px 0;
}
#profile-box{
padding: 16px;
margin-top: 30px;
border-radius: 10px;
}
section{
  padding:24px;
  border-bottom: 1px solid #dee2e6;
 }
 #time-set, #about_mentor, #careers, #recom_ment{
 margin:16px 0;
 width: 500px;
 }
 #tag-set, #tags-box{
 margin:16px 0;
 }
 #myTab{
 margin-top: 16px;
 }
 #dropdown-input{
 width:150px;
 }
 #champ-icon{
  width: 80px;
 }
 #champ-info{
 margin:0 20px;
 }
#btn-check{
margin: 5px;
}
#pos-box{
padding: 10px;
margin-right: 10px;
}
#pos-img{
margin-right: 8px;
}
#mentor-name{
margin-bottom:12px;
}
#mentor-intro{
padding:30px;
}
#champ-item{
padding: 18px 10px;
}
#champ-item:hover{
background-color: white;
cursor: pointer;
}
#champ-info span{
font-weight:bold;
}
#champ-list{
margin-top:10px;
height: 370px;
border: 1px solid #dee2e6;
border-radius: 20px;
overflow: auto; /* 스크롤바를 추가하기 위해 overflow 속성 설정 */
}
#champ-icon{
margin:auto;
}
::-webkit-scrollbar {
    width: 3px;
}
::-webkit-scrollbar-thumb {
    background-color: #888;
}
::-webkit-scrollbar-track {
    background: none;
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
#champ-selector-inner{
margin:18px 0;
}
#champ-selected-box{
padding: 16px;
border: 3px solid #dee2e6;
border-radius: 20px;
}

#champ-selected-box:hover{
border: 5px solid #adb5bd;
background-color: #f8f9fa;
cursor: pointer;
}
#champ-search{
margin-top: 8px;
}

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
	<div id="container" class="container">
	
		<section id="profile-box" class="row border">
			<div class="col-2" id="mentor-img">
				<img style="width: 128px" class="rounded" src="http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/${mentor_profile.profile_icon_id}.png">
			</div>
			<div class="col-8" id="mentor-intro">
				<div id= "mentor-name" class="row">
					<span class='col'><span class="h3"><strong>${mentor_profile.lol_account}</strong></span><em>&nbsp멘토님</em></span>
				</div>
				<div id="mentor-stat" class="row">
					<div id="mentor-spec" class="col">
						<div class="row">
							<span>
								<span>찜한 횟수: <em id = "mentor_likes">${mentor_profile.num_of_likes}</em></span>
								<span>수업 횟수: <em>${mentor_profile.num_of_lessons}</em></span>
								<span>리뷰 횟수: <em>${mentor_profile.num_of_reviews}</em></span>
								<span id="avg_grade">평점:
									<em>${mentor_profile.total_grade/mentor_profile.num_of_reviews}</em>
								</span>
							</span>
						</div>
						<div class="row">
							<span>
								<span>소환사 레벨: <em>${mentor_profile.s_level}LV</em></span>
								<span>게임 수: <em>${mentor_profile.games}회</em></span>
								<span>리그 포인트: <em>${mentor_profile.lp}LP</em></span>
							</span>
						</div>
					</div>
				</div>
			</div><!-- mentor-intro -->
			<div id="tier" class="col-2 d-flex flex-column align-items-center justify-content-center">
				<img src="https://online.gamecoach.pro/img/lol/emblem-${mentor_profile.tier}.svg">
				<dt>${mentor_profile.tier}</dt>
			</div>
		</section><!-- profile-box -->
		
		<ul class="nav nav-tabs" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">기본 정보</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">태그 설정</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">수업 설정</button>
		  </li>
		</ul><!-- nav-tabs -->
		
	<div class="tab-content" id="myTabContent">
	 	<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			<section>
				<h5><strong>멘토 소개</strong></h5>
				<span>${mentor_profile.about_mentor}</span>
				<div class="form-floating">
				  <textarea class="form-control" placeholder="Leave a comment here" id="about_mentor" style="height: 100px">${mentor_profile.about_mentor}</textarea>
				  <label for="about_mentor">소개 글을 작성해보세요</label>
				</div>
			</section>
			<section>
				<h5><strong>경력</strong></h5>
				<ul>
					<li>${mentor_profile.careers}
				</ul>
				<input type="text" class="form-control" id="careers" name="careers" value="${mentor_profile.careers}">
			</section>
			<section>
				<h5><strong>특화 포지션</strong></h5>
				<div id="specializedPosition" class="d-flex">
						<!-- 저장된 특화 포지션 -->
				</div>
				
				<div class="position-buttons">
				<button type="button" class="btn" id="top-button" name="탑"><img
						src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg" 
						class="position-img"><p>탑</p></button>
				<button type="button" class="btn" id="jungle-button" name="정글"><img
						src="https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg" 
						class="position-img"><p>정글</p></button>
				<button type="button" class="btn" id="mid-button" name="미드" ><img
						src="https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg"
						class="position-img"><p>미드</p></button>
				<button type="button" class="btn" id="bot-button" name="바텀"><img
						src="https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg" 
						class="position-img"><p>바텀</p></button>
				<button type="button" class="btn" id="support-button" name="서포터"><img
						src="https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg"
						class="position-img"><p>서포터</p></button>
				</div>
			</section>
				
			<section id="top"> <!-- 탑 특화 챔피언 -->
				<div class="d-flex align-items-center">
					<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg">
					<h5><strong>&nbspTOP&nbsp</strong></h5>
					<h5><strong>특화 챔피언</strong></h5>
				</div>
			<%-- <input type="text" class="form-control" id="top_specializedChampion" name="top_specialized_champion"
				value="${mentor_profile.top_specialized_champion}"> --%>
			<div id="champ-selector-inner" class="d-flex align-items-center text-center justify-content-start">
				<div id="champ-selected-box" class="d-flex align-items-center">
					<div id="champ-info">
						<img src="" id="champ-icon" class="rounded">
						<span class="champ-name">특화 챔피언(탑)을 선택 해주세요</span>
					</div>
					<img style="width: 43px" src="/resources/img/icon/arrow-icon-down.png" class="arrow-icon">
				</div>
			</div>
			<div id="filter-champ-wrap" style="display: none">
				<div id="filter-title-wrap">
					<div class="d-flex justify-content-between">
						<h5><strong>챔피언</strong></h5>
						<button type="button" class="btn-close" id="champ-wrap-close" aria-label="Close"></button>
					</div>
				</div>
				<div>
					<div>
						<input placeholder="챔피언을 검색하세요" class="form-control" type="text" id="champ-search">
					</div>
					<div id="champ-list">
					</div>
				</div>
			</div>
			</section> <!-- 탑 특화 챔피언 -->
			
			<section id="jg"> <!-- 정글 특화 챔피언 -->
				<div class="d-flex align-items-center">
					<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg">
					<h5><strong>&nbspJUNGLE&nbsp</strong></h5>
					<h5><strong>특화 챔피언</strong></h5>
				</div>
			<%-- <input type="text" class="form-control" id="jg_specializedChampion" name="jg_specialized_champion"
				value="${mentor_profile.jg_specialized_champion}"> --%>
			<div id="champ-selector-inner" class="d-flex align-items-center text-center justify-content-start">
				<div id="champ-selected-box" class="d-flex align-items-center">
					<div id="champ-info">
						<img src="" id="champ-icon" class="rounded">
						<span class="champ-name">특화 챔피언(정글)을 선택 해주세요</span>
					</div>
					<img style="width: 43px" src="/resources/img/icon/arrow-icon-down.png" class="arrow-icon">
				</div>
			</div>
			<div id="filter-champ-wrap" style="display: none">
				<div id="filter-title-wrap">
					<div class="d-flex justify-content-between">
						<h5><strong>챔피언</strong></h5>
						<button type="button" class="btn-close" id="champ-wrap-close" aria-label="Close"></button>
					</div>
				</div>
				<div>
					<div>
						<input placeholder="챔피언을 검색하세요" class="form-control" type="text" id="champ-search">
					</div>
					<div id="champ-list">
					</div>
				</div>
			</div>
			</section> <!-- 정글 특화 챔피언 -->
			
			<section id="mid"> <!-- 미드 특화 챔피언 -->
				<div class="d-flex align-items-center">
					<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg">
					<h5><strong>&nbspMID&nbsp</strong></h5>
					<h5><strong>특화 챔피언</strong></h5>
				</div>
			<%-- <input type="text" class="form-control" id="mid_specializedChampion" name="mid_specialized_champion"
				value="${mentor_profile.mid_specialized_champion}"> --%>
			<div id="champ-selector-inner" class="d-flex align-items-center text-center justify-content-start">
				<div id="champ-selected-box" class="d-flex align-items-center">
					<div id="champ-info">
						<img src="" id="champ-icon" class="rounded">
						<span class="champ-name">특화 챔피언(미드)을 선택 해주세요</span>
					</div>
					<img style="width: 43px" src="/resources/img/icon/arrow-icon-down.png" class="arrow-icon">
				</div>
			</div>
			<div id="filter-champ-wrap" style="display: none">
				<div id="filter-title-wrap">
					<div class="d-flex justify-content-between">
						<h5><strong>챔피언</strong></h5>
						<button type="button" class="btn-close" id="champ-wrap-close" aria-label="Close"></button>
					</div>
				</div>
				<div>
					<div>
						<input placeholder="챔피언을 검색하세요" class="form-control" type="text" id="champ-search">
					</div>
					<div id="champ-list">
					</div>
				</div>
			</div>
			</section> <!-- 미드 특화 챔피언 -->
			
			<section id="ad"> <!-- 원딜 특화 챔피언 -->
				<div class="d-flex align-items-center">
					<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg">
					<h5><strong>&nbspBOTTOM&nbsp</strong></h5>
					<h5><strong>특화 챔피언</strong></h5>
				</div>
			<%-- <input type="text" class="form-control" id="ad_specializedChampion" name="ad_specialized_champion"
				value="${mentor_profile.ad_specialized_champion}"> --%>
			<div id="champ-selector-inner" class="d-flex align-items-center text-center justify-content-start">
				<div id="champ-selected-box" class="d-flex align-items-center">
					<div id="champ-info">
						<img src="" id="champ-icon" class="rounded">
						<span class="champ-name">특화 챔피언(원딜)을 선택 해주세요</span>
					</div>
					<img style="width: 43px" src="/resources/img/icon/arrow-icon-down.png" class="arrow-icon">
				</div>
			</div>
			<div id="filter-champ-wrap" style="display: none">
				<div id="filter-title-wrap">
					<div class="d-flex justify-content-between">
						<h5><strong>챔피언</strong></h5>
						<button type="button" class="btn-close" id="champ-wrap-close" aria-label="Close"></button>
					</div>
				</div>
				<div>
					<div>
						<input placeholder="챔피언을 검색하세요" class="form-control" type="text" id="champ-search">
					</div>
					<div id="champ-list">
					</div>
				</div>
			</div>
			</section> <!-- 원딜 특화 챔피언 -->
			
			<section id="sup"> <!-- 서포터 특화 챔피언 -->
				<div class="d-flex align-items-center">
					<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg">
					<h5><strong>&nbspSUPPORT&nbsp</strong></h5>
					<h5><strong>특화 챔피언</strong></h5>
				</div>
			<%-- <input type="text" class="form-control" id="sup_specializedChampion" name="sup_specialized_champion"
				value="${mentor_profile.sup_specialized_champion}"> --%>
			<div id="champ-selector-inner" class="d-flex align-items-center text-center justify-content-start">
				<div id="champ-selected-box" class="d-flex align-items-center">
					<div id="champ-info">
						<img src="" id="champ-icon" class="rounded">
						<span class="champ-name">특화 챔피언(서포터)을 선택 해주세요</span>
					</div>
					<img style="width: 43px" src="/resources/img/icon/arrow-icon-down.png" class="arrow-icon">
				</div>
			</div>
			<div id="filter-champ-wrap" style="display: none">
				<div id="filter-title-wrap">
					<div class="d-flex justify-content-between">
						<h5><strong>챔피언</strong></h5>
						<button type="button" class="btn-close" id="champ-wrap-close" aria-label="Close"></button>
					</div>
				</div>
				<div>
					<div>
						<input placeholder="챔피언을 검색하세요" class="form-control" type="text" id="champ-search">
					</div>
					<div id="champ-list">
					</div>
				</div>
			</div>
			</section> <!-- 서포터 특화 챔피언 -->
				
			<section>
				<h5><strong>수업 가능 시간</strong></h5>
				<span>${mentor_profile.contact_time}</span>
				<div id="time-set" class="d-flex align-items-center justify-content-start">
					<select id="dropdown-input" class="form-control" onchange="selectValue(this)">
					  <option value="">선택</option>
					  <option value="매일">매일</option>
					  <option value="주말">주말</option>
					  <option value="평일">평일</option>
					</select>
					&nbsp&nbsp
					<input type="time" class="form-control" id="contactTimeFrom1" name="contact_time1" value="12:00">
					<h3>&nbsp~&nbsp</h3>
					<input type="time" class="form-control" id="contactTimeFrom2" name="contact_time2" value="16:00">
				</div>
			</section>
			
			<section>
				<h5><strong>이런 분들께 추천해요</strong></h5>
				<ul>
					<li>${mentor_profile.recom_ment}
				</ul>
				<div class="form-floating">
				  <textarea class="form-control" placeholder="Leave a comment here" id="recom_ment" style="height: 100px">${mentor_profile.recom_ment}</textarea>
				  <label for="recom_ment">소개 글을 작성해보세요</label>
				</div>
			</section>
			<div class="d-flex justify-content-center">
				<button type="button" style="margin:10px" class="btn btn-outline-success btn-lg" id="submit-btn" >프로필 저장</button>
			</div>
		</div><!-- home-tab -->
		
	<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
		<section>
			<h5><strong>태그 설정</strong></h5>
			<div id="tags-box">
			<span id="mentor-tags">
					<!-- 멘토 태그 -->
			</span>
			</div>
			
			<section id="tag-set" class="row border rounded">
			  <div class="col d-flex flex-wrap">
			    <c:forEach items="${tag_list}" var="tag_list">
			      <c:if test="${not empty tag_list.mentor_version}">
			        <div class="d-flex align-items-center">
			          <input type="checkbox" class="btn-check" id="${tag_list.tag_id}" name="selected_tags" value="${tag_list.tag_id}">
			          <label class="btn btn-outline-primary btn-sm" id="btn-check" for="${tag_list.tag_id}">${tag_list.mentor_version}</label>
			        </div>
			      </c:if>
			    </c:forEach>
			  </div>
			  <div style="padding:0" class="col-2 d-flex align-items-center justify-content-end">
			  	<button type="button" id="save_tag" style="height:65px" class="btn btn-success" onclick="deleteMentorTag()">태그 저장</button>
			  </div>
			</section>
		</section>
	</div><!-- tab2 -->
	
	<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
		<section>
			<div class="d-flex justify-content-between">
				<h5><strong>수업 내용</strong></h5>
				<button id="create-class" class="btn btn-dark btn-lg">신규 수업 등록</button>
			</div>
			<div id="mentor_class_info">
				<!-- 클래스 정보 -->
			</div>
		</section>
	</div><!-- tab3 -->	
	
	</div><!-- tab-content -->	
		
	</div><!-- container -->
	
	<!-- 수업 만들기 모달 -->
	<div class="modal fade" id="classModal" tabindex="-1" aria-labelledby="classModalLabel" aria-hidden="true" style="display: none;">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header d-flex">
	        <h5 class="modal-title" id="classModalLabel">새로운 클래스를 등록해 보세요</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form id="classForm" onsubmit="return classSubmitForm()">
		        <div class="mb-3">
		            <label for="classTitle" class="form-label">수업 이름</label>
		            <input type="text" class="form-control" id="classTitle" name="classTitle">
	          	</div>
	          	<div class="mb-3">
		            <label for="classPrice" class="form-label">가격</label>
		            <input type="text" class="form-control" id="classPrice" name="classPrice">
	          	</div>
	          <div class="mb-3">
	            <label for="classInfo" class="form-label">수업 내용</label>
	            <textarea class="form-control" id="classInfo" rows="5"></textarea>
	          </div>
	          <div class="modal-footer">
	            <button type="submit" class="btn btn-primary">전송</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
	get_mentor_tags(); //멘토 태그 가져오기
	laneImgChange();
	//평균 평점 계산
	let avg_grade = ${mentor_profile.total_grade/mentor_profile.num_of_reviews};
	let roundedGrade = avg_grade.toFixed(1);
	if(roundedGrade == "NaN"){
		roundedGrade=0;
	}
	$('#avg_grade').html('평점: '+roundedGrade);
	
	// 선택한 포지션 값을 저장할 배열
	let positions = [];
	
	// 이미 추가된 챔피언들의 ID 배열화
	let top_selectedChampions = [];
	let jg_selectedChampions = [];
	let mid_selectedChampions = [];
	let ad_selectedChampions = [];
	let sup_selectedChampions = [];
	try {
		top_selectedChampions = JSON.parse("${mentor_profile.top_specialized_champion}");
	} catch (error) {
		console.log("탑 챔피언이 없습니다")		
	}
	try {
		jg_selectedChampions = JSON.parse("${mentor_profile.jg_specialized_champion}");
	} catch (error) {
		console.log("정글 챔피언이 없습니다")		
	}
	try {
		mid_selectedChampions = JSON.parse("${mentor_profile.mid_specialized_champion}");
	} catch (error) {
		console.log("미드 챔피언이 없습니다")		
	}
	try {
		ad_selectedChampions = JSON.parse("${mentor_profile.ad_specialized_champion}");
	} catch (error) {
		console.log("원딜 챔피언이 없습니다")		
	}
	try {
		sup_selectedChampions = JSON.parse("${mentor_profile.sup_specialized_champion}");
	} catch (error) {
		console.log("서포터 챔피언이 없습니다")		
	}
	console.log(top_selectedChampions);
	console.log(jg_selectedChampions);
	console.log(mid_selectedChampions);
	console.log(ad_selectedChampions);
	console.log(sup_selectedChampions);
	
	let c_time = "${mentor_profile.contact_time}";
	console.log(c_time);
	let c1_time = c_time.split(" ")[0];
	let c2_time = c_time.split(" ")[1];
	let c3_time = c_time.split(" ")[3];
	$("#dropdown-input").val(c1_time);
	$("#contactTimeFrom1").val(c2_time);
	$("#contactTimeFrom2").val(c3_time);
	
	function selectValue(selectElement) {
	  let selectedValue = $(selectElement).val();
	  console.log(selectedValue);
	}
	
	$(document).ready(function () {
		
		$("#create-class").click(()=>{
			$("#classModal").modal("show");
		})
		
		$("#classPrice").on("input", function() {
		    // 입력 값 가져오기
		    let input = $(this).val();
		    // 양의 정수 유효성 검사
		    if (input !== "" && !(/^\d+$/.test(input))) {
		      // 양의 정수가 아닌 경우 입력 값을 초기화
		      $(this).val("");
		    }
		  });
		
		//////////////////////챔피언 검색/////////////////////////////////
		
		// 탑 챔피언 검색창 입력할 때마다 불러오기
		$("#top #champ-search").on("input", function() { 
			var searchText = $(this).val();
		      $.ajax({
		        url: "/mentor/get-champ-name-by-keyword",//키워드로 챔피언 찾기
		        type: "GET",
		        data: {
		        	keyword: searchText
		        },
		        success: function(data) {
		          $("#top #champ-list").text("");
		          let championList = JSON.parse(data);
			        championList.forEach(function (champion) {
			            let imageUrl =
			                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			                champion.champion_en_name + ".png?&amp;retry=0";
			            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
			            .attr("id","champ-item").click(function () {
			            	if(top_selectedChampions == null || top_selectedChampions == ""){
				                // 새로운 챔피언을 추가
					                top_selectedChampions.push(champion.champion_id);
					                
					                if ($("#top #champ-icon").attr("src")==""){
					                	$('#top #champ-info').remove();  
					                	
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#top .arrow-icon").before(championDiv);
						                
						                $("#top_specializedChampion").val(top_selectedChampions);
						                console.log("탑 챔피언: "+top_selectedChampions);
					                }else{
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#top .arrow-icon").before(championDiv);
							            $("#top_specializedChampion").val(top_selectedChampions);
							            console.log("탑 챔피언: "+top_selectedChampions);
					                }
				                }else if (top_selectedChampions.length >= 3){ //세명 골랐을때 
			            		// 이미 추가된 챔피언인지 검사
				                if (top_selectedChampions.includes(champion.champion_id)) {
				                	let index = top_selectedChampions.indexOf(champion.champion_id);
				                	top_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
				                	console.log("탑 챔피언: "+top_selectedChampions);
				                	$("#top_specializedChampion").val(top_selectedChampions);
				                	$('#top #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
				                }else{
			            		let delChampId = top_selectedChampions[0];
			            		top_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
			            		$("#top #champ-info[data='" + delChampId + "']").remove();
			            		top_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
			            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#top .arrow-icon").before(championDiv);
				                $("#top_specializedChampion").val(top_selectedChampions);
			            		console.log("탑 챔피언: "+top_selectedChampions);
			            		return;
				                }
			            	}
			                // 이미 추가된 챔피언인지 검사
			                else if (top_selectedChampions.includes(champion.champion_id)) {
			                	if (top_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
			                		let index = top_selectedChampions.indexOf(champion.champion_id);
			                		top_selectedChampions.splice(index, 1);
				                	console.log("탑 챔피언: "+top_selectedChampions);
				                	$("#top_specializedChampion").val(top_selectedChampions);
				                	$('#top #champ-info[data="' + champion.champion_id + '"]').remove(); 
			                		console.log('이미지가 비었습니다.');
			                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
						            let champName = $("<span>").text("특화 챔피언(탑)을 선택해주세요");
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#top .arrow-icon").before(championDiv);
			                		  return;
			                		}else{
			                			let index = top_selectedChampions.indexOf(champion.champion_id);
			                			top_selectedChampions.splice(index, 1);
					                	console.log("탑 챔피언: "+top_selectedChampions);
					                	$("#top_specializedChampion").val(top_selectedChampions);
					                	$('#top #champ-info[data="' + champion.champion_id + '"]').remove();
					                    return;
			                		}
			                }else{
			                // 새로운 챔피언을 추가
			                top_selectedChampions.push(champion.champion_id);
			                
			                if ($("#top #champ-icon").attr("src")==""){
			                	$('#top #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#top .arrow-icon").before(championDiv);
				                
				                $("#top_specializedChampion").val(top_selectedChampions);
				                console.log("탑 챔피언: "+top_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#top .arrow-icon").before(championDiv);
					            $("#top_specializedChampion").val(top_selectedChampions);
					            console.log("탑 챔피언: "+top_selectedChampions);
			                }
			                }
			            });
			            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
						let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						let champName = $("<div>").addClass("my-auto mx-2")
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
			            $("#top #champ-list").append(champItem);
			        });
			    },
			    error: function () {
			        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		          
		        }
		      });
		  });
		
		// 정글 챔피언 검색창 입력할 때마다 불러오기
		$("#jg #champ-search").on("input", function() { 
			var searchText = $(this).val();
		      $.ajax({
		        url: "/mentor/get-champ-name-by-keyword",//키워드로 챔피언 찾기
		        type: "GET",
		        data: {
		        	keyword: searchText
		        },
		        success: function(data) {
		          $("#jg #champ-list").text("");
		          let championList = JSON.parse(data);
			        championList.forEach(function (champion) {
			            let imageUrl =
			                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			                champion.champion_en_name + ".png?&amp;retry=0";
			            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
			            .attr("id","champ-item").click(function () {
			            	if(jg_selectedChampions == null || jg_selectedChampions == ""){
				                // 새로운 챔피언을 추가
					                jg_selectedChampions.push(champion.champion_id);
					                
					                if ($("#jg #champ-icon").attr("src")==""){
					                	$('#jg #champ-info').remove();  
					                	
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#jg .arrow-icon").before(championDiv);
						                
						                $("#jg_specializedChampion").val(jg_selectedChampions);
						                console.log("정글 챔피언: "+jg_selectedChampions);
					                }else{
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#jg .arrow-icon").before(championDiv);
							            $("#jg_specializedChampion").val(jg_selectedChampions);
							            console.log("정글 챔피언: "+jg_selectedChampions);
					                }
				                }else if (jg_selectedChampions.length >= 3){ //세명 골랐을때 
			            		// 이미 추가된 챔피언인지 검사
				                if (jg_selectedChampions.includes(champion.champion_id)) {
				                	let index = jg_selectedChampions.indexOf(champion.champion_id);
				                	jg_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
				                	console.log("정글 챔피언: "+jg_selectedChampions);
				                	$("#jg_specializedChampion").val(jg_selectedChampions);
				                	$('#jg #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
				                }else{
			            		let delChampId = jg_selectedChampions[0];
			            		jg_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
			            		$("#jg #champ-info[data='" + delChampId + "']").remove();
			            		jg_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
			            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
				                $("#jg_specializedChampion").val(jg_selectedChampions);
			            		console.log("정글 챔피언: "+jg_selectedChampions);
			            		return;
				                }
			            	}
			                // 이미 추가된 챔피언인지 검사
			                else if (jg_selectedChampions.includes(champion.champion_id)) {
			                	if (jg_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
			                		let index = jg_selectedChampions.indexOf(champion.champion_id);
			                		jg_selectedChampions.splice(index, 1);
				                	console.log("정글 챔피언: "+jg_selectedChampions);
				                	$("#jg_specializedChampion").val(jg_selectedChampions);
				                	$('#jg #champ-info[data="' + champion.champion_id + '"]').remove(); 
			                		console.log('이미지가 비었습니다.');
			                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
						            let champName = $("<span>").text("특화 챔피언(정글)을 선택해주세요");
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#jg .arrow-icon").before(championDiv);
			                		  return;
			                		}else{
			                			let index = jg_selectedChampions.indexOf(champion.champion_id);
			                			jg_selectedChampions.splice(index, 1);
					                	console.log("정글 챔피언: "+jg_selectedChampions);
					                	$("#jg_specializedChampion").val(jg_selectedChampions);
					                	$('#jg #champ-info[data="' + champion.champion_id + '"]').remove();
					                    return;
			                		}
			                }else{
			                // 새로운 챔피언을 추가
			                jg_selectedChampions.push(champion.champion_id);
			                
			                if ($("#jg #champ-icon").attr("src")==""){
			                	$('#jg #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
				                
				                $("#jg_specializedChampion").val(jg_selectedChampions);
				                console.log("정글 챔피언: "+jg_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
					            $("#jg_specializedChampion").val(jg_selectedChampions);
					            console.log("정글 챔피언: "+jg_selectedChampions);
			                }
			                }
			            });
			            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
						let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						let champName = $("<div>").addClass("my-auto mx-2")
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
			            $("#jg #champ-list").append(champItem);
			        });
			    },
			    error: function () {
			        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		          
		        }
		      });
		  });
		
		// 미드 챔피언 검색창 입력할 때마다 불러오기
		$("#mid #champ-search").on("input", function() { 
			var searchText = $(this).val();
		      $.ajax({
		        url: "/mentor/get-champ-name-by-keyword",//키워드로 챔피언 찾기
		        type: "GET",
		        data: {
		        	keyword: searchText
		        },
		        success: function(data) {
		          $("#mid #champ-list").text("");
		          let championList = JSON.parse(data);
			        championList.forEach(function (champion) {
			            let imageUrl =
			                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			                champion.champion_en_name + ".png?&amp;retry=0";
			            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
			            .attr("id","champ-item").click(function () {
			            	if(mid_selectedChampions == null || mid_selectedChampions == ""){
				                // 새로운 챔피언을 추가
					                mid_selectedChampions.push(champion.champion_id);
					                
					                if ($("#mid #champ-icon").attr("src")==""){
					                	$('#mid #champ-info').remove();  
					                	
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#mid .arrow-icon").before(championDiv);
						                
						                $("#mid_specializedChampion").val(mid_selectedChampions);
						                console.log("미드 챔피언: "+mid_selectedChampions);
					                }else{
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#mid .arrow-icon").before(championDiv);
							            $("#mid_specializedChampion").val(mid_selectedChampions);
							            console.log("미드 챔피언: "+mid_selectedChampions);
					                }
				                }else if (mid_selectedChampions.length >= 3){ //세명 골랐을때 
			            		// 이미 추가된 챔피언인지 검사
				                if (mid_selectedChampions.includes(champion.champion_id)) {
				                	let index = mid_selectedChampions.indexOf(champion.champion_id);
				                	mid_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
				                	console.log("미드 챔피언: "+mid_selectedChampions);
				                	$("#mid_specializedChampion").val(mid_selectedChampions);
				                	$('#mid #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
				                }else{
			            		let delChampId = mid_selectedChampions[0];
			            		mid_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
			            		$("#mid #champ-info[data='" + delChampId + "']").remove();
			            		mid_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
			            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#mid .arrow-icon").before(championDiv);
				                $("#mid_specializedChampion").val(mid_selectedChampions);
			            		console.log("미드 챔피언: "+mid_selectedChampions);
			            		return;
				                }
			            	}
			                // 이미 추가된 챔피언인지 검사
			                else if (mid_selectedChampions.includes(champion.champion_id)) {
			                	if (mid_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
			                		let index = mid_selectedChampions.indexOf(champion.champion_id);
			                		mid_selectedChampions.splice(index, 1);
				                	console.log("미드 챔피언: "+mid_selectedChampions);
				                	$("#mid_specializedChampion").val(mid_selectedChampions);
				                	$('#mid #champ-info[data="' + champion.champion_id + '"]').remove(); 
			                		console.log('이미지가 비었습니다.');
			                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
						            let champName = $("<span>").text("특화 챔피언(미드)을 선택해주세요");
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#mid .arrow-icon").before(championDiv);
			                		  return;
			                		}else{
			                			let index = mid_selectedChampions.indexOf(champion.champion_id);
			                			mid_selectedChampions.splice(index, 1);
					                	console.log("미드 챔피언: "+mid_selectedChampions);
					                	$("#mid_specializedChampion").val(mid_selectedChampions);
					                	$('#mid #champ-info[data="' + champion.champion_id + '"]').remove();
					                    return;
			                		}
			                }else{
			                // 새로운 챔피언을 추가
			                mid_selectedChampions.push(champion.champion_id);
			                
			                if ($("#mid #champ-icon").attr("src")==""){
			                	$('#mid #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#mid .arrow-icon").before(championDiv);
				                
				                $("#mid_specializedChampion").val(mid_selectedChampions);
				                console.log("미드 챔피언: "+mid_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#mid .arrow-icon").before(championDiv);
					            $("#mid_specializedChampion").val(mid_selectedChampions);
					            console.log("미드 챔피언: "+mid_selectedChampions);
			                }
			                }
			            });
			            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
						let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						let champName = $("<div>").addClass("my-auto mx-2")
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
			            $("#mid #champ-list").append(champItem);
			        });
			    },
			    error: function () {
			        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		          
		        }
		      });
		  });
		
		// 원딜 챔피언 검색창 입력할 때마다 불러오기
		$("#ad #champ-search").on("input", function() { 
			var searchText = $(this).val();
		      $.ajax({
		        url: "/mentor/get-champ-name-by-keyword",//키워드로 챔피언 찾기
		        type: "GET",
		        data: {
		        	keyword: searchText
		        },
		        success: function(data) {
		          $("#ad #champ-list").text("");
		          let championList = JSON.parse(data);
			        championList.forEach(function (champion) {
			            let imageUrl =
			                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			                champion.champion_en_name + ".png?&amp;retry=0";
			            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
			            .attr("id","champ-item").click(function () {
			            	if(ad_selectedChampions == null || ad_selectedChampions == ""){
				                // 새로운 챔피언을 추가
					                ad_selectedChampions.push(champion.champion_id);
					                
					                if ($("#ad #champ-icon").attr("src")==""){
					                	$('#ad #champ-info').remove();  
					                	
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#ad .arrow-icon").before(championDiv);
						                
						                $("#ad_specializedChampion").val(ad_selectedChampions);
						                console.log("원딜 챔피언: "+ad_selectedChampions);
					                }else{
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#ad .arrow-icon").before(championDiv);
							            $("#ad_specializedChampion").val(ad_selectedChampions);
							            console.log("원딜 챔피언: "+ad_selectedChampions);
					                }
				                }else if (ad_selectedChampions.length >= 3){ //세명 골랐을때 
			            		// 이미 추가된 챔피언인지 검사
				                if (ad_selectedChampions.includes(champion.champion_id)) {
				                	let index = ad_selectedChampions.indexOf(champion.champion_id);
				                	ad_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
				                	console.log("원딜 챔피언: "+ad_selectedChampions);
				                	$("#ad_specializedChampion").val(ad_selectedChampions);
				                	$('#ad #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
				                }else{
			            		let delChampId = ad_selectedChampions[0];
			            		ad_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
			            		$("#ad #champ-info[data='" + delChampId + "']").remove();
			            		ad_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
			            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#ad .arrow-icon").before(championDiv);
				                $("#ad_specializedChampion").val(ad_selectedChampions);
			            		console.log("원딜 챔피언: "+ad_selectedChampions);
			            		return;
				                }
			            	}
			                // 이미 추가된 챔피언인지 검사
			                else if (ad_selectedChampions.includes(champion.champion_id)) {
			                	if (ad_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
			                		let index = ad_selectedChampions.indexOf(champion.champion_id);
			                		ad_selectedChampions.splice(index, 1);
				                	console.log("원딜 챔피언: "+ad_selectedChampions);
				                	$("#ad_specializedChampion").val(ad_selectedChampions);
				                	$('#ad #champ-info[data="' + champion.champion_id + '"]').remove(); 
			                		console.log('이미지가 비었습니다.');
			                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
						            let champName = $("<span>").text("특화 챔피언(원딜)을 선택해주세요");
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#ad .arrow-icon").before(championDiv);
			                		  return;
			                		}else{
			                			let index = ad_selectedChampions.indexOf(champion.champion_id);
			                			ad_selectedChampions.splice(index, 1);
					                	console.log("원딜 챔피언: "+ad_selectedChampions);
					                	$("#ad_specializedChampion").val(ad_selectedChampions);
					                	$('#ad #champ-info[data="' + champion.champion_id + '"]').remove();
					                    return;
			                		}
			                }else{
			                // 새로운 챔피언을 추가
			                ad_selectedChampions.push(champion.champion_id);
			                
			                if ($("#ad #champ-icon").attr("src")==""){
			                	$('#ad #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#ad .arrow-icon").before(championDiv);
				                
				                $("#ad_specializedChampion").val(ad_selectedChampions);
				                console.log("원딜 챔피언: "+ad_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#ad .arrow-icon").before(championDiv);
					            $("#ad_specializedChampion").val(ad_selectedChampions);
					            console.log("원딜 챔피언: "+ad_selectedChampions);
			                }
			                }
			            });
			            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
						let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						let champName = $("<div>").addClass("my-auto mx-2")
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
			            $("#ad #champ-list").append(champItem);
			        });
			    },
			    error: function () {
			        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		          
		        }
		      });
		  });
		
		// 서포터 챔피언 검색창 입력할 때마다 불러오기
		$("#sup #champ-search").on("input", function() { 
			var searchText = $(this).val();
		      $.ajax({
		        url: "/mentor/get-champ-name-by-keyword",//키워드로 챔피언 찾기
		        type: "GET",
		        data: {
		        	keyword: searchText
		        },
		        success: function(data) {
		          $("#sup #champ-list").text("");
		          let championList = JSON.parse(data);
			        championList.forEach(function (champion) {
			            let imageUrl =
			                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			                champion.champion_en_name + ".png?&amp;retry=0";
			            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
			            .attr("id","champ-item").click(function () {
			            	if(sup_selectedChampions == null || sup_selectedChampions == ""){
				                // 새로운 챔피언을 추가
					                sup_selectedChampions.push(champion.champion_id);
					                
					                if ($("#sup #champ-icon").attr("src")==""){
					                	$('#sup #champ-info').remove();  
					                	
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#sup .arrow-icon").before(championDiv);
						                
						                $("#sup_specializedChampion").val(sup_selectedChampions);
						                console.log("서포터 챔피언: "+sup_selectedChampions);
					                }else{
					                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
							            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
							            let champName = $("<span>").text(champion.champion_kr_name);
							            championDiv.append(champImg);
							            championDiv.append(champName);
							            $("#sup .arrow-icon").before(championDiv);
							            $("#sup_specializedChampion").val(sup_selectedChampions);
							            console.log("서포터 챔피언: "+sup_selectedChampions);
					                }
				                }else if (sup_selectedChampions.length >= 3){ //세명 골랐을때 
			            		// 이미 추가된 챔피언인지 검사
				                if (sup_selectedChampions.includes(champion.champion_id)) {
				                	let index = sup_selectedChampions.indexOf(champion.champion_id);
				                	sup_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
				                	console.log("서포터 챔피언: "+sup_selectedChampions);
				                	$("#sup_specializedChampion").val(sup_selectedChampions);
				                	$('#sup #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
				                }else{
			            		let delChampId = sup_selectedChampions[0];
			            		sup_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
			            		$("#sup #champ-info[data='" + delChampId + "']").remove();
			            		sup_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
			            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#sup .arrow-icon").before(championDiv);
				                $("#sup_specializedChampion").val(sup_selectedChampions);
			            		console.log("서포터 챔피언: "+sup_selectedChampions);
			            		return;
				                }
			            	}
			                // 이미 추가된 챔피언인지 검사
			                else if (sup_selectedChampions.includes(champion.champion_id)) {
			                	if (sup_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
			                		let index = sup_selectedChampions.indexOf(champion.champion_id);
			                		sup_selectedChampions.splice(index, 1);
				                	console.log("서포터 챔피언: "+sup_selectedChampions);
				                	$("#sup_specializedChampion").val(sup_selectedChampions);
				                	$('#sup #champ-info[data="' + champion.champion_id + '"]').remove(); 
			                		console.log('이미지가 비었습니다.');
			                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
						            let champName = $("<span>").text("특화 챔피언(서포터)을 선택해주세요");
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#sup .arrow-icon").before(championDiv);
			                		  return;
			                		}else{
			                			let index = sup_selectedChampions.indexOf(champion.champion_id);
			                			sup_selectedChampions.splice(index, 1);
					                	console.log("서포터 챔피언: "+sup_selectedChampions);
					                	$("#sup_specializedChampion").val(sup_selectedChampions);
					                	$('#sup #champ-info[data="' + champion.champion_id + '"]').remove();
					                    return;
			                		}
			                }else{
			                // 새로운 챔피언을 추가
			                sup_selectedChampions.push(champion.champion_id);
			                
			                if ($("#sup #champ-icon").attr("src")==""){
			                	$('#sup #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#sup .arrow-icon").before(championDiv);
				                
				                $("#sup_specializedChampion").val(sup_selectedChampions);
				                console.log("서포터 챔피언: "+sup_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#sup .arrow-icon").before(championDiv);
					            $("#sup_specializedChampion").val(sup_selectedChampions);
					            console.log("서포터 챔피언: "+sup_selectedChampions);
			                }
			                }
			            });
			            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
						let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						let champName = $("<div>").addClass("my-auto mx-2")
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
			            $("#sup #champ-list").append(champItem);
			        });
			    },
			    error: function () {
			        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		          
		        }
		      });
		  });
		
		//////////////////////챔피언 검색/////////////////////////////////
		
		//저장된 특화 포지션 가져오기
		let spec_pos = [${mentor_profile.specialized_position}];
		$.each(spec_pos, function(i,pos){ 
			$.each(pos, function(j,lane){
			console.log(lane);
			if (lane=="탑"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/TOP.png")
				let posName = $("<strong>").text(lane);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (lane=="바텀"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/AD_CARRY.png")
				let posName = $("<strong>").text(lane);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (lane=="서포터"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/SUPPORT.png")
				let posName = $("<strong>").text(lane);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (lane=="정글"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/JUNGLE.png")
				let posName = $("<strong>").text(lane);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (lane=="미드"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/MID.png")
				let posName = $("<strong>").text(lane);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}
			})
		})
		
		displaySpecializedPosition(); //멘토 특화 포지션과 특화 챔피언을 인풋창에 출력
		select_by_email_class();
		
		//챔피언 검색창 펼치기/닫기
		$("#top #champ-selector-inner").click(function () {
			if ($(this).next().css('display') === 'none') {
				$(this).next().css('display', 'block');
			} else {
				$(this).next().css('display', 'none');
			}
		});
		$("#top #champ-wrap-close").click(function () {
			$("#top #filter-champ-wrap").css('display', 'none');
		});
		
		$("#jg #champ-selector-inner").click(function () {
			if ($(this).next().css('display') === 'none') {
				$(this).next().css('display', 'block');
			} else {
				$(this).next().css('display', 'none');
			}
		});
		$("#jg #champ-wrap-close").click(function () {
			$("#jg #filter-champ-wrap").css('display', 'none');
		});
		
		$("#mid #champ-selector-inner").click(function () {
			if ($(this).next().css('display') === 'none') {
				$(this).next().css('display', 'block');
			} else {
				$(this).next().css('display', 'none');
			}
		});
		$("#mid #champ-wrap-close").click(function () {
			$("#mid #filter-champ-wrap").css('display', 'none');
		});
		
		$("#ad #champ-selector-inner").click(function () {
			if ($(this).next().css('display') === 'none') {
				$(this).next().css('display', 'block');
			} else {
				$(this).next().css('display', 'none');
			}
		});
		$("#ad #champ-wrap-close").click(function () {
			$("#ad #filter-champ-wrap").css('display', 'none');
		});
		
		$("#sup #champ-selector-inner").click(function () {
			if ($(this).next().css('display') === 'none') {
				$(this).next().css('display', 'block');
			} else {
				$(this).next().css('display', 'none');
			}
		});
		$("#sup #champ-wrap-close").click(function () {
			$("#sup #filter-champ-wrap").css('display', 'none');
		});
		

		$.ajax({ //탑 챔피언 목록 가져오기
		    url: "/mentor/get-all-champ",
		    type: "GET",
		    success: function (data) {
		        let championList = JSON.parse(data);
		        championList.forEach(function (champion) {
		            let imageUrl =
		                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
		                champion.champion_en_name + ".png?&amp;retry=0";
		            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between").attr("id","champ-item").click(function () {
		            	if(top_selectedChampions == null || top_selectedChampions == ""){
			                // 새로운 챔피언을 추가
				                top_selectedChampions.push(champion.champion_id);
				                
				                if ($("#top #champ-icon").attr("src")==""){
				                	$('#top #champ-info').remove();  
				                	
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#top .arrow-icon").before(championDiv);
					                
					                $("#top_specializedChampion").val(top_selectedChampions);
					                console.log("탑 챔피언: "+top_selectedChampions);
				                }else{
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#top .arrow-icon").before(championDiv);
						            $("#top_specializedChampion").val(top_selectedChampions);
						            console.log("탑 챔피언: "+top_selectedChampions);
				                }
			                }else if (top_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (top_selectedChampions.includes(champion.champion_id)) {
			                	let index = top_selectedChampions.indexOf(champion.champion_id);
			                	top_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log("탑 챔피언: "+top_selectedChampions);
			                	$("#top_specializedChampion").val(top_selectedChampions);
			                	$('#top #champ-info[data="' + champion.champion_id + '"]').remove();
			                    return;
			                }else{
		            		let delChampId = top_selectedChampions[0];
		            		top_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
		            		$("#champ-info[data='" + delChampId + "']").remove();
		            		top_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
		            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#top .arrow-icon").before(championDiv);
			                $("#top_specializedChampion").val(top_selectedChampions);
		            		console.log("탑 챔피언: "+top_selectedChampions);
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (top_selectedChampions.includes(champion.champion_id)) {
		                	if (top_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = top_selectedChampions.indexOf(champion.champion_id);
		                		top_selectedChampions.splice(index, 1);
			                	console.log("탑 챔피언: "+top_selectedChampions);
			                	$("#top_specializedChampion").val(top_selectedChampions);
			                	$('#top #champ-info[data="' + champion.champion_id + '"]').remove(); 
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
					            let champName = $("<span>").text("특화 챔피언(탑)을 선택해주세요");
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#top .arrow-icon").before(championDiv);
		                		  return;
		                		}else{
		                			let index = top_selectedChampions.indexOf(champion.champion_id);
		                			top_selectedChampions.splice(index, 1);
				                	console.log("탑 챔피언: "+top_selectedChampions);
				                	$("#top_specializedChampion").val(top_selectedChampions);
				                	$('#top #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
		                top_selectedChampions.push(champion.champion_id);
		                
		                if ($("#top #champ-icon").attr("src")==""){
		                	$('#top #champ-info').remove();  
		                	
		                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#top .arrow-icon").before(championDiv);
			                
			                $("#top_specializedChampion").val(top_selectedChampions);
			                console.log("탑 챔피언: "+top_selectedChampions);
		                }else{
		                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#top .arrow-icon").before(championDiv);
				            $("#top_specializedChampion").val(top_selectedChampions);
				            console.log("탑 챔피언: "+top_selectedChampions);
		                }
		                }
		            });
		            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
					let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					let champName = $("<div>").addClass("my-auto mx-2")
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
		            $("#top #champ-list").append(champItem);
		        });
		    },
		    error: function () {
		        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		    }
		});
		
		$.ajax({ //정글 챔피언 목록 가져오기
		    url: "/mentor/get-all-champ",
		    type: "GET",
		    success: function (data) {
		        let championList = JSON.parse(data);
		        championList.forEach(function (champion) {
		            let imageUrl =
		                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
		                champion.champion_en_name + ".png?&amp;retry=0";
		            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between").attr("id","champ-item").click(function () {
		            	if(jg_selectedChampions == null || jg_selectedChampions == ""){ //챔피언을 고른적이 없을때
		            		
			                jg_selectedChampions.push(champion.champion_id);
			                
			                if ($("#jg #champ-icon").attr("src")==""){
			                	$('#jg #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
				                
				                $("#jg_specializedChampion").val(jg_selectedChampions);
				                console.log("정글 챔피언: "+jg_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
					            $("#jg_specializedChampion").val(jg_selectedChampions);
					            console.log("정글 챔피언: "+jg_selectedChampions);
			                }
		                }else if (jg_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (jg_selectedChampions.includes(champion.champion_id)) {
			                	let index = jg_selectedChampions.indexOf(champion.champion_id);
			                	jg_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log("정글 챔피언: "+jg_selectedChampions);
			                	$("#jg_specializedChampion").val(jg_selectedChampions);
			                	$('#jg #champ-info[data="' + champion.champion_id + '"]').remove();
			                    return;
			                }else{
		            		let delChampId = jg_selectedChampions[0];
		            		jg_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
		            		$("#jg #champ-info[data='" + delChampId + "']").remove();
		            		jg_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
		            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#jg .arrow-icon").before(championDiv);
			                $("#jg_specializedChampion").val(jg_selectedChampions);
		            		console.log("정글 챔피언: "+jg_selectedChampions);
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (jg_selectedChampions.includes(champion.champion_id)) {
		                	if (jg_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = jg_selectedChampions.indexOf(champion.champion_id);
		                		jg_selectedChampions.splice(index, 1);
			                	console.log("정글 챔피언: "+jg_selectedChampions);
			                	$("#jg_specializedChampion").val(jg_selectedChampions);
			                	$('#jg #champ-info[data="' + champion.champion_id + '"]').remove(); 
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
					            let champName = $("<span>").text("특화 챔피언(정글)을 선택해주세요");
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
		                		  return;
		                		}else{
		                			let index = jg_selectedChampions.indexOf(champion.champion_id);
		                			jg_selectedChampions.splice(index, 1);
				                	console.log("정글 챔피언: "+jg_selectedChampions);
				                	$("#jg_specializedChampion").val(jg_selectedChampions);
				                	$('#jg #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
			                jg_selectedChampions.push(champion.champion_id);
			                
			                if ($("#jg #champ-icon").attr("src")==""){
			                	$('#jg #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
				                
				                $("#jg_specializedChampion").val(jg_selectedChampions);
				                console.log("정글 챔피언: "+jg_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#jg .arrow-icon").before(championDiv);
					            $("#jg_specializedChampion").val(jg_selectedChampions);
					            console.log("정글 챔피언: "+jg_selectedChampions);
			                }
		                }
		            });
		            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
					let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					let champName = $("<div>").addClass("my-auto mx-2")
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
		            $("#jg #champ-list").append(champItem);
		        });
		    },
		    error: function () {
		        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		    }
		});
		
		$.ajax({ //미드 챔피언 목록 가져오기
		    url: "/mentor/get-all-champ",
		    type: "GET",
		    success: function (data) {
		        let championList = JSON.parse(data);
		        championList.forEach(function (champion) {
		            let imageUrl =
		                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
		                champion.champion_en_name + ".png?&amp;retry=0";
		            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
		            	.attr("id","champ-item").click(function () {
		            	if(mid_selectedChampions == null || mid_selectedChampions == ""){ //챔피언을 고른적이 없을때
		            		
				                mid_selectedChampions.push(champion.champion_id);
				                
				                if ($("#mid #champ-icon").attr("src")==""){
				                	$('#mid #champ-info').remove();  
				                	
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#mid .arrow-icon").before(championDiv);
					                
					                $("#mid_specializedChampion").val(mid_selectedChampions);
					                console.log("미드 챔피언: "+mid_selectedChampions);
				                }else{
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#mid .arrow-icon").before(championDiv);
						            $("#mid_specializedChampion").val(mid_selectedChampions);
						            console.log("미드 챔피언: "+mid_selectedChampions);
				                }
			                }else if (mid_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (mid_selectedChampions.includes(champion.champion_id)) {
			                	let index = mid_selectedChampions.indexOf(champion.champion_id);
			                	mid_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log("미드 챔피언: "+mid_selectedChampions);
			                	$("#mid_specializedChampion").val(mid_selectedChampions);
			                	$('#mid #champ-info[data="' + champion.champion_id + '"]').remove();
			                    return;
			                }else{
		            		let delChampId = mid_selectedChampions[0];
		            		mid_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
		            		$("#mid #champ-info[data='" + delChampId + "']").remove();
		            		mid_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
		            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#mid .arrow-icon").before(championDiv);
			                $("#mid_specializedChampion").val(mid_selectedChampions);
		            		console.log("미드 챔피언: "+mid_selectedChampions);
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (mid_selectedChampions.includes(champion.champion_id)) {
		                	if (mid_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = mid_selectedChampions.indexOf(champion.champion_id);
		                		mid_selectedChampions.splice(index, 1);
			                	console.log("미드 챔피언: "+mid_selectedChampions);
			                	$("#mid_specializedChampion").val(mid_selectedChampions);
			                	$('#mid #champ-info[data="' + champion.champion_id + '"]').remove(); 
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
					            let champName = $("<span>").text("특화 챔피언(미드)을 선택해주세요");
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#mid .arrow-icon").before(championDiv);
		                		  return;
		                		}else{
		                			let index = mid_selectedChampions.indexOf(champion.champion_id);
		                			mid_selectedChampions.splice(index, 1);
				                	console.log("미드 챔피언: "+mid_selectedChampions);
				                	$("#mid_specializedChampion").val(mid_selectedChampions);
				                	$('#mid #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
			                mid_selectedChampions.push(champion.champion_id);
			                
			                if ($("#mid #champ-icon").attr("src")==""){
			                	$('#mid #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#mid .arrow-icon").before(championDiv);
				                
				                $("#mid_specializedChampion").val(mid_selectedChampions);
				                console.log("미드 챔피언: "+mid_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#mid .arrow-icon").before(championDiv);
					            $("#mid_specializedChampion").val(mid_selectedChampions);
					            console.log("미드 챔피언: "+mid_selectedChampions);
			                }
		                }
		            });
		            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
					let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					let champName = $("<div>").addClass("my-auto mx-2")
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
		            $("#mid #champ-list").append(champItem);
		        });
		    },
		    error: function () {
		        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		    }
		});
		
		$.ajax({ //원딜 챔피언 목록 가져오기
		    url: "/mentor/get-all-champ",
		    type: "GET",
		    success: function (data) {
		        let championList = JSON.parse(data);
		        championList.forEach(function (champion) {
		            let imageUrl =
		                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
		                champion.champion_en_name + ".png?&amp;retry=0";
		            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
		            	.attr("id","champ-item").click(function () {
		            	if(ad_selectedChampions == null || ad_selectedChampions == ""){ //챔피언을 고른적이 없을때
		            		
				                ad_selectedChampions.push(champion.champion_id);
				                
				                if ($("#ad #champ-icon").attr("src")==""){
				                	$('#ad #champ-info').remove();  
				                	
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#ad .arrow-icon").before(championDiv);
					                
					                $("#ad_specializedChampion").val(ad_selectedChampions);
					                console.log("원딜 챔피언: "+ad_selectedChampions);
				                }else{
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#ad .arrow-icon").before(championDiv);
						            $("#ad_specializedChampion").val(ad_selectedChampions);
						            console.log("원딜 챔피언: "+ad_selectedChampions);
				                }
			                }else if (ad_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (ad_selectedChampions.includes(champion.champion_id)) {
			                	let index = ad_selectedChampions.indexOf(champion.champion_id);
			                	ad_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log("원딜 챔피언: "+ad_selectedChampions);
			                	$("#ad_specializedChampion").val(ad_selectedChampions);
			                	$('#ad #champ-info[data="' + champion.champion_id + '"]').remove();
			                    return;
			                }else{
		            		let delChampId = ad_selectedChampions[0];
		            		ad_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
		            		$("#ad #champ-info[data='" + delChampId + "']").remove();
		            		ad_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
		            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#ad .arrow-icon").before(championDiv);
			                $("#ad_specializedChampion").val(ad_selectedChampions);
		            		console.log("원딜 챔피언: "+ad_selectedChampions);
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (ad_selectedChampions.includes(champion.champion_id)) {
		                	if (ad_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = ad_selectedChampions.indexOf(champion.champion_id);
		                		ad_selectedChampions.splice(index, 1);
			                	console.log("원딜 챔피언: "+ad_selectedChampions);
			                	$("#ad_specializedChampion").val(ad_selectedChampions);
			                	$('#ad #champ-info[data="' + champion.champion_id + '"]').remove(); 
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
					            let champName = $("<span>").text("특화 챔피언(원딜)을 선택해주세요");
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#ad .arrow-icon").before(championDiv);
		                		  return;
		                		}else{
		                			let index = ad_selectedChampions.indexOf(champion.champion_id);
		                			ad_selectedChampions.splice(index, 1);
				                	console.log("원딜 챔피언: "+ad_selectedChampions);
				                	$("#ad_specializedChampion").val(ad_selectedChampions);
				                	$('#ad #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
			                ad_selectedChampions.push(champion.champion_id);
			                
			                if ($("#ad #champ-icon").attr("src")==""){
			                	$('#ad #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#ad .arrow-icon").before(championDiv);
				                
				                $("#ad_specializedChampion").val(ad_selectedChampions);
				                console.log("원딜 챔피언: "+ad_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#ad .arrow-icon").before(championDiv);
					            $("#ad_specializedChampion").val(ad_selectedChampions);
					            console.log("원딜 챔피언: "+ad_selectedChampions);
			                }
		                }
		            });
		            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
					let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					let champName = $("<div>").addClass("my-auto mx-2")
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
		            $("#ad #champ-list").append(champItem);
		        });
		    },
		    error: function () {
		        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		    }
		});
		
		$.ajax({ //서포터 챔피언 목록 가져오기
		    url: "/mentor/get-all-champ",
		    type: "GET",
		    success: function (data) {
		        let championList = JSON.parse(data);
		        championList.forEach(function (champion) {
		            let imageUrl =
		                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
		                champion.champion_en_name + ".png?&amp;retry=0";
		            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between")
		            	.attr("id","champ-item").click(function () {
		            	if(sup_selectedChampions == null || sup_selectedChampions == ""){ //챔피언을 고른적이 없을때
		            		
				                sup_selectedChampions.push(champion.champion_id);
				                
				                if ($("#sup #champ-icon").attr("src")==""){
				                	$('#sup #champ-info').remove();  
				                	
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#sup .arrow-icon").before(championDiv);
					                
					                $("#sup_specializedChampion").val(sup_selectedChampions);
					                console.log("서포터 챔피언: "+sup_selectedChampions);
				                }else{
				                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
						            let champName = $("<span>").text(champion.champion_kr_name);
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $("#sup .arrow-icon").before(championDiv);
						            $("#sup_specializedChampion").val(sup_selectedChampions);
						            console.log("서포터 챔피언: "+sup_selectedChampions);
				                }
			                }else if (sup_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (sup_selectedChampions.includes(champion.champion_id)) {
			                	let index = sup_selectedChampions.indexOf(champion.champion_id);
			                	sup_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log("서포터 챔피언: "+sup_selectedChampions);
			                	$("#sup_specializedChampion").val(sup_selectedChampions);
			                	$('#sup #champ-info[data="' + champion.champion_id + '"]').remove();
			                    return;
			                }else{
		            		let delChampId = sup_selectedChampions[0];
		            		sup_selectedChampions.shift(); //가장 앞에 있는 챔피언 삭제
		            		$("#sup #champ-info[data='" + delChampId + "']").remove();
		            		sup_selectedChampions.push(champion.champion_id); //클릭한 챔피언 추가
		            		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $("#sup .arrow-icon").before(championDiv);
			                $("#sup_specializedChampion").val(sup_selectedChampions);
		            		console.log("서포터 챔피언: "+sup_selectedChampions);
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (sup_selectedChampions.includes(champion.champion_id)) {
		                	if (sup_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = sup_selectedChampions.indexOf(champion.champion_id);
		                		sup_selectedChampions.splice(index, 1);
			                	console.log("서포터 챔피언: "+sup_selectedChampions);
			                	$("#sup_specializedChampion").val(sup_selectedChampions);
			                	$('#sup #champ-info[data="' + champion.champion_id + '"]').remove(); 
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
					            let champName = $("<span>").text("특화 챔피언(서포터)을 선택해주세요");
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#sup .arrow-icon").before(championDiv);
		                		  return;
		                		}else{
		                			let index = sup_selectedChampions.indexOf(champion.champion_id);
		                			sup_selectedChampions.splice(index, 1);
				                	console.log("서포터 챔피언: "+sup_selectedChampions);
				                	$("#sup_specializedChampion").val(sup_selectedChampions);
				                	$('#sup #champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
			                sup_selectedChampions.push(champion.champion_id);
			                
			                if ($("#sup #champ-icon").attr("src")==""){
			                	$('#sup #champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#sup .arrow-icon").before(championDiv);
				                
				                $("#sup_specializedChampion").val(sup_selectedChampions);
				                console.log("서포터 챔피언: "+sup_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $("#sup .arrow-icon").before(championDiv);
					            $("#sup_specializedChampion").val(sup_selectedChampions);
					            console.log("서포터 챔피언: "+sup_selectedChampions);
			                }
		                }
		            });
		            let championDiv = $("<div>").addClass("d-flex my-auto").attr("id", "champion");
					let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					let champName = $("<div>").addClass("my-auto mx-2")
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
		            $("#sup #champ-list").append(champItem);
		        });
		    },
		    error: function () {
		        console.error("챔피언 정보를 불러오는데 실패했습니다.");
		    }
		});
		//챔피언 목록 불러오기
		////////////////////////////////////////////////////////

		$(".position-buttons button").click(function () {
			  $(this).toggleClass("selected");
			  // 현재 선택된 버튼들을 찾아서 positions 배열에 추가 또는 삭제
			  positions = [];
			  $(".position-buttons button.selected").each(function () {
			    const position = $(this).text();
			    if (position !== "") {  // 빈 문자열이 아닌 경우에만 추가
			      positions.push(position);
			    	console.log(positions)
			    }
			  });
			  // 선택된 버튼이 두 개 이상인 경우, 나머지 버튼들은 선택 해제
			  if (positions.length >= 2) {
			    $(".position-buttons button:not(.selected)").prop("disabled", true);
			  } else {
			    $(".position-buttons button:not(.selected)").prop("disabled", false);
			  }
			  
			  laneImgChange();
			
			});
		
		

		//포지션 버튼 마우스오버 시
		$(".position-buttons button").hover(function () {
			$(this).addClass("mouse-over");
		}, function () {
			$(this).removeClass("mouse-over");
		});
		
		
		//프로필 작성 버튼 클릭시
		$("#submit-btn").click(function(e){
			e.preventDefault();
			submitForm();
		});

		function submitForm() {
			  let time0 = $('#dropdown-input').val();
			  let time1 = $('#contactTimeFrom1').val();
			  let time2 = $('#contactTimeFrom2').val();
			  let top_champ = JSON.stringify(top_selectedChampions);
			  let jg_champ = JSON.stringify(jg_selectedChampions);
			  let mid_champ = JSON.stringify(mid_selectedChampions);
			  let ad_champ = JSON.stringify(ad_selectedChampions);
			  let sup_champ = JSON.stringify(sup_selectedChampions);
			  
			  if(top_champ == "[]"){
				  top_champ = null;
			  }if(jg_champ == "[]"){
				  jg_champ = null;
			  }if(mid_champ == "[]"){
				  mid_champ = null;
			  }if(ad_champ == "[]"){
				  ad_champ = null;
			  }if(sup_champ == "[]"){
				  sup_champ = null;
			  }
			  
			  $.ajax({
			    url: '/mentor/edit-profile/',
			    type: 'PUT',
			    contentType: 'application/json;charset=UTF-8',
			    data: JSON.stringify({
			      mentor_email: '${email}',
			      about_mentor: $('#about_mentor').val(),
			      specialized_position: JSON.stringify(positions),
			      top_specialized_champion: top_champ,
			      jg_specialized_champion: jg_champ,
			      mid_specialized_champion: mid_champ,
			      ad_specialized_champion: ad_champ,
			      sup_specialized_champion: sup_champ,
			      contact_time: time0 + " " + time1 + " ~ " + time2,
			      careers: $('#careers').val(),
			      recom_ment: $('#recom_ment').val()
			    }),
			    success: function(data) {
			    	alert("프로필 작성 성공");
			    	location.reload();
			      },
			      error: function(error) {
			          console.log(error);
			      }
			  });
			  return false;
			}
		
		 //수업 삭제하기
		function deleteClass(class_id) {
			  $.ajax({
			    url: "/mentor/delete-mentor-class/",
			    type: "DELETE",
			    contentType: "application/json;charset=UTF-8",
			    data: class_id,
			    success: function() {
			      select_by_email_class();
			      alert("클래스 삭제 성공");
			    },
			    error: function() {
			      console.error("멘토 클래스 삭제 실패");
			    }
			  });
			}
		
		$(document).on("click", "#deleteButton", function(){
		    // 버튼 클릭시 실행할 함수
		    const class_id = $(this).attr('data');
		    deleteClass(class_id);
		});

	});//ready
	
	// 이미지 경로 업데이트 및 선택 해제 시 원래 이미지로 복원
	function laneImgChange(){
	  $(".position-buttons button").each(function() {
	    const position = $(this).text();
	    if (position === "탑") {
	      const imageUrl = "https://online.gamecoach.pro/img/icon/lol/ico_lol_top.svg" ;
	      if ($(this).hasClass("selected")) {
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
		      if ($(this).hasClass("selected")) {
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
		      if ($(this).hasClass("selected")) {
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
		      if ($(this).hasClass("selected")) {
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
		      if ($(this).hasClass("selected")) {
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
	

	//멘토 프로필 가져오기
	function displaySpecializedPosition() {
		  $.ajax({
		    url: '/mentor/get-mentor-profile',
		    type: 'POST',
		    contentType: 'application/json;charset=UTF-8',
		    data: JSON.stringify({ mentor_email: '${member.email}' }),
		    success: function(data) {
		      let sp = JSON.parse(data);
		      let mpsp = JSON.parse(sp.specialized_position);
		      positions = mpsp;
		      if (mpsp !== null && mpsp !== '') {
		        if (mpsp.length === 2) {
		          $('#specializedPosition').val(mpsp[0] + ' / ' + mpsp[1]);
		          $("button[name='" + mpsp[0] + "']").toggleClass("selected");
		          $("button[name='" + mpsp[1] + "']").toggleClass("selected");
		          $(".position-buttons button:not(.selected)").prop("disabled", true);
		          laneImgChange();
		        } else {
		          $('#specializedPosition').val(mpsp[0]);
		          $("button[name='" + mpsp[0] + "']").toggleClass("selected");
		          laneImgChange();
		        }
		      }
		      if (sp.top_specialized_champion != null && sp.top_specialized_champion != '') {
		        $('#top #champ-info').remove();
		        topLoadChampionInfo();
		      }
		      if (sp.jg_specialized_champion != null && sp.jg_specialized_champion != '') {
		        $('#jg #champ-info').remove();
		        jgLoadChampionInfo();
		      }
		      if (sp.mid_specialized_champion != null && sp.mid_specialized_champion != '') {
		        $('#mid #champ-info').remove();
		        midLoadChampionInfo();
		      }
		      if (sp.ad_specialized_champion != null && sp.ad_specialized_champion != '') {
		        $('#ad #champ-info').remove();
		        adLoadChampionInfo();
		      }
		      if (sp.sup_specialized_champion != null && sp.sup_specialized_champion != '') {
		        $('#sup #champ-info').remove();
		        supLoadChampionInfo();
		      }
		    },
		    error: function(xhr, status, error) {
		      console.log(error);
		    }
		  });
		}
		
		//동기처리 탑 챔피언
		async function topLoadChampionInfo() {
		  for (let i = 0; i < top_selectedChampions.length; i++) {
		    try {
		      await getChampionInfo(top_selectedChampions[i],"#top");
		    } catch (error) {
		      console.error("챔피언 정보 로드 중 오류:", error);
		    }
		  }
		}
		//동기처리 정글 챔피언
		async function jgLoadChampionInfo() {
		  for (let i = 0; i < jg_selectedChampions.length; i++) {
		    try {
		      await getChampionInfo(jg_selectedChampions[i],"#jg");
		    } catch (error) {
		      console.error("챔피언 정보 로드 중 오류:", error);
		    }
		  }
		}
		//동기처리 미드 챔피언
		async function midLoadChampionInfo() {
		  for (let i = 0; i < mid_selectedChampions.length; i++) {
		    try {
		      await getChampionInfo(mid_selectedChampions[i],"#mid");
		    } catch (error) {
		      console.error("챔피언 정보 로드 중 오류:", error);
		    }
		  }
		}
		//동기처리 원딜 챔피언
		async function adLoadChampionInfo() {
		  for (let i = 0; i < ad_selectedChampions.length; i++) {
		    try {
		      await getChampionInfo(ad_selectedChampions[i],"#ad");
		    } catch (error) {
		      console.error("챔피언 정보 로드 중 오류:", error);
		    }
		  }
		}
		//동기처리 서포터 챔피언
		async function supLoadChampionInfo() {
		  for (let i = 0; i < sup_selectedChampions.length; i++) {
		    try {
		      await getChampionInfo(sup_selectedChampions[i],"#sup");
		    } catch (error) {
		      console.error("챔피언 정보 로드 중 오류:", error);
		    }
		  }
		}
		
		//선택된 챔피언 가져오기
		function getChampionInfo(championId, targetSelector) {
			  return new Promise(function(resolve, reject) {
			    $.ajax({
			      url: "/mentor/get-champ-name-by-id?id=" + championId,
			      type: "GET",
			      success: function(data) {
			        let champion_data = JSON.parse(data);
			        let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion_data.champion_id);
			        let champImg = $("<img>").attr("id", "champ-icon").addClass("rounded")
			          .attr("src", "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			            champion_data.champion_en_name + ".png?&amp;retry=0");
			        let champName = $("<span>").text(champion_data.champion_kr_name);
			        championDiv.append(champImg);
			        championDiv.append(champName);
			        $(targetSelector +" .arrow-icon").before(championDiv);

			        resolve(); // 성공적으로 완료되었음을 알림
			      },
			      error: function(xhr, status, error) {
			        reject(error); // 오류 발생시 reject를 호출하여 오류를 알림
			      }
			    });
			  });
			}
	
	//멘토 태그 가져오기
	function get_mentor_tags(){
			$.ajax({ 
		        type: "POST",
		        url: "/mentor/get-mentor-tag",
		        data: JSON.stringify({"mentor_email": "${mentor_profile.mentor_email}"}),
		        contentType: "application/json; charset=utf-8",
		        dataType: "json",
		        success: function(response) {
		            const mentorTags = $("#mentor-tags");
		            $.each(response, function(i,tag){
		            	mentorTags.append($("<button>").addClass("btn btn-outline-primary")
		            			.css('margin', "3px")
		            			.prop('disabled', true)
		            			.text(tag.mentor_version));
		            })
		        },
		        error: function(error) {
		            console.error(error);
		            // 오류 처리 로직
		        }
		    })
		}
	
	function deleteClass(class_id) {
		  $.ajax({
		    url: "/mentor/delete-mentor-class/",
		    type: "DELETE",
		    contentType: "application/json;charset=UTF-8",
		    data: class_id,
		    success: function() {
		      select_by_email_class();
		      alert("클래스 삭제 성공");
		    },
		    error: function() {
		      console.error("멘토 클래스 삭제 실패");
		    }
		  });
		}
	
	//클래스 작성 기능
	function classSubmitForm() {
	    event.preventDefault();
	    let form_data = {
	    	mentor_email: "${mentor_profile.mentor_email}",
    		class_name: $("#classTitle").val(),
    		class_info: $("#classInfo").val(),
    		price: $("#classPrice").val()
	    };
	    console.log(form_data);
	    $.ajax({ 
	      type: "POST",
	      url: "/mentor/insert-mentor-class/",
	      data: JSON.stringify(form_data),
	      contentType: "application/json; charset=utf-8",
	      success: function(data) {
	    	  alert("클래스가 추가되었습니다.");
	        $("#classModal").modal("hide");
	        select_by_email_class();
	      },
	      error: function(xhr, status, error) {
	    	  alert("클래스 추가에 실패했습니다.");
	        console.error(xhr.responseText);
	        console.error(status);
	        console.error(error);
	      }
	    });
	  };
  
	function submitTagForm(tagList) {
		  let jsonData = JSON.stringify(tagList);
		  $.ajax({
		    url: "/mentor/edit-mentor-tag/",
		    type: "PUT",
		    contentType: "application/json;charset=UTF-8",
		    data: jsonData,
		    success: function () {
		    	alert("멘토 태그가 저장되었습니다.");
		    	$("#mentor-tags").text("");
		    	get_mentor_tags();
		    },
		    error: function () {
		    	alert("멘토 태그 저장에 실패했습니다.");
		    }
		  });
		  return false;
		}


	function deleteMentorTag() {
		  let mentorEmail = "${mentor_profile.mentor_email}";
		  $.ajax({
		    url: "/mentor/delete-mentor-tag",
		    type: "DELETE",
		    contentType: "application/json;charset=UTF-8",
		    data: mentorEmail,
		    success: function () {
		      let checkboxes = $("input[name='selected_tags']");
		      let tagList = [];
		      for (let i = 0; i < checkboxes.length; i++) {
		        if (checkboxes[i].checked) {
		          let tag = checkboxes[i].value;
		          let data = {
		            mentor_email: "${mentor_profile.mentor_email}",
		            tag_id: tag,
		          };
		          tagList.push(data);
		        }
		      }
		      submitTagForm(tagList); // 태그 저장 함수 호출
		    },
		    error: function () {
		    	alert("멘토 태그 저장에 실패했습니다.");
		    }
		  });
		}
	
	function select_by_email_class() { //멘토 클래스 가져오기
		  const lol_account = "${member.lol_account}";
		  $.ajax({
			url: "/mentor/select-mentor-class?lol_account=" + lol_account,
		    type: "GET",
		    contentType: "application/json;charset=UTF-8",
		    success: function (class_list) {
		    let classList = JSON.parse(class_list);
		      handleClassList(classList);
		    },
		    error: function (xhr, status, error) {
		      console.log(error);
		    },
		  });
		}

	
	function handleClassList(classList) { //생성된 클래스 html div에 주입
		  const $mentorClassInfo = $("#mentor_class_info");
		  $mentorClassInfo.empty();

		  classList.forEach((mentorClass) => {
		    const classHtml = createClassHtml(mentorClass);
		    $mentorClassInfo.append(classHtml);
		  });
		}

	function createClassHtml(mentorClass) { //멘토 클래스 html 생성
	  const { class_name, class_id, price, class_info } = mentorClass;

	  const $container = $("<div>").attr("id", "container-by-class")
	  					.css("padding","24px").css("margin","10px 0").addClass("border rounded");
	  const $classInfo = $("<div>").addClass("d-flex justify-content-between");
	  const $classTitle = $("<h5>").append($("<strong>").text(class_name));
	  const $deleteButton = $("<button>").addClass("btn btn-outline-danger btn-sm")
	    .attr("id","deleteButton")
	    .attr("data", class_id)
	    .text("삭제");
	  const $classPrice = $("<div>").css("margin","10px 0").html("<span>"  + price.toLocaleString()+ " P" + "</span>");
	  const $classDescription = $("<ul>").html("<li>" + class_info + "</li>");

	  $classInfo.append($classTitle, $deleteButton);
	  $container.append($classInfo, $classPrice, $classDescription);

	  return $container;
	}


	

    </script>
</body>
</html>
