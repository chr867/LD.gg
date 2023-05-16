/* 세션 정보 */
const email = $("#chat_room_seq").html().trim();
const chat_room_seq = $("#chat_room_seq").html().trim();
const chat_category = $("#chat_category").html().trim();

console.log(email);
console.log(chat_room_seq);
console.log(chat_category);

/* 이전 채팅 기록 띄우는 ajax */
$.ajax({
    method : "POST",
    url : "/chat/get_chatting_data",
    data : {
        'chat_room_seq' : chat_room_seq
    },
    dataType : "json",
}).done(function(resp){
    console.log("resp : ", resp);

    let rlist = "";

    console.log(typeof(resp));
    console.log("resp : ", resp.length);

    if(resp.length === 0){
        console.log("if...")
        rlist += "환영합니다!";
    }
    else {
        console.log("else...")
        for(key of resp){
            rlist += "<div>" + key.chat_user + "</div>" + "<div>" + key.chat_content + "</div>" + "<div>" + key.chat_user + "</div>" +
                "<div>" + key.chat_time + "</div>";
        }
    }
    $("#chatting-content").html(rlist);
}).fail(function(err){
    console.log(err);
})

/* 소켓 */
const socket = new SockJS('/chat/chatroom');
var stompClient = Stomp.over(socket);

/* stompClient 통신 연결 */
stompClient.connect({}, function (frame){
    console.log("Connected : " + frame);
    stompClient.subscribe('/topic/' + chat_room_seq, function (message){
        console.log(message);
        showMessage(message);
    })
});

/* 메시지 보내기 */
function sendMessage() {

    const chat_content = $("#send-chat-content").val();

    /* 시간 관련 */
    const currentTime = new Date();
    const options = {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false,
        timeZone: 'Asia/Seoul' // 한국 표준시간대 (KST)
    };
    const time = currentTime.toLocaleString('ko-KR', options)
        .replace(/\. /g, '-');
    const datePart = time.slice(0, 10);
    const timePart = time.slice(11);

    const timeStamp = datePart + " " + timePart;

    console.log(datePart);
    console.log(timePart);

    console.log("chat_content: " + chat_content);
    console.log("timestamp: " + timeStamp);

    const message = {
        chat_category: parseInt(chat_category),
        chat_content: chat_content,
        chat_user: email,
        chat_time : timeStamp
    };

    console.info(message);

    stompClient.send('/app/chat/chatroom/' + chat_room_seq, {}, JSON.stringify(message));
}

/* 메시지 수신 */
function showMessage(message){
    const messageBody = JSON.parse(message.body);

    var chatting_content = $("#chatting-content").html();

    console.log("messageContent : ", messageBody);

    chatting_content += '<div> 보낸 사람 : ' + messageBody.chat_user + '</div>';
    chatting_content += '<div> 보낸 내용 : ' + messageBody.chat_content + '</div>';
    chatting_content += '<div> 보낸 내용 : ' + messageBody.chat_time + '</div>';

    $("#chatting-content").html(chatting_content);
}
