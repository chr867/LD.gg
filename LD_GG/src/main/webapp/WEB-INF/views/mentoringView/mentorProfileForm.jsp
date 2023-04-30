<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Mentor Profile Form</title>
  </head>
  <body>
    <h1>멘토 프로필 작성</h1>
    <form id="mentorProfileForm" onsubmit="return submitForm()">
      <h2>${mentor_profile.mentor_email} 멘토님</h2>
      <label for="about_mentor">멘토 소개:</label>
      <input type="text" id="about_mentor" name="about_mentor" value="${mentor_profile.about_mentor}" required><br><br>
      <label for="specializedPosition">특화 포지션:</label>
      <input type="text" id="specializedPosition" name="specialized_position" value="${mentor_profile.specialized_position}" required><br><br>
      <label for="specializedChampion">특화 챔피언:</label>
      <input type="text" id="specializedChampion" name="specialized_champion" value="${mentor_profile.specialized_champion}" required><br><br>
      <label for="contactTime">수업 가능 시간:</label>
      <input type="text" id="contactTime" name="contact_time" value="${mentor_profile.contact_time}" required><br><br>
      <label for="careers">경력:</label>
      <input type="text" id="careers" name="careers" value="${mentor_profile.careers}" required><br><br>
      <label for="recom_ment">이런 분들께 추천해요:</label>
      <input type="text" id="recom_ment" name="recom_ment" value="${mentor_profile.recom_ment}" required><br><br>
      
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
	  <button onclick="submitTagForm()">태그 저장</button>
	</table>
      
      <input type="submit" value="작성">
      
    </form>
    <script>
      function submitForm() {
        let form = document.getElementById("mentorProfileForm");
        let formData = new FormData(form);
        let xhr = new XMLHttpRequest();
        xhr.open("PUT", "/mentor/edit-profile/");
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        let mentorProfileDTO = {
        	mentor_email: "${email}",
        	about_mentor: formData.get("about_mentor"),
            specialized_position: formData.get("specialized_position"),
            specialized_champion: formData.get("specialized_champion"),
            contact_time: formData.get("contact_time"),
            careers: formData.get("careers"),
            recom_ment: formData.get("recom_ment")
        };
        xhr.send(JSON.stringify(mentorProfileDTO));
        return false;
      }
      
      function submitTagForm() {
    	  let checkboxes = document.getElementsByName("selected_tags");
    	  let selectedTags = [];
    	  for (let i = 0; i < checkboxes.length; i++) {
    	    if (checkboxes[i].checked) {
    	      selectedTags.push(checkboxes[i].value);
    	    }
    	  }
    	  console.log(selectedTags); // 선택한 태그들의 정보를 출력

    	  // 선택한 태그들의 정보를 객체에 담기
    	  let data = {
    	    selected_tags: selectedTags
    	  };

    	  // 서버로 전달할 JSON 형태로 변환
    	  let jsonData = JSON.stringify(data);

    	  // AJAX 요청 보내기
    	  let xhr = new XMLHttpRequest();
    	  xhr.open("PUT", "/mentor/edit-mentor-tag/");
    	  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    	  xhr.send(jsonData);

    	  return false; // 폼 제출 방지
    	}
    </script>
  </body>
</html>
