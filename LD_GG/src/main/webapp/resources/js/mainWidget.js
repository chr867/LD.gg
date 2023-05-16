const email = $("#email").html().trim();
console.log(email);

/* 소켓 */
const socket = new SockJS('/chat/chatroom');
var stompClient = Stomp.over(socket);

/* stompClient 통신 연결 */
stompClient.connect({}, function (frame){
    console.log("Connected : " + frame);
    stompClient.subscribe('/topic/' + email, function (message){
        console.log(message);
        showMessage(message);
    })
});

/* 메시지 수신 */
function showMessage(message){
    const messageBody = JSON.parse(message.body);

    var chatting_content = $(".widget-container").html();

    console.log("messageContent : ", messageBody);

    chatting_content += '<div>' + messageBody.chat_user + ' 님이';
    chatting_content += messageBody.chat_content + '라고 보냈습니다.</div>';
    // chatting_content += '<div> 보낸 내용 : ' + messageBody.chat_time + '</div>';

    console.log(chatting_content);
    $(".widget-container").html(chatting_content);
}