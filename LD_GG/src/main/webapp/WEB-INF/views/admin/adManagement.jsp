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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
</head>

<body>
	<h1>광고관리 페이지</h1>
		<div class="input-box">
		  <label for="advertiser">광고주:</label>
		  <input type="text" id="ad_advertiser" name="advertiser">
		
		  <label for="company-name">업체명:</label>
		  <input type="text" id="ad_name" name="company-name">
		
		  <label for="display-period">노출기간:</label>
		  <input type="date" id="start_date" name="display-period"> ~
		  <input type="date" id="end_date" name="display-period">
		
		  <label for="ad-cost">광고비:</label>
		  <input type="number" id="ad_pay" name="ad-cost">
		  
		  <button id="adSubmit" onclick="adRegistration()">등록</button>
		</div>
</body>
<script type="text/javascript">
	function adRegistration() {
		const ad_advertiser = document.getElementById("ad_advertiser").value;
		const ad_name = document.getElementById("ad_name").value;
		const ad_start_date = document.getElementById("start_date").value;
		const ad_end_date = document.getElementById("end_date").value;
		const ad_pay = document.getElementById("ad_pay").value;
		
		$.ajax({
	        method: 'post',
	        url: '/userinterface/ad/regist',
	        data: {ad_advertiser:ad_advertiser,
	        	   ad_name:ad_name,
	        	   ad_start_date:ad_start_date,
	        	   ad_end_date:ad_end_date,
	        	   ad_pay:ad_pay},
	      }).done(res=>{
	        console.log(res);
	        if (res) {
	        	  console.log(res);
	        	  document.getElementById("comment-textarea").value = null;
	        	  loadComments(); //댓글 등록시 비동기로 댓글로드
	        	} else {
	        	  console.log(res)
	        	  alert("댓글 등록 실패")
	        	} 
	      }).fail(err=>{
	        console.log(err);
	      }); 
	}
</script>
</html>