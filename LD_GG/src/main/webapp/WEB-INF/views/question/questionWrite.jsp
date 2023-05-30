<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>질문글 작성</title>
  <style>
    .main-container {
      margin: 0px auto auto auto;
      width: 60%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      text-align: center;
    }
    form {
      display: flex;
      flex-direction: column;
      margin: 85px auto auto auto;
      width: 80%;
    }
    form > * {
      margin-top: 5px;
      margin-bottom: 5px;
    }
    textarea {
      height: 500px;
    }
    .btn-col {
      width: 100%;
      display: flex;
      justify-content: center;
      padding: 5px;
    }
    .btn-col > * {
      margin: 5px;
    }
    .tag-box {
      width: auto;
      display: flex;
      justify-content: flex-start;
      align-items: center;
    }
  </style>
  <title>title</title>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
          crossorigin="anonymous">
  <!--BOOTSTRAP JavaScript-->
  <script
          src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
          crossorigin="anonymous">
  </script>
  <!--SWEET-ALERT2 CSS-->
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
  <!--SWEET-ALERT2 JS-->
  <script
          src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
  <!--JQUERY-->
  <!--AJAX-->
  <script
          src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <!--JQUERY VALIDATE-->
  <script
          src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
  <!--sideBar CSS-->
  <link rel="stylesheet" type="text/css"
        href="/resources/css/main/sideBar.css">
  <!--header CSS-->
  <link rel="stylesheet" type="text/css"
        href="/resources/css/main/header.css">
  <!--footer CSS-->
  <link rel="stylesheet" type="text/css"
        href="/resources/css/main/footer.css">
  <!--loginModal CSS-->
  <link rel="stylesheet" type="text/css"
        href="/resources/css/main/loginModal.css">
  <!--로그인 및 세션관련 JS-->
  <script src="/resources/js/main/loginSession.js" defer></script>
  <!-- 채팅 관련 JS-->
  <script src="/resources/js/main/chat.js" defer></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
<%@ include file="../header.jsp" %>
<%@ include file="../sidebar.jsp" %>
<%@ include file="../footer.jsp" %>
<div class="main-container">
  <form method="post" action="/question/write_question">
    <div id="email" hidden="true">
      ${email}
    </div>
    <input type="text" name="q_title" style="width: 50%; margin-bottom: 5px;" placeholder="제목" value="${title}"/>
    <textarea name="q_content" placeholder="질문글을 작성해주세요!"></textarea>
    <div class="tag-box">
      태그 입력 : <input type="text" name="q_hashtag" style="width: 40%;" placeholder="해시태그 입력" value="${hashtag}"/>
    </div>
    <div class="btn-col">
      <input id="subBtn" type="button" value="글 작성" onclick="goWrite(this.form)" />
      <input id="reset" type="reset" value="취소">
    </div>
  </form>
</div>
<script type="text/javascript">
  function goWrite(frm) {
    let title = frm.q_title.value;
    console.log(title);
    let contents = frm.q_content.value; //공백 => &nbsp
    console.log(contents);
    let hashtag = frm.q_hashtag.value;
    var tagStrig = hashtag.replace(/\s/g, "");
    var tag = tagStrig.split("#");


    if (title.trim() == '') {
      alert('제목을 입력해주세욧!!')
      return false;
    }
    if (contents.trim() == '') {
      alert('내용을 입력해주세욧!!!')
      return false;
    }

    frm.submit();
  }
</script>
</body>
</html>