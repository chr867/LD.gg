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
</head>
<body>
    <div id="email">
        ${email}
    </div>
    <div id="chat_room_seq">
        ${chat_room_seq}
    </div>
    <div id="chat_category">
        ${chat_category}
    </div>
    <div id="chatting-content">
    </div>
    <input type="text" id="send-chat-content"><input type="button" onclick="sendMessage()">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <script src="/resources/js/chat_1.js"></script>
</body>
</html>
