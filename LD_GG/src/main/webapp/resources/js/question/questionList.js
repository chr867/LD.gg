const email = $("#email").html().trim();
var question_list = $("#question_list");
var tag1;
var qs = [];

console.log(email);

/* pageLoad 시 질문 리스트 가져오기 */
$.ajax({
    url: "/question/select_list_test",
    type: "POST",
    data: {
        'email': email
    },
    success: function (resp) {
        /* 내가 스크랩한 글을 배열에 담기 */
        qs = [];
        resp.question_scrape.forEach(question => qs.push(question.question_id));

        $("#question_list").html(makeQuestion_test(resp.question_all));
    }
});

/* Tab별로 질문 리스트 가져오기*/
function select_question(option) {
    /* 비로그인 시 내 스크랩, 내 질문 접근 막기 */
    if ((option == 3 || option == 4) && email === "") {
        alert("로그인 창으로 이동합니다.");
        var loginModal = new bootstrap.Modal(document.getElementById('login-modal'), {
            keyboard: true
        })
        loginModal.show();
    } else {
        $.ajax({
            method: "POST",
            url: "/question/select_list",
            data: {
                'email': email,
                'option': option,
            },
            dataType: "json",
        }).done(function (resp) {
            var rHtml = '';

            console.log(resp);

            /* 스크랩한 글을 배열에 담기(스크랩 글 업데이트) */
            if (option == 3) {
                qs = [];
                resp.forEach(question => qs.push(question.question_id));
            }

            if (resp.length === 0) {
                rHtml += "<h1 style='margin: auto;'>지금 질문을 작성해보세요!</h1>>";
            } else {
                rHtml += makeQuestion_test(resp);
            }

            $("#question_list").html(rHtml);
        }).fail(function (err) {
            console.log(err);
        });
    }

}

/* 비로그인 시 질문 작성글 이동 막기 */
$("#question_write").click(function () {
    if (email != "") {
        window.location.href = "/question/question_write";
    } else {
        alert("로그인 창으로 이동합니다.");
        var loginModal = new bootstrap.Modal(document.getElementById('login-modal'), {
            keyboard: true
        })
        loginModal.show();
    }
});

function makeQuestion(res) {
    /* Time 변환 */
    const timestamp = res.question_date;
    const date = new Date(timestamp);

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    const formattedDate = `${year}. ${month}. ${day}`;

    questionHtml = "";
    questionHtml += '<div class="question" id="question">\n' +
        '            <div class="question-hashtag" id="question_hashtag">\n';
    if (res.tag1 !== null && res.tag1 !== "") {
        questionHtml += '<div class="tag" id="tag1"># ' + res.tag1 + '</div>\n';
    }
    if (res.tag2 !== null && res.tag2 !== "") {
        questionHtml += '<div class="tag" id="tag1"># ' + res.tag2 + '</div>\n';
    }
    questionHtml += '            </div>\n' +
        '            <div class="question-info">\n' +
        '                <div class="question-title" id="question_title">' + res.question_title + '</div>\n' +
        '                <div class="question-ppt">\n' +
        '                    <div class="profile-detail">\n' +
        '                        <img src="/resources/img/profileicon/' + res.profile_icon_id + '.png" alt="이미지" class="profile-image">\n' +
        '                        <div class="profile-name" id="mento_name">' + res.lol_account + '</div>\n' +
        '                        <div class="date" id="question_date">\n' +
        '                            <span class="vertical-bar"></span>\n' +
        '                            ' + formattedDate + '\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="question-content" id="question_content">\n' + res.question_content +
        '            </div>\n' +
        '            <div class="my-scrape">\n' +
        '                <button class="my-scrape-btn" onclick="my_scrape(' + res.question_id + ')">스크랩하기</button>\n' +
        '            </div>\n' +
        '            <div class="answer-box" id="answer">\n';
    if (res.status == 0) {
        questionHtml += '<div class="answer-label">\n' +
            '                    <span class="no-answer"></span>\n' +
            '                </div>\n' +
            '                <div class="write-answer" id="write_answer">\n' +
            '                    <form method="post" action="/question/write_answer">\n' +
            '                        <div id="answer_hidden1" hidden><input type="text" name="email" value="' + email + '"></div>\n' +
            '                        <div id="answer_hidden2" hidden><input type="text" name="question_id" value="' + res.question_id + '"></div>\n' +
            '                        <textarea class="answer-t" name="a_content" placeholder="질문에 대한 답변을 입력하세요!"></textarea>\n' +
            '                        <input class="subBtn" id="subBtn" type="button" value="답변 작성" onclick="goWrite(this.form)"/>\n' +
            '                    </form>\n' +
            '                </div>'
    } else {
        $.ajax({
            method: "POST",
            url: "/question/select_answer",
            data: {
                'question_id': res.question_id
            },
            dataType: "json",
            async: false,
        }).done(function (resp) {
            var answerHtml = '';
            for (key of resp) {
                /* Time 변환 */
                const timestamp = key.answer_date;
                const date = new Date(timestamp);

                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');

                const formattedDate = `${year}. ${month}. ${day}`;

                answerHtml += '                <div class="answer-label">\n' +
                    '                    <span class="yes-answer"></span>\n' +
                    '                </div>\n' +
                    '                <div class="answer-ppt">\n' +
                    '                    <div class="profile-detail">\n' +
                    '                        <img src="/resources/img/profileicon/' + key.profile_icon_id + '.png" alt="이미지" class="profile-image">\n' +
                    '                        <div class="profile-name" id="answerer_id">' + key.lol_account + '</div>\n' +
                    '                        <div class="question-date" id="answer_date">\n' +
                    '                            <span class="vertical-bar"></span>\n' +
                    '                            ' + formattedDate + '\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '                <div class="answer-content" id="answer_content">\n' + key.answer_content +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>';
            }

            questionHtml += answerHtml;
        }).fail(function (err) {
            console.log(err);
        });
    }
    questionHtml += "</div></div>";

    return questionHtml;
}

