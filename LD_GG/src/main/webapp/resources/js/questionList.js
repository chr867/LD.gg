const email = $("#email").html().trim();
var question_list = $("#question_list");

console.log(email);

/* pageLoad 시 질문 리스트 가져오기 */
$.ajax({
    url: "/question/select_list_all",
    type: "POST",
    data: {},
    success: function(resp) {
        console.log(resp);
        var rlist = '';

        if(resp.length === 0){
            rlist += "지금 질문을 작성해보세요!";
        }
        else {
            for(var key of resp){
                rlist += '<div id="question"><div id="question_hashtag">' +
                    '<div id="tag1"> tag1 : ' + key.tag1 + '</div>' +
                    '<div id="tag1"> tag2 : ' + key.tag2 + '</div></div>' +
                    '<div id="question_date"> question_date : ' + key.question_date + '</div>' +
                    '<div id="question_profile"> question_profile : ' + '사진' + '</div>' +
                    '<div id="question_title"> question_title : ' + key.question_title + '</div>' +
                    '<div id="question_content"> question_content : ' + key.question_content + '</div></div>';

                console.log(key.status);

                if(key.status == 0){
                    rlist += '<div id="write_answer">' +
                        '<form method="post" action="/question/write_answer">' +
                        '<div id="answer_hidden1" hidden><input type="text" name="email" value="' + email + '"></div>' +
                        '<div id="answer_hidden2" hidden><input type="text" name="question_id" value="' + key.question_id + '"></div>' +
                        '<textarea id="summernote" name="a_content"></textarea></br>' +
                        '<input id="subBtn" type="button" value="답변 작성" onclick="goWrite(this.form)" />' +
                        '</form>' +
                        '</div>';
                }
                else if(key.status == 1){
                    $.ajax({
                        method : "POST",
                        url : "/question/select_answer",
                        data : {
                            'question_id' : key.question_id
                        },
                        dataType : "json",
                        async: false,
                    }).done(function(resp){
                        console.log("answer resp : ", resp);

                        for(var res of resp){
                            rlist += '<div id="answer"><div id="answerer_id">답변 작성자 : ' + res.answerer_id + '</div>' +
                                '<div id="answer_content">답변 내용 : '+ res.answer_content +'</div></div>';
                        }
                    }).fail(function(err){

                    });
                }
            }
        }
        $("#question_list").html(rlist);
    }
});

/* Tab별로 질문 리스트 가져오기*/
function select_question(option){
    select_option = option;
    $.ajax({
        method : "POST",
        url : "/question/select_list",
        data : {
            'email' : email,
            'option' : option,
        },
        dataType : "json",
    }).done(function(resp){
        var rlist = '';

        if(resp.length === 0){
            rlist += "지금 질문을 작성해보세요!";
        }
        else {
            for(var key of resp){
                rlist += '<div id="question"><div id="question_hashtag">' +
                    '<div id="tag1"> tag1 : ' + key.tag1 + '</div>' +
                    '<div id="tag1"> tag2 : ' + key.tag2 + '</div></div>' +
                    '<div id="question_date"> question_date : ' + key.question_date + '</div>' +
                    '<div id="question_profile"> question_profile : ' + '사진' + '</div>' +
                    '<div id="question_title"> question_title : ' + key.question_title + '</div>' +
                    '<div id="question_content"> question_content : ' + key.question_content + '</div></div>';

                console.log(key.status);

                if(key.status == 0){
                    rlist += '<div id="write_answer">' +
                        '<form method="post" action="/question/write_answer">' +
                        '<div id="answer_hidden1" hidden><input type="text" name="email" value="' + email + '"></div>' +
                        '<div id="answer_hidden2" hidden><input type="text" name="question_id" value="' + key.question_id + '"></div>' +
                        '<textarea id="summernote" name="a_content"></textarea></br>' +
                        '<input id="subBtn" type="button" value="답변 작성" onclick="goWrite(this.form)" />' +
                        '</form>' +
                        '</div>';
                }
                else if(key.status == 1){
                    $.ajax({
                        method : "POST",
                        url : "/question/select_answer",
                        data : {
                            'question_id' : key.question_id
                        },
                        dataType : "json",
                        async: false,
                    }).done(function(resp){
                        console.log("answer resp : ", resp);

                        for(var res of resp){
                            rlist += '<div id="answer"><div id="answerer_id">답변 작성자 : ' + res.answerer_id + '</div>' +
                                '<div id="answer_content">답변 내용 : '+ res.answer_content +'</div></div>';
                        }
                    }).fail(function(err){

                    });
                }
            }
        }
        $("#question_list").html(rlist);
    }).fail(function(err){
        console.log(err);
    });
}

$("#hidden_position").on("click", function() {
    var isHidden = $("#tag_position").attr("hidden");

    console.log(isHidden);

    if(isHidden == 'hidden'){
        $("#tag_position").attr("hidden", false);
    }
    else {
        $("#tag_position").attr("hidden", true);
    }
});

$("#hidden_champion").on("click", function() {
    var isHidden = $("#tag_champion").attr("hidden");

    console.log(isHidden);

    if(isHidden == 'hidden'){
        $("#tag_champion").attr("hidden", false);
    }
    else {
        $("#tag_champion").attr("hidden", true);
    }
});

$("#question_write").click(function() {
    window.location.href = "/question/question_write";
});
$("#answer_write").click(function() {
    window.location.href = "/question/answer_write";
});

/* 답변 찾아오기 */
function select_answer(question_id){
    var rlist = '';
    $.ajax({
        method : "POST",
        url : "/question/select_answer",
        data : {
            'question_id' : question_id
        },
        dataType : "json",
        async: true,
    }).done(function(resp){
        console.log("answer resp : ", resp);

        for(var res of resp){
            rlist += '<div id="answer"><div id="answerer_id">답변 작성자 : ' + res.answerer_id + '</div>' +
                '<div id="answer_content">답변 내용 : '+ res.answer_content +'</div></div>';
        }
    }).fail(function(err){
        console.log(err);
    });

    return rlist;
}