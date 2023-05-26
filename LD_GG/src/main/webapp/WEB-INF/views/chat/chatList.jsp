<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/08
  Time: 9:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>채팅</title>
  <link rel="stylesheet" type="text/css" href="/resources/css/chat/chatList.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 이메일 hidden -->
<div id="email" hidden="true">
  ${email}
</div>
<!-- 채팅 페이지 header -->
<div class="chat-header">
  <img src="/resources/img/logo/LDGG.png" alt="" class="ld-logo"></img>
</div>
<div class="chat-list">
  <div class="tab-container">
    <div class="tab" onclick="openTab('allTab')">
      전체
    </div>
    <div class="tab" onclick="openTab('mentoringTab')">
      멘토링
    </div>
    <div class="tab" onclick="openTab('mateTab')">
      메이트
    </div>
  </div>
  <div class="tab-contents">
    <div class="tab-content" id="allTab">
      <ul class="all-list">

      </ul>
    </div>
    <div class="tab-content" id="mentoringTab">
      <ul class="mentoring-list">

      </ul>
    </div>
    <div class="tab-content" id="mateTab">
      <ul class="mate-list">

      </ul>
    </div>
  </div>
</div>
<script src="/resources/js/chat/chatList.js"></script>
</body>
</html>