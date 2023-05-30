$(document).ready(function() {
    var email = $("#email").html().trim();
    console.log(email);

    var summonerName = document.getElementById('session-summoner-name').innerText;
    var userType = document.getElementById('session-user-type').innerText;

    sessionCheck(summonerName, userType);

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
});

function chatPopup() {
    var url = "/chat/list";
    window.open(url, "_blank", "width=530,height=670");
}

/* 메시지 수신 */
function showMessage(message){
    var email = $("#email").html().trim();

    const messageBody = JSON.parse(message.body);

    /* chat_noti에 알림 온 noti 저장하기 */
    if(email !== messageBody.chat_user){
        $(".alarm-notification").css("display", "block");
        var chat_noti = document.querySelector(".chat-noti")
        var noti_box = '<div className="noti-box">' + messageBody.chat_user + '님이 메시지를 보냈습니다.</div>'
        chat_noti.insertAdjacentHTML('beforeend', noti_box);

        /* 메시지 토스트 */
        showToast("메시지가 도착했습니다.");
    }

    console.log("messageContent : ", messageBody);
}

function showChatnoti(){
    var element = document.querySelector(".chat-noti");
    var alarm = document.querySelector(".alarm-notification");

    if (element.style.display === 'none') {
        element.style.display = 'block';
    } else {
        alarm.style.display = 'none';
        element.style.display = 'none';
    }
}

/* 토스트 메시지 보여주기 */
function showToast(message) {
    var toastContainer = document.getElementById("toast-container");

    var toast = document.createElement("div");
    toast.classList.add("toast");
    toast.setAttribute("role", "alert");
    toast.setAttribute("aria-live", "assertive");
    toast.setAttribute("aria-atomic", "true");

    var toastHeader = document.createElement("div");
    toastHeader.classList.add("toast-header");

    var toastBody = document.createElement("div");
    toastBody.classList.add("toast-body");
    toastBody.textContent = message;

    toast.appendChild(toastHeader);
    toast.appendChild(toastBody);

    toastContainer.appendChild(toast);

    var bootstrapToast = new bootstrap.Toast(toast);
    bootstrapToast.show();

    setTimeout(function() {
        toastContainer.removeChild(toast);
    }, 3000);
}