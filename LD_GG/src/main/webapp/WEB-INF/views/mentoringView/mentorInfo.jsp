<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 프로필</title>
<style>

.container{
	margin-top: 30px;
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
.top-champ {
  display: flex;
  flex-direction: row;
}
#mentor-tags button{
	margin : 2px;
}
section{
margin-bottom:48px;
padding:24px;
}
.tab-content{
padding-top:30px;
}
#tag-box{
margin-bottom:12px;
}
#mentor-name{
margin-bottom:12px;
}
#mentor-intro{
padding:24px;
}
#mentor_class_info{
padding:24px;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

</head>
<body>
<div class="container">
	<div id="go-list" style="padding-left: 15px" class="row">
		<a href="/mentor/list" style="width: 75px" class="col-1 btn btn-light btn-sm">
		<img style="width: 15px" src="/resources/img/icon/arrow-icon-left.png">
		목록
		</a>
	</div>
<div id="mentor-detail" class="row">
<div id="mentor-info" class="col-9">
	<div class="d-flex justify-content-end">
		<button id="like-btn" class="btn btn-outline-danger btn-sm">찜 하기</button>
	</div>
	<div id="mentor-profile" class="row">
		<div id="profile-box" class="row">
			<div class="col-2" id="mentor-img">
				<img style="width: 128px" class="rounded" src="http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/${mentor_profile.profile_icon_id}.png">
			</div>
			<div class="col" id="mentor-intro">
				<div id= "mentor-name" class="row">
					<span class='col'><span class="h3">${mentor_profile.lol_account}</span><em>&nbsp멘토님</em></span>
				</div>
				<div id="mentor-stat" class="row">
					<div id="mentor-spec" class="col-10">
						<div class="row">
							<span>
								<span>찜한 횟수: <em id = "mentor_likes">${mentor_profile.num_of_likes}</em></span>
								<span>수업 횟수: <em>${mentor_profile.num_of_lessons}</em></span>
								<span>리뷰 횟수: <em>${mentor_profile.num_of_reviews}</em></span>
								<span id="avg_grade">평점:
									<em>${mentor_profile.total_grade/mentor_profile.num_of_reviews}</em>
								</span>
							</span>
						</div>
						<div class="row">
							<span>
								<span>소환사 레벨: <em>${mentor_profile.s_level}LV</em></span>
								<span>게임 수: <em>${mentor_profile.games}회</em></span>
								<span>리그 포인트: <em>${mentor_profile.lp}LP</em></span>
							</span>
						</div>
					</div>
				</div>
			</div><!-- mentor-intro -->
			<div id="tier" class="col-2 d-flex flex-column align-items-center justify-content-center">
				<img src="https://online.gamecoach.pro/img/lol/emblem-${mentor_profile.tier}.svg">
				<dt>${mentor_profile.tier}</dt>
			</div>
		</div>
		
		<div id="tag-box" class="row">
			<span id="mentor-tags">
				<!-- 멘토 태그 -->
			</span>
		</div>
		
		<ul class="nav nav-tabs" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">멘토 소개</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">리뷰</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">수업 소개</button>
		  </li>
		</ul>
		
		<div class="tab-content" id="myTabContent">
		  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				  <section class="border rounded">
				  	<h4>멘토소개</h4>
				  	<span>${mentor_profile.about_mentor}</span>
				  </section>
				<section class="border rounded">
					<h4>경력</h4>
					<ul>
						<li>${mentor_profile.careers}
					</ul>
				</section>
				<section class="border rounded">
					<h4>특화 포지션</h4>
					<div id="specializedPosition">${mentor_profile.specialized_position}</div>
				</section>
				<section class="border rounded">
					<h4>특화 챔피언</h4>
					<div id="specializedChampion">
						<h3>탑</h3>
						<hr/>
						<div class="top-champ">
						</div>
						<h3>정글</h3>
						<hr/>
						<div class="jungle-champ">
						</div>
						<h3>미드</h3>
						<hr/>
						<div class="mid-champ">
						</div>
						<h3>바텀</h3>
						<hr/>
						<div class="bottom-champ">
						</div>
						<h3>서포터</h3>
						<hr/>
						<div class="supporter-champ">
						</div>
					</div><!-- specializedChampion -->
				</section>
		  </div>
		  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
		  	<h3>멘토링 리뷰</h3>
			<div id="review_for_me"><!-- 리뷰내용 --></div>
		  </div>
		  <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
			<section class="border rounded">
				<h4>수업 가능 시간: ${mentor_profile.contact_time}</h4>
			</section>
			<section class="border rounded">
				<h4>이런 분들께 추천해요: ${mentor_profile.recom_ment}</h4>
			</section>
		  </div>
		</div>
	</div>
	</div><!-- mentor-info -->
	<article class="col-3">
		<div id="mentor_class_info" class="border rounded">
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
	</article>
	</div><!-- mentor detail -->
</div><!-- 여까지 컨테이너 -->
	
