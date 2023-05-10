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
    /* 멘토 리스트 조회 버튼 */
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

                if(resp !== null){
                  $.each(resp, function(i, resp) {
                    rlist += '<input type="button" value="' + resp + '" onClick="go_chat_room(this.value, 0)">';
                  });
                }
                else {
                  rlist = '조회되는 데이터가 없거나 잠시 후 다시 시도하여 주시기 바랍니다.';
                }

                $("#mentor-list").html(rlist);
              })
              .fail(function(err){
                console.log(err);
              })
    }
    /* 메이트 리스트 구현하는 버튼 */
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
                  rlist += '<input type="button" value="' + resp + '" onclick="go_chat_room(this.value, 1)">';
                });

                $("#mentor-list").html(rlist);
              })
              .fail(function(err){
                console.log(err);
              })
    }

    /* chat_room에 insert 하고 팝업창 띄우기 */
    function go_chat_room(chat_receive_user, chat_category){
      console.log(chat_receive_user);

      $.ajax({
        url: "/chat/go_chatroom/",
        method: "POST",
        data: {
          'chat_category' : chat_category,
          'chat_receive_user' : chat_receive_user,
          'chat_send_user' : '${email}'
        },
        dataType : "json"
      }).done(function(resp){
        console.log(resp);

        // res = 0 실패 => alert
        // res = chat_room_seq => 팝업창으로 채팅방 열기

        if(resp == 0) {
          alert("잠시 후 다시 시도해주세요.");
        }
        else{
          console.log(resp);
          var url = "http://localhost:8080/chat/enter_chatroom?chat_room_seq=" + resp + "&chat_category=" + chat_category;

          console.log(url);
          // 팝업 창의 크기
          var width = 500;
          var height = 500;
          // 팝업 창을 화면 중앙에 위치시키기 위한 좌표 계산
          var left = (window.innerWidth / 2) - (width / 2);
          var top = (window.innerHeight / 2) - (height / 2);
          // 팝업 창을 열기 위한 window.open 함수 호출
          //var popup = window.open(url, "popup", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
          var popup = window.open(url, 'popupView', 'width=430, height=500, location=no, status=no, scrollbars=yes');
        }
        console.log(resp);
      }).fail(function (err){
        console.log(err);
      });
    }

    /* 기존 채팅방 가져오기 */
    function go_exist_chatting(chat_receive_user, chat_category){
      $.ajax({
        url: "/chat/go_exist_chatting/",
        method: "POST",
        data: {
          'chat_category' : chat_category,
          'chat_receive_user' : chat_receive_user,
          'chat_send_user' : '${email}'
        },
        dataType : "json"
      }).done(function(resp){
        console.log(resp);

        // res = 0 실패 => alert
        // res = chat_room_seq => 팝업창으로 채팅방 열기

        if(resp == 0) {
          alert("잠시 후 다시 시도해주세요.");
        }
        else{
          console.log(resp);
          var url = "http://localhost:8080/chat/enter_chatroom?chat_room_seq=" + resp + "&chat_category=" + chat_category;

          console.log(url);
          // 팝업 창의 크기
          var width = 500;
          var height = 500;
          // 팝업 창을 화면 중앙에 위치시키기 위한 좌표 계산
          var left = (window.innerWidth / 2) - (width / 2);
          var top = (window.innerHeight / 2) - (height / 2);
          // 팝업 창을 열기 위한 window.open 함수 호출
          //var popup = window.open(url, "popup", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
          var popup = window.open(url, 'popupView', 'width=430, height=500, location=no, status=no, scrollbars=yes');
        }
        console.log(resp);
      }).fail(function (err){
        console.log(err);
      });
    }

  </script>
</head>
<body>
  ${email}의 채팅방 페이지입니다. <br>
  멘토링과 메이트를 조회하시고 이메일을 클릭하세요.<br><br>
  멘토링<br>
  <button id="get_mentor" onclick="get_mentor_list()">멘토링</button>
  <div id="mentor-list">
  </div>
  메이트<br>
  <button id="get_mate" onclick="get_mate_list()">메이트</button>
  <div id="mate-list">
  </div>

  기존 채팅방을 이용하고 싶으시다면 아래에서 이메일을 입력하세요.<br>
  <div id="chatroom-list">
  </div>
  <script>
    /* 기존 채팅방 리스트를 얻어옵니다. */
    console.log('${email}');
    $.ajax({
      url: "/chat/get_chatting_list/",
      method: "POST",
      data: {
        'email' : '${email}'
      },
      dataType : "json"
    }).done(function (resp){
      console.log(resp);

      let rlist = '';

      for(key of resp){
        const miter = "'" + key.chat_receive_user +"', " + key.chat_category;
        console.log(miter);
        rlist += '<input type="button" value="';
        rlist += '${email}' == key.chat_receive_user ? key.chat_send_user : key.chat_receive_user +
                '" onclick="go_exist_chatting(' + miter +')">';
      }

      $("#chatroom-list").html(rlist);

    }).fail(function (err){
      console.log(err);
    })
  </script>
</body>
</html>
