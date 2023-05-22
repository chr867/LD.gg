function go_mypage(){
  location.href="/member/mypage"
}

$('#champ_recom').submit(function(event){
  event.preventDefault();
  let formData = $(this).serialize();

  $.ajax({
    url: "/champion/champ-recom.json",
    type: 'POST',
    data: formData,
  }).done(res=>{
    console.log(res)
  }).fail(err=>{
    console.log(err)
  })
})

$('#build_recom').submit(function(event){
  event.preventDefault();
  let formData = $(this).serialize();

  $.ajax({
    url: "/champion/build-recom.json",
    type: 'POST',
    data: formData,
  }).done(res=>{
    console.log(res)
  }).fail(err=>{
    console.log(err)
  })
})

$('#champ_search').submit(function(evt){
  evt.preventDefault();
  let formData = $(this).serialize();

  $.ajax({
  url:'/champion/search.json',
  type: 'POST',
  data: formData
  }).done(res=>{
    console.log(res)
    document.getElementById('search_txt').value=""
  }).fail(err=>{
    console.log(err)
  })
})