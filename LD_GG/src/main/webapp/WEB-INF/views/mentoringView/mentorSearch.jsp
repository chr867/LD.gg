<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>멘토 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.container{
		margin-top: 30px;
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
    top: 30px;
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>

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
					  <button type="button" class='btn btn-outline-info'>유쾌한</button>
					  <button type="button" class='btn btn-outline-info'>입문자 추천</button>
					  <button type="button" class='btn btn-outline-info'>브실골 탈출</button>
					  <button type="button" class='btn btn-outline-info'>프로 경력</button>
					  <button type="button" class='btn btn-outline-info'>대회 입상</button>
					</div>
				</div>
				<div class='row'>			
					<div id="ordered_box">
					<p class='h4'>정렬순서</p>
					  <button type="button" class='btn btn-outline-warning'>수업 횟수 많은</button>
					  <button type="button" class='btn btn-outline-warning'>평점 높은</button>
					  <button type="button" class='btn btn-outline-warning'>후기 많은</button>
					  <button type="button" class='btn btn-outline-warning'>티어 높은</button>
					</div>
				</div>
			</div>
		</article>
		
		<div class='col-9'>
			<h4>멘토 찾기</h4>
			<div id="mentor-search-list">
			<div id= "summary">
				<span><em></em></span>
				<span id="mentor-count"><em>0</em>명의 멘토님
				</span>
			</div>
				<div id="mentor-list">
					<!-- 멘토 프로필 목록 추가. -->
				</div>
			</div>
		</div>
	</div>
</div><!-- container -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
    function get_mentor_list() {
    	$.ajax({
            url: '/mentor/find-all-mentor/',
            method: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
            	console.log(data);
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

    $(document).ready(function() {
    	get_mentor_list(); //멘토 목록 불러오기
    	
    	// 엔터 키 이벤트 핸들러
    	$("#searchInput").on("keydown", function(event) {
    	      if (event.keyCode === 13) {
    	        event.preventDefault();
    	        performSearch();
    	      }
    	    });

   	    // 검색 버튼 클릭 이벤트 핸들러
   	    $("#searchButton").on("click", performSearch);
    	
    	function performSearch() {
    	      var searchKeyword = $("#searchInput").val();
    	      if (searchKeyword === '' || searchKeyword === null) {
    	        alert('검색어를 입력해주세요');
    	        location.reload();
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
    	              location.reload();
    	            }
    	            
	               $("#mentor-list").text('');
    	            let nul_count = 0
    	            $('#summary')
    	            .children($("<span>").text("(으)로 검색 된 ")
    	              .children($("<em>").text(searchKeyword)));
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
   	                	  let dataLen = [];
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
    	                	location.reload();
    	                  console.error('Error:', error);
    	                }
    	              })
    	              }else{
    	            	  nul_count = nul_count + 1;
    	            	  if(nul_count == member_list.length){
    	            		  alert('검색 결과가 없습니다')
    	            		  location.reload();
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