<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맞춤 멘토</title>
</head>
<body>
	<h2>맞춤 멘토 페이지 입니다~</h2>
	<form id="mentorProfileForm" onsubmit="return submitForm()">
      <h2>${member.lol_account} 회원님</h2>
      <label for="position_to_learn">배우고 싶은 포지션:</label>
      <input type="text" id="position_to_learn" name="position_to_learn" value="${mentor_profile.about_mentor}" required><br><br>
      <label for="champion_to_learn">배우고 싶은 챔피언:</label>
      <input type="text" id="champion_to_learn" name="champion_to_learn" value="${mentor_profile.specialized_position}" required><br><br>
      <label for="target_tier">목표 티어:</label>
      <input type="text" id="target_tier" name="target_tier" value="${mentor_profile.specialized_champion}" required><br><br>
      <label for="own_goal">나만의 목표:</label>
      <input type="text" id="own_goal" name="own_goal" value="${mentor_profile.contact_time}" required><br><br>
      
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
	  <button onclick="deleteMentorTag()">태그 저장</button>
	</table>
      
      <input type="submit" value="작성">
      
    </form>
</body>
</html>