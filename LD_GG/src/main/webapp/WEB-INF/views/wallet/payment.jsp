<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
/* 모달 창을 초기에는 보이지 않게 함 */
.flex-modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

/* 모달 창 내용 */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 600px;
}

/* 닫기 버튼 */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.flex-store-div {
	display: flex;
	flex-flow: wrap;
	flex-direction: column;
	width: 70%;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.flex-store-title {
	display: flex;
	width: 90%;
}

.flex-hold-cash {
	display: flex;
	height: 5%;
	border: 1px solid #000000;
	background-color: #000000;
	border-radius: 5px;
	width: 90%;
	justify-content: center;
	align-items: center;
}

.flex-strong-cash {
	color: #ffffff;
}

.flex-store-notice {
	display: flex;
	width: 90%;
	height: 3%;
	border: 1px solid #EAEAEA;
	background-color: #EAEAEA;
	border-radius: 5px;
	justify-content: center;
	align-items: center;
}

.flex-payment-info {
	width: 90%;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.flex-payment-header {
	align-self: flex-start;
	margin-left: 0;
}

.flex-normal-charge {
	margin-left: 0;
}

.flex-paymnent-cash {
	display: flex;
	align-items: center;
	border: 1px solid #EAEAEA;
	background-color : #fcfcfc;
}

.flex-label {
	display: flex;
	align-items: center;
}

.flex-payment-button {
	margin-left: 10px; /* 원하는 간격으로 조정 가능 */
}
</style>

<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script type="text/javascript">
	const IMP = window.IMP; // 생략 가능
	IMP.init("imp26843336"); // 예: imp00000000a, 본인의 가맹점 식별코드

	//IMP.agency('TC0ONETIME', '카카오페이 결제창');  //ABC = Tier Code

	//주문번호는 결제창 요청 시 항상 고유 값으로 채번 되어야 합니다.
	//결제 완료 이후 결제 위변조 대사 작업시 주문번호를 이용하여 검증이 필요하므로 주문번호는 가맹점 서버에서 고유하게(unique)채번하여 DB 상에 저장해주세요.
</script>


</head>
<body>

	<div class="flex-store-div">
		<h2 class="flex-store-title">스토어</h2>
		<div class="flex-hold-cash">
			<strong class="flex-strong-cash" id="flex-hold-title">보유 캐시</strong>
			<strong class="flex-strong-cash" id="flex-hold-cash">${cash}
				캐시</strong>
		</div>
		<div class="flex-store-notice">
			<span class="flex-span-notice">고객캐시는 '알바'카테고리에서 사용이 가능하며, 이력서
				열람 시 개당 2,500 캐시가 사용됩니다.</span>
		</div>
		<div class="flex-payment-info">
			<header class="flex-payment-header">
				<strong class="flex-normal-charge">일반 충전</strong>
			</header>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>1 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="1 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>10,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="10,000 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>30,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="30,000 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong>50,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="50,000 원"
					style="cursor: pointer">
			</div>

		</div>
	</div>


	<div id="payment-modal" class="flex-modal">
		<div class="modal-content">
			<header class="modal-header">
				<strong>결제 수단</strong>
			</header>

			<div class="modal-payment-method">
				<input type="checkbox" value="card" class="payment-button"
					id="check1"><label for="check1">신용/체크카드</label>
				<div class="separator"></div>
				<!-- 구분선 -->
				<input type="checkbox" value="kakaopay" class="payment-button"
					id="check2"><label for="check2">카카오페이</label>
			</div>

			<button onclick="requestPay()">결제하기</button>

			<span class="close">닫기</span>
		</div>
	</div>

	<script type="text/javascript">
	let email = "";
	let phone_num = "";
	let lol_account = "";
	window.onload = function() {
        $.ajax({
        	method : 'post',
        	url : '/wallet/payment/userinfo',
        	data : {email : "${email}"}
        }).done(res=>{
        	email = res[0].email;
        	phone_num = res[0].phone_num;
        	lol_account = res[0].lol_account;
        }).fail(err=>{
        	console.log(err)
        })
      }
	
	$(document).ready(function() {
	    $(".flex-payment-button").click(function() {
	      $(".flex-modal").fadeIn();
	    });
	  
	    $(".close").click(function() {
	      $(".flex-modal").fadeOut();
	    });
	  });
	
	$('.payment-button').on('change',function(){
		// 체크된 버튼 확인
		let checked = $(this).prop('checked');
		
		if(checked){
			$('.payment-button').not(this).prop('checked', false);
		}
	});
	
	let price = "";
	$('.flex-payment-button').on('click',function(){
		price = $(this).val();
		console.log(price);
	})
	
	let pm = "";
	let company = "";
	$('.payment-button').on('click',function(){
		company = $(this).val();
		pm = $(this).val();
		console.log(company,pm);
	})
	
	function requestPay() {
		$(".flex-modal").fadeOut();
		
		let orderId = "";
		
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
			async : false
		}).done(res=>{
			orderId = res;
			console.log(orderId);
		}).fail(err=>{
			console.log(err);
		})
		if(pm == "kakaopay"){
			IMP.request_pay({
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
					$.ajax({
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
						console.log(res)
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
							payment_status : "success",
							payment_method : rsp.pg_type
						}
					}).done(res=>{
						// 가맹점 서버 결제 API 성공시 로직
						console.log(res)
					})
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}
			});
		}
		if(pm == "card"){
			IMP.request_pay({
				pg : "kcp.A52CY",
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
					$.ajax({
						url : "/wallet/payment/kcp/success",
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
						console.log(res)
					})
				} else {
					$.ajax({
						url : "/wallet/payment/kcp/fail",
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
						console.log(res)
					})
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}
			});
		}
	}
	  
	</script>

</body>
</html>