$(document).ready(function() {
    // var email = document.getElementById('')

    var summonerName = document.getElementById('session-summoner-name').innerText;
    var userType = document.getElementById('session-user-type').innerText;

    sessionCheck(summonerName, userType);
});

function chatPopup() {
    var url = "/chat/list";
    window.open(url, "_blank", "width=530,height=670");
}