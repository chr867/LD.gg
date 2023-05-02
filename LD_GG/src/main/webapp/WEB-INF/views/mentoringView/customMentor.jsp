<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맞춤 멘토</title>
<style>
.scrollable-table {
	height: 200px;
	overflow: auto;
}

.toggle-button {
	display: block;
	margin: 10px;
}
</style>
</head>
<body>
	<h2>맞춤 멘토 페이지 입니다~</h2>
	<form id="customMentorForm" onsubmit="return submitForm()">
      <h2>${member.lol_account} 회원님</h2>
      <label for="position_to_learn">배우고 싶은 포지션:</label>
      <input type="text" id="position_to_learn" name="position_to_learn" value="${mentor_profile.about_mentor}" required><br><br>
      <label for="champion_to_learn">배우고 싶은 챔피언:</label>
      <input type="text" id="champion_to_learn" name="champion_to_learn" value="${mentor_profile.specialized_position}" required><br><br>
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
    <script>
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