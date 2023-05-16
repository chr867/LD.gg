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
</head>
<body>
	<h2>멘토 찾기 페이지 입니다~~~</h2>
	<div id="mentor-list">
	<!-- 멘토 프로필 목록 추가. -->
	</div>
	
	
<script>
    function get_mentor_list() {
    	$.ajax({
            url: '/mentor/find-mentor/',
            dataType: 'json',
            success: function(data) {
                const mentorList = $("#mentor-list");
                $.each(data, function(i, mentor) {
                    console.log(mentor);
                    const mentorDiv = $("<div></div>").appendTo(mentorList);
                    mentorDiv
                        .addClass("mentor-link")
                        .attr('data-href', '/mentor/profile/' + mentor)
                        .on('click', function(event) {
                            event.preventDefault();
                            window.location.href = $(this).attr('data-href');
                        })
                        .append($("<span></span>").text(mentor + '멘토님'));
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