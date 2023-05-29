<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>멘토 찾기</title>
<style>
.wrap{
width:100%;
min-height:100vh;
background-color:white;
margin:0px;
}
#whole-box{
  padding-top:120px;
  padding-bottom:100px;
}
	#tag-order-box .btn {
        margin-bottom: 5px; 
        
    }
	#search-box, #tag_box {
	margin-bottom: 20px;
	}
	#fixed-box {
     position: sticky;
     height: 500px;
    top: 120px;
	}
	
    #mentor-link {
        cursor: pointer;
        padding: 10px;
        border-radius: 10px;
        border-bottom: 1px solid #ebebeb;
    }
    #mentor-link:hover {
        background-color: #e0e0e0;
    }
    #mentor-link span {
        font-weight: bold;
    }
    #summary{
    	border-bottom: 1px solid #ebebeb;
    	padding-top: 15px;
    	padding-bottom: 15px;
    }
    #mentor-header{
    margin-top: 5px;
    }
    #mentor-view-box {
        margin-top: 15px;
        height: 100px;
        border-radius: 10px;
        background-color: #f9f9f9;
    }
   	#mentor-name {
        margin: 10px;
    }
    #mentor-careers {
        margin: 10px;
    }
    
</style>
<!--BOOTSTRAP CSS-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<!--JQUERY-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--sideBar CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/sideBar.css">
<!--header CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/header.css">
<!--footer CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/footer.css">
<!--loginModal CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/loginModal.css">
<!--로그인 및 세션관련 JS-->
<script src="/resources/js/main/loginSession.js" defer></script>
<!-- 채팅 관련 JS-->
<script src="/resources/js/main/chat.js" defer></script>
</head>
<body>
<%@ include file="../header.jsp" %>
<%@ include file="../sidebar.jsp" %>
<%@ include file="../footer.jsp" %>
<div class='wrap'>
<div class='container'>
	<div id='whole-box' class='row'>
		<article id='fixed-box' class='col-3'>
			<div class='row text-center'>
				<div id="search-box" class="d-flex">
				  <div class="form-floating">
				    <input type="text" class="form-control" id="searchInput" placeholder="소환사명으로 검색">
				    <label for="search-input">소환사명으로 검색</label>
				  </div>
				  <button class="btn btn-success" id="searchButton">검색</button>
				</div>
			</div>
			<div id='tag-order-box'>
				<div class='row'>
					<div id="tag_box">
						<p class='h4'>태그</p>
						<input type="checkbox" class="btn-check" id=10 name="selected_tags" value=10>
			          <label class="btn btn-outline-info btn" id="btn-check" for=10>유쾌한</label>
						<input type="checkbox" class="btn-check" id=18 name="selected_tags" value=18>
			          <label class="btn btn-outline-info btn" id="btn-check" for=18>입문자 추천</label>
						<input type="checkbox" class="btn-check" id=20 name="selected_tags" value=20>
			          <label class="btn btn-outline-info btn" id="btn-check" for=20>브실골 탈출</label>
						<input type="checkbox" class="btn-check" id=22 name="selected_tags" value=22>
			          <label class="btn btn-outline-info btn" id="btn-check" for=22>프로 경력</label>
						<input type="checkbox" class="btn-check" id=28 name="selected_tags" value=28>
			          <label class="btn btn-outline-info btn" id="btn-check" for=28>대회 입상</label>
					</div>
				</div>
				<div class='row'>			
					<div id="ordered_box">
					<p class='h4'>정렬순서</p>
					  <button type="button" class='btn btn-outline-warning' id="num_of_lessons">수업 횟수 많은</button>
					  <button type="button" class='btn btn-outline-warning' id="num_of_likes">찜 횟수 높은</button>
					  <button type="button" class='btn btn-outline-warning' id="num_of_reviews">후기 많은</button>
					  <button type="button" class='btn btn-outline-warning' id="tier_int">티어 높은</button>
					</div>
				</div>
			</div>
		</article>
		
		<div class='col-9'>
			<h4>멘토 찾기</h4>
			<div id="mentor-search-list">
			<div id= "summary">
				<em id="search-key"></em><span id="search-ment"></span>
				<span id="mentor-count"><em>0</em>명의 멘토님</span>
			</div>
				<div id="mentor-list">
					<!-- 멘토 프로필 목록 추가. -->
				</div>
			</div>
		</div>
	</div>
</div><!-- container -->
</div><!-- wrap -->

