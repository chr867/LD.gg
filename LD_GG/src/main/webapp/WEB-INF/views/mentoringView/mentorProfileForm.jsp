<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Mentor Profile Form</title>
  </head>
  <body>
    <h1>멘토 프로필 작성</h1>
    <form id="mentorProfileForm" onsubmit="return submitForm()" method="post" action="/mentor/edit-profile">
      <h2>${email} 멘토님</h2>
      <label for="classInfo">수업 내용:</label>
      <input type="text" id="classInfo" name="class_info" value="ddd" required><br><br>
      <label for="specializedPosition">특화 포지션:</label>
      <input type="text" id="specializedPosition" name="specialized_position" required><br><br>
      <label for="specializedChampion">특화 챔피언:</label>
      <input type="text" id="specializedChampion" name="specialized_champion" required><br><br>
      <label for="contactTime">연락 가능 시간:</label>
      <input type="text" id="contactTime" name="contact_time" required><br><br>
      <input type="submit" value="작성">
    </form>
    <script>
      function submitForm() {
        let form = document.getElementById("mentorProfileForm");
        let formData = new FormData(form);
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/mentor/edit-profile");
        xhr.send(formData);
        return false;
      }
    </script>
  </body>
</html>