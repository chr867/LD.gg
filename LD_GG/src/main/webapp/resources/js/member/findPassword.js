$('#find_password').on('click',function(){
	if($('#email').val() !='' && $('#phone').val() !=''){
		let email = $('#email').val();
		let phone = $('#phone').val()
		$.ajax({
			method: 'post',
			url: '/member/find_password',
			data: {email:$('#email').val(), phone_num:$('#phone').val()},
		}).done(res=>{
			console.log(res);
			if(res !== ""){
				$('#result').html("임시비밀번호 : "+res);
			}else{
				alert("이메일 또는 전화번호를 확인해주세요")
			}
			
		}).fail(err=>{
			console.log(err);
		})
	}
})