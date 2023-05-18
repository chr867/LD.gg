	function moveMain() {
		event.preventDefault();
		location.href = "/"
	}
	
	let emailSubmit = false;
	let accountSubmit = false;
	let phoneSubmit = false;
	
	function check() {
		let frm = document.joinFrm;
		  let inputs = frm.getElementsByTagName("input");
	
		  for (let i = 0; i < inputs.length; i++) {
		    if (inputs[i].type === "text" || inputs[i].type === "password") {
		      if (inputs[i].value.trim() === "") {
		        alert(inputs[i].placeholder + "을(를) 입력하세요!!");
		        inputs[i].focus();
		        return false; // 실패시
		      }
		    }
		  }
		
		if(!emailSubmit){
			alert("이메일 중복검사를 다시해주세요")
			return false;
		}
		
		if(!accountSubmit){
			alert("소환사계정 중복검사를 다시해주세요")
			return false;
		}
		
		if(!phoneSubmit){
			alert("전화번호 중복검사를 다시해주세요")
			return false;
		}
		return true;//성공시 서버로 전송
	}//end function
	
	$('#check_lol_account').on('click',function(){
		if($('#summoner').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_lol_account',
				data: {lol_account:$('#summoner').val()},
			}).done(res=>{
				if(res.length === 0){
					$('#summoner-duplicate').hide();
					$('#summoner-duplicate-pass').show()
					accountSubmit = true;
				}else{
					$('#summoner-duplicate').show();
					$('#summoner-duplicate-pass').hide()
					$('#summoner').val("");
					accountSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})
	
	$('#check_email').on('click',function(){
		event.preventDefault();
		if($('#email').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_email',
				data: {email:$('#email').val()},
				//dataType: 'html', //json,html(text)
			}).done(res=>{
				if(res == true){
					$('#eamlil-duplicate-pass').show();
					$('#eamlil-duplicate').hide();
					console.log('res : '+res);
					emailSubmit = true;
				}else{
					$('#eamlil-duplicate-pass').hide();
					$('#eamlil-duplicate').show();
					$('#email').val("");
					emailSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})
	
	$('#check_phone_num').on('click',function(){
		if($('#phone').val() !=''){
			$.ajax({
				method: 'get',
				url: '/member/check_phone_num',
				data: {phone_num:$('#phone').val()},
				//dataType: 'html', //json,html(text)
			}).done(res=>{
				if(res == true){
					$('#phone-duplicate-pass').show();
					$('#phone-duplicate').hide();
					console.log('res : '+res);
					phoneSubmit = true;
				}else{
					$('#phone-duplicate-pass').hide();
					$('#phone-duplicate').show();
					$('#phone').val("");
					phoneSubmit = false;
				}
				
			}).fail(err=>{
				console.log(err);
			})
		}
	})