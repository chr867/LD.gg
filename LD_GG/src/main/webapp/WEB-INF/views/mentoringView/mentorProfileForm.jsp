<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>멘토 프로필 작성</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.position-buttons button.selected {
  background-color: yellow;
  color: black;
}
.position-buttons button{
	width:100px;
	height:70px;
}
section{
  padding:24px;
  border-bottom: 1px solid #dee2e6;
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
padding:24px;
}
#champ-item{
padding: 10px 0;
}
#champ-item:hover{
background-color: white;
cursor: pointer;
}
#champ-list{
padding: 8px;
height: 370px;
margin: 10px 0;
border: 1px solid #dee2e6;
border-radius: 5px;
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
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}
#champ-selector-inner{
margin:18px 0;
}

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
	<div class="container">
	
		<section id="profile-box" class="row border rounded">
			<div class="col-2" id="mentor-img">
				<img style="width: 128px" class="rounded" src="http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/${mentor_profile.profile_icon_id}.png">
			</div>
			<div class="col" id="mentor-intro">
				<div id= "mentor-name" class="row">
					<span class='col'><span class="h3"><strong>${mentor_profile.lol_account}</strong></span><em>&nbsp멘토님</em></span>
				</div>
				<div id="mentor-stat" class="row">
					<div id="mentor-spec" class="col-10">
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
		
		<section>
			<h5><strong>멘토 소개</strong></h5>
			<span>${mentor_profile.about_mentor}</span>
			<div class="form-floating">
			  <textarea class="form-control" placeholder="Leave a comment here" id="about_mentor" style="height: 100px">${mentor_profile.about_mentor}</textarea>
			  <label for="about_mentor">소개 글을 작성해보세요</label>
			</div>
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
			
		<section>
			<div class="d-flex align-items-center">
				<img src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg">
				<span>
					<strong>TOP</strong>
				</span>
				<span>
					<strong>특화 챔피언</strong>
				</span>
			</div>
		<input type="text" id="top_specializedChampion" name="top_specialized_champion"
			value="${mentor_profile.top_specialized_champion}">
			
		<div id="champ-selector-inner" class="d-flex align-items-center text-center">
				<div id="champ-info">
					<img src="" id="champ-icon" class="rounded">
					<span class="champ-name">특화 챔피언(탑)을 선택 해주세요</span>
				</div>
			<img src="https://online.gamecoach.pro/img/icon/icon-arrow-down-grey.svg" class="arrow-icon">
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
		</section>
			
		<section>
			<h5><strong>수업 가능 시간</strong></h5>
			<span>${mentor_profile.contact_time}</span>
			<select id="dropdown-input" onchange="selectValue(this)">
			  <option value="">선택</option>
			  <option value="매일">매일</option>
			  <option value="주말">주말</option>
			  <option value="평일">평일</option>
			</select>
			<span>&nbsp<input type="time" id="contactTimeFrom1" name="contact_time1" value="12:00"></span>
			<span>&nbsp~&nbsp</span>
			<span><input type="time" id="contactTimeFrom2" name="contact_time2" value="16:00"></span>
		</section>
		<section>
			<h5><strong>경력</strong></h5>
			<ul>
				<li>${mentor_profile.careers}
			</ul>
			<input type="text" id="careers" name="careers" value="${mentor_profile.careers}">
		</section>
		<section>
			<h5><strong>이런 분들께 추천해요</strong></h5>
			<span>${mentor_profile.recom_ment}</span>
			<div class="form-floating">
			  <textarea class="form-control" placeholder="Leave a comment here" id="recom_ment" style="height: 100px">${mentor_profile.recom_ment}</textarea>
			  <label for="recom_ment">소개 글을 작성해보세요</label>
			</div>
		</section>
		<div class="d-flex justify-content-end">
			<button type="button" class="btn btn-success" id="submit-btn" >작성</button>
		</div>
	
	<section>
		<h5><strong>태그 설정</strong></h5>
		<span id="mentor-tags">
				<!-- 멘토 태그 -->
		</span>
		<div id="tags-box">
		<!-- 태그정보 -->
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
		  <div class="col-2 d-flex justify-content-end">
		  	<button type="button" id="save_tag"  class="btn btn-success" onclick="deleteMentorTag()">태그 저장</button>
		  </div>
		</section>
	</section>

	
	
	<section>
		<div class="d-flex justify-content-between">
			<h5><strong>수업 내용</strong></h5>
			<button id="create-class" class="btn btn-dark btn-lg">신규 수업 등록</button>
		</div>
		<div id="mentor_class_info">
			<!-- 클래스 정보 -->
		</div>
	</section>

	<form id="classForm" onsubmit="return classSubmitForm()">
		<label for="class_name">수업명:</label> 
		<input type="text" id="class_name" name="class_name" value="" required>
		<label for="class_info">수업 정보:</label> 
		<input type="text" id="class_info" name="class_info" value="" required>
		<label for="price">가격: </label> 
		<input type="number" id="price" name="price" value="" required>
		<input type="submit" value="새로운 수업 작성">
	</form>
	
		
	</div><!-- container -->
	
	<!-- 수업 만들기 모달 -->
	<div class="modal fade" id="classModal" tabindex="-1" aria-labelledby="classModalLabel" aria-hidden="true" style="display: none;">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="classModalLabel">새로운 클래스를 등록해 보세요</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">닫기</button>
	      </div>
	      <div class="modal-body">
	        <form id="classForm">
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
	//평균 평점 계산
	let avg_grade = ${mentor_profile.total_grade/mentor_profile.num_of_reviews}
	let roundedGrade = avg_grade.toFixed(1);
	$('#avg_grade').html('평점: '+roundedGrade);
	
	// 선택한 포지션 값을 저장할 배열
	let positions = [];
	
	// 이미 추가된 챔피언들의 ID를 저장할 배열
	let top_selectedChampions = [];
	let current_tsc = "${mentor_profile.top_specialized_champion}";
	const championIds = current_tsc.split(",");
	if (current_tsc != null && current_tsc != ''){
		for (let i = 0; i < championIds.length; i++) {
		  const parsedId = parseInt(championIds[i]);
		  top_selectedChampions.push(parsedId);
		}
	}
	
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
		/* 
		function classSubmitForm() { //새로운 수업 만들기
			  let formData = $("#classForm").serializeArray();
			  let mentorClassDTO = {};
			  $.each(formData, function(index, field){
			    mentorClassDTO[field.name] = field.value;
			  });
			  mentorClassDTO.mentor_email = "${mentor_profile.mentor_email}";
			  mentorClassDTO.price = parseInt(mentorClassDTO.price);
			  $.ajax({
			    url: "/mentor/insert-mentor-class/",
			    type: "POST",
			    contentType: "application/json;charset=UTF-8",
			    data: JSON.stringify(mentorClassDTO),
			    success: function () {
			   		alert("클래스가 추가되었습니다.");
			      select_by_email_class();
			    },
			    error: function () {
			      alert("클래스 추가에 실패했습니다.");
			    }
			  });
			  return false;
			} */
		
		$("#classForm").submit(function(event) {
		    event.preventDefault();
		    let form_data = {
		    	mentor_email: mentor_profile.mentor_email,
	    		class_name: $("#classTitle").text(),
	    		class_info: $("#classInfo").text(),
	    		price: $("#classPrice").text()
		    };
		    console.log(form_data);
		    $.ajax({ //클래스 작성 기능
		      type: "POST",
		      url: "/mentor/insert-mentor-class/",
		      data: JSON.stringify(form_data),
		      contentType: "application/json; charset=utf-8",
		      success: function(data) {
		    	  alert("클래스가 추가되었습니다.");
		        $("#classModal").modal("hide");
		      },
		      error: function(xhr, status, error) {
		    	  alert("클래스 추가에 실패했습니다.");
		        console.error(xhr.responseText);
		        console.error(status);
		        console.error(error);
		      }
		    });
		  });
		
		$("#champ-search").on("input", function() { // 검색창 입력할 때마다 불러오기
			var searchText = $(this).val();
		      $.ajax({
		        url: "/mentor/get-champ-name-by-keyword",//키워드로 챔피언 찾기
		        type: "GET",
		        data: {
		        	keyword: searchText
		        },
		        success: function(data) {
		          console.log(data);
		          $("#champ-list").text("");
		          let championList = JSON.parse(data);
			        championList.forEach(function (champion) {
			            let imageUrl =
			                "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
			                champion.champion_en_name + ".png?&amp;retry=0";
			            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between hover-div").attr("id","champ-item").click(function () {
			            	if (top_selectedChampions.length >= 3){ //세명 골랐을때 
			            		// 이미 추가된 챔피언인지 검사
				                if (top_selectedChampions.includes(champion.champion_id)) {
				                	let index = top_selectedChampions.indexOf(champion.champion_id);
				                	top_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
				                	console.log(top_selectedChampions);
				                	$("#top_specializedChampion").val(top_selectedChampions);
				                	$('div#champ-info[data="' + champion.champion_id + '"]').remove();
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
					            $(".arrow-icon").before(championDiv);
				                $("#top_specializedChampion").val(top_selectedChampions);
			            		console.log(top_selectedChampions);
			            		return;
				                }
			            	}
			                // 이미 추가된 챔피언인지 검사
			                else if (top_selectedChampions.includes(champion.champion_id)) {
			                	if (top_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
			                		let index = top_selectedChampions.indexOf(champion.champion_id);
			                		top_selectedChampions.splice(index, 1);
				                	console.log(top_selectedChampions);
				                	$("#top_specializedChampion").val(top_selectedChampions);
				                	$('div#champ-info[data="' + champion.champion_id + '"]').remove(); 
			                		console.log('이미지가 비었습니다.');
			                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
						            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
						            let champName = $("<span>").text("특화 챔피언(탑)을 선택해주세요");
						            championDiv.append(champImg);
						            championDiv.append(champName);
						            $(".arrow-icon").before(championDiv);
			                		  return;
			                		}else{
			                			let index = top_selectedChampions.indexOf(champion.champion_id);
			                			top_selectedChampions.splice(index, 1);
					                	console.log(top_selectedChampions);
					                	$("#top_specializedChampion").val(top_selectedChampions);
					                	$('div#champ-info[data="' + champion.champion_id + '"]').remove();
					                    return;
			                		}
			                }else{
			                // 새로운 챔피언을 추가
			                top_selectedChampions.push(champion.champion_id);
			                
			                if ($("#champ-icon").attr("src")==""){
			                	$('#champ-info').remove();  
			                	
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $(".arrow-icon").before(championDiv);
				                
				                $("#top_specializedChampion").val(top_selectedChampions);
				                console.log(top_selectedChampions);
			                }else{
			                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
					            let champName = $("<span>").text(champion.champion_kr_name);
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $(".arrow-icon").before(championDiv);
					            $("#top_specializedChampion").val(top_selectedChampions);
					            console.log(top_selectedChampions);
			                }
			                }
			            });
			            let championDiv = $("<div>").attr("id", "champion");
			            let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
			            let champName = $("<span>").text(champion.champion_kr_name);
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
		  });
		
		$.ajax({ //멘토 태그 가져오기
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
	    });
		
		let spec_pos = ${mentor_profile.specialized_position};
		$.each(spec_pos, function(i,pos){ //저장된 특화 포지션 가져오기
			console.log(pos);
			if (pos=="탑"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/TOP.png")
				let posName = $("<strong>").text(pos);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (pos=="바텀"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/AD_CARRY.png")
				let posName = $("<strong>").text(pos);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (pos=="서포터"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/SUPPORT.png")
				let posName = $("<strong>").text(pos);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (pos=="정글"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/JUNGLE.png")
				let posName = $("<strong>").text(pos);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}else if (pos=="미드"){
				let posImg = $("<img>").attr("id","pos-img").attr("src","https://online.gamecoach.pro/img/coaching/lol-line-black/MID.png")
				let posName = $("<strong>").text(pos);
				let posBox = $("<div>").attr("id","pos-box").addClass("border rounded");
				posBox.append(posImg,posName);
				$("#specializedPosition").append(posBox);
			}
		})
		
		displaySpecializedPosition(); //멘토 특화 포지션과 특화 챔피언을 인풋창에 출력
		select_by_email_class();
		
		$("#champ-selector-inner").click(function () { //챔피언 선택 펼치기
			if ($("#filter-champ-wrap").css('display') === 'none') {
				$("#filter-champ-wrap").css('display', 'block');
			} else {
				$("#filter-champ-wrap").css('display', 'none');
			}
		});
		$("#champ-wrap-close").click(function () { //챔피언 선택 닫기
			$("#filter-champ-wrap").css('display', 'none');
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
		            let champItem = $("<div>").addClass("d-flex align-items-center justify-content-between hover-div").attr("id","champ-item").click(function () {
		            	if (top_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (top_selectedChampions.includes(champion.champion_id)) {
			                	let index = top_selectedChampions.indexOf(champion.champion_id);
			                	top_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log(top_selectedChampions);
			                	$("#top_specializedChampion").val(top_selectedChampions);
			                	$('div#champ-info[data="' + champion.champion_id + '"]').remove();
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
				            $(".arrow-icon").before(championDiv);
			                $("#top_specializedChampion").val(top_selectedChampions);
		            		console.log(top_selectedChampions);
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (top_selectedChampions.includes(champion.champion_id)) {
		                	if (top_selectedChampions.length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = top_selectedChampions.indexOf(champion.champion_id);
		                		top_selectedChampions.splice(index, 1);
			                	console.log(top_selectedChampions);
			                	$("#top_specializedChampion").val(top_selectedChampions);
			                	$('div#champ-info[data="' + champion.champion_id + '"]').remove(); 
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
					            let champImg = $("<img>").addClass("rounded").attr("id","champ-icon").attr("src", "");
					            let champName = $("<span>").text("특화 챔피언(탑)을 선택해주세요");
					            championDiv.append(champImg);
					            championDiv.append(champName);
					            $(".arrow-icon").before(championDiv);
		                		  return;
		                		}else{
		                			let index = top_selectedChampions.indexOf(champion.champion_id);
		                			top_selectedChampions.splice(index, 1);
				                	console.log(top_selectedChampions);
				                	$("#top_specializedChampion").val(top_selectedChampions);
				                	$('div#champ-info[data="' + champion.champion_id + '"]').remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
		                top_selectedChampions.push(champion.champion_id);
		                
		                if ($("#champ-icon").attr("src")==""){
		                	$('#champ-info').remove();  
		                	
		                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $(".arrow-icon").before(championDiv);
			                
			                $("#top_specializedChampion").val(top_selectedChampions);
			                console.log(top_selectedChampions);
		                }else{
		                	let championDiv = $("<div>").addClass("d-flex flex-column").attr("id","champ-info").attr("data",champion.champion_id);
				            let champImg = $("<img>").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $(".arrow-icon").before(championDiv);
				            $("#top_specializedChampion").val(top_selectedChampions);
				            console.log(top_selectedChampions);
		                }
		                }
		            });
		            let championDiv = $("<div>").attr("id", "champion");
		            let champImg = $("<img>").css("width","56px").attr("id","champ-icon").addClass("rounded").attr("src", imageUrl);
		            let champName = $("<span>").text(champion.champion_kr_name);
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
			});

		
		$(".position-buttons button").hover(function () {
			$(this).addClass("mouse-over");
		}, function () {
			$(this).removeClass("mouse-over");
		});
		
		$("#submit-btn").click(function(e){
			e.preventDefault();
			submitForm();
		});

		function submitForm() {
			  let time0 = $('#dropdown-input').val();
			  let time1 = $('#contactTimeFrom1').val();
			  let time2 = $('#contactTimeFrom2').val();
			  $.ajax({
			    url: '/mentor/edit-profile/',
			    type: 'PUT',
			    contentType: 'application/json;charset=UTF-8',
			    data: JSON.stringify({
			      mentor_email: '${email}',
			      about_mentor: $('#about_mentor').val(),
			      specialized_position: JSON.stringify(positions),
			      top_specialized_champion: top_selectedChampions.join(","),
			      contact_time: time0 + " " + time1 + " ~ " + time2,
			      careers: $('#careers').val(),
			      recom_ment: $('#recom_ment').val()
			    }),
			    success: function(data) {
			    	alert("프로필 작성 성공");
			    	$('#champ-info').remove();
			    	$('#champ-info').remove();
			        displaySpecializedPosition();
			      },
			      error: function(error) {
			          console.log(error);
			      }
			  });
			  return false;
			}
		
		function deleteClass(class_id) { //수업 삭제하기
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

	});
	

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
		        } else {
		          $('#specializedPosition').val(mpsp[0]);
		          $("button[name='" + mpsp[0] + "']").toggleClass("selected");
		        }
		      }
		      if (sp.top_specialized_champion != null && sp.top_specialized_champion != '') {
		        $('#champ-info').remove();
		        loadChampionInfo();
		      }
		    },
		    error: function(xhr, status, error) {
		      console.log(error);
		    }
		  });
		}
		
		async function loadChampionInfo() {
		  for (let i = 0; i < top_selectedChampions.length; i++) {
		    try {
		      await getChampionInfo(top_selectedChampions[i]);
		    } catch (error) {
		      console.error("챔피언 정보 로드 중 오류:", error);
		    }
		  }
		}
		
		function getChampionInfo(championId) {
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
			        $(".arrow-icon").before(championDiv);

			        resolve(); // 성공적으로 완료되었음을 알림
			      },
			      error: function(xhr, status, error) {
			        reject(error); // 오류 발생시 reject를 호출하여 오류를 알림
			      }
			    });
			  });
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
		
	/* function classSubmitForm() {
		  let formData = $("#classForm").serializeArray();
		  let mentorClassDTO = {};
		  $.each(formData, function(index, field){
		    mentorClassDTO[field.name] = field.value;
		  });
		  mentorClassDTO.mentor_email = "${mentor_profile.mentor_email}";
		  mentorClassDTO.price = parseInt(mentorClassDTO.price);
		  $.ajax({
		    url: "/mentor/insert-mentor-class/",
		    type: "POST",
		    contentType: "application/json;charset=UTF-8",
		    data: JSON.stringify(mentorClassDTO),
		    success: function () {
		    	alert("클래스 추가 성공");
		      select_by_email_class();
		    },
		    error: function () {
		      alert("클래스 추가에 실패했습니다.");
		    }
		  });
		  return false;
		} */

  
	function submitTagForm(tagList) {
		  let jsonData = JSON.stringify(tagList);
		  $.ajax({
		    url: "/mentor/edit-mentor-tag/",
		    type: "PUT",
		    contentType: "application/json;charset=UTF-8",
		    data: jsonData,
		    success: function () {
		    	alert("멘토 태그가 저장되었습니다.");
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
