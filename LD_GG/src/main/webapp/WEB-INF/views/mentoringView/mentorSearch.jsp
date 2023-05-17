<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>멘토 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.search-container {
  display: flex;
  align-items: center;
}

#search-input {
  padding: 8px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

#search-button {
  padding: 8px 16px;
  font-size: 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

#search-button:hover {
  background-color: #45a049;
}

    .mentor-link {
        cursor: pointer;
        width: 500px;
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
</head>
<body>
	<h2>멘토 찾기 페이지 입니다~~~</h2>
	<div class="search-container">
	  <input type="text" id="search-input" placeholder="검색어를 입력하세요">
	  <button id="search-button">검색</button>
	</div>
	<div id="mentor-list">
	<!-- 멘토 프로필 목록 추가. -->
	</div>
	
	
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
        	  console.log("검색어:", searchKeyword);
        	  $.ajax({
        		  url: '/mentor/get-member-info',
        		  type: 'GET',
        		  data: {
        			lol_account_keyword: searchKeyword // 요청에 필요한 파라미터를 전달합니다
        		  },
        		  success: function(member_list_json) {
        			  $("#mentor-list").text("");
	       			  let member_list = JSON.parse(member_list_json);
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
	       			            },
	       			            error: function(error) {
	       			                console.error('Error:', error);
	       			            }
	       			        });
	       			        
	       			      }
        		  },
        		  error: function(xhr, status, error) {
        		    // 요청이 실패했을 때 실행할 코드를 작성합니다
        		    console.error(error); // 에러 메시지를 콘솔에 출력하거나 에러 처리를 수행합니다
        		  }
        		});

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