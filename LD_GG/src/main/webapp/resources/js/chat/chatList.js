var email = document.getElementById('email').innerHTML.trim();

/* css control */
openTab('allTab');

function openTab(tabName) {
    var i, tabContent;
    const divs = document.querySelectorAll('.tab');

    if (event?.target){
        var selectDiv = event.target;
    }
    else{
        var selectDiv = document.querySelector(`.tab:nth-child(1)`);
    }

    console.log(selectDiv);

    divs.forEach(div => {
        const selectedDiv = document.querySelector('.tab.selected');

        if (selectedDiv) {
            selectedDiv.classList.remove('selected');
        }
    })

    tabContent = document.getElementsByClassName("tab-content");
    tab = document.getElementsByClassName("tab");

    for (i = 0; i < tabContent.length; i++) {
        tabContent[i].style.display = "none";
    }

    document.getElementById(tabName).style.display = "block";
    document.getElementById(tabName).style.backgroundColor = "#c7c7c7";
    selectDiv.classList.add('selected');
}
/* css control end line */

/* 멘토 또는 멘티, 메이트 리스트 띄우기 */
$.ajax({
    url: "/chat/get_mento_mate",
    method: "POST",
    data: {
        'email' : email
    },
    dataType : "json"
}).done(function (resp){
    var allHTML = '';
    var mentoringHTML = '';
    var mateHTML = '';

    /* 멘토링 리스트 */
    mentoringHTML += makeLi(resp.mentor_list);
    allHTML += makeLi(resp.mentor_list);
    mentoringHTML += makeLi(resp.menti_list);
    allHTML += makeLi(resp.menti_list);

    /* 메이트 리스트 */
    mateHTML += makeLi(resp.mate_list);
    allHTML += makeLi(resp.mate_list);
    mateHTML += makeLi(resp.mateapp_list);
    allHTML += makeLi(resp.mateapp_list);

    $(".all-list").html(allHTML);
    $(".mentoring-list").html(mentoringHTML);
    $(".mate-list").html(mateHTML);
}).fail(function (err){
    console.log(err);
})

/* 채팅방 select, insert */
function go_chat__(receiveemail, chat_category, lol_account){
    $.ajax({
        url: "/chat/go_chat",
        method: "POST",
        data: {
            'chat_category' : chat_category,
            'chat_receive_user' : receiveemail,
            'chat_send_user' : email
        },
        dataType : "json"
    }).done(function(resp){
        console.log(resp);

        // res = 0 실패 => alert
        // res = chat_room_seq => 팝업창으로 채팅방 열기

        if(resp == 0) {
            alert("잠시 후 다시 시도해주세요.");
        }
        else{
            console.log(resp);
            var url = "/chat/enter_chatroom?chat_room_seq=" + resp + "&chat_category=" + chat_category + "&lol_account=" + lol_account;

            var width = 520;
            var height = 600;
            var left = (window.innerWidth / 2) - (width / 2);
            var top = (window.innerHeight / 2) - (height / 2);
            var popup = window.open(url, 'popupView', 'width=430, height=500, location=no, status=no, scrollbars=yes');
        }
    }).fail(function (err){
        console.log(err);
    });
}

function makeLi(arr){
    var liHtml = '';

    arr.forEach((key, index) => {
        liHtml += '<li><div class="profile-detail"><img src="img/profileicon/'+ index + '.png" alt="이미지" class="profile-image">';
        liHtml += '<div class="profile-name" value="'+ key.email +'" onclick="go_chat__(' + "'" + key.email + "'" + ', 1, ' + "'" + key.lol_account + "'"  +')">' +  key.lol_account +'</div>';
        if(index == 1){
            liHtml += '<div class="profile-msg">좋은 하루!</div>';
        }
        liHtml += '</div></li>';

        console.log(liHtml)
    });

    /*for(k of arr){
        liHtml += '<li><div class="profile-detail"><img src="img/profileicon/0.png" alt="이미지" class="profile-image">';
        liHtml += '<div class="profile-name" value="'+ k.email +'" onclick="go_chat__(' + "'" + k.email + "'" + ', 1)">'+ k.lol_account +'</div>';
        liHtml += '</div></li>';
    }*/

    console.log(liHtml)

    return liHtml;
}