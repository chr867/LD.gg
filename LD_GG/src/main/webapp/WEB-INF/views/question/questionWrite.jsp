<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/14
  Time: 3:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
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
  <script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
          crossorigin="anonymous"></script>
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
</head>
<style>
  .main-container {
    margin: 71px auto auto auto;
    width: 60%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
  }
  form {
    display: flex;
    flex-direction: column;
    margin: 20px auto auto auto;
    width: 80%;
  }
  form > * {
    margin-top: 5px;
    margin-bottom: 5px;
  }
  textarea {
    height: 500px;
  }
  #my_champion{
    position: absolute;
    top: 15%;
    left: 15%;
  }

  #champ_search_box input{
    width: 220px;
    border-radius: 5px;
  }

  #my_champion_img{
    width: 370px;
    height: 400px;
    padding-top: 20px;
    padding-bottom: 15px;
    border-radius: 70%;
  }

  #build_recom_box button{
    margin-top: 20px;
  }

  #counter_champion{
    position: absolute;
    height: auto;
    top: 25%;
    left: 55%;
  }

  #right_champion_img{
    width: 140px;
    height: 140px;
    border-radius: 70%;
  }

  #right_champ_search_box{
    position: relative;
    left: -30%;
    top: 30%;
  }

  #recom_champ{
    position: absolute;
    left: 36%;
    top: 67%;
  }

  #recom_champ img{
    width: 140px;
    height: 140px;
    margin-right: 20px;
    border-radius: 70%;
  }

  #span_container{
    display: grid;
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
<body>
<%@ include file="../header.jsp" %>
<%@ include file="../sidebar.jsp" %>
<%@ include file="../footer.jsp" %>
<div class="main-container">
    <form method="post" action="/question/write_question">
      <div hidden="true">
        ${email}
      </div>
      <input type="text" name="q_title" style="width: 50%;" placeholder="제목" value="${title}"/>
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
