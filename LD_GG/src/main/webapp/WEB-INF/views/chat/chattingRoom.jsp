<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/10
  Time: 3:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>chattingRoom</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function insert_chat_list(){
            const chat_content = $("chat-content").value;

            $.ajax({
                method : "POST",
                url : "/chat/insert_chat_content",
                data : {
                    "chat_room_seq" : ${chat_room_seq},
                    "chat_category" : ${chat_category},
                    "chat_content" : chat_content
                },
                dataType : "json"
            })
                .done(function (resp){
                    console.log(resp);
                    // 업데이트 된 채팅 seq 가져오기
                })
                .fail(function(err){
                    console.log(err);
                })
        }
    </script>
</head>
<body>
<div id="chatting-content">
</div>
<input type="text" id="chat-content"><input type="button" onclick="insert_chat_list">
<script>
    console.log('${email}');
    console.log('${chat_room_seq}');
    console.log('${chat_category}');

    const chat_room_seq = '${chat_room_seq}';
    const socket = new SockJS('/chat/chatroom');
    var stompClient = Stomp.over(socket);


    // var roomId = 1;
    // var socket = new SockJS('/chat/chatroom');
    // var stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/' + chat_room_seq, function (message) {
            showMessage(JSON.parse(message.body).content);
        });
    });

    function send(event) {
        var messageContent = messageInput.value.trim();

        if(messageContent && stompClient) {
            var chatMessage = {
                sender: username,
                content: messageInput.value,
                type: 'CHAT'
            };

            stompClient.send("/app/chat.send", {}, JSON.stringify(chatMessage));
            messageInput.value = '';
        }
        event.preventDefault();
    }


    function sendMessage() {
        var messageContent = document.getElementById('message').value;
        stompClient.send("/app/chat/" + roomId + "/sendMessage", {}, JSON.stringify({
            'content': messageContent
        }));
    }

    function showMessage(messageContent) {
        var messageArea = document.getElementById('messageArea');
        messageArea.innerHTML += '<div>' + messageContent + '</div>';
    }

    $.ajax({
        method : "POST",
        url : "/chat/get_chatting_data",
        data : {
            'chat_room_seq' : '${chat_room_seq}'
        },
        dataType : "json",
    })
        .done(function(resp){
            console.log(resp);

            let rlist = '';

            if(resp !== null){
                $.each(resp, function(i, resp) {
                    // chat_content, chat_timestamp 찍기
                    rlist += '<div>'+ i +'</div>';
                });
            }
            else {
                rlist = '환영합니다!';
            }

            $("#chatting-content").html(rlist);
        })
        .fail(function(err){
            console.log(err);
        })
</script>
</body>
</html>
