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
.scrollable-table {
	height: 200px;
	overflow: auto;
}

.toggle-button {
	display: block;
	margin: 10px;
}
.position-buttons {
  display: flex;
}

.position-buttons button {
  background-color: #f2f2f2;
  border: none;
  color: black;
  padding: 10px;
  margin: 5px;
  cursor: pointer;
}

.position-buttons button:hover {
  background-color: #ddd;
}

</style>
</head>
<body>
	<h2>맞춤 멘토 페이지 입니다~</h2>
	<form id="customMentorForm" onsubmit="return submitForm()">
      <h2>${member.lol_account} 회원님</h2>
      <h4>나에게 딱 맞는 멘토님을 찾기위해</h4>
      <h4><img src=""><em>목표를 설정해 볼까요?</em></h4>
      <label for="position_to_learn">배우고 싶은 포지션:</label>
      <input type="text" id="position_to_learn" name="position_to_learn" value="${mentor_profile.about_mentor}" required><br><br>
      <div class="position-buttons">
		  <button id="top-button">탑</button>
		  <button id="jungle-button">정글</button>
		  <button id="mid-button">미드</button>
		  <button id="bot-button">바텀</button>
		  <button id="support-button">서포터</button>
		</div><br><br>
      <label for="champion_to_learn">배우고 싶은 챔피언:</label>
      <input type="text" id="champion_to_learn" name="champion_to_learn" value="${mentor_profile.specialized_position}" required><br><br>
      
      <div class="champ-selector-inner"><div class="champ-info"><span><img retry-img="" src="" cdn-img="" class="champ-img"><p class="champ-name">배우고 싶은 챔피언을 선택 해주세요</p></span></div><img src="" class="arrow-icon"></div>
      
      <div class="filter-champ-wrap" style="">
      <div win-rate-filter-champ="">
      <span text-input="" class="input-champ-keyword white">
      <input placeholder="챔피언을 검색하세요" tabindex="0" type="text" class="">
      <!----></span>
      <div class="champ-list">
      <div class="champ-item">
      <div id="champion">
      <img retry-img="" src="https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/Garen.png?&amp;retry=0" cdn-img="" d="64x64" class="champ-icon">
      <span>가렌</span></div>
      <div class="rate-wrap">
      <div class="rate-bar-wrap">
      <div class="rate-bar-bg">
      </div><!---->
      </div>
      <p class="pick-rate">픽률 0%</p>
      </div>
      </div>
      </div>
      </div>
      
      <label for="target_tier">목표 티어:</label>
      <input type="text" id="target_tier" name="target_tier" value="${mentor_profile.specialized_champion}" required><br><br>
      
      <label for="own_goal">나만의 목표:</label>
      <input type="text" id="own_goal" name="own_goal" value="${mentor_profile.contact_time}" required><br><br>
      <input type="submit" value="작성">
      </form>
      <div class="scrollable-table">
      <table>
	  <thead>
	  
	    <tr>
	      <th>선택</th>
	      <th>필드1</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach items="${tag_list}" var="tag_list">
	      <tr>
	        <td>
	          <input type="checkbox" name="selected_tags" value="${tag_list.tag_id}">
	        </td>
	        <td>${tag_list.tag_info}</td>
	      </tr>
	    </c:forEach>
	  </tbody>
	  </table>
    </div>
    <button class="save_tag" onclick="deleteMentiTag()">태그 저장</button>
	<button class="toggle-button" onclick="toggleTable()">토글 버튼</button>  
    <button id="recom-mentor-btn">추천 멘토 찾기</button>
    <div id="recom_mentor_list">
    </div>
    <script>
    $(document).ready(function() {
    	
    	// 선택한 포지션 값을 저장할 배열
    	let positions = [];

    	// 버튼 클릭 이벤트 추가
    	$("#top-button").on("click", function() {
    	  if (positions.includes("top")) {
    	    // 선택한 포지션 배열에서 삭제
    	    positions.splice(positions.indexOf("top"), 1);
    	  } else {
    	    // 선택한 포지션 배열에 추가
    	    positions.push("top");
    	  }
    	  $("#position_to_learn").val("top");
    	});

    	// 나머지 버튼들도 동일하게 추가
    	$("#jungle-button").on("click", function() {
    	  if (positions.includes("jungle")) {
    	    positions.splice(positions.indexOf("jungle"), 1);
    	  } else {
    	    positions.push("jungle");
    	  }
    	  $("#position_to_learn").val("jungle");
    	});

    	$("#mid-button").on("click", function() {
    	  if (positions.includes("mid")) {
    	    positions.splice(positions.indexOf("mid"), 1);
    	  } else {
    	    positions.push("mid");
    	  }
    	  $("#position_to_learn").val("mid");
    	});

    	$("#bot-button").on("click", function() {
    	  if (positions.includes("bot")) {
    	    positions.splice(positions.indexOf("bot"), 1);
    	  } else {
    	    positions.push("bot");
    	  }
    	  $("#position_to_learn").val("bot");
    	});

    	$("#support-button").on("click", function() {
    	  if (positions.includes("support")) {
    	    positions.splice(positions.indexOf("support"), 1);
    	  } else {
    	    positions.push("support");
    	  }
    	  $("#position_to_learn").val("support");
    	});
    	
		$("#recom-mentor-btn").click(function() {
			$.ajax({
		        type: "GET",
		        url: "/mentor/recom-mentor",
		        contentType: "application/json; charset=utf-8",
		        dataType: "json",
	        	success: function(data) {
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
        		},
		        error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		            console.error(status);
		            console.error(error);
		        }
		    });
		});
	});

    
    function submitForm() {
        let form = document.getElementById("customMentorForm");
        let formData = new FormData(form);
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/mentor/save-custom-mentor/");
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        let customMentorDTO = {
        	menti_email: "${member.email}",
        	summoner_name: "${member.lol_account}",
        	position_to_learn: formData.get("position_to_learn"),
        	champion_to_learn: formData.get("champion_to_learn"),
        	target_tier: formData.get("target_tier"),
        	own_goal: formData.get("own_goal")
        };
        console.log(customMentorDTO);
        xhr.send(JSON.stringify(customMentorDTO));
        return false;
      }
    function deleteMentiTag() {
   	let checkboxes = document.getElementsByName("selected_tags");
      let tagList = [];
      for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
          let tag = checkboxes[i].value;
          let data = {
            menti_email: "${member.email}",
            tag_id: tag,
          };
          tagList.push(data);
        }
      }
   	let jsonData = JSON.stringify(tagList);
  	  let xhr = new XMLHttpRequest();
  	  xhr.open("POST", "/mentor/save-menti-tag/");
  	  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  	  xhr.onload = function () {
  	    if (xhr.status === 200) {
  	      console.log("멘토 태그가 저장되었습니다.");
  	    } else {
  	      console.error("멘토 태그 저장에 실패했습니다.");
  	    }
  	  };
  	  xhr.send(jsonData);
  	  return false;
  	}
    function toggleTable() {
    	  let table = document.querySelector('.scrollable-table');
    	  if (table.style.display === 'none') {
    	    table.style.display = 'block';
    	  } else {
    	    table.style.display = 'none';
    	  }
    	}
    </script>
</body>
</html>