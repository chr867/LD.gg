<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MateWrite.jsp</title>
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
</head>

<style type="text/css">
body {
      image-rendering: -webkit-optimize-contrast; /* chrome */
      background-image: url("/resources/img/mate/back.png");
      background-size: 100%;
      overflow-x: hidden;
}
form {
    display:flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.note-editor note-frame panel panel-default {
 display:flex;
 flex-start:center;
 align-items: center;

}
form div {
 display:block;
}
.note-editor.note-airframe .note-editing-area, .note-editor.note-frame .note-editing-area {
    height: 740px;
    overflow: hidden;
}

.panel {

    height: 800px;
    width:900px;
    margin-bottom: 20px;
    background-image: url("/resources/img/mate/m-w-b3.png");
    background-size: 100%;
    background-repeat: no-repeat;
    background-color: transparent;
    border-radius: 4px;
    -webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);
    box-shadow: 0 1px 1px rgba(0,0,0,.05);
}
</style>

<body>
	<div id="mate-w-header">
	<img>
	</div>
	<h3 style="text-align: center; color:red;">${errorMsg}</h3>
	<div style="width: 60%; margin: auto;">
		<form method="post" action="/mate/write_mate"><!-- 액션=요청URL -->
		<input type="text" name="mate_title" style="width: 40%;"
				placeholder="제목" value="${title}"/>
		<br> <br>
		<textarea id="summernote" name="mate_content">${content}</textarea>
		<br> 
		<input id="subBtn" type="button"
			   value="글 작성" onclick="goWrite(this.form)" /> <input id="reset"
			   type="reset" value="취소">
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#summernote').summernote({
			height : 300, // 에디터 높이
			minHeight : null, // 최소 높이
			maxHeight : null, // 최대 높이
			focus : true, // 에디터 로딩후 포커스를 맞출지 여부
			lang : "ko-KR", // 한글 설정
			placeholder : '최대 2048자까지 쓸 수 있습니다' //placeholder 설정

		});
	});
	function goWrite(frm){//goWrite(this.form) 위에 이거 작성해놔서
		console.log('frm '+frm);
		let title =frm.mate_title.value;
		console.log('메이트 글 제목'+title);
		console.log(title);
		let contents = frm.mate_content.value; //공백 => &nbsp 
		console.log(contents);
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