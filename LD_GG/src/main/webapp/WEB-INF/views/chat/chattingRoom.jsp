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
</head>
<body>
<div id="chatting-content">
</div>
<input type="text" id="chat-content"><input type="button" onclick="insert_chat_list">
<script>
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
