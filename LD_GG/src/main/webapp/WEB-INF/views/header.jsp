<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/26
  Time: 2:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>LD.GG</title>
  <!--BOOTSTRAP CSS-->
</head>
<body>
<div id="session-summoner-name" style="display: none">${sessionScope.lol_account}</div>
<div id="session-user-type" style="display: none">${sessionScope.user_type}</div>
<div id="session-summoner-name" style="display: none">${sessionScope.summoner_name}</div>
<div id="session-summoner-icon" style="display: none">${sessionScope.summoner_icon}</div>
<div id="error-check" style="display: none">${check}</div>
<!----------------------------------------------------------------------------------------------------------------->
<!-- 헤더 -->
<div class="chat-noti" style="display: none;">
</div>
<div class="toast-container" id="toast-container">
</div>
<div class="header-container">
  <header>

    <div class="search-bar-box">
      <img src="/resources/img/logo/LD_logo_bluered.png" alt=""
           class="search-bar-logo"> <input type="text"
                                           class="search-bar-input" placeholder="소환사명을 입력해주세요"
                                           autocomplete="off"> <img
            src="/resources/img/icon/free-icon-magnifying-glass-49116.png"
            alt="" class="search-bar-icon">
    </div>

    <div class="header-icon-box" style="display: none;">
      <div class="message-icon-box">
        <img src="/resources/img/icon/free-icon-message-5941217.png" alt=""
             class="message-icon-img" onclick="chatPopup();">
        <div class="message-notification" style="display: none;"></div>
      </div>
      <div class="alarm-icon-box">
        <img
                src="/resources/img/icon/free-icon-notification-bell-3680267.png"
                alt="" class="alarm-icon-img" onclick="showChatnoti()"> <span
              class="alarm-notification" style="display: none;"></span>
      </div>
      <div class="bookmark-icon-box">
        <img src="/resources/img/icon/free-icon-bookmark-white-25667.png"
             alt="" class="bookmark-icon-img">
      </div>
    </div>

    <div class="user-info-box" style="display: none;" onclick="go_mypage()">
      <div class="summoner-profile-icon-box">
        <img src="/resources/img/profileicon/${sessionScope.summoner_icon}.png" alt="">
      </div>
      <div class="summoner-name-box">
        <h5>${sessionScope.lol_account} 님</h5>
      </div>
      <div class="user-type-box">
        <div class="user-type-common" style="display: none;">
          <h5>일반회원</h5>
        </div>
        <div class="user-type-mentor" style="display: none;">
          <h5>멘토회원</h5>
        </div>
        <div class="user-type-admin" style="display: none;">
          <h5>어드민</h5>
        </div>
        <div class="user-type-stop" style="display: none;">
          <h5>정지회원</h5>
        </div>
      </div>
    </div>

    <div class="login-button-box">
      <button class="login-button" data-bs-toggle="modal"
              data-bs-target="#login-modal" onclick="loginCheck()">LOGIN</button>
    </div>

    <div class="logout-button-box" style="display: none;">
      <form id="logoutFrm" action="/member/logout" method="post">
        <button class="logout-button" onclick="logout()">LOGOUT</button>
      </form>
    </div>

  </header>
</div>
<!----------------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------->
<!-- 로그인 모달박스 -->
<div class="modal fade" id="login-modal" tabindex="-1"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #172B36;">
        <h1 class="modal-title fs-5" id="exampleModalLabel"></h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal"
                aria-label="Close" style="background-color: #ffffff;"></button>
      </div>
      <div class="modal-body login-modal-body"
           style="background-image: url(/resources/img/logo/2020_key_art_Banner.png);">
        <div class="login-img-box">
          <img src="/resources/img/logo/main.png" alt="로그인 이미지">
        </div>
        <div class="login-box">
          <div class="input-area">
            <div>
              <img src="/resources/img/logo/LD_logo.svg" alt="LD_logo"
                   style="width: 100px; height: 100px;">
            </div>
            <form action="/member/login" name="logFrm" method="post">
              <div class="input-id">
                <input type="text" placeholder="아이디" name="email">
              </div>
              <div class="input-pw">
                <input type="password" placeholder="비밀번호" name="password">
              </div>
              <div>
                <button class="login-modal-button">로그인</button>
              </div>
            </form>
            <div>
              <button class="login-modal-button" onclick="join()">회원가입</button>
            </div>
            <div>
              <a href="/member/findEmail" class="find-tag">이메일아이디 찾기</a>
            </div>
            <div>
              <a href="/member/findPassword" class="find-tag">비밀번호 찾기</a>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer" style="background-color: #1E3D4F;">
      </div>
    </div>
  </div>
</div>
<!----------------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------->
  <script type="text/javascript">
    function go_mypage(){
      location.href="/member/mypage"
    }
  </script>
</body>

</html>