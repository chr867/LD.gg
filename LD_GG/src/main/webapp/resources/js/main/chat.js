$(document).ready(function() {
    // var email = document.getElementById('')

    var summonerName = document.getElementById('session-summoner-name').innerText;
    var userType = document.getElementById('session-user-type').innerText;

    sessionCheck(summonerName, userType);
});

function chatPopup(){
    url = "/chat/list"
    window.open(url, "_blank", "width=400,height=600,alwaysRaised=yes");
}