$('#find_email').on('click',function(){
	if($('#phone').val() !=''){
		$.ajax({
			method: 'get',
			url: '/member/find_email',
			data: {phone_num:$('#phone').val()},
		}).done(res=>{
			console.log(res);
			if(res.length !== 0){
				$('#result').html(res).css('color','blue');

			}else{
				$('#result').html("등록된 이메일 없음").css('color','red');
			}
			
		}).fail(err=>{
			console.log(err);
		})
	}
})