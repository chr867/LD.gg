let myEmail = document.getElementById("email").textContent;

function modify(t_b_num) {
  location.href = `/userinterface/notice/modify?t_b_num=${t_b_num}`
}

function go_list(){
  location.href = '/userinterface/notice'
}

const t_b_num = document.getElementById('t_b_num').textContent
loadComments();
function loadComments(){  // 댓글 리스트
  $.ajax({
    method : 'get',
    url : '/userinterface/notice/reply-list.json',
    data : {'t_b_num': t_b_num}
  }).done(res=>{
    let replyList = "";
    res.forEach(reply => {
      let deleteButton = '';
      let modifyButton = '';
      let date = new Date(reply.t_r_date)
      let localTime = date.toLocaleString();
      if(myEmail===reply.email || myEmail=='admin@ld.gg'){
        deleteButton = '<td><button id="comment-delete-btn-'+reply.t_r_num+'" onclick="deleteComment('+reply.t_r_num+')" class="per_button">삭제</button></td>'
        modifyButton = '<td><button id="comment-modify-btn-'+reply.t_r_num+'" onclick="modifyReplyBtn('+reply.t_r_num+')" class="per_button">수정</button></td>'
      }
      replyList += '<tr height="35" align="center" id="reply_box_'+reply.t_r_num+'">'
      replyList += '<td id="reply_email" width="100">'+reply.email+'</td>'
      replyList += '<td width="500" id="content_num_'+reply.t_r_num+'">'+reply.t_r_content+'</td>'
      replyList += '<td width="100">'+localTime+'</td>'
      replyList += deleteButton
      replyList += modifyButton
      replyList += '</tr>'
    });
    document.getElementById('comment-section').innerHTML=replyList
  }).fail(err=>{
    console.log(err)
  })

}

function submitComment() {  // 댓글 작성
	let t_r_content = document.getElementById("comment-textarea").value;
	$.ajax({
        method: 'post',
        url: '/userinterface/notice/reply-insert.do',
        data: {
          t_b_num: t_b_num,
          t_r_content: t_r_content
        },
      }).done(res=>{
        console.log(res);
        if (res) {
        	  console.log(res);
        	  document.getElementById("comment-textarea").value = null;
        	  loadComments();
        	} else {
        	  console.log(res)
        	  alert("댓글 등록 실패")
        	} 
      }).fail(err=>{
        console.log(err);
      }); 
}

function deleteComment(t_r_num) {  // 댓글 삭제
  $.ajax({
       method: 'post',
       url: '/userinterface/notice/reply-delete.do',
       data: {t_r_num: t_r_num},
     }).done(res=>{
       console.log(res);
       if (res==1) {
           console.log()
           alert("댓글 삭제 성공")
           loadComments();
         }else if(res==2){
           console.log(res)
           alert("댓글 삭제 실패")
         }else if(res==3){
             console.log(res)
           alert("본인 게시물 외엔 삭제할 수 없습니다.")
         }else{
             console.log(res)
             alert("오류발생")
         }
       loadComments(); //댓글 삭제시 비동기로 댓글로드
     }).fail(err=>{
       console.log(err);
       alert("오류발생")
     });  
}

function modifyReplyBtn(t_r_num) {  // 댓글 수정
  $.ajax({
      method: 'post',
      url: '/userinterface/notice/reply-modify',
      data: {t_r_num: t_r_num},
  }).done(res => {
      if (res) {
          console.log(res);
          const contentId = 'content_num_' + t_r_num;
          const inputId = 'content_input_num_' + t_r_num;
          const contentElement = document.getElementById(contentId);
          const content = contentElement.innerHTML;
          contentElement.innerHTML = '<input class="modifyBox" type="text" id="' + inputId + '" value="' + content + '">';

          const deleteBtn = document.getElementById('comment-delete-btn-' + t_r_num);
          const modifyBtn = document.getElementById('comment-modify-btn-' + t_r_num);
          const submitBtnId = 'comment-submit-btn-' + t_r_num;
          const submitBtn = '<button id="' + submitBtnId + '" onclick="submitModifiedComment(' + t_r_num + ')">수정완료</button>';
          deleteBtn.style.display = "none";
          modifyBtn.style.display = "none";
          const wrapper = document.createElement('div');
          wrapper.innerHTML = submitBtn;
          contentElement.parentNode.insertBefore(wrapper.firstChild, contentElement.nextSibling);

      } else {
          console.log(res)
          alert("본인 댓글만 수정 가능합니다.")
      }
  }).fail(err => {
      console.log(err);
  });
}

function submitModifiedComment(t_r_num) {  // 댓글 수정 작업
	console.log(t_r_num);

    const t_r_content = document.getElementById('content_input_num_' + t_r_num).value;
    $.ajax({
        method: 'post',
        url: '/userinterface/notice/reply-modify.do',
        data: {t_r_num: t_r_num, t_r_content: t_r_content},
      }).done(res=>{
        console.log(res);
        if (res) {
            console.log(res);
            loadComments(); //댓글 수정시 비동기로 댓글로드
        } else {
            console.log(res)
            alert("댓글 수정 실패")
        } 
      }).fail(err=>{
        console.log(err);
      }); 
}