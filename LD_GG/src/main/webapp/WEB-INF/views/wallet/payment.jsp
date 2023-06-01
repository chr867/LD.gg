<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>LD.GG 내 지갑</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
    </script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--AJAX-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!--JQUERY VALIDATE-->
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
<!--sideBar CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/sideBar.css">
<!--header CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/header.css">
<!--footer CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/footer.css">
<!--loginModal CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/main/loginModal.css">
<!--로그인 및 세션관련 JS-->
<script src="/resources/js/main/loginSession.js" defer></script>
<!-- 채팅 관련 JS-->
<script src="/resources/js/main/chat.js" defer></script>
<!-- 결제 관련 CSS -->
<link href = "/resources/css/wallet/payment.css?after" rel = "stylesheet">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>

<!-- jqGrid CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">

<!-- jqGrid JS -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

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

<%@ include file="../header.jsp"%>
<%@ include file="../sidebar.jsp"%>
<%@ include file="../footer.jsp"%>
<div class = "store-container">
	<div class="flex-store-div">
	
	<h2 class="flex-store-title">스토어</h2>
	
		<div class = "flex-store-tab">
			<div class = "flex-purchaseTab">포인트 충전</div>	<div class = "flex-chargeTab">충전/사용내역</div>
		</div>
		
		<div class="flex-hold-cash">
			<div class = "cash-title-div"><strong class="flex-strong-cash" id="flex-hold-title">보유 캐시</strong></div>
			<div class = "cash-title-div"><strong class="flex-strong-cash" id="flex-hold-cash">${buyer.point_balance} 캐시</strong></div>
		</div>
		
		<div class="flex-payment-info">

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong class = "flex-payment-cash-text">10,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="10,000 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong class = "flex-payment-cash-text">30,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="30,000 원"
					style="cursor: pointer">
			</div>

			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong class = "flex-payment-cash-text">50,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="50,000 원"
					style="cursor: pointer">
			</div>
			
			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong class = "flex-payment-cash-text">100,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="100,000 원"
					style="cursor: pointer">
			</div>
			
			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong class = "flex-payment-cash-text">150,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="150,000 원"
					style="cursor: pointer">
			</div>
			
			<div class="flex-paymnent-cash">
				<div class="flex-label">
					<strong class = "flex-payment-cash-text">200,000 캐시</strong>
				</div>
				<input type="button" class="flex-payment-button" value="200,000 원"
					style="cursor: pointer">
			</div>

		</div>
		
	</div>
	
	<div id = "usageHistory">
		<div id = "history-content">
		
			<table class="usageWindow">
			  <thead>
			    <tr class="usageCategory">
			      <th class="usageMiniCategory">거래 날짜</th>
			      <th class="usageMiniCategory">거래 금액</th>
			    </tr>
			  </thead>
			  <tbody class="usageHistoryWindow"></tbody>
			</table>
			
			<table class = "usageWindow">
				<thead>
					<tr class="usageCategory">
						<th class="usageMiniCategory">구매 번호</th>
			      		<th class="usageMiniCategory">충전 금액</th>
					</tr>
				</thead>
				<tbody class = "merchantHistoryWindow"></tbody>
			</table>
			
		</div>
	</div>

	<div id="payment-modal" class="flex-modal">
		<div class="payment-modal-content">
			<div class = "payment-modal-header">
				<strong class = "payment-method-text">결제 수단</strong>
			</div>
			
			<div class="modal-payment-method">
			
				<div class = "payment-method">
					<input type="checkbox" value="card" class="payment-button"id="check1"><label for="check1">신용/체크카드</label>
				</div>
				
				<div class = "payment-method">
					<input type="checkbox" value="kakaopay" class="payment-button"id="check2"><label for="check2">카카오페이</label>
				</div>
				
			</div>

			<button class = "requestBtn" onclick="requestPay()">결제하기</button>

			<span class="close">닫기</span>
		</div>
	</div>
</div>
	<script type="text/javascript">
	let holder_email = "${buyer.holder_email}"
	let email = "";
	let phone_num = "";
	let lol_account = "";
	console.log(holder_email);
	window.onload = function() {
        $.ajax({
        	method : 'post',
        	url : '/wallet/payment/userinfo',
        	data : {email : '${buyer.holder_email}'}
        }).done(res=>{
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
	    $("#usageHistory").css("display","none");
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
						location.reload();
						console.log(res);
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
						// 가맹점 서버 결제 API 실패시 로직
						location.reload();
						console.log(res);
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
						location.reload();
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
						// 가맹점 서버 결제 API 실패 시 로직
						console.log(res)
					})
					alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}
			});
		}
	};
	
	$('.flex-chargeTab').click(function(){
		$("#usageHistory").fadeIn();
		
		let charge = "";
		let merchant = "";
		
		$.ajax({
			url : '/wallet/payment/getCharge',
			method : 'post',
			data : {email : holder_email},
			async : false
		}).done(res=>{
			console.log(res);
			/* $.each(res, function(i, history){
				  let historyTr = $('<tr class="historyTr"></tr>');
				  let dateTd = $('<td class="dateTd">'+history.tx_date+'</td>');
				  let pointsTd = $('<td class="pointsTd">'+history.points_sent+'</td>');
				  let merchantIdTd = $('<td class="merchantIdTd">'+history.merchant_id+'</td>');
				  let priceTd = $('<td class="priceTd">'+history.price+'</td>');
				  historyTr.append(dateTd, pointsTd, merchantIdTd, priceTd);
				  $('.usageHistoryWindow').append(historyTr);
				}); */
			charge = res;
		}).fail(err=>{
			console.log(err);
		});
		
		$.ajax({
			url : '/wallet/payment/getMerchant',
			method : 'post',
			data : {email : holder_email},
			async : false
		}).done(res=>{
			console.log(res);
			merchant = res;
		}).fail(err=>{
			console.log(err);
		})
		
		let chargeData = '';
		$.each(charge, function(i, charge){
			let chargeTr = $('<tr class="historyTr"></tr>');
			let dateTd = "";
			let pointsTd = "";
		
			if(charge.sender_id === holder_email){
				dateTd = $('<td class="dateTd">'+charge.tx_date+'</td>');
				pointsTd = $('<td class="pointsTd">신청료 : '+charge.points_sent+'</td>');
				chargeTr.append(dateTd, pointsTd);
				chargeData += chargeTr.prop('outerHTML');
			}else{
				dateTd = $('<td class="dateTd">'+charge.tx_date+'</td>');
				pointsTd = $('<td class="pointsTd">받은 금액 : '+charge.points_received+'</td>');
				chargeTr.append(dateTd, pointsTd);
				chargeData += chargeTr.prop('outerHTML');
			}
		});
		$('.usageHistoryWindow').html(chargeData);

		let historyData = "";
		$.each(merchant, function(j, merchant){
			let historyTr = $('<tr class="historyTr"></tr>');
			let merchantIdTd = $('<td class="merchantIdTd">'+merchant.merchant_id+'</td>');
			let priceTd = $('<td class="priceTd">'+merchant.price+'</td>');
			
			historyTr.append(merchantIdTd, priceTd);
			historyData += historyTr.prop('outerHTML');
		});
		$('.merchantHistoryWindow').html(historyData);
	});
	
	window.addEventListener("click", function(event) {
		  if (event.target == document.getElementById("usageHistory")) {
		    document.getElementById("usageHistory").style.display = "none";
		  }else if(event.target == document.getElementById("payment-modal")) {
			  document.getElementById("payment-modal").style.display = "none";
		  }
		});
	</script>

</body>
</html>