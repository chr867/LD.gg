<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Mentor Profile Form</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', sans-serif;
  font-size: 16px;
  color: #333;
}

h1, h2, h3, h4, h5, h6 {
  margin: 1rem 0;
}

h1 {
  font-size: 2.5rem;
}

h2 {
  font-size: 2rem;
}

h3 {
  font-size: 1.5rem;
}

h4 {
  font-size: 1.2rem;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

form label {
  display: block;
  margin-bottom: 0.5rem;
}

form input[type="text"], form input[type="number"] {
  padding: 0.5rem;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 0.5rem;
  width: 100%;
  margin-bottom: 1rem;
}

form input[type="submit"] {
  background-color: #4CAF50;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.5rem;
  font-size: 1rem;
  cursor: pointer;
}

form input[type="submit"]:hover {
  background-color: #3e8e41;
}

.scrollable-table {
  height: 200px;
  overflow: auto;
  margin-top: 1rem;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #ddd;
  padding: 0.5rem;
  text-align: left;
}

th {
  background-color: #f2f2f2;
}

.toggle-button, .save_tag {
  display: block;
  margin-top: 1rem;
  background-color: #4CAF50;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.5rem;
  font-size: 1rem;
  cursor: pointer;
}

.toggle-button:hover {
  background-color: #3e8e41;
}
.save_tag:hover {
  background-color: #3e8e41;
}

#container_by_class {
  border: 1px solid black;
  margin: 1rem 0;
  padding: 1rem;
}

.delete-button {
  background-color: #f44336;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.5rem;
  font-size: 1rem;
  cursor: pointer;
}

.delete-button:hover {
  background-color: #d32f2f;
}

@media screen and (min-width: 768px) {
  .flex-container {
    display: flex;
    justify-content: space-between;
  }
  
  .form-container {
    width: 45%;
  }
  
  #mentor_class_info {
    width: 45%;
  }
}
.scrollable-table {
	height: 200px;
	overflow: auto;
}

.toggle-button {
	display: block;
	margin: 10px;
}

#container_by_class {
	border: 1px solid black;
}

.position-buttons button.selected {
  background-color: yellow;
  color: black;
  /* 다른 스타일 추가 가능 */
}

.champ-list {
			height: 336px;
			border-radius: 12px;
			overflow-y: scroll;
			box-sizing: border-box;
			border: 1px solid #d5d5de;
		}
#dropdown-input {
    padding: 10px;
    border: none;
    border-radius: 4px;
    background-color: #f1f1f1;
    cursor: pointer;
  }

  /* 드롭다운 메뉴 옵션 스타일 */
  #dropdown-input option {
    color: #000;
  }

