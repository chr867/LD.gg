<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 프로필</title>
<style>
  #container_by_class{
  	border: 1px solid black;
  }
</style>
</head>
<body>
	<h2>${member.lol_account} 멘토님의 프로필</h2>
	<h4>멘토 소개: ${mentor_profile.about_mentor}</h4>
	<h4>특화 챔피언: ${mentor_profile.specialized_champion}</h4>
	<h4>특화 포지션: ${mentor_profile.specialized_position}</h4>
	<h4>수업 가능 시간: ${mentor_profile.contact_time}</h4>
	<h4>경력: ${mentor_profile.careers}</h4>
	<h4>이런 분들께 추천해요: ${mentor_profile.recom_ment}</h4>
	
	<div id="mentor_class_info">
       <c:forEach items="${class_list}" var="class_list">
       		<div id="container_by_class">
		        <div>
		        <h4>${class_list.class_name}</h4><button onclick="apply()">수업신청</button>
		        </div>
		        <div>
		        <h4>${class_list.price}</h4>
		        </div>
		        <div>
		        <h4>${class_list.class_info}</h4>
		        </div>
		       </div>
		</c:forEach>
       </div>
	
	
	<a href="/mentor/list">목록</a>
	
	<script>
		function apply() {
			window.location.href = "/apply/" + "${mentor_email}";
		}
	</script>
</body>
</html>