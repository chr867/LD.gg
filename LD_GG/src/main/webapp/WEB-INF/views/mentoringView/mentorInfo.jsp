<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 프로필</title>
<style>
.container_by_class {
	border: 1px solid black;
}

#flex-add-store {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-contents {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.flex-paymnent-cash {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.flex-label {
	margin-right: 10px;
}

.flex-payment-button {
	cursor: pointer;
}

.close {
	color: #aaa;
	float: right;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script type="text/javascript">
	const IMP = window.IMP; // 생략 가능
	IMP.init("imp26843336"); // 예: imp00000000a, 본인의 가맹점 식별코드
</script>

</head>
<body>
	<h2>${mentor.lol_account}멘토님의프로필</h2>
	<button class="like-btn" id="${mentor.lol_account}">찜하기</button>

	<h4>찜한 횟수: ${mentor_profile.num_of_likes}</h4>

	<h4>수업 횟수: ${mentor_profile.num_of_lessons}</h4>

	<h4>리뷰 횟수: ${mentor_profile.num_of_reviews}</h4>

	<h4 id="avg_grade">평점:
		${mentor_profile.total_grade/mentor_profile.num_of_reviews}</h4>

	<h4>특화 포지션:</h4>
	<div id="specializedPosition">${mentor_profile.specialized_position}</div>

	<h4>특화 챔피언</h4>
	<div id="specializedChampion">
		<div class="top-champ">
			<p>탑</p>
		</div>
		<div class="jungle-champ">
			<p>정글</p>
		</div>
		<div class="mid-champ">
			<p>미드</p>
		</div>
		<div class="bottom-champ">
			<p>바텀</p>
		</div>
		<div class="supporter-champ">
			<p>서포터</p>
		</div>
	</div>

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
					<h4>${class_list.class_name}</h4>
					<button class="apply-btn" id="${class_list.class_id}"
						value="${class_list.price}">수업신청</button>
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

	<div id="flex-add-store">
		<!-- 추가 결제 모달 : 가격 옵션 및 결제 -->
		<div class="modal-contents">

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>10,000 캐시</strong>
				</div>
				<input type="checkbox" class="flex-payment-button" value="10,000 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>30,000 캐시</strong>
				</div>
				<input type="checkbox" class="flex-payment-button" value="30,000 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>50,000 캐시</strong>
				</div>
				<input type="checkbox" class="flex-payment-button" value="50,000 원"
					style="cursor: pointer">
			</div>

			<button onclick="requestPay()">결제하기</button>

			<span class="close">닫기</span>

		</div>
	</div>

	<a href="/mentor/list">목록</a>

	<script>
	$(document).ready(function() {
		displaySpecializedPosition();//멘토 프로필 가져와서 특화 포지션 게시
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
		
		//탑 특화 챔피언
		let top_specialized_champion = [${mentor_profile.top_specialized_champion}];
		
		top_specialized_champion.forEach(function (id) {
		    $.ajax({ //챔피언 id로 이름 가져오기
		        type: "GET",
		        url: "/mentor/get-champ-name-by-id?id=" + id,
		        contentType: "application/json; charset=utf-8",
		        dataType: "json",
		        success: function (champion) {
		            console.log(top_specialized_champion);
		            let imageUrl = "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +champion.champion_en_name + ".png?&amp;retry=0";
		            let champImg = $("<img>").addClass("champ-icon").attr("src", imageUrl);
		            let champName = $("<p>").addClass("champ-name").text(champion.champion_kr_name);
		            $(".top-champ").append(champImg);
		            $(".top-champ").append(champName);
		        },
		        error: function (request, status, error) {
		            console.error(error);
		            // 오류 처리
		        }
		    });
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
	    	let price = $(this).val();
	    	
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
	                    
	                    let applicationData = {
	                    		holder_email : email,
                    			price : price.toString()
                    	};
	                    
	                    console.log(applicationData);
	                    
	                    $.ajax({
	                    	url: '/mentor/profile/payment/mentoring-application',
	                    	method : 'post',
	                    	contentType : 'application/json; charset=utf-8',
	                    	data : JSON.stringify(applicationData)	//수업 신청 버튼 클릭 시, 멘티의 잔액 확인 후 신청 승인 여부 결정
	                    }).done(res=>{
	                    	console.log(res);
	                    	let response = res.result;
	                    	if(response){
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
	                    	}else{
	                    		alert("잔액이 부족합니다. 충전 후 이용해주세요.");
	                    		$('#flex-add-store').css("display","block");
	                    		$('.close').click(function(){
	                    			$('#flex-add-store').css("display","none");
	                    		})
	                    	}
	                    }).fail(err=>{
	                    	console.log(err);
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
	    
	    function displaySpecializedPosition(){
			$.ajax({
			  url: '/mentor/get-mentor-profile',
			  type: 'POST',
			  contentType: 'application/json;charset=UTF-8',
			  data: JSON.stringify({ mentor_email: '${mentor_profile.mentor_email}' }),
			  success: function(data) {
				  let sp = JSON.parse(data);
				  let mpsp = JSON.parse(sp.specialized_position);
				  if (mpsp.length == 2) {
					    $('#specializedPosition').text(mpsp[0] + '/' + mpsp[1]);
					  } else {
					    $('#specializedPosition').text(mpsp[0]);
					  }
			  },
			  error: function(xhr, status, error) {
			    console.log(error);
			  }
			});
			}
	    
	    
	    
	});//ready
	
	let price = "";
    $('.flex-payment-button').on("click", function(){
    	price = $(this).val();
    })
    
    $('.flex-payment-button').on('change',function(){
	// 체크된 버튼 확인
	let checked = $(this).prop('checked');
	
	if(checked){
		$('.flex-payment-button').not(this).prop('checked', false);
	}
});
	
	 function requestPay(){//추가 결제
	    	let email = "";
	    	let phone_num = "";
	    	let lol_account = "";
	    	$.ajax({//결제에 필요한 정보 가져오기
	        	method : 'post',
	        	url : '/mentor/mentoring/adpay',
	        	data : {lol_account : "${mentor.lol_account}"}
	        }).done(res=>{
	        	console.log(res)
	        	email = res.email;
	        	phone_num = res.phone_num;
	        	lol_account = mentor.lol_account;
	        }).fail(err=>{
	        	console.log(err)
	        });
	    	
	    	
	    	let orderId = "";//주문번호 생성
			
			if(price === "1 원"){
				let regex = /\d+/;
				price = parseInt(price.match(regex)[0]);
				console.log(price);
			}else{
				price = parseInt(price.replace(/,/g, ""));
				console.log(price);
			}
			
			$.ajax({
				method : 'post',
				url : '/wallet/payment/getOrderId',
			}).done(res=>{
				orderId = res;
				console.log(orderId);
			}).fail(err=>{
				console.log(err);
			});
			
			IMP.request_pay({//결제 진행
				pg : "kakaopay.TC0ONETIME",
				pay_method : "card",
				merchant_uid : orderId, // 주문번호
				name : "테스트용 상품",
				amount : price, // 숫자 타입
				buyer_email : email,
				buyer_name : lol_account,
				buyer_tel : phone_num,
			}, function(rsp) {
				if (rsp.success) {
					alert("결제가 완료되었습니다");
					// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					// jQuery로 HTTP 요청
					console.log(rsp)
					$.ajax({//결제 데이터 저장
						url : "/wallet/payment/kakaopay/success",
						method : "POST",
						data : {
							imp_uid : rsp.imp_uid, // 결제 고유번호
							merchant_uid : rsp.merchant_uid, // 주문번호
							price : rsp.paid_amount,
							email : email,
							lol_account : lol_account,
							phone_num : phone_num,
							payment_status : "success",
							payment_method : rsp.pg_type
						}
					}).done(res=>{
						// 가맹점 서버 결제 API 성공시 로직
						console.log(res);
						location.reload();
					}).fail(err=>{
						console.log(err);
					})
				} else {
					$.ajax({
						url : "/wallet/payment/kakaopay/fail",
						method : "POST",
						data : {
							imp_uid : rsp.imp_uid, // 결제 고유번호
							merchant_uid : rsp.merchant_uid, // 주문번호
							price : rsp.paid_amount,
							email : email,
							lol_account : lol_account,
							phone_num : phone_num,
							payment_status : "fail",
							payment_method : rsp.pg_type
						}
					}).done(res=>{
						console.log(res);
					})
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
					location.reload();
				}
			});
			
	    }
		
</script>
</body>
</html>