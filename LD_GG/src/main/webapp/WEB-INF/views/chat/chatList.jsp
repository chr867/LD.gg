<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/08
  Time: 9:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>채팅 리스트</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    /* get mentor list */
    function get_mentor_list(){
      $.ajax({
        method : "POST",
        url : "/chat/get_mentor_list",
        data : {'email' : '${email}'},
        dataType : "json",
      })
              .done(function(resp){
                console.log(resp);

                let rlist = '';

                $.each(resp, function(i, resp) {
                  rlist += '<input type="button" value="' + resp + '" onClick="go_chat_room">';
                });

                $("#mentor-list").html(rlist);
              })
              .fail(function(err){
                console.log(err);
              })
    }

    function get_mate_list(){
      $.ajax({
        method : "POST",
        url : "/chat/get_mate_list",
        data : {'email' : '${email}'},
        dataType : "json",
      })
              .done(function(resp){
                console.log(resp);

                let rlist = '';

                $.each(resp, function(i, resp) {
                  rlist += '<input type="button" value="' + resp + '" onClick="go_chat_room">';
                });

                $("#mentor-list").html(rlist);
              })
              .fail(function(err){
                console.log(err);
              })
    }

    function go_chat_room(){
      $.ajax({
        method : "POST",
        url : "chat/chatroom/${sendEmail}",
        data : {data : JSON.stringify(data)},
        // 스프링 추가 설정.
        dataType : "json",
        timeout : "1000" // 요청 타임 아웃
      })
              .done(function(resp){
                // res = 0 성공 => 팝업창으로 채팅방 열기
                // res = 1 실패 => 재시도 요청하기
                console.log(resp);
              })
              .fail(function(err){
                console.log(err);
              })
    }

    function goAjax(){
      $.ajax({
        method : "POST",
        url : "member/info",
        data : {data : JSON.stringify(data)},
        // 스프링 추가 설정.
        dataType : "json",
        timeout : "1000" // 요청 타임 아웃
      })
              .done(function(resp){
                console.log(resp);

                $("#memberInfo").html(resp.id + "<br>" + resp.pw);
              })
              .fail(function(err){
                console.log(err);
              })
    }
    let mentor_list = document.getElementById("mentoring-list");
    const axios = require('axios');

    // Make a request for a user with a given ID
    axios.get('/user?ID=12345')
            .then(function (response) {
              // handle success
              console.log(response);
            })
            .catch(function (error) {
              // handle error
              console.log(error);
            })
            .finally(function () {
              // always executed
            });

    // Optionally the request above could also be done as
    axios.get('/user', {
      params: {
        ID: 12345
      }
    })
            .then(function (response) {
              console.log(response);
            })
            .catch(function (error) {
              console.log(error);
            })
            .finally(function () {
              // always executed
            });

    // Want to use async/await? Add the `async` keyword to your outer function/method.
    async function getUser() {
      try {
        const response = await axios.get('/user?ID=12345');
        console.log(response);
      } catch (error) {
        console.error(error);
      }
    }
  </script>
</head>
<body>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  email : ${email}
  채팅방 페이지입니다. <br>
  멘토링과 메이트를 조회하시고 이메일을 클릭하세요.<br><br>
  멘토링<br>
  <button id="get_mentor" onclick="get_mentor_list()">멘토링</button>
  <div id="mentor-list">
  </div>
  메이트<br>
  <button id="get_mate" onclick="get_mate_list()">메이트</button>
  <div id="mate-list">
  </div>

  <button onclick="go_chat_room()">채팅</button>
  <input type="button" value="" onclick="go_chat_room()"/>

  기존 채팅방을 이용하고 싶으시다면 아래에서 이메일을 입력하세요.
  <table border="1">
    <tr>
      멘토링 채팅
    </tr>
    <tr>
      메이트 채팅
    </tr>
  </table>
  <button onclick="window.open('http://localhost:8080/chat/chatroom', 'window_name', 'width=430, height=500, location=no, status=no, scrollbars=yes');">열기</button>
</body>
</html>