/* 글 스크랩 */
function my_scrape(question_id, event) {
    $.ajax({
        method: "POST",
        url: "/question/my_scrape",
        data: {
            'question_id': question_id,
            'email': email
        },
        dataType: "json",
    }).done(function (res) {
        /* 스크랩 버튼을 스크랩 취소 버튼으로 변경 */
        var scrapeHtml = event.target;
        var unscrapeHtml = '                <button class="my-scrape-btn" onclick="my_unscrape(' + question_id + ', event)">스크랩 취소</button>\n'; // 삽입할 HTML 문자열
        scrapeHtml.insertAdjacentHTML("afterend", unscrapeHtml);
        scrapeHtml.remove();

        alert("글이 스크랩 되었습니다.");
    }).fail(function (err) {
        alert("중복 스크랩입니다. 내 스크랩에서 확인해주세요.");
        console.log(err);
    });
}

function tag1_search(event) {
    tag1 = event.target.value;
    var tag2 = document.getElementById("champion_txt").value;

    if (tag2 !== "") {
        $.ajax({
            method: "POST",
            url: "/question/select_tag_by_two",
            data: {
                'tag1': tag1,
                'tag2': tag2
            },
            dataType: "json",
        }).done(function (resp) {
            var rHtml = '';

            if (resp.length === 0) {
                rHtml += "<h1 style='margin: auto;'>지금 질문을 작성해보세요!</h1>";
            } else {
                rHtml += makeQuestion_test(resp);
            }

            $("#question_list").html(rHtml);
        }).fail(function (err) {
            console.log(err);
        });
    } else {
        $.ajax({
            method: "POST",
            url: "/question/select_tag_one",
            data: {
                'tag1': tag1
            },
            dataType: "json",
        }).done(function (resp) {
            var rHtml = '';

            if (resp.length === 0) {
                rHtml += "<h1 style='margin: auto;'>지금 질문을 작성해보세요!</h1>";
            } else {
                rHtml += makeQuestion_test(resp);
            }

            $("#question_list").html(rHtml);
        }).fail(function (err) {
            console.log(err);
        });
    }
}

function tag2_search() {
    var tag2 = document.getElementById("champion_txt").value;

    if (tag1 !== undefined && tag1 !== "") {
        $.ajax({
            method: "POST",
            url: "/question/select_tag_by_two",
            data: {
                'tag1': tag1,
                'tag2': tag2
            },
            dataType: "json",
        }).done(function (resp) {
            var rHtml = '';

            if (resp.length === 0) {
                rHtml += "<h1 style='margin: auto;'>지금 질문을 작성해보세요!</h1>";
            } else {
                rHtml += makeQuestion_test(resp);
            }

            $("#question_list").html(rHtml);
        }).fail(function (err) {
            console.log(err);
        });
    } else {
        $.ajax({
            method: "POST",
            url: "/question/select_tag_two",
            data: {
                'tag2': tag2
            },
            dataType: "json",
        }).done(function (resp) {
            var rHtml = '';

            if (resp.length === 0) {
                rHtml += "지금 질문을 작성해보세요!";
            } else {
                for (var key of resp) {
                    rHtml += makeQuestion_test(key);
                }
            }
            $("#question_list").html(rHtml);
        }).fail(function (err) {
            console.log(err);
        });
    }
    if (tag2 == "") {
        alert("검색어를 입력해주세요!")
    }
}

