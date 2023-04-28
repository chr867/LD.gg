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
                    const link = document.createElement('a');
                    link.href = '/mentor/profile/' + mentor.mentor_email;
                    link.innerHTML = '<h2>' + mentor.mentor_email + '멘토님 </h2>';
                    link.onclick = function(event) {  // 클릭 이벤트 핸들러 등록
                        event.preventDefault();  // 기본 동작 방지
                        window.location.href = link.href;  // URL 이동
                    };
                    listItem.appendChild(link);
                    mentorList.appendChild(listItem);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
    function renewal_mentor_list() {
    	  return fetch('/mentor/renewal-mentor-list', {
    	    method: 'POST',
    	    headers: {
    	      'Content-Type': 'application/json'
    	    }
    	  })
    	  .then(response => {
    	    if (response.ok) {
    	      console.log('HTTP POST 요청이 성공적으로 처리되었습니다.');
    	    } else {
    	      console.error('HTTP POST 요청이 실패하였습니다.');
    	    }
    	  })
    	  .catch(error => console.error(error));
    	}

    window.onload = function() {
        // 페이지 로드가 완료되면 멘토 리스트를 출력합니다.
    	renewal_mentor_list()
        .then(() => get_mentor_list())
        .catch(error => console.error(error));
    };
</script>
</body>
</html>