<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 프로필</title>
</head>
<body>
	<h2>${mentor_profile.mentor_email}멘토님의 프로필</h2>
	<h4>멘토 소개: ${mentor_profile.about_mentor}</h4>
	<h4>특화 챔피언: ${mentor_profile.specialized_champion}</h4>
	<h4>특화 포지션: ${mentor_profile.specialized_position}</h4>
	<h4>수업 가능 시간: ${mentor_profile.contact_time}</h4>
	<h4>경력: ${mentor_profile.careers}</h4>
	<h4>이런 분들께 추천해요: ${mentor_profile.recom_ment}</h4>
	
	<button onclick="apply()">수업신청</button>
	<a href="/mentor/list">목록</a>
	
	<script>
		function apply() {
			window.location.href = "/apply/" + "${mentor_email}";
		}
	</script>
</body>
</html>