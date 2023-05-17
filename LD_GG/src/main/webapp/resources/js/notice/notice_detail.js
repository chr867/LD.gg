let myEmail = document.getElementById("email").textContent;
console.log(myEmail)
function modify(t_b_num) {
  location.href = `/userinterface/notice/modify?t_b_num=${t_b_num}`
}

function go_list(){
  location.href = '/userinterface/notice'
}

const t_b_num = document.getElementById('t_b_num').textContent

$.ajax({  // 댓글 리스트
  method : 'get',
  url : '/userinterface/notice/reply-list.json',
  data : {'t_b_num': t_b_num}
}).done(res=>{
  console.log(res)
  let replyList = "";
  res.forEach(reply => {
    console.log(reply)
    let deleteButton = '';
    let modifyButton = '';
    let date = new Date(reply.t_r_date)
    let localTime = date.toLocaleString();
    if(myEmail===reply.email){
      deleteButton = '<td><button id="comment-delete-btn-'+reply.t_r_num+'" onclick="deleteComment('+reply.t_r_num+')">삭제</button></td>'
      modifyButton = '<td><button id="comment-modify-btn-'+reply.t_r_num+'" onclick="modifyReplyBtn('+reply.t_r_num+')">수정</button></td>'
    }
    replyList += '<tr height="35" align="center" id="reply_box_'+reply.t_r_num+'">'
    replyList += '<td width="100">'+reply.email+'</td>'
    replyList += '<td width="500" id="content_num_'+reply.t_r_num+'">'+reply.t_r_content+'</td>'
    replyList += '<td width="100">'+localTime+'</td>'
    replyList += deleteButton
    replyList += modifyButton
    replyList += '</tr>'
  });
  document.getElementById('reply_table').innerHTML=replyList
}).fail(err=>{
  console.log(err)
})

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
        	  loadComments(); //댓글 등록시 비동기로 댓글로드
        	} else {
        	  console.log(res)
        	  alert("댓글 등록 실패")
        	} 
      }).fail(err=>{
        console.log(err);
      }); 
}
