<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
	<h3>마이페이지입니다~~</h3>
	<button onclick="insertMentorProfile()">멘토 회원으로 전환</button>
	<button onclick="deleteMentorProfile()">일반 회원으로 전환</button>
	
<script>
  function insertMentorProfile() {
    let xhr = new XMLHttpRequest();
    let url = "mentor/insert-mentor-list";
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.onload = function () {
      if (xhr.status === 200) {
        console.log("success");
      }
    };
    let data = JSON.stringify({ mentor_email: "${email}"});
    xhr.send(data);
  }
  
  function deleteMentorProfile() {
    let xhr = new XMLHttpRequest();
    let url = "mentor/delete-mentor-profile";
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.onload = function () {
      if (xhr.status === 200) {
        console.log("success");
      }
    };
    let data = JSON.stringify({ mentor_email: "${email}"});
    xhr.send(data);
  }
</script>
</body>
</html>