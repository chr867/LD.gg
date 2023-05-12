<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MateWrite.jsp</title>
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
	<h1>메이트 게시판 글 수정 페이지</h1>
	<h2 style="text-align: center;">글 작성</h2>
	<h3 style="text-align: center; color:red;">${errorMsg}</h3>
	<div style="width: 60%; margin: auto;">
		<form method="post" action="/mate/write_mateModify"><!-- 액션=요청URL -->
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