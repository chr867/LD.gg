<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/14
  Time: 3:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link
        href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
        rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
<body>
<h1>질문 작성 페이지</h1>
<h2 style="text-align: center;">질문글</h2>

<div style="width: 60%; margin: auto;">
  <form method="post" action="/question/write_question">
    <!-- enctype="multipart/form-data" -->
    <input type="text" name="q_title" style="width: 40%;"
           placeholder="제목" value="${title}"/> <br> <br>
    <textarea id="summernote" name="q_content">${content}</textarea>
    <br>
    태그 입력 : <input type="text" name="q_hashtag" style="width: 40%;" placeholder="해시태그 입력" value="${hashtag}"/> <br> <br>
    <input id="subBtn" type="button" value="글 작성" onclick="goWrite(this.form)" />
    <input id="reset" type="reset" value="취소">
  </form>
</div>
</body>
<script type="text/javascript">
  $(document).ready(function() {
    //여기 아래 부분
    $('#summernote').summernote({
      height : 300, // 에디터 높이
      minHeight : null, // 최소 높이
      maxHeight : null, // 최대 높이
      focus : true, // 에디터 로딩후 포커스를 맞출지 여부
      lang : "ko-KR", // 한글 설정
      placeholder : '최대 2048자까지 쓸 수 있습니다' //placeholder 설정

    });
  });

  function goWrite(frm) {
    let title = frm.q_title.value;
    console.log(title);
    let contents = frm.q_content.value; //공백 => &nbsp
    console.log(contents);
    let hashtag = frm.q_hashtag.value;
    var tagStrig = hashtag.replace(/\s/g, "");
    var tag = tagStrig.split("#");


    if (title.trim() == '') {
      alert('제목을 입력해주세욧!!')
      return false;
    }
    if (contents.trim() == '') {
      alert('내용을 입력해주세욧!!!')
      return false;
    }

    frm.submit();
  }
</script>
</html>
