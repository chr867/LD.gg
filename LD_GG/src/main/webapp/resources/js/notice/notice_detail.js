function modify(t_b_num) {
  location.href = `/userinterface/notice/modify?t_b_num=${t_b_num}`
}

function go_list(){
  location.href = '/userinterface/notice'
}

const t_b_num = document.getElementById('t_b_num').textContent

$.ajax({
  method : 'get',
  url : '/userinterface/notice/reply-list.json',
  data : {'t_b_num': t_b_num}
}).done(res=>{
  console.log(res)
}).fail(err=>{
  console.log(err)
})