<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>멘토 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

    #mentor-link {
        cursor: pointer;
        padding: 10px;
        border: 1px solid #ccc;
        margin-bottom: 10px;
        background-color: #f9f9f9;
    }
    #mentor-link:hover {
        background-color: #e0e0e0;
    }
    #mentor-link span {
        font-weight: bold;
    }
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>

<div class='container'>
	<div class='row'>
		<div class='col-3'>
			<div class='row text-center'>
			<div class="d-flex">
			  <div class="form-floating">
			    <input type="text" class="form-control" id="searchInput" placeholder="소환사명으로 검색">
			    <label for="search-input">소환사명으로 검색</label>
			  </div>
			  <button class="btn" id="searchButton">검색</button>
			</div>
			</div>
			<div class='row'>
			<div id="tag_box">
				<h3>태그</h3>
			  <button type="button" class='btn'>유쾌한</button>
			  <button type="button" class='btn'>입문자 추천</button>
			  <button type="button" class='btn'>브실골 탈출</button>
			  <button type="button" class='btn'>프로 경력</button>
			  <button type="button" class='btn'>대회 입상</button>
			</div>
			</div>
			
			<div class='row'>			
			<div id="ordered_box">
			<h3>정렬순서</h3>
			  <button type="button" class='btn'>수업 횟수 많은</button>
			  <button type="button" class='btn'>가격 낮은</button>
			  <button type="button" class='btn'>후기 많은</button>
			  <button type="button" class='btn'>평점 높은</button>
			</div>
			</div>
			
		</div>
		<div class='col-9'>
			<h4>멘토 찾기</h4>
			<div id="mentor-search-list">
			<div id= "summary">
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
                        
                    const mentorImg = $("<img>").addClass("col-2")
                    						.attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/588.png")
                	mentorImg.appendTo(mentorDiv);//멘토 프로필 사진
                	const mentorIntro = $("<div>").addClass("col-10")
						                	.attr('id','mentor-intro')
						                	.appendTo(mentorDiv);//멘토 정보div
                	const mentorName = $("<div>").attr('id','mentor-name')
                							.appendTo(mentorIntro);//멘토 이름
                	mentorName.append($("<span></span>").text(mentor.lol_account + ' 멘토님'));
                	const mentorCareers =$("<div>").attr('id','mentor-careers')
                							.appendTo(mentorIntro);//멘토 경력
                	mentorCareers.text(mentor.about_mentor);
                    
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
    	            }
    	            for (var i = 0; i < member_list.length; i++) {
    	            	let nul_count = 0
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
    	                success: function(data) {
    	                  if (data != null) {
    	                	  let dataLen = [];
    	                	  dataLen.push(data);
    	                	  $('#mentor-count em').text(dataLen.length);
    	                	  $("#mentor-list").text('');
    	                    const mentorList = $("#mentor-list");
    	                    const mentorDiv = $("<div></div>").appendTo(mentorList);
    	                    mentorDiv
    	                      .addClass("row")
    	                      .attr("id","mentor-link")
    	                      .attr('data-href', '/mentor/profile/' + data.lol_account)
    	                      .on('click', function(event) {
    	                        event.preventDefault();
    	                        window.location.href = $(this).attr('data-href');
    	                      })
    	                      .append($("<span></span>").text(data.lol_account + ' 멘토님'));
    	                  }
    	                },
    	                error: function(error) {
    	                	alert('검색 결과가 없습니다');
    	                  console.error('Error:', error);
    	                }
    	              })
    	              }else{
    	            	  nul_count = nul_count + 1;
    	            	  if(nul_count == member_list.length){
    	            		  alert('검색 결과가 없습니다')
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