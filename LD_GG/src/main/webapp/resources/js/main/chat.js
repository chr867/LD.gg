$(document).ready(function() {
    // var email = document.getElementById('')

    var summonerName = document.getElementById('session-summoner-name').innerText;
    var userType = document.getElementById('session-user-type').innerText;

    sessionCheck(summonerName, userType);
});

function chatPopup(){
    url = "http://localhost:8080/chat/list"
    window.open(url, "_blank", "width=500,height=500,alwaysRaised=yes");
}