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
    background-color: rgba(0,0,0,0.4);
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

  .close:hover,
  .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
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

<h2>스토어</h2>

<div class = "flex-store-div">
	<div class = "flex-hold-cash">
		<strong class = "flex-strong-cash">보유 캐시</strong>
		<strong class = "flex-strong-cash">${cash} 캐시</strong>
	</div>
	<div class = "flex-store-notice">
		<span class = "flex-span-notice">고객캐시는 '알바'카테고리에서 사용이 가능하며, 이력서 열람 시 개당 2,500 캐시가 사용됩니다.</span>
	</div>
	<div class = "flex-payment-info">
		<header class = "flex-payment-header">
			<strong class = "flex-normal-charge">일반 충전</strong>
		</header>
		
		<div class = "flex-paymnent-cash">
			<div class = "flex-label">
				<strong>10,000 캐시</strong>
			</div>
			<input type = "button" class = "flex-payment-button" value = "10,000 원" style = "cursor : pointer">
		</div>
		
		<div class = "flex-paymnent-cash">
			<div class = "flex-label">
				<strong>30,000 캐시</strong>
			</div>
			<input type = "button" class = "flex-payment-button" value = "30,000 원" style = "cursor : pointer">
		</div>
		
		<div class = "flex-paymnent-cash">
			<div class = "flex-label">
				<strong>50,000 캐시</strong>
			</div>
			<input type = "button" class = "flex-payment-button" value = "50,000 원" style = "cursor : pointer">
		</div>
		
	</div>
</div>


<div id = "payment-modal" class = "flex-modal">
	<div class = "modal-content">
		<header class = "modal-header">
			<strong>결제 수단</strong>
		</header>
	
		<div class = "modal-payment-method">
			<input type = "checkbox" value = "card" class = "payment-button" id = "check1"><label for = "check1">신용/체크카드</label>
			<div class = "separator"></div><!-- 구분선 -->
			<input type = "checkbox" value = "kakaopay" class = "payment-button" id = "check2"><label for = "check2">카카오페이</label>
		</div>
		
		<button onclick="requestPay()">결제하기</button>
		
		<span class = "close">닫기</span>
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
        	console.log(res)
        	email = res.email;
        	phone_num = res.phone_num;
        	lol_account = res.lol_account;
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
		if(pm == "kakaopay"){
			IMP.request_pay({
				pg : "kakaopay.TC0ONETIME",
				pay_method : "card",
				merchant_uid : "Iamport_test_payment1", // 주문번호
				name : "테스트용 상품",
				amount : price, // 숫자 타입
				buyer_email : email,
				buyer_name : lol_account,
				buyer_tel : phone_num,
			}, function(rsp) {
				if (rsp.success) {
					// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					// jQuery로 HTTP 요청
					$.ajax({
						url : "/payment/result",
						method : "POST",
						data : {
							imp_uid : rsp.imp_uid, // 결제 고유번호
							merchant_uid : rsp.merchant_uid
						// 주문번호
						}
					}).done(function(data) {
						// 가맹점 서버 결제 API 성공시 로직
					})
				} else {
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}
			});
		}
		if(pm == "card"){
			IMP.request_pay({
				pg : "kcp.A52CY",
				pay_method : "card",
				merchant_uid : "Iamport_test_payment2", // 주문번호
				name : "테스트용 상품",
				amount : price, // 숫자 타입
				buyer_email : email,
				buyer_name : lol_account,
				buyer_tel : phone_num,
			}, function(rsp) {
				if (rsp.success) {
					// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					// jQuery로 HTTP 요청
					$.ajax({
						url : "/payment/result",
						method : "POST",
						data : {
							imp_uid : rsp.imp_uid, // 결제 고유번호
							merchant_uid : rsp.merchant_uid
						// 주문번호
						}
					}).done(function(data) {
						// 가맹점 서버 결제 API 성공시 로직
					})
				} else {
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}
			});
		}
	}
	  
	</script>
	
</body>
</html>