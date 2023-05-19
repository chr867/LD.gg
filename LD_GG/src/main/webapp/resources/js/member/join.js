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
function setSummoner(name) {
    document.getElementById("summoner").value = name;
  }

  function confirmSummoner() {
    $('#exampleModal').modal('hide');
    document.getElementById("summoner").readOnly = true;
    accountSubmit = true;
  }
  
$('#check_lol_account').on('click', function() {
  if ($('#summoner').val() != '') {
  $('.modal-body table').empty();
    $.ajax({
      method: 'get',
      url: '/member/check_lol_account',
      data: { summoner_name: $('#summoner').val(), lol_account: $('#summoner').val() },
    }).done(function(res) {
      console.log(res)
      if (res.length === 0) {
        $('#summoner-duplicate').show();
        $('#summoner-duplicate-pass').hide();
        $('#summoner').val("");
      } else {
        $('#exampleModal').modal('show');
        $('#summoner-duplicate').hide();
        $('#summoner-duplicate-pass').show();
        var tableHTML = '';
        res.forEach(function(summoner) {
          tableHTML += '<tr>';
          tableHTML += '<td><img class="find-summoner-icon" src="/resources/img/icon/profileIcon5626.webp" alt="소환사 아이콘"></td>';
          tableHTML += '<td class="summoner-name">' + summoner.summoner_name + '</td>';
          tableHTML += '<td class="summoner-level">' + summoner.s_level + '</td>';
          tableHTML += '<td><input type="radio" id="selection1" name="selection" value="1" onclick="setSummoner(\'' + summoner.summoner_name + '\')"></td>';
          tableHTML += '</tr>';
        });
        $('.modal-body table').append(tableHTML);
      }
    }).fail(function(err) {
      console.log(err);
    });
  } else {
    alert("소환사계정을 입력해주세요.");
  }
});

  
 $('#check_email').on('click',function(){
	event.preventDefault();
	if($('#email').val() !=''){
		$.ajax({
			method: 'get',
			url: '/member/check_email',
			data: {email:$('#email').val()},
			//dataType: 'html', //json,html(text)
		}).done(res=>{
			if(res){
				$('#email-duplicate-pass').show();
				$('#email-duplicate').hide();
				console.log('res : '+res);
				emailSubmit = true;
			}else{
				$('#email-duplicate-pass').hide();
				$('#email-duplicate').show();
				$('#email').val("");
				emailSubmit = false;
			}
			
		}).fail(err=>{
			console.log(err);
		})
	}
})