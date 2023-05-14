<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/12
  Time: 7:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>질문글 게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- include summernote css/js -->
    <link
            href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
            rel="stylesheet">
    <script
            src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
</head>
<body>
<div id="email" hidden>
    ${email}
</div>
<div>
    <div>
        <div><button onclick="select_question(this.value)" value="1">답변 완료</button></div>
        <div><button onclick="select_question(this.value)" value="2">답변 대기</button></div>
        <div><button onclick="select_question(this.value)" value="3">내 스크랩</button></div>
        <div><button onclick="select_question(this.value)" value="4">내 질문</button></div>
    </div>
    <div id="tag_list">
        <div id="all">전체</div>
        <div id="position">
            <button id="hidden_position">포지션</button>
            <div id="tag_position" hidden="true">
                <select id="position-dropdown">
                    <option value="top">탑</option>
                    <option value="jungle">정글</option>
                    <option value="mid">미드</option>
                    <option value="bottom">바텀</option>
                    <option value="supporter">서포터</option>
                </select>
            </div>
        <div id="champion">
            <button id="hidden_champion">챔피언</button>
            <div id="tag_champion" hidden="true"><input type="text" id="champion_txt"></div>
        </div>
    </div>
    <div>
        <div><button id="question_write">질문 작성하기</button></div>
    </div>
    <div id="question_list">
        <div id="question">
            <div id="question_hashtag">
                <div id="tag1"></div>
                <div id="tag2"></div>
            </div>
            <div id="question_date">날짜</div>
            <div id="question_profile">사진</div>
            <div id="question_title">질문 제목</div>
            <div id="question_content">질문 내용</div>
            <div id="answer">
                <div id="answerer_id">답변 작성자</div>
                <div id="answer_content">답변 내용</div>
                <div id="write_answer">
                    <form method="post" action="/question/write_answer">
                        <div id="answer_hidden1" hidden><input type="text" name="email" value="${email}"></div>
                        <div id="answer_hidden2" hidden><input type="text" name="question_id" value="0"></div>
                        <textarea id="summernote" name="a_content">${content}</textarea></br>
                        <input id="subBtn" type="button" value="답변 작성" onclick="goWrite(this.form)" />
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/resources/js/questionList.js"></script>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        //여기 아래 부분
        $('#summernote').summernote({
            width : 200,
            height : 200, // 에디터 높이
            minHeight : null, // 최소 높이
            maxHeight : null, // 최대 높이
            focus : true, // 에디터 로딩후 포커스를 맞출지 여부
            lang : "ko-KR", // 한글 설정
            placeholder : '최대 2048자까지 쓸 수 있습니다' //placeholder 설정

        });
    });

    function goWrite(frm) {
        let contents = frm.a_content.value; //공백 => &nbsp
        console.log(contents);
        let question_id = frm.question_id.value;
        console.log(question_id);
        let email = frm.email.value;
        console.log(email);

        if (contents.trim() == '') {
            alert('내용을 입력해주세욧!!!')
            return false;
        }

        frm.submit();
    }
</script>
</html>