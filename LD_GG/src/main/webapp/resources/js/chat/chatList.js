var email = '';
$(document).ready(function() {
    /* email 저장 */
    email = document.getElementById('email').innerHTML.trim();

    /* 멘토 또는 멘티, 메이트 리스트 띄우기 */
    $.ajax({
        url: "/chat/get_mento_mate",
        method: "POST",
        data: {
            'email' : email
        },
        dataType : "json"
    }).done(function (resp){
        rlst = '';

        console.log(resp);

        /* 멘토링 리스트 */

        /* 메이트 리스트 */

    }).fail(function (err){
        console.log(err);
    })
});