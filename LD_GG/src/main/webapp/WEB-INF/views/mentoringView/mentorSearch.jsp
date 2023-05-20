<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>멘토 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

    .mentor-link {
        cursor: pointer;
        padding: 10px;
        border: 1px solid #ccc;
        margin-bottom: 10px;
        background-color: #f9f9f9;
    }
    .mentor-link:hover {
        background-color: #e0e0e0;
    }
    .mentor-link span {
        font-weight: bold;
    }
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>

<div class='container text-center'>
	<div class='row'>
		<div class='col-4'>
			<div class='row'>
			<div class="form-floating">
			  <input type="text" class="form-control" id="search-input" placeholder="소환사명으로 검색">
			  <label for="search-input">소환사명으로 검색</label>
			  <button class="btn" id="search-button">검색</button>
			</div>
			</div>
			<div class='row'>
			<div id="tag_box">
			  <button type="button" class='btn'>태그</button>
			  <button type="button" class='btn'>태그</button>
			  <button type="button" class='btn'>태그</button>
			  <button type="button" class='btn'>태그</button>
			</div>
			</div>
			
			<div class='row'>			
			<div id="ordered_box">
			  <button type="button" class='btn'>정렬</button>
			  <button type="button" class='btn'>정렬</button>
			  <button type="button" class='btn'>정렬</button>
			  <button type="button" class='btn'>정렬</button>
			</div>
			</div>
			
		</div>
		<div class='col-8'>
			<h4>멘토 찾기</h4>
			<div id="mentor-list">
				<!-- 멘토 프로필 목록 추가. -->
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
            success: function(data) {
                const mentorList = $("#mentor-list");
                $.each(data, function(i, mentor) {
                    const mentorDiv = $("<div></div>").appendTo(mentorList);
                    mentorDiv
                        .addClass("mentor-link")
                        .attr('data-href', '/mentor/profile/' + mentor)
                        .on('click', function(event) {
                            event.preventDefault();
                            window.location.href = $(this).attr('data-href');
                        })
                        .append($("<span></span>").text(mentor + ' 멘토님'));
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
    	
    	 
        $("#search-button").on("click", function() {
        	  var searchKeyword = $("#search-input").val();
        	  if(searchKeyword == '' || searchKeyword ==null){
        		  location.reload();
        		  console.log("검색어:", searchKeyword);
        	  } else{
        	  $.ajax({
        		  url: '/mentor/get-member-info',
        		  type: 'GET',
        		  data: {
        			lol_account_keyword: searchKeyword // 요청에 필요한 파라미터를 전달합니다
        		  },
        		  success: function(member_list_json) {
        			  $("#mentor-list").text("");
	       			  let member_list = JSON.parse(member_list_json);
	       			  if(member_list =='' || member_list ==null){
	       				  alert('검색 결과가 없습니다');
	       				location.reload();
	       			  }
	       			  for (var i = 0; i < member_list.length; i++) {
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
	       			            	if(data != null){
	       			                const mentorList = $("#mentor-list");
	      			                    const mentorDiv = $("<div></div>").appendTo(mentorList);
	      			                    
	      			                    mentorDiv
	      			                        .addClass("mentor-link")
	      			                        .attr('data-href', '/mentor/profile/' + data.lol_account)
	      			                        .on('click', function(event) {
	      			                            event.preventDefault();
	      			                            window.location.href = $(this).attr('data-href');
	      			                        })
	      			                        .append($("<span></span>").text(data.lol_account + ' 멘토님'));
	       			            	}else {
	       			            		alert('검색 결과가 없습니다');
	       			       				location.reload();
	      	       			      }
	       			            },
	       			            error: function(error) {
	       			                console.error('Error:', error);
	       			            }
	       			        })
	       			        
	       			      
	       			  }
        		  },
        		  error: function(xhr, status, error) {
        		    // 요청이 실패했을 때 실행할 코드를 작성합니다
        		    console.error(error); // 에러 메시지를 콘솔에 출력하거나 에러 처리를 수행합니다
        		  }
        		});
        	  }
       	});

    	
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