<script>
    function get_mentor_list() {
    	$.ajax({
            url: '/mentor/find-all-mentor/',
            method: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
            	$('#mentor-count em').text(data.length);
                const mentorList = $("#mentor-list");
                $.each(data, function(i, mentor) {
                    const mentorDiv = $("<div></div>").appendTo(mentorList); //멘토 div
                    mentorDiv
                        .addClass("row")
                        .attr("id","mentor-link")
                        .attr('data-href', '/mentor/profile/' + mentor.lol_account)
                        .on('click', function(event) {
                            event.preventDefault();
                            window.location.href = $(this).attr('data-href');
                        });
                    let grade = mentor.total_grade/mentor.num_of_reviews;
					grade = grade.toFixed(1);
					if (grade == "NaN"){
						grade=0;
					}
                        
                    const mentorImg = $("<div>").addClass("col-2 d-flex flex-column align-items-center justify-content-center")
						                    .attr("id",'mentor-img')
						                    .append($("<img>").addClass("row rounded")
						                    .css('width','128px')
						                    .attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/"+mentor.profile_icon_id+".png"))
						                    .append($("<span>").text("LV "+mentor.s_level).css("padding-top","15px").addClass("text-center"));
                	mentorImg.appendTo(mentorDiv); //멘토 프로필 사진
                	const mentorInfo = $("<div>").addClass("col-10")
						                	.attr('id','mentor-info')
						                	.appendTo(mentorDiv);//멘토 정보div
						                	
              			const mentorHeader =$("<div>").addClass("row")
              								.attr('id','mentor-header')
											.appendTo(mentorInfo);     	
						                	
               			const mentorMain =$("<div>").addClass("col-9")
               								.attr('id','mentor-main')
											.appendTo(mentorHeader);
						                	
	                	const mentorName = $("<div>").addClass("row")
	                							.attr('id','mentor-name')
	                							.appendTo(mentorMain);//멘토 이름
	                	mentorName.append($("<span></span>").text("["+mentor.lol_account + '] 멘토님'));
	                							
	                	const mentorCareers =$("<div>").addClass("row")
	                							.attr('id','mentor-careers')
	                							.appendTo(mentorMain);//멘토 소개
	                	mentorCareers.append($("<dd>").text(mentor.about_mentor));
	                							
	                	const mentorTier =$("<div>").addClass("col-3 d-flex flex-column align-items-center justify-content-center")
												.attr('id','mentor-tier')
												.appendTo(mentorHeader)
												.append($("<img>").addClass("row").attr('id','tier-img').attr('src',"https://online.gamecoach.pro/img/lol/emblem-"+mentor.tier+".svg"))
												.append($("<span>").addClass("row text-center").text(mentor.tier));
	                							
	                	
	                							
	                	const mentorViewBox = $("<div>").addClass("row d-flex align-items-center text-center justify-content-evenly")
	                							.attr('id','mentor-view-box')
	                							.appendTo(mentorInfo);
	                	
		                	const mentorPosition = $("<div>").addClass("col")
		                							.attr('id','mentor-position')
		                							.appendTo(mentorViewBox)
		                							.append($("<dd>").text('특화 포지션'))
		                							.append($("<dt>").text(JSON.parse(mentor.specialized_position))); //멘토 특화 포지션
		                							
		                	const mentorReview = $("<div>").addClass("col")
													.attr('id','mentor-review')
		                							.appendTo(mentorViewBox)
								                	.append($("<dd>").text('후기'))
													.append($("<dt>").text(mentor.num_of_reviews+'개')); //멘토 리뷰 횟수
							const mentorGrade = $("<div>").addClass("col")
													.attr('id','mentor-grade')
		                							.appendTo(mentorViewBox)
								                	.append($("<dd>").text('평점'))
													.append($("<dt>").text(grade+'점')); //멘토 리뷰 점수
		                	const mentorLesson = $("<div>").addClass("col")
													.attr('id','mentor-lesson')
		                							.appendTo(mentorViewBox)
								                	.append($("<dd>").text('멘토링'))
													.append($("<dt>").text(mentor.num_of_lessons+'건')); //멘토 수업 횟수
		                	const mentorPrice = $("<div>").addClass("col-3")
													.attr('id','mentor-price')
		                							.appendTo(mentorViewBox)
		                							.append($("<dd>").text('연락 가능 시간'))
		                							.append($("<dt>").text(mentor.contact_time));
                });
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    }
   

    function renewal_mentor_list() {
        return $.ajax({
            url: '/mentor/renewal-mentor-list',
            method: 'POST',
            contentType: 'application/json',
            success: function(response) {
                console.log('HTTP POST 요청이 성공적으로 처리되었습니다.');
            },
            error: function(error) {
                console.error(error);
            }
        });
    }
    
    function getOrderedProfiles(order_keyword) {
    	  $.ajax({
    	    url: '/mentor/get-order-profile',
    	    type: 'GET',
    	    dataType: 'json',
    	    data: { order_keyword: order_keyword },
    	    success: function(data) {
    	    	$("#mentor-list").html("");
    	    	$('#mentor-count em').text(data.length);
                const mentorList = $("#mentor-list");
                $.each(data, function(i, mentor) {
                    const mentorDiv = $("<div></div>").appendTo(mentorList); //멘토 div
                    mentorDiv
                        .addClass("row")
                        .attr("id","mentor-link")
                        .attr('data-href', '/mentor/profile/' + mentor.lol_account)
                        .on('click', function(event) {
                            event.preventDefault();
                            window.location.href = $(this).attr('data-href');
                        });
                    let grade = mentor.total_grade/mentor.num_of_reviews;
					grade = grade.toFixed(1);
					if (grade == "NaN"){
						grade=0;
					}
                        
                    const mentorImg = $("<div>").addClass("col-2 d-flex flex-column align-items-center justify-content-center")
						                    .attr("id",'mentor-img')
						                    .append($("<img>").addClass("row rounded")
						                    .css('width','128px')
						                    .attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/"+mentor.profile_icon_id+".png"))
						                    .append($("<span>").text("LV "+mentor.s_level).css("padding-top","15px").addClass("text-center"));
                	mentorImg.appendTo(mentorDiv); //멘토 프로필 사진
                	const mentorInfo = $("<div>").addClass("col-10")
						                	.attr('id','mentor-info')
						                	.appendTo(mentorDiv);//멘토 정보div
						                	
              			const mentorHeader =$("<div>").addClass("row")
              								.attr('id','mentor-header')
											.appendTo(mentorInfo);     	
						                	
               			const mentorMain =$("<div>").addClass("col-9")
               								.attr('id','mentor-main')
											.appendTo(mentorHeader);
						                	
	                	const mentorName = $("<div>").addClass("row")
	                							.attr('id','mentor-name')
	                							.appendTo(mentorMain);//멘토 이름
	                	mentorName.append($("<span></span>").text("["+mentor.lol_account + '] 멘토님'));
	                							
	                	const mentorCareers =$("<div>").addClass("row")
	                							.attr('id','mentor-careers')
	                							.appendTo(mentorMain);//멘토 소개
	                	mentorCareers.append($("<dd>").text(mentor.about_mentor));
	                							
	                	const mentorTier =$("<div>").addClass("col-3 d-flex flex-column align-items-center justify-content-center")
												.attr('id','mentor-tier')
												.appendTo(mentorHeader)
												.append($("<img>").addClass("row").attr('id','tier-img').attr('src',"https://online.gamecoach.pro/img/lol/emblem-"+mentor.tier+".svg"))
												.append($("<span>").addClass("row text-center").text(mentor.tier));
	                							
	                	
	                							
	                	const mentorViewBox = $("<div>").addClass("row d-flex align-items-center text-center justify-content-evenly")
	                							.attr('id','mentor-view-box')
	                							.appendTo(mentorInfo);
	                	
		                	const mentorPosition = $("<div>").addClass("col")
		                							.attr('id','mentor-position')
		                							.appendTo(mentorViewBox)
		                							.append($("<dd>").text('특화 포지션'))
		                							.append($("<dt>").text(JSON.parse(mentor.specialized_position))); //멘토 특화 포지션
		                							
		                	const mentorReview = $("<div>").addClass("col")
													.attr('id','mentor-review')
		                							.appendTo(mentorViewBox)
								                	.append($("<dd>").text('후기'))
													.append($("<dt>").text(mentor.num_of_reviews+'개')); //멘토 리뷰 횟수
							const mentorGrade = $("<div>").addClass("col")
													.attr('id','mentor-grade')
		                							.appendTo(mentorViewBox)
								                	.append($("<dd>").text('평점'))
													.append($("<dt>").text(grade+'점')); //멘토 리뷰 점수
		                	const mentorLesson = $("<div>").addClass("col")
													.attr('id','mentor-lesson')
		                							.appendTo(mentorViewBox)
								                	.append($("<dd>").text('멘토링'))
													.append($("<dt>").text(mentor.num_of_lessons+'건')); //멘토 수업 횟수
		                	const mentorPrice = $("<div>").addClass("col-3")
													.attr('id','mentor-price')
		                							.appendTo(mentorViewBox)
		                							.append($("<dd>").text('연락 가능 시간'))
		                							.append($("<dt>").text(mentor.contact_time));
                });
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    }

    $(document).ready(function() {
    	get_mentor_list(); //멘토 목록 불러오기
    	
    	// 엔터 키 이벤트 핸들러
    	$("#searchInput").on("keydown", function(event) {
    	      if (event.keyCode === 13) {
    	        event.preventDefault();
    	        performSearch();
    	      }
    	    });
    	
    	$("#ordered_box button").on("click", function() {
    		getOrderedProfiles($(this).attr("id"));
    	});
    	
    	$("#tag_box input").on("click", function() {
    	    var checkedValues = [];
    	    $("#tag_box input:checked").each(function() {
    	        checkedValues.push($(this).val());
    	    });
    	    if (checkedValues.length !== 0) {
    	        var url = "/mentor/get-mentor-by-tag";
    	        $.ajax({
    	            url: url,
    	            type: "GET",
    	            dataType: 'json',
    	            data: { tagIds: checkedValues },
    	            traditional: true,
    	            success: function (data) {
    	            	$("#mentor-list").html("")
    	            	$('#mentor-count em').text(data.length);
    	                const mentorList = $("#mentor-list");
    	                $.each(data, function(i, mentor) {
    	                    const mentorDiv = $("<div></div>").appendTo(mentorList); //멘토 div
    	                    mentorDiv
    	                        .addClass("row")
    	                        .attr("id","mentor-link")
    	                        .attr('data-href', '/mentor/profile/' + mentor.lol_account)
    	                        .on('click', function(event) {
    	                            event.preventDefault();
    	                            window.location.href = $(this).attr('data-href');
    	                        });
    	                    let grade = mentor.total_grade/mentor.num_of_reviews;
    						grade = grade.toFixed(1);
    						if (grade == "NaN"){
    							grade=0;
    						}
    	                        
    	                    const mentorImg = $("<div>").addClass("col-2 d-flex flex-column align-items-center justify-content-center")
    							                    .attr("id",'mentor-img')
    							                    .append($("<img>").addClass("row rounded")
    							                    .css('width','128px')
    							                    .attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/"+mentor.profile_icon_id+".png"))
    							                    .append($("<span>").text("LV "+mentor.s_level).css("padding-top","15px").addClass("text-center"));
    	                	mentorImg.appendTo(mentorDiv); //멘토 프로필 사진
    	                	const mentorInfo = $("<div>").addClass("col-10")
    							                	.attr('id','mentor-info')
    							                	.appendTo(mentorDiv);//멘토 정보div
    							                	
    	              			const mentorHeader =$("<div>").addClass("row")
    	              								.attr('id','mentor-header')
    												.appendTo(mentorInfo);     	
    							                	
    	               			const mentorMain =$("<div>").addClass("col-9")
    	               								.attr('id','mentor-main')
    												.appendTo(mentorHeader);
    							                	
    		                	const mentorName = $("<div>").addClass("row")
    		                							.attr('id','mentor-name')
    		                							.appendTo(mentorMain);//멘토 이름
    		                	mentorName.append($("<span></span>").text("["+mentor.lol_account + '] 멘토님'));
    		                							
    		                	const mentorCareers =$("<div>").addClass("row")
    		                							.attr('id','mentor-careers')
    		                							.appendTo(mentorMain);//멘토 소개
    		                	mentorCareers.append($("<dd>").text(mentor.about_mentor));
    		                							
    		                	const mentorTier =$("<div>").addClass("col-3 d-flex flex-column align-items-center justify-content-center")
    													.attr('id','mentor-tier')
    													.appendTo(mentorHeader)
    													.append($("<img>").addClass("row").attr('id','tier-img').attr('src',"https://online.gamecoach.pro/img/lol/emblem-"+mentor.tier+".svg"))
    													.append($("<span>").addClass("row text-center").text(mentor.tier));
    		                							
    		                	
    		                							
    		                	const mentorViewBox = $("<div>").addClass("row d-flex align-items-center text-center justify-content-evenly")
    		                							.attr('id','mentor-view-box')
    		                							.appendTo(mentorInfo);
    		                	
    			                	const mentorPosition = $("<div>").addClass("col")
    			                							.attr('id','mentor-position')
    			                							.appendTo(mentorViewBox)
    			                							.append($("<dd>").text('특화 포지션'))
    			                							.append($("<dt>").text(JSON.parse(mentor.specialized_position))); //멘토 특화 포지션
    			                							
    			                	const mentorReview = $("<div>").addClass("col")
    														.attr('id','mentor-review')
    			                							.appendTo(mentorViewBox)
    									                	.append($("<dd>").text('후기'))
    														.append($("<dt>").text(mentor.num_of_reviews+'개')); //멘토 리뷰 횟수
    								const mentorGrade = $("<div>").addClass("col")
    														.attr('id','mentor-grade')
    			                							.appendTo(mentorViewBox)
    									                	.append($("<dd>").text('평점'))
    														.append($("<dt>").text(grade+'점')); //멘토 리뷰 점수
    			                	const mentorLesson = $("<div>").addClass("col")
    														.attr('id','mentor-lesson')
    			                							.appendTo(mentorViewBox)
    									                	.append($("<dd>").text('멘토링'))
    														.append($("<dt>").text(mentor.num_of_lessons+'건')); //멘토 수업 횟수
    			                	const mentorPrice = $("<div>").addClass("col-3")
    														.attr('id','mentor-price')
    			                							.appendTo(mentorViewBox)
    			                							.append($("<dd>").text('연락 가능 시간'))
    			                							.append($("<dt>").text(mentor.contact_time));
    	                });
    	            },
    	            error: function (error) {
    	                console.error(error);
    	            }
    	        });
    	    }else{
				console.log("선택해제")    	
				$("#mentor-list").html("");
				get_mentor_list();
    	    }
    	});

   	    // 검색 버튼 클릭 이벤트 핸들러
   	    $("#searchButton").on("click", performSearch);
    	
    	function performSearch() {
    	      var searchKeyword = $("#searchInput").val();
    	      if (searchKeyword === '' || searchKeyword === null) {
    	        alert('검색어를 입력해주세요');
    	        $("#mentor-list").html("");
				get_mentor_list();
    	      } else {
    	        // 검색에 필요한 AJAX 요청 코드
    	        $.ajax({
    	          url: '/mentor/get-member-info',
    	          type: 'GET',
    	          data: {
    	            lol_account_keyword: searchKeyword
    	          },
    	          success: function(member_list_json) {
    	            let member_list = JSON.parse(member_list_json);
    	            if (member_list == '' || member_list == null) {
    	              alert('검색 결과가 없습니다');
    	              $("#search-key").html("");
            		  $("#search-ment").html("");
    	              $("#mentor-list").html("");
    					get_mentor_list();
    	            }
	               $("#mentor-list").text('');
    	            let nul_count = 0
    	            let dataLen = [];
    	            for (var i = 0; i < member_list.length; i++) {
    	              if(member_list[i].user_type == 2){
    	            let mentor_email = member_list[i].email;
    	              $.ajax({
    	                url: '/mentor/get-mentor-profile/',
    	                method: 'POST',
    	                contentType: "application/json; charset=utf-8",
    	                dataType: "json",
    	                data: JSON.stringify({
    	                  mentor_email: mentor_email
    	                }),
    	                success: function(mentor) {
    	                	console.log(mentor);
    	                  if (mentor != null) {
    	                	  $('#search-key').text(searchKeyword);
    	      	            $('#search-ment').text("(으)로 검색된");
   	                	  dataLen.push(mentor);
   	                	  $('#mentor-count em').text(dataLen.length);
    	                    const mentorList = $("#mentor-list");
    	                    const mentorDiv = $("<div></div>").appendTo(mentorList); //멘토 div
    	                    mentorDiv
    	                        .addClass("row")
    	                        .attr("id","mentor-link")
    	                        .attr('data-href', '/mentor/profile/' + mentor.lol_account)
    	                        .on('click', function(event) {
    	                            event.preventDefault();
    	                            window.location.href = $(this).attr('data-href');
    	                        });
    	                    let grade = mentor.total_grade/mentor.num_of_reviews;
    						grade = grade.toFixed(1);
    						if (grade == "NaN"){
    							grade=0;
    						}
    	                    const mentorImg = $("<div>").addClass("col-2 d-flex flex-column align-items-center justify-content-center")
    							                    .attr("id",'mentor-img')
    							                    .append($("<img>").addClass("row rounded")
    							                    .css('width','128px')
    							                    .attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/"+mentor.profile_icon_id+".png"))
    							                    .append($("<span>").text("LV "+mentor.s_level).css("padding-top","15px").addClass("text-center"));
    	                	mentorImg.appendTo(mentorDiv); //멘토 프로필 사진
    	                	const mentorInfo = $("<div>").addClass("col-10")
    							                	.attr('id','mentor-info')
    							                	.appendTo(mentorDiv);//멘토 정보div
    							                	
    	              			const mentorHeader =$("<div>").addClass("row")
    	              								.attr('id','mentor-header')
    												.appendTo(mentorInfo);     	
    							                	
    	               			const mentorMain =$("<div>").addClass("col-9")
    	               								.attr('id','mentor-main')
    												.appendTo(mentorHeader);
    							                	
    		                	const mentorName = $("<div>").addClass("row")
    		                							.attr('id','mentor-name')
    		                							.appendTo(mentorMain);//멘토 이름
    		                	mentorName.append($("<span></span>").text("["+mentor.lol_account + '] 멘토님'));
    		                							
    		                	const mentorCareers =$("<div>").addClass("row")
    		                							.attr('id','mentor-careers')
    		                							.appendTo(mentorMain);//멘토 소개
    		                	mentorCareers.append($("<dd>").text(mentor.about_mentor));
    		                							
    		                	const mentorTier =$("<div>").addClass("col-3 d-flex flex-column align-items-center justify-content-center")
    													.attr('id','mentor-tier')
    													.appendTo(mentorHeader)
    													.append($("<img>").addClass("row").attr('id','tier-img').attr('src',"https://online.gamecoach.pro/img/lol/emblem-"+mentor.tier+".svg"))
    													.append($("<span>").addClass("row text-center").text(mentor.tier));
    		                							
    		                	const mentorViewBox = $("<div>").addClass("row d-flex align-items-center text-center justify-content-evenly")
    		                							.attr('id','mentor-view-box')
    		                							.appendTo(mentorInfo);
    		                	
    			                	const mentorPosition = $("<div>").addClass("col")
    			                							.attr('id','mentor-position')
    			                							.appendTo(mentorViewBox)
    			                							.append($("<dd>").text('특화 포지션'))
    			                							.append($("<dt>").text(JSON.parse(mentor.specialized_position))); //멘토 특화 포지션
    			                							
    			                	const mentorReview = $("<div>").addClass("col")
    														.attr('id','mentor-review')
    			                							.appendTo(mentorViewBox)
    									                	.append($("<dd>").text('후기'))
    														.append($("<dt>").text(mentor.num_of_reviews+'개')); //멘토 리뷰 횟수
    								const mentorGrade = $("<div>").addClass("col")
    														.attr('id','mentor-grade')
    			                							.appendTo(mentorViewBox)
    									                	.append($("<dd>").text('평점'))
    														.append($("<dt>").text(grade+'점')); //멘토 리뷰 점수
    			                	const mentorLesson = $("<div>").addClass("col")
    														.attr('id','mentor-lesson')
    			                							.appendTo(mentorViewBox)
    									                	.append($("<dd>").text('멘토링'))
    														.append($("<dt>").text(mentor.num_of_lessons+'건')); //멘토 수업 횟수
    			                	const mentorPrice = $("<div>").addClass("col-3")
    														.attr('id','mentor-price')
    			                							.appendTo(mentorViewBox)
    			                							.append($("<dd>").text('연락 가능 시간'))
    			                							.append($("<dt>").text(mentor.contact_time));
    	                  }
    	                },
    	                error: function(error) {
    	                	alert('검색 결과가 없습니다');
    	                	$("#search-key").html("");
  	            		  $("#search-ment").html("");
    	                	$("#mentor-list").html("");
    	    				get_mentor_list();
    	                  console.error('Error:', error);
    	                }
    	              })
    	              }else{
    	            	  nul_count = nul_count + 1;
    	            	  if(nul_count == member_list.length){
    	            		  alert('검색 결과가 없습니다')
    	            		  $("#search-key").html("");
    	            		  $("#search-ment").html("");
    	            		  $("#mentor-list").html("");
    	      				get_mentor_list();
    	            	  }
    	              }
    	            }
    	          
    	          },
    	          error: function(xhr, status, error) {
    	            console.error(error);
    	          }
    	        });
    	      }
    	    }
    	
        $.ajax({
            url: '/mentor/renewal-point-table',
            method: 'GET',
            success: function(response) {
                console.log('renewal-point-table 요청이 성공적으로 처리되었습니다.');
            },
            error: function(error) {
                console.error('renewal-point-table 요청 처리 중 오류가 발생했습니다.', error);
            }
        });

    });
</script>

</body>
</html>