function makeQuestion_test(resp) {
    questionHtml = "";
    for (res of resp) {
        console.log(res);
        /* Time 변환 */
        const timestamp = res.question_date;
        const date = new Date(timestamp);

        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');

        const formattedDate = `${year}. ${month}. ${day}`;

        questionHtml += '<div class="question" id="question">\n' +
            '            <div class="question-hashtag" id="question_hashtag">\n';
        if (res.tag1 !== null && res.tag1 !== "") {
            questionHtml += '<div class="tag" id="tag1"># ' + res.tag1 + '</div>\n';
        }
        if (res.tag2 !== null && res.tag2 !== "") {
            questionHtml += '<div class="tag" id="tag1"># ' + res.tag2 + '</div>\n';
        }
        questionHtml += '            </div>\n' +
            '            <div class="question-info">\n' +
            '                <div class="question-title" id="question_title">' + res.question_title + '</div>\n' +
            '                <div class="question-ppt">\n' +
            '                    <div class="profile-detail">\n' +
            '                        <img src="/resources/img/profileicon/' + res.profile_icon_id + '.png" alt="이미지" class="profile-image">\n' +
            '                        <div class="profile-name" id="mento_name">' + res.lol_account + '</div>\n' +
            '                        <div class="date" id="question_date">\n' +
            '                            <span class="vertical-bar"></span>\n' +
            '                            ' + formattedDate + '\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="question-content" id="question_content">\n' + res.question_content +
            '            </div>\n' +
            '            <div class="my-scrape">\n';
        if (email !== "") {
            if(qs.some(id => id == res.question_id)){
                questionHtml += '                <button class="my-scrape-btn" onclick="my_unscrape(' + res.question_id + ', event)">스크랩 취소</button>\n';
            }
            else {
                questionHtml += '                <button class="my-scrape-btn" onclick="my_scrape(' + res.question_id + ', event)">스크랩하기</button>\n';
            }
        }
        questionHtml += '            </div>\n' +
            '            <div class="answer-box" id="answer">\n';
        if (res.status == 0) {
            questionHtml += '<div class="answer-label">\n' +
                '                    <span class="no-answer"></span>\n' +
                '                </div>\n' +
                '                <div class="write-answer" id="write_answer">\n' +
                '                    <form method="post" action="/question/write_answer">\n' +
                '                        <div id="answer_hidden1" hidden><input type="text" name="email" value="' + email + '"></div>\n' +
                '                        <div id="answer_hidden2" hidden><input type="text" name="question_id" value="' + res.question_id + '"></div>\n' +
                '                        <textarea class="answer-t" name="a_content" placeholder="질문에 대한 답변을 입력하세요!"></textarea>\n' +
                '                        <input class="subBtn" id="subBtn" type="button" value="답변 작성" onclick="goWrite(this.form)"/>\n' +
                '                    </form>\n' +
                '                </div> </div></div>'
        } else {
            $.ajax({
                method: "POST",
                url: "/question/select_answer",
                data: {
                    'question_id': res.question_id
                },
                dataType: "json",
                async: false,
            }).done(function (resp) {
                var answerHtml = '';
                for (key of resp) {
                    /* Time 변환 */
                    const timestamp = key.answer_date;
                    const date = new Date(timestamp);

                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1).padStart(2, '0');
                    const day = String(date.getDate()).padStart(2, '0');

                    const formattedDate = `${year}. ${month}. ${day}`;

                    answerHtml += '                <div class="answer-label">\n' +
                        '                    <span class="yes-answer"></span>\n' +
                        '                </div>\n' +
                        '                <div class="answer-ppt">\n' +
                        '                    <div class="profile-detail">\n' +
                        '                        <img src="/resources/img/profileicon/' + key.profile_icon_id + '.png" alt="이미지" class="profile-image">\n' +
                        '                        <div class="profile-name" id="answerer_id">' + key.lol_account + '</div>\n' +
                        '                        <div class="question-date" id="answer_date">\n' +
                        '                            <span class="vertical-bar"></span>\n' +
                        '                            ' + formattedDate + '\n' +
                        '                        </div>\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '                <div class="answer-content" id="answer_content">\n' + key.answer_content +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div></div>';
                }

                questionHtml += answerHtml;
            }).fail(function (err) {
                console.log(err);
            });

            console.log(questionHtml);
        }
    }
    return questionHtml;
}

function my_unscrape(question_id, event) {
    $.ajax({
        method: "POST",
        url: "/question/my_unscrape",
        data: {
            'question_id': question_id,
            'email': email
        },
        dataType: "json",
    }).done(function (res) {
        if (res > 0) {
            var scrapeHtml = event.target;
            var unscrapeHtml = '<button class="my-scrape-btn" onclick="my_scrape(' + question_id + ', event)">스크랩하기</button>\n'; // 삽입할 HTML 문자열
            scrapeHtml.insertAdjacentHTML("afterend", unscrapeHtml);
            scrapeHtml.remove();

            alert("스크랩이 취소되었습니다.");
        }
        else {
            alert("잠시 후 다시 시도해주세요!")
        }
    }).fail(function (err) {
        console.log(err);
    });
}

function hasNextElement(array, index) {
    return index < array.length - 1;
}
