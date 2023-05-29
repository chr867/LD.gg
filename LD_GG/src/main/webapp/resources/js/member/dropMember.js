document.getElementById("dropMember").addEventListener("click", function() {
		const password = document.getElementById("password").value;
		if(password !== ""){
			$.ajax({
		        method: 'post',
		        url: '/member/drop_member',
		        data: {password:password},
		      }).done(res=>{
		        console.log(res);
		        if(res){
		        	location.href = '/';
		        }
		      }).fail(err=>{
		        console.log(err);
		        alert("회원탈퇴 실패")
		      }); 
		}else{
			alert("비밀번호를 적어주세요")
		}
	});