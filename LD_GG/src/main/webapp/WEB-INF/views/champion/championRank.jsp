<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챔피언 랭크</title>
<!--BOOTSTRAP CSS-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
</script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--JQUERY-->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<!--AJAX-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!--JQUERY VALIDATE-->
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
<!--sideBar CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/sideBar.css">
<!--header CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/header.css">
<!--footer CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/footer.css">
</head>
<style>
.container_box{
	width: 80%;
	position: absolute;
	left: 40%;
	top: 10%;
}
</style>
<body>

<div class="container_box">
    <div class="container">
	    <div class="col">
	    	<select>
	    		<option>Challenger</option>
	    		<option>Grandmaster</option>
	    		<option>Master +</option>
	    		<option>Diamond +</option>
	    		<option>Platinum +</option>
	    		<option>Gold +</option>
	    	</select>
	    	<b>탑</b>
	    	<b>정글</b>
	    	<b>미드</b>
	    	<b>바텀</b>
	    	<b>서포터</b>
	    </div>

	    <table class="table table-striped">
	        <thead>
	            <tr>
	                <th>순위</th>
	                <th>챔피언</th>
	                <th>티어</th>
	                <th>승률</th>
	                <th>픽률</th>
	                <th>밴률</th>
	                <th>상대하기 어려운 챔피언</th>
	            </tr>
	        </thead>
	        <tbody id="championTableBody">
	        </tbody>
	    </table>
    </div>
</div>

</body>
<script>
  $.ajax({
    url: '/champion/rank.json',
    type: 'POST',
    data:{lane: 'top', tier: 'platinum'}
  }).done(res=>{
    console.log(res)
	let cList='<tbody>';
	let i = 1;
		for(champion of res){
			cList += '<tr id="'+champion.champion_id+'" class="'+champion.teamposition+'" height="20" align="center" onclick="detail(this)">'
			cList += '<td align="center">'+i+'</td>'
			cList += '<td><img src="/resources/img/img/champion_img/tiles/'+champion.champion_en_name+'.jpg" alt="#"></td>'
			cList += '<td align="center">'+champion.champion_kr_name+'</td>'
			cList += '<td align="center">'+champion.champion_tier+'</td>'
			cList += '<td align="center">'+champion.win_rate+'%</td>'
			cList += '<td align="center">'+champion.pick_rate+'%</td>'
			cList += '<td align="center">'+champion.ban_rate+'%</td>'
			cList += '</tr>'
			i++
		}
		cList+='</tbody>';
		$('.table').html(cList);
  }).fail(err=>{
    console.log(err)
  })

</script>
</html>