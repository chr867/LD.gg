<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>멘토 찾기</title>
</head>
<body>
	<h2>멘토 찾기 페이지 입니다~~~</h2>
	<ul id="mentor-list">
	<!-- 멘토 프로필 목록 추가. -->
	</ul>
	
	<script>
    function get_mentor_list() {
        fetch('/mentor/find-mentor/')
            .then(response => response.json())
            .then(data => {
            	console.log(data);
                const mentorList = document.getElementById("mentor-list");
                for (let i = 0; i < data.length; i++) {
                    const mentor = data[i];
                    const listItem = document.createElement('li');
                    listItem.innerHTML = '<h2>' + mentor.mentor_email + '멘토님 </h2>';
                  	mentorList.appendChild(listItem);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    window.onload = function() {
        // 페이지 로드가 완료되면 북리스트를 출력합니다.
        get_mentor_list();
    };
</script>
</body>
</html>