<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 프로필</title>
<style>
  .container_by_class{
  	border: 1px solid black;
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<h2>${mentor.lol_account} 멘토님의 프로필</h2> <button class="like-btn" id="${mentor.lol_account}">찜하기</button>
	<h4>찜한 횟수: ${mentor_profile.num_of_likes}</h4>
	<h4>수업 횟수: ${mentor_profile.num_of_lessons}</h4>
	<h4>리뷰 횟수: ${mentor_profile.num_of_reviews}</h4>
	<h4 id="avg_grade">평점: ${mentor_profile.total_grade/mentor_profile.num_of_reviews}</h4>
	<h4>특화 챔피언: ${mentor_profile.specialized_champion}</h4>
	<h4>특화 포지션: ${mentor_profile.specialized_position}</h4>
	<h4>수업 가능 시간: ${mentor_profile.contact_time}</h4>
	<h4>경력: ${mentor_profile.careers}</h4>
	<h4>이런 분들께 추천해요: ${mentor_profile.recom_ment}</h4>
	
	<h4>멘토 리뷰</h4>
	<div id="review_for_me"></div>
	<br>
	
	<div id="mentor_class_info">
       <c:forEach items="${class_list}" var="class_list">
       		<div class="container_by_class">
		        <div>
		        <h4>${class_list.class_name}</h4><button class="apply-btn" id="${class_list.class_id}">수업신청</button>
		        </div>
		        <div>
		        <h4>${class_list.price}</h4>
		        </div>
		        <div>
		        <h4>${class_list.class_info}</h4>
		        </div>
		       </div>
		</c:forEach>
       </div>
	
	
	<a href="/mentor/list">목록</a>
	
<script>
	$(document).ready(function() {
		let avg_grade = ${mentor_profile.total_grade/mentor_profile.num_of_reviews}
		let roundedGrade = avg_grade.toFixed(1);
		$('#avg_grade').html('평점: '+roundedGrade);
    	if("${member.email}" === "${mentor.email}"){
    		$('.like-btn').remove();
    		$(".apply-btn").remove();
    	}
		var isLiked = false;
		let data = {
			email: "${member.email}"
		}
		$.ajax({
		    url: "/mentor/get-like-mentor",
		    method: "POST",
		    dataType: "json",
		    data: JSON.stringify(data),
		    contentType: "application/json; charset=utf-8",
		    success: function(response) {
		    	for (var i = 0; i < response.length; i++) {
		    	    if (response[i].like_mentor === "${mentor.email}") {
		    	        isLiked = true;
		    	        $('.like-btn').text('찜 해제');
		    	        break;
		    	    }
		    	}
		    }
		});
		
    	
		  $('.like-btn').click(function() {
			  $.ajax({
		            url: "/mentor/check-session",
		            method: "GET",
		            success: function(response) {
		            if (response.isLoggedIn) {
		            	let email = response.email;
					    if (isLiked) {
					    	isLiked = false;
					    	$('.like-btn').text('찜 하기');
					    	let data = {
			                		email: email,
			                        like_mentor: "${mentor.email}"
			                };
					    	$.ajax({
			                    url: "/mentor/delete-like-mentor",
			                    method: "DELETE",
			                    data: JSON.stringify(data),
			                    contentType: "application/json; charset=utf-8",
			                    success: function() {
			                        alert("찜 목록에서 삭제되었습니다.");
			                    },
			                    error: function() {
			                        alert("삭제 실패.");
			                    }
			                });
					      console.log('찜 해제');
					    } else {
					    	isLiked = true;
					    	$('.like-btn').text('찜 해제');
					    	let data = {
			                		email: email,
			                        like_mentor: "${mentor.email}"
			                };
					    	$.ajax({
			                    url: "/mentor/insert-like-mentor",
			                    method: "POST",
			                    data: JSON.stringify(data),
			                    contentType: "application/json; charset=utf-8",
			                    success: function() {
			                        alert("찜 목록에 추가되었습니다.");
			                    },
			                    error: function() {
			                        alert("찜 목록 추가에 실패했습니다.");
			                    }
			                });
					      console.log('찜 하기');
					    }
		            }else {
	                    alert("로그인 후 이용 가능합니다.");
		            }
	             }
			  });
		  });
	    $(".apply-btn").click(function() {
	    	let class_id =$(this).attr("id");
	        $.ajax({
	            url: "/mentor/check-session",
	            method: "GET",
	            success: function(response) {
	                if (response.isLoggedIn) {
	                    let email = response.email;
	                    let data = {
	                    		menti_email: email,
	                            class_id: class_id,
	                            mentor_email: "${mentor.email}"
	                    };
	                    $.ajax({
	                        url: "/mentor/save-mentoring-history",
	                        method: "POST",
	                        data: JSON.stringify(data),
	                        contentType: "application/json; charset=utf-8",
	                        success: function() {
	                            alert("수강 신청이 완료되었습니다.");
	                        },
	                        error: function() {
	                            alert("이미 신청한 수업입니다.");
	                        }
	                    });
	                } else {
	                    alert("로그인 후 이용 가능합니다.");
	                }
	            }
	        });
	    });
	    
	    $.ajax({ //내게 달린 리뷰
			url: "/mentor/get-review-for-me",
			type: "POST",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        data: JSON.stringify({
				mentor_email: "${mentor_profile.mentor_email}"
			}),
	        success: function(data) {
	    		  let reviewForMeList = $("#review_for_me");
	    		  let table = $("<table>").addClass("review-for-me-table");
	    		  let header = $("<tr>").append(
	    		    $("<th>").text("작성자"),
	    		    $("<th>").text("멘토"),
	    		    $("<th>").text("수업 이름"),
	    		    $("<th>").text("리뷰 내용"),
	    		    $("<th>").text("작성일"),
	    		    $("<th>").text("평점")
	    		  );
	    		  table.append(header);
	    		  for (let i = 0; i < data.length; i++) {
	    		    let review_for_me = data[i];
	    		    let row = $("<tr>").append(
	    		      $("<td>").text(review_for_me.reviewer_lol_account),
	    		      $("<td>").text(review_for_me.mentor_lol_account),
	    		      $("<td>").text(review_for_me.class_name),
	    		      $("<td>").text(review_for_me.review_content),
	    		      $("<td>").text(review_for_me.review_date),
	    		      $("<td>").text(review_for_me.grade+'점')
	    		    );
	    		    table.append(row);
	    		  }
	    		  reviewForMeList.empty().append(table);
			},
	        error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	            console.error(status);
	            console.error(error);
	        }
	    });
	    
	});//ready
		
</script>
</body>
</html>