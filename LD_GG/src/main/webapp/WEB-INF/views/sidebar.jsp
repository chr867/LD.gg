<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/26
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- 사이드바 -->
<div class="sidebar">
  <div class="sidebar-nothover-menu">
    <div class="sidebar-menu" style="padding: 8px 0px 8px 12px;">
      <img src="/resources/img/logo/LD_logo_gray.png" alt=""
           style="width: 40px; height: 40px;">
    </div>
    <div class="sidebar-menu" style="padding: 18px;">
    </div>
    <div class="sidebar-menu">
      <img src="/resources/img/icon/free-icon-ranking-3162263.png" alt=""
           class="side-bar-icon">
    </div>
    <div class="sidebar-menu">
      <img src="/resources/img/icon/free-icon-community-3594834.png"
           alt="" class="side-bar-icon">
    </div>
    <div class="sidebar-menu">
      <img src="/resources/img/icon/free-icon-mentorship-8920780.png"
           alt="" class="side-bar-icon">
    </div>
<!--     <div class="sidebar-menu">
      <img src="/resources/img/icon/free-icon-game-control-4315528.png"
           alt="" class="side-bar-icon">
    </div> -->
    <div class="sidebar-menu">
      <img src="/resources/img/icon/free-icon-user-996484.png" alt=""
           class="side-bar-icon">
    </div>
    <div class="sidebar-menu">
      <img src="/resources/img/icon/free-icon-megaphone-92206.png" alt=""
           class="side-bar-icon">
    </div>
  </div>

  <div class="sidebar-area">
    <div class="sidebar-logo-box" onclick="moveMain()">
      <img src="/resources/img/logo/LoLing in the Deep2.svg" alt="LD.GG로고">
    </div>

    <div class="accordion" id="accordionExample">

      <div class="accordion-item">
        <h2 class="accordion-header" id="headingOne">
          <button class="accordion-button" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseOne"
                  aria-expanded="true" aria-controls="collapseOne">
            <img src="/resources/img/icon/free-icon-ranking-3162263.png"
                 alt="" class="side-bar-icon"> 랭킹
          </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse"
             aria-labelledby="headingOne" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="accordion-body-menu">
              <a href="/champion/rank" class="accordion-body-link"><span>• 챔피언 티어</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/summoner/rank" class="accordion-body-link"><span>• 소환사 랭킹</span></a>
            </div>
          </div>
        </div>
      </div>

      <div class="accordion-item">
        <h2 class="accordion-header" id="headingTwo">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseTwo"
                  aria-expanded="false" aria-controls="collapseTwo">
            <img src="/resources/img/icon/free-icon-community-3594834.png"
                 alt="" class="side-bar-icon"> 커뮤니티
          </button>
        </h2>
        <div id="collapseTwo" class="accordion-collapse collapse"
             aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <span class="bullet bullet-dot"></span>
            <div class="accordion-body-menu">
              <a href="/tip/" class="accordion-body-link"><span>• 챔피언 공략</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/mate/" class="accordion-body-link"><span>• 롤 메이트</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/question/" class="accordion-body-link"><span>• 질문</span></a>
            </div>
          </div>
        </div>
      </div>

      <div class="accordion-item">
        <h2 class="accordion-header" id="headingThree">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseThree"
                  aria-expanded="false" aria-controls="collapseThree">
            <img src="/resources/img/icon/free-icon-mentorship-8920780.png"
                 alt="" class="side-bar-icon"> 멘토링
          </button>
        </h2>
        <div id="collapseThree" class="accordion-collapse collapse"
             aria-labelledby="headingThree" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="accordion-body-menu">
              <a href="/mentor/custom-mentor/" class="accordion-body-link"><span>• 맞춤 멘토</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/mentor/list/" class="accordion-body-link"><span>• 멘토 찾기</span></a>
            </div>
                        <div class="accordion-body-menu">
              <a href="/mentor/my-mentoring/" class="accordion-body-link"><span>• 마이 멘토링</span></a>
            </div>
          </div>
        </div>
      </div>

<!--       <div class="accordion-item">
        <h2 class="accordion-header" id="headingFour">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseFour"
                  aria-expanded="false" aria-controls="collapseFour">
            <img src="/resources/img/icon/free-icon-game-control-4315528.png"
                 alt="" class="side-bar-icon"> 미니게임
          </button>
        </h2>
        <div id="collapseFour" class="accordion-collapse collapse"
             aria-labelledby="headingFour" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="accordion-body-menu">
              <a href="" class="accordion-body-link"><span>• 승부예측</span></a>
            </div>
          </div>
        </div>
      </div> -->

      <div class="accordion-item">
        <h2 class="accordion-header" id="headingFive">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseFive"
                  aria-expanded="false" aria-controls="collapseFive">
            <img src="/resources/img/icon/free-icon-user-996484.png" alt=""
                 class="side-bar-icon"> 마이 메뉴
          </button>
        </h2>
        <div id="collapseFive" class="accordion-collapse collapse"
             aria-labelledby="headingFive" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="accordion-body-menu">
              <a href="/summoner/testDashBoard" class="accordion-body-link"><span>• 대시보드</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/mentor/write-profile" class="accordion-body-link"><span>• 프로필</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/wallet/payment" class="accordion-body-link"><span>• 내 지갑</span></a>
            </div>
                        <div class="accordion-body-menu">
              <a href="/member/changePassword" class="accordion-body-link"><span>• 비밀번호 변경</span></a>
            </div>
                        <div class="accordion-body-menu">
              <a href="/member/changeUserType" class="accordion-body-link"><span>• 일반/멘토회원 전환</span></a>
            </div>
                        <div class="accordion-body-menu">
              <a href="/member/dropMember" class="accordion-body-link"><span>• 회원탈퇴</span></a>
            </div>
          </div>
        </div>
      </div>

      <div class="accordion-item">
        <h2 class="accordion-header" id="headingSix">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseSix"
                  aria-expanded="false" aria-controls="collapseSix">
            <img src="/resources/img/icon/free-icon-megaphone-92206.png"
                 alt="" class="side-bar-icon"> 고객지원
          </button>
        </h2>
        <div id="collapseSix" class="accordion-collapse collapse"
             aria-labelledby="headingSix" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="accordion-body-menu">
              <a href="/userinterface/notice" class="accordion-body-link"><span>• 공지사항</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/faq/" class="accordion-body-link"><span>• FAQ</span></a>
            </div>
            <div class="accordion-body-menu">
              <a href="/faq/inquiries/" class="accordion-body-link"><span>• 문의사항</span></a>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>
</body>
</html>