</style>
</head>
<body>
	<h1>멘토 프로필 작성</h1>
	<form id="mentorProfileForm" onsubmit="return submitForm()">
		<h2>${member.lol_account}멘토님</h2>
		
		<h4>찜한 횟수: ${mentor_profile.num_of_likes}</h4>

		<h4>수업 횟수: ${mentor_profile.num_of_lessons}</h4>
	
		<h4>리뷰 횟수: ${mentor_profile.num_of_reviews}</h4>
		
		<h4 id="avg_grade">평점:</h4>
		
		<label for="about_mentor">멘토 소개:</label> <input type="text"
			id="about_mentor" name="about_mentor"
			value="${mentor_profile.about_mentor}"><br>
			
		<br> <label for="specializedPosition">특화 포지션:</label> 
		<input type="text" id="specializedPosition" name="specialized_position" value=""><br>
			
			<div class="position-buttons">
			<button type="button" id="top-button"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg" class="position-img">탑</button>
			<button type="button" id="jungle-button"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg" class="position-img">정글</button>
			<button type="button" id="mid-button"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg"
					class="position-img">미드</button>
			<button type="button" id="bot-button"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg" class="position-img">바텀</button>
			<button type="button" id="support-button"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg"
					class="position-img">서포터</button>
		</div><br><br>
			
		<br> <label for="top_specializedChampion">특화 챔피언(탑):</label> <input
			type="text" id="top_specializedChampion" name="top_specialized_champion"
			value="${mentor_profile.top_specialized_champion}"><br>
			
		<div class="champ-selector-inner">
			<div class="champ-info"><span><img retry-img="" src="" cdn-img="" class="champ-img">
					<p class="champ-name">특화 챔피언(탑)을 선택 해주세요</p>
				</span></div><img src="https://online.gamecoach.pro/img/icon/icon-arrow-down-grey.svg"
				class="arrow-icon">
		</div>
		<div class="filter-champ-wrap" style="display: none">
			<div class="filter-title-wrap">
				<div>
					<h4 class="filter-text">챔피언</h4>
				</div>
			</div>
			<div win-rate-filter-champ="">
				<span text-input="" class="input-champ-keyword white">
					<input placeholder="챔피언을 검색하세요" tabindex="0" type="text" class="champ-search">
				</span>
				<div class="champ-list">
				</div>
			</div>
		</div><br><br>	
			
			
		<br> <label for="contactTime">수업 가능 시간:</label> 
		<select id="dropdown-input" onchange="selectValue(this)">
		  <option value="">구분</option>
		  <option value="매일">매일</option>
		  <option value="주말">주말</option>
		  <option value="평일">평일</option>
		</select>
		<p><input type="time" id="contactTimeFrom" name="contact_time1" value="${mentor_profile.contact_time}"></p>
		<p><input type="time" id="contactTimeFrom" name="contact_time2" ></p>
		<br>
			
		<br> <label for="careers">경력:</label> <input type="text"
			id="careers" name="careers" value="${mentor_profile.careers}"><br>
			
		<br> <label for="recom_ment">이런 분들께 추천해요:</label> <input
			type="text" id="recom_ment" name="recom_ment"
			value="${mentor_profile.recom_ment}"><br>
	<br> <button id="submit-btn" >작성</button>
	</form>
	

	<div class="scrollable-table">
		<table>
			<thead>
				<tr>
					<th>선택</th>
					<th>태그</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${tag_list}" var="tag_list">
					<tr>
						<td><input type="checkbox" name="selected_tags"
							value="${tag_list.tag_id}"></td>
						<td>${tag_list.tag_info}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<button type="button" class="save_tag" onclick="deleteMentorTag()">태그 저장</button>
	<button type="button" class="toggle-button" onclick="toggleTable()">숨기기</button>

	<form id="classForm" onsubmit="return classSubmitForm()">
		<label for="class_name">수업명:</label> <input type="text"
			id="class_name" name="class_name" value="" required><br>
		<br> <label for="class_info">수업 정보:</label> <input type="text"
			id="class_info" name="class_info" value="" required><br>
		<br> <label for="price">가격: </label> <input type="number"
			id="price" name="price" value="" required><br>
			
		<br> <input type="submit" value="새로운 수업 작성">
	</form>
	<div id="mentor_class_info">
	</div>
	<script>
	//평균 평점 계산
	let avg_grade = ${mentor_profile.total_grade/mentor_profile.num_of_reviews}
	let roundedGrade = avg_grade.toFixed(1);
	$('#avg_grade').html('평점: '+roundedGrade);
	// 선택한 포지션 값을 저장할 배열
	let positions = [];
	// 이미 추가된 챔피언들의 ID를 저장할 배열
	let top_selectedChampions = [];
	
	$(document).ready(function () {
		displaySpecializedPosition(); //멘토 특화 포지션을 인풋창에 출력
		select_by_email_class();
		
		$(".champ-selector-inner").click(function () { //챔피언 선택 펼치기
			if ($(".filter-champ-wrap").css('display') === 'none') {
				$(".filter-champ-wrap").css('display', 'block');
			} else {
				$(".filter-champ-wrap").css('display', 'none');
			}
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
		            	if (top_selectedChampions.length >= 3){ //세명 골랐을때 
		            		// 이미 추가된 챔피언인지 검사
			                if (top_selectedChampions.includes(champion.champion_id)) {
			                	let index = top_selectedChampions.indexOf(champion.champion_id);
			                	top_selectedChampions.splice(index, 1); //클릭한 챔피언 삭제
			                	console.log(top_selectedChampions);
			                	$("#top_specializedChampion").val(top_selectedChampions);
			                	$('.champ-info#'+champion.champion_id).remove();
			                    return;
			                }else{
		            		alert("특화 챔피언은 3명까지만 선택 가능합니다")
		            		console.log(top_selectedChampions);
		            		$(".filter-champ-wrap").css('display', 'none');
		            		return;
			                }
		            	}
		                // 이미 추가된 챔피언인지 검사
		                else if (top_selectedChampions.includes(champion.champion_id)) {
		                	if ($('.champ-selector-inner').find('.champ-info').length === 1) { //champ-selector-inner 안에 champ-info가 하나 남았을때 삭제했을시
		                		let index = top_selectedChampions.indexOf(champion.champion_id);
		                		top_selectedChampions.splice(index, 1);
			                	console.log(top_selectedChampions);
			                	$("#top_specializedChampion").val(top_selectedChampions);
			                	$('.champ-info#'+champion.champion_id).remove();  
		                		console.log('이미지가 비었습니다.');
		                		let championDiv = $("<div>").addClass("champ-info").attr("id","");
					            let champImg = $("<img>").addClass("champ-icon").attr("src", "");
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
				                	$('.champ-info#'+champion.champion_id).remove();
				                    return;
		                		}
		                }else{
		                // 새로운 챔피언을 추가
		                top_selectedChampions.push(champion.champion_id);
		                
		                if ($(".champ-img").attr("src")==""){
		                	$('.champ-info').remove();  
		                	
		                	let championDiv = $("<div>").addClass("champ-info").attr("id",champion.champion_id);
				            let champImg = $("<img>").addClass("champ-icon").attr("src", imageUrl);
				            let champName = $("<span>").text(champion.champion_kr_name);
				            championDiv.append(champImg);
				            championDiv.append(champName);
				            $(".arrow-icon").before(championDiv);
			                
			                $("#top_specializedChampion").val(top_selectedChampions);
			                console.log(top_selectedChampions);
		                }else{
		                	let championDiv = $("<div>").addClass("champ-info").attr("id",champion.champion_id);
				            let champImg = $("<img>").addClass("champ-icon").attr("src", imageUrl);
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

		
		$("#submit-btn").click(function(e){
			e.preventDefault();
			submitForm();
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

		function submitForm() {
			  let formData = new FormData($('#mentorProfileForm')[0]);
			  let time0 = $('#dropdown-input').val();
			  let time1 = formData.get('contact_time1')
			  let time2 = formData.get('contact_time2')
			  $.ajax({
			    url: '/mentor/edit-profile/',
			    type: 'PUT',
			    contentType: 'application/json;charset=UTF-8',
			    data: JSON.stringify({
			      mentor_email: '${email}',
			      about_mentor: formData.get('about_mentor'),
			      specialized_position: JSON.stringify(positions),
			      top_specialized_champion: formData.get('top_specialized_champion'),
			      contact_time: time0 + " " + time1 + " ~ " + time2,
			      careers: formData.get('careers'),
			      recom_ment: formData.get('recom_ment')
			    }),
			    success: function(data) {
			    	alert("프로필 작성 성공");
			        displaySpecializedPosition();
			      },
			      error: function(error) {
			          console.log(error);
			      }
			  });
			  return false;
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
			
		function classSubmitForm() {
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
			}


		
		$(document).on("click", ".deleteButton", function(){
		    // 버튼 클릭시 실행할 함수
		    const class_id = $(this).attr('id');
		    deleteClass(class_id);
		});


	});
	

	//멘토 프로필 가져오기
	function displaySpecializedPosition(){
	$.ajax({
	  url: '/mentor/get-mentor-profile',
	  type: 'POST',
	  contentType: 'application/json;charset=UTF-8',
	  data: JSON.stringify({ mentor_email: '${member.email}' }),
	  success: function(data) {
		  let sp = JSON.parse(data);
		  let mpsp = JSON.parse(sp.specialized_position);
		  positions = mpsp;
		  if (mpsp.length == 2) {
			    $('#specializedPosition').val(mpsp[0] + '/' + mpsp[1]);
			  } else {
			    $('#specializedPosition').val(mpsp[0]);
			  }
	  },
	  error: function(xhr, status, error) {
	    console.log(error);
	  }
	});
	}
	
	function submitForm() {
		  let formData = new FormData($('#mentorProfileForm')[0]);
		  $.ajax({
		    url: '/mentor/edit-profile/',
		    type: 'PUT',
		    contentType: 'application/json;charset=UTF-8',
		    data: JSON.stringify({
		      mentor_email: '${email}',
		      about_mentor: formData.get('about_mentor'),
		      specialized_position: JSON.stringify(positions),
		      top_specialized_champion: formData.get('top_specialized_champion'),
		      contact_time: formData.get('contact_time'),
		      careers: formData.get('careers'),
		      recom_ment: formData.get('recom_ment')
		    }),
		    success: function(data) {
		    	console.log("프로필 작성 성공");
		        displaySpecializedPosition();
		      },
		      error: function(error) {
		          console.log(error);
		      }
		  });
		  return false;
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
		
	function classSubmitForm() {
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
		}

	
	function toggleTable() {
		  let table = $('.scrollable-table');
		  if (table.css('display') === 'none') {
		    table.css('display', 'block');
		  } else {
		    table.css('display', 'none');
		  }
		}
  
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
		      alert("멘토 태그가 저장되었습니다.");
		    },
		    error: function () {
		    	alert("멘토 태그 저장에 실패했습니다.");
		    }
		  });
		}
	
	function select_by_email_class() {
		  const lol_account = "${member.lol_account}";
		  $.ajax({
		    url: "/mentor/select-mentor-class?lol_account=" + lol_account,
		    type: "GET",
		    contentType: "application/json;charset=UTF-8",
		    success: function (class_list) {
		    	let classList = JSON.parse(class_list);
		    	console.log(classList);
		    	
		      const $mentorClassInfo = $("#mentor_class_info");
		      $mentorClassInfo.empty();

		      classList.forEach((mentorClass) => {
		        const classHtml = '<div id="container_by_class">' +
		          '<div>' +
		          '<h4>' + mentorClass.class_name + '</h4>' +
		          '<button class="deleteButton" id="' + mentorClass.class_id + '">삭제</button>' +
		          '</div>' +
		          '<div>' +
		          '<h4>' + mentorClass.price + '</h4>' +
		          '</div>' +
		          '<div>' +
		          '<h4>' + mentorClass.class_info + '</h4>' +
		          '</div>' +
		          '</div>';

		        $mentorClassInfo.append(classHtml);
		      });
		    },
		    error: function (xhr, status, error) {
		      console.error(error);
		    },
		  });
		}


	

    </script>
</body>
</html>
