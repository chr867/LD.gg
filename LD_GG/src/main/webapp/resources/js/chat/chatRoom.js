/* 세션 정보 */
const email = $("#email").html().trim();
const chat_room_seq = $("#chat_room_seq").html().trim();
const chat_category = $("#chat_category").html().trim();
const receive_user = $("#receive_user").html().trim();
const profile_icon_id = $("#profile_icon_id").html().trim();

/* Header 만들기 */
var hl = '<div class="profile-detail"><img src="/resources/img/profileicon/' + profile_icon_id + '.png" alt="이미지" class="profile-image"><div class="profile-name" id="mento_name">' + receive_user + '</div></div></div>';
$(".chatroom-header").html(hl);

/* 이전 채팅 기록 띄우는 ajax */
$.ajax({
    method: "POST",
    url: "/chat/get_chatting_data",
    data: {
        'chat_room_seq': chat_room_seq
    },
    dataType: "json",
}).done(function (resp) {
    var rHtml = '';

    resp.forEach((key) => {
        rHtml += makeBalloon(key);
    })

    $(".chat-content").html(rHtml);

    $(".chat-around").scrollTop($(".chat-content").height());
}).fail(function (err) {
    console.log(err);
})

/* 소켓 */
const socket = new SockJS('/chat/chatroom');
var stompClient = Stomp.over(socket);

/* stompClient 통신 연결 */
stompClient.connect({}, function (frame) {
    console.log("Connected : " + frame);
    stompClient.subscribe('/topic/' + chat_room_seq, function (message) {
        console.log("message : " + message);
        showMessage(message);
    })
});

/* 메시지 보내기 */
function sendMessage(chat_content) {
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
    const time = currentTime.toLocaleString('ko-KR', options).replace(/\. /g, '-');
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
        chat_time: timeStamp
    };
    stompClient.send('/app/chat/chatroom/' + chat_room_seq, {}, JSON.stringify(message));
}

/* 메시지 수신 */
function showMessage(message) {
    const messageBody = JSON.parse(message.body);

    var rHtml = makeBalloon(messageBody);

    const chat_content = document.querySelector(".chat-content");
    chat_content.insertAdjacentHTML('beforeend', rHtml);

    console.log("messageContent : ", messageBody);
    $(".chat-around").scrollTop($(".chat-content").height());
}

/* css control */
function formattedDate(dateString) {
    var date = new Date(dateString);
    var month = date.getMonth() + 1; // 월 가져오기
    var day = date.getDate(); // 일 가져오기
    var hours = date.getHours(); // 시간 가져오기
    var minutes = date.getMinutes(); // 분 가져오기

    console.log("dateString : " +  dateString);
    console.log("date : " + date);

    if (month < 10) {
        month = '0' + month; // 05월
    }
    if (day < 10) {
        day = '0' + day; // 01일
    }

    var formattedDate = month + '월 ' + day + '일 ' + hours + ':' + minutes;

    return formattedDate;
}

function makeBalloon(chat) {
    var blHtml = '';

    if (chat.chat_user == email) {
        blHtml += '<div class="chat-content-receive" id="chatting-content-receive">\n' +
            '        <div class="chat-time-content">\n' +
            '            <div class="time">' + formattedDate(chat.chat_time) + '</div>' +
            '<div class="speech-bubble-r">\n' +
            '                <p>' + chat.chat_content + '</p>\n' +
            '            </div>\n' +
            '        </div>\n' +
            '    </div>';
    } else {
        blHtml += '<div class="chat-content-send" id="chatting-content-send">\n' +
            '            <div class="profile-detail">\n' +
            '                <img src="/resources/img/profileicon/0.png" alt="이미지" class="profile-image">\n' +
            '                <div class="profile-name" id="mento_name">' + receive_user + '</div>\n' +
            '            </div>\n' +
            '            <div\n' +
            '            <div class="chat-time-content">\n' +
            '                <div class="speech-bubble-l">\n' +
            '                    <p>' + chat.chat_content + '</p>\n' +
            '                </div>\n' +
            '                <div class="time">' + formattedDate(chat.chat_time) + '</div>\n' +
            '            </div>\n' +
            '        </div>'
    }

    return blHtml;
}

document.getElementById("send_content").addEventListener("keydown", function (event) {
    if (event.shiftKey && event.key === "Enter") {
        console.log('ENTER + SHIFT 호출');
        this.value = this.value + "\n";
        this.style.height = "auto";
        this.style.height = this.scrollHeight + "px";
    } else if (event.keyCode === 13 && this.value !== "") {
        sendMessage(this.value);
        this.style.height = 'auto';
        this.value = "";
    }
});

document.addEventListener('keydown', function (event) {
    if (event.keyCode === 13) {
        event.preventDefault();
    }

}, true);

function send() {
    send_message = document.getElementById("send_content").value;
    if(send_message !== "") {
        sendMessage(send_message);
        document.getElementById("send_content").value = "";
    }
}

function textareaHeight(textarea) {
    textarea.style.height = "auto";
    textarea.style.height = textarea.scrollHeight + "px";
}
/* css control end line */