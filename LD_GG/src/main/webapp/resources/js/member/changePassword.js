document.getElementById("changePassword").addEventListener("click", function() {
	  const password = document.getElementById("password").value;
	  const passwordTochange1 = document.getElementById("passwordTochange1").value;
	  const passwordTochange2 = document.getElementById("passwordTochange2").value;
	  
 	  if (password !== "" && passwordTochange1 !== "" && passwordTochange2 !== "") {
	    if (passwordTochange1 === passwordTochange2) {
 	      $.ajax({
	        method: 'post',
	        url: '/member/change_password',
	        data: {email:'${sessionScope.email}', password:password, changePw:passwordTochange2},
	      }).done(res=>{
	        console.log(res);
	        if (res) {
	        	  document.getElementById("result").innerHTML = "비밀번호 변경완료";
	        	  document.getElementById("result").style.color = "blue";
	        	} else {
	        	  document.getElementById("result").innerHTML = "비밀번호 변경 실패";
	        	  document.getElementById("result").style.color = "red";
	        	} 
	      }).fail(err=>{
	        console.log(err);
	      }); 
	    } else {
	      alert("변경할 비밀번호가 일치하지 않습니다.");
	    }
	  }else{
		  alert("값을 모두 입력해주세요")
	  } 
	});