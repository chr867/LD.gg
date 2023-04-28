<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script src="/resources/js/jquery.serializeObject.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'
	crossorigin='anonymous'></script>
	
	
</head>
<body>

	<div id = "whole_div">
		<div id = "background-profile">
			<div id = "summoner-profile">
				<div id = "renewal">
					
				</div><!-- 정보 갱신 -->
			</div><!-- 소환사 프로필 세부 -->
		</div><!-- 소환사 프로필 -->
		
		<div>
		
		</div><!-- 티어 및 그래프 정보 -->
		
		<div>
		
		</div><!-- 해당 소환사의 Top3 챔피언 통계 -->
		
		<div>
			<div></div><!-- 전적 정보 필터 -->
			
				<table id = "record">
					
				</table><!-- 전적 정보 테이블 -->
		
		</div><!-- 소환사 전적 -->
		
	</div>	<!-- 전체 -->

	<script type="text/javascript">
	
		$.ajax({
			method : 'get',
			url : '/get_summoner_record',
			data : {summoner_name : '${summoner_name}'}
		}).done(res=>{
			let rList = '<tbody>';
			for(record of res){
				rList += '<tr id = "'record.summoner_name'">'
				rList += '<td><span class = "win_lose"></span><span class = "game_mode"></span></td>'
			}
		}).fail(err=>{
			console.log(err)
		})
	
	</script>

</body>
</html>