<!-- 추가 결제 모달 : 가격 옵션 및 결제 -->
	<div id="flex-add-store">
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
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
	
	let GlobalEmail = "";
	let GlobalPhone_num = "";
	let GlobalLol_account = "";
	let price = 0;
	$(document).ready(function() {
		
		const IMP = window.IMP; // 생략 가능
		//IMP.init("imp26843336"); // 예: imp00000000a, 본인의 가맹점 식별코드
		
	    $.ajax({
	    	method : 'post',
	    	url : '/wallet/payment/userinfo',
	    	data : {email : "${mentor_profile.mentor_email}"}
	    }).done(res=>{
	    	GlobalEmail = res[0].email;
	    	GlobalPhone_num = res[0].phone_num;
	    	GlobalLol_account = res[0].lol_account;
	    }).fail(err=>{
	    	console.log(err)
	    })
				
		displaySpecializedPosition();//멘토 프로필 가져와서 특화 포지션 게시
		
		//평점 적용
		let avg_grade = ${mentor_profile.total_grade/mentor_profile.num_of_reviews}
		let roundedGrade = avg_grade.toFixed(1);
		if(roundedGrade == 'NaN'){
			roundedGrade = 0;			
		}
		$('#avg_grade').html('평점: '+roundedGrade).append($('<i>').addClass('fas fa-star'));
		
		//자기 자신의 프로필 볼때 버튼 사라지게 하기
    	if("${member.email}" === "${mentor.email}"){
    		$('#like-btn').prop('disabled', true);
    		$(".apply-btn").prop('disabled', true);
    	}
    	
    	//멘토 찜버튼 이미 찜했을 시 찜해제로 변경하는 기능
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
		    	        $('#like-btn').text('찜 해제').attr("class","col-2 btn btn-danger");
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
		            let imageUrl = "https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +champion.champion_en_name + ".png?&amp;retry=0";
		            let champImg = $("<img>").addClass("rounded").attr("src", imageUrl);
		            let champName = $("<p>").addClass("text-center").text(champion.champion_kr_name);
		            let champDiv = $("<div>").addClass("champ-post");
		            champDiv.append(champImg);
		            champDiv.append(champName);
		            $(".top-champ").append(champDiv);
		        },
		        error: function (request, status, error) {
		            console.error(error);
		            // 오류 처리
		        }
		    });
		});
		
    	//멘토 찜하기 기능
		  $('#like-btn').click(function() {
			  $.ajax({
		            url: "/mentor/check-session",
		            method: "GET",
		            success: function(response) {
		            if (response.isLoggedIn) {
		            	let email = response.email;
					    if (isLiked) {
					    	isLiked = false;
					    	$('#like-btn').text('찜 하기').attr("class","col-2 btn btn-outline-danger");
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
			                        let current_likes = parseInt($('#mentor_likes').text());
			                        $('#mentor_likes').text(current_likes-1);
			                    },
			                    error: function() {
			                        alert("삭제 실패.");
			                    }
			                });
					      console.log('찜 해제');
					    } else {
					    	isLiked = true;
					    	$('#like-btn').text('찜 해제').attr("class","col-2 btn btn-danger");
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
			                        let current_likes = parseInt($('#mentor_likes').text());
			                        $('#mentor_likes').text(current_likes+1);
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
    	
    	//수업 신청하기 기능
	    $(".apply-btn").click(function() {
	    	let class_id =$(this).attr("id");
	    	price = $(this).val();
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
	                    $.ajax({
	                    	url: '/mentor/profile/payment/mentoring-application',
	                    	method : 'post',
	                    	contentType : 'application/json; charset=utf-8',
	                    	data : JSON.stringify(applicationData)	//수업 신청 버튼 클릭 시, 멘티의 잔액 확인 후 신청 승인 여부 결정
	                    }).done(res=>{
	                    	console.log(res);
	                    	if(res){
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
    	
	    $.ajax({ //멘토 태그 가져오기
	        type: "POST",
	        url: "/mentor/get-mentor-tag",
	        data: JSON.stringify({"mentor_email": "${mentor_profile.mentor_email}"}),
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        success: function(response) {
	            const mentorTags = $("#mentor-tags");
	            $.each(response, function(i,tag){
	            	mentorTags.append($("<button>").addClass("btn btn-outline-primary")
	            			.prop('disabled', true)
	            			.text(tag.mentor_version));
	            })
	        },
	        error: function(error) {
	            console.error(error);
	            // 오류 처리 로직
	        }
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
	    		  let $section = $("<section>").addClass("border rounded");
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
	    		  $section.append(table)
	    		  reviewForMeList.empty().append($section);
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
	function requestPay() {
		if(price === "1 원"){
			let regex = /\d+/;
			price = parseInt(price.match(regex)[0]);
			console.log(price);
		}else{
			price = parseInt(price.replace(/,/g, ""));
			console.log(price);
		}
		let orderId = "";
		$.ajax({
			method: 'post',
			url: '/wallet/payment/getOrderId',
			async : false
		}).done(res => {
			orderId = res;
		}).fail(err => {
			console.log(err);
		});
		
		// IMP.request_pay() 호출 부분을 이동
		IMP.request_pay({
			pg: "kakaopay.TC0ONETIME",
			pay_method: "card",
			merchant_uid: orderId,
			name: "테스트용 상품",
			amount: price,
			buyer_email : GlobalEmail,
			buyer_name : GlobalLol_account,
			buyer_tel : GlobalPhone_num,
		}, function (rsp) {
			if (rsp.success) {
			console.log(rsp);
			$.ajax({
				url: "/wallet/payment/kakaopay/success",
				method: "POST",
				data: {
				imp_uid: rsp.imp_uid,
				merchant_uid: rsp.merchant_uid,
				price: rsp.paid_amount,
				email: GlobalEmail,
				lol_account: GlobalLol_account,
				phone_num: GlobalPhone_num,
				payment_status: "success",
				payment_method: rsp.pg_type
				}
			}).done(res => {
				alert("결제가 완료되었습니다");
				console.log(res);
				location.reload();
			}).fail(err => {
				console.log(err);
			});
			} else {
			$.ajax({
				url: "/wallet/payment/kakaopay/fail",
				method: "POST",
				data: {
				imp_uid: rsp.imp_uid,
				merchant_uid: rsp.merchant_uid,
				price: rsp.paid_amount,
				email: GlobalEmail,
				lol_account: GlobalLol_account,
				phone_num: GlobalPhone_num,
				payment_status: "fail",
				payment_method: rsp.pg_type
				}
			}).done(res => {
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