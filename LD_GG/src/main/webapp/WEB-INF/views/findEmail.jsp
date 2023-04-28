<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
</head>
<body>
	<h1>이메일 찾기~~~~~~</h1>
	<input class="input" type="text" id="phone" name="phone_num">
	<input type="button" id="find_email" value="이메일 찾기">
	<span id="result"></span>
	</td>
</body>
<script type="text/javascript">
$('#find_email').on('click',function(){
	if($('#phone').val() !=''){
		$.ajax({
			method: 'get',
			url: '/find_email',
			data: {phone_num:$('#phone').val()},
		}).done(res=>{
			console.log(res);
			if(res.length !== 0){
				$('#result').html(res).css('color','blue');

			}else{
				$('#result').html("등록된 이메일 없음").css('color','red');
			}
			
		}).fail(err=>{
			console.log(err);
		})
	}
})
</script>
</html>