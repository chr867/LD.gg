<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의사항</title>
<!-- Bootstrap CSS (버전 5.3.0-alpha1) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

<!-- SweetAlert2 CSS (버전 11.4.10) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

<!-- jQuery (버전 3.6.3) -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>

<!-- jqGrid CSS (버전 4.15.5) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">

<!-- jqGrid JS (버전 4.15.5) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

<!-- Bootstrap JS (버전 3.3.2) -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- Bootstrap CSS (버전 3.3.2) -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

</head>
<style>
/* 테이블 전체 스타일 */
#gview_grid {
  width: 100%; /* 테이블 너비 조정 */
  border-collapse: collapse; /* 테이블 셀 경계 병합 */
}

/* 테이블 헤더 스타일 */
#grid th {
  background-color: #f2f2f2; /* 헤더 배경색 */
  border: 1px solid #ddd; /* 헤더 테두리 스타일 */
  padding: 8px; /* 헤더 셀 안쪽 여백 */
  text-align: left; /* 헤더 텍스트 정렬 */
}

/* 테이블 내용 스타일 */
#grid td {
  border: 1px solid #ddd; /* 셀 테두리 스타일 */
  padding: 8px; /* 셀 안쪽 여백 */
}

/* 짝수 행 배경색 스타일 */
#grid tr:nth-child(even) {
  background-color: #f9f9f9; /* 짝수 행 배경색 */
}

/* 홀수 행 배경색 스타일 */
#grid tr:nth-child(odd) {
  background-color: #fff; /* 홀수 행 배경색 */
}

.modal-backdrop {
    z-index: 0; 
}
.textarea {
  width: 100%;
  max-width: 500px; /* 최대 너비 설정 */
}
</style>
<body>

<h3>고객 문의사항</h3>

<div class="container mt-5">
    <div class="row">
        <div class="col-lg-6">
            <input type="text" class="form-control mb-2 mr-sm-2" id="keyword" placeholder="검색어 입력">
            <button type="button" class="btn btn-primary mb-2" id="search">검색</button>
        </div>
        
        <!-- 문의사항 작성 모달 -->
<div class="modal fade" id="inquiriesModal" tabindex="-1" aria-labelledby="inquiriesModalLabel" aria-hidden="true" style="display: none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="inquiriesModalLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body"> 
        <form id="inquiriesForm">
          <div class="mb-3">
            <label for="inquiriesTitle" class="form-label">제목</label>
            <input type="text" class="form-control" id="inquiriesTitle" name="inquiriesTitle">
          </div>
          <div class="mb-3">
            <label for="inquiriesContent" class="form-label">내용</label>
            <textarea class="form-control" id="inquiriesContent" name="inquiriesContent" rows="5"></textarea>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-primary">전송</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- 모달 -->
    </div>
    
    
   <div id="grid-wrapper">
    <table id="grid" style="width: 100%;"></table>
	    <div class="col-md-6 text-right">
			<button type="button" id="open-inquiries" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#inquiriesModal">글작성</button>
		</div>
    <div id="pager"></div>
    
    </div>
</div>

<!-- jQuery library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- jqGrid library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<!-- Bootstrap jQuery UI library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
    	loadGrid();
    	
    	$('#keyword').on('keydown', function(event) {
    	    if (event.key === 'Enter') { // 인풋창에서 엔터 눌렀을때 검색
    	      event.preventDefault();
    	      $('#search').click();
    	    }
    	  });
    	
    	 $("#inquiriesForm").submit(function(event) {
    		    event.preventDefault();
    		    let form_data = {
    		    	inquiries_title: $("#inquiriesTitle").val(),
    		    	inquiries_info: $("#inquiriesContent").val(),
    		      	customer_email: "${member.email}"
    		    };
    		    console.log(form_data)
    		    $.ajax({ //견적서 보내기 기능
    		      type: "POST",
    		      url: "/faq/save-ci",
    		      data: JSON.stringify(form_data),
    		      contentType: "application/json; charset=utf-8",
    		      success: function(data) {
    		        alert("질문이 등록되었습니다.");
    		        $("#inquiriesModal").modal("hide");
    		        location.reload();
    		      },
    		      error: function(xhr, status, error) {
    		        console.error(xhr.responseText);
    		        console.error(status);
    		        console.error(error);
    		      }
    		    });
    		  })
    	 
    	
    	$("#open-inquiries").click(function() {
            let costomer_email = "${member.email}";
            $("#inquiriesModal").modal("show"); //문의사항 모달 켜기
            $(".modal-title").text("문의 하실 내용을 작성해주세요");
        });
    	
    	$(".btn-close").click(()=>{ //문의사항 모달 끄기
    		$("#inquiriesModal").modal("hide");
    	});
    	
    	


        $("#search").on("click", function () { //검색
            var keyword = $("#keyword").val();

            $("#grid").jqGrid('setGridParam', {
                url: "/faq/get-by-keyword-ci",
                datatype: "json",
                postData: { keyword: keyword },
                colNames: ['번호','상태', '제목', '작성일', '작성자', '조회수'],
	      		  colModel: [
	      		    { name: 'inquiries_id', index: 'inquiries_id', width: 20 },
	      		    { name: 'state', index: 'state', width: 50 },
	      		    { name: 'inquiries_title', index: 'inquiries_title', width: 300 },
	      		    { name: 'date', index: 'date', width: 90 },
	      		    { name: 'lol_account', index: 'lol_account', width: 80 },
	      		    { name: 'views', index: 'views', width: 50 }
	      		  ],
                loadtext: '로딩중..',
                sortable: true,
                loadonce: true,
                multiselect: false,
                pager: '#pager',
                rowNum: 10,
                sortname: 'createdDate',
                sortorder: 'desc',
                width: 1000,
                height: 500,
                pgbuttons: true,
                pgtext: null,
                viewrecords: false,
                recordpos: 'left',
                pagerpos: 'center',
                pginput: false,
                onSelectRow: function (row_id) {
      			  $('tr.inquiries-info').remove(); // 이미 생성된 답변 창을 모두 닫음
      			  $('tr.answer-row').remove();
      			  $('tr.cs-info').remove();
      			  let row_data = $("#grid").jqGrid('getRowData', row_id);// 행데이터
      			  let id = row_data.inquiries_id;//글 번호
      			  let $inquiries_info_tr = $('<tr>').addClass('inquiries-info'); //질문 내용 보여줄 tr 태그
      			  let $inquiries_info_td1 = $('<td>').attr('colspan', 2);
      			  let $inquiries_info_td2 = $('<td>').attr('colspan', 4);
      			  $.ajax({//질문 내용 가져오기
  				    type: "GET",
  				    url: "/faq/get-by-id-ci/"+id,
  				    dataType: "json",
  				    success: function(res) {
  				      let row = $('#' + row_id);//행 선택
  				      $inquiries_info_tr.append($inquiries_info_td1, $inquiries_info_td2);
  				      row.after($inquiries_info_tr);
  				      var inquiries = res.inquiries_info;// 질문 내용
  				      $inquiries_info_td1.text("문의 내용");
  				      $inquiries_info_td2.text(inquiries);
  				      
  				      $.ajax({//고객 응대 가져오기
  						    type: "GET",
  						    url: "/faq/get-cs/"+id,
  						    dataType: "json",
  						    success: function(res) {
  						      if(res!=null){//답변이 있는 경우
  						    	  console.log(res);
  						    	  console.log(row_data);
  						    	  
  						    	  let cs_info_tr = $('<tr>').addClass('cs-info'); //질문 내용 보여줄 tr 태그
  				    			  let cs_info_td1 = $('<td>').attr('colspan', 2);
  				    			  let cs_info_td2 = $('<td>').attr('colspan', 4);
  				    			  cs_info_tr.append(cs_info_td1,cs_info_td2)
  				    			  $inquiries_info_tr.after(cs_info_tr);
  				    			  
  				    			  var answer = res.cs_info;
  				    			  cs_info_td1.text("답변 내용");
  							      cs_info_td2.text(answer);
  						      }else{//답변이 없는 경우
  						    	  console.log("답변이 없습니다");
  						      
  					    		    var $newRow = $('<tr>').addClass('answer-row');
  					    		    var $newCell = $('<td>').attr('colspan', 5);
  					    		    var $answerForm = $('<form>').addClass('answer-form');
  					    		    var $answerTextarea = $('<textarea>').attr('name', 'answer');
  					    		    var $answerSubmit = $('<input>').attr({
  					    		      'type': 'submit',
  					    		      'value': '답변 등록'
  					    		    });
  					    		    $answerForm.append($answerTextarea, $answerSubmit);
  					    		    $newCell.append($answerForm);
  					    		    $newRow.append($newCell);
  					    		    $inquiries_info_tr.after($newRow);
  					    		    
  					    		    $answerSubmit.on('click', function(e) { //저장 버튼을 눌렀을때
  					   		    	  e.preventDefault(); // 폼 전송을 막습니다.
  					   		    	  let cs_id = row_data.inquiries_id;
  					   		    	  let cs_title = row_data.inquiries_title;
  					   		    	  let cs_info = $('textarea[name="answer"]').val();
  					   		    	  
  					   		    	  let data = {
  					   		    			cs_id: cs_id,
  					   		    	        cs_title: cs_title,
  					   		    			cs_info : cs_info,
  					   		    			cs_answerer_email : "${member.email}"
  					   		    	  }
  						   		    	$.ajax({// cs 저장
  						   		    	  type: 'POST',
  						   		    	  url: '/faq/save-cs',
  						   		    	contentType: "application/json;charset=UTF-8",
  						   		    	  data: JSON.stringify(data),
  						   		    	  success: function(data) {
  						   		    		console.log("답변이 등록되었습니다");
  						   		    	  },
  						   		    	  error: function(xhr, status, error) {
  						   		    		console.log(error);
  						   		    	  }
  						   		    	});

  					   		    	});//답변 등록
  						      }
  						    },
  						    error: function(jqXHR, textStatus, errorThrown) {
  						      console.log("AJAX Error: " + textStatus);
  						    }
  						  });
  				    },
  				    error: function(jqXHR, textStatus, errorThrown) {
  				      console.log("AJAX Error: " + textStatus);
  				    }
  				  });
      		  }//onSelectRow
            }).trigger("reloadGrid");
        });
        
    });
    function loadGrid(){
    	$("#grid").jqGrid({
    		  url: "/faq/get-all-ci", //고객 문의사항 가져오기
    		  datatype: "json",
    		  colNames: ['번호','상태', '제목', '작성일', '작성자', '조회수'],
    		  colModel: [
    		    { name: 'inquiries_id', index: 'inquiries_id'},
    		    { name: 'state', index: 'state'},
    		    { name: 'inquiries_title', index: 'inquiries_title'},
    		    { name: 'date', index: 'date'},
    		    { name: 'lol_account', index: 'lol_account'},
    		    { name: 'views', index: 'views'}
    		  ],
    		  loadtext: '로딩중..',
    		  sortable: true,
    		  loadonce: true,
    		  multiselect: false,
    		  pager: '#pager',
    		  rowNum: 10,
    		  sortname: 'createdDate',
    		  sortorder: 'desc',
    		  autowidth: true,
  			shrinkToFit: true,
    		  height: "auto",
    		  pgbuttons: true,
    		  pgtext: null,
    		  viewrecords: false,
    		  recordpos: 'left',
    		  pagerpos: 'center',
    		  pginput: false,
    		  onSelectRow: function (row_id) {
    			  $('tr.inquiries-info').remove(); // 이미 생성된 답변 창을 모두 닫음
    			  $('tr.answer-row').remove();
    			  $('tr.cs-info').remove();
    			  let row_data = $("#grid").jqGrid('getRowData', row_id);// 행데이터
    			  let id = row_data.inquiries_id;//글 번호
    			  let $inquiries_info_tr = $('<tr>').addClass('inquiries-info'); //질문 내용 보여줄 tr 태그
    			  let $inquiries_info_td1 = $('<td>').attr('colspan', 2);
    			  let $inquiries_info_td2 = $('<td>').attr('colspan', 4);
    			  $.ajax({//질문 내용 가져오기
				    type: "GET",
				    url: "/faq/get-by-id-ci/"+id,
				    dataType: "json",
				    success: function(res) {
				      let row = $('#' + row_id);//행 선택
				      $inquiries_info_tr.append($inquiries_info_td1, $inquiries_info_td2);
				      row.after($inquiries_info_tr);
				      var inquiries = res.inquiries_info;// 질문 내용
				      $inquiries_info_td1.text("문의 내용");
				      $inquiries_info_td2.text(inquiries);
				      
				      $.ajax({//고객 응대 가져오기
						    type: "GET",
						    url: "/faq/get-cs/"+id,
						    dataType: "json",
						    success: function(res) {
						      if(res!=null && res != ''){//답변이 있는 경우
						    	  console.log(res);
						    	  console.log(row_data);
						    	  
						    	  let cs_info_tr = $('<tr>').addClass('cs-info'); //질문 내용 보여줄 tr 태그
				    			  let cs_info_td1 = $('<td>').attr('colspan', 2);
				    			  let cs_info_td2 = $('<td>').attr('colspan', 4);
				    			  cs_info_tr.append(cs_info_td1,cs_info_td2)
				    			  $inquiries_info_tr.after(cs_info_tr);
				    			  
				    			  var answer = res.cs_info;
				    			  cs_info_td1.text("답변 내용");
							      cs_info_td2.text(answer);
						      }else{//답변이 없는 경우
						    	  console.log("답변이 없습니다");
						      
					    		    var $newRow = $('<tr>').addClass('answer-row');
					    		    var $newCell = $('<td>').attr('colspan', 6);
					    		    var $answerForm = $('<form>').addClass('answer-form');
					    		    var $answerTextarea = $('<textarea>').attr('name', 'answer')
					    		    	.css('width', '100%').css('height', '75px');;
					    		    var $answerSubmit = $('<input>').attr({
					    		      'type': 'submit',
					    		      'value': '답변 등록'
					    		    });
					    		    $answerForm.append($answerTextarea, $answerSubmit);
					    		    $newCell.append($answerForm);
					    		    $newRow.append($newCell);
					    		    $inquiries_info_tr.after($newRow);
					    		    
					    		    $answerSubmit.on('click', function(e) { //저장 버튼을 눌렀을때
					   		    	  e.preventDefault(); // 폼 전송을 막습니다.
					   		    	  let cs_id = row_data.inquiries_id;
					   		    	  let cs_title = row_data.inquiries_title;
					   		    	  let cs_info = $('textarea[name="answer"]').val();
					   		    	  
					   		    	  let data = {
					   		    			cs_id: cs_id,
					   		    	        cs_title: cs_title,
					   		    			cs_info : cs_info,
					   		    			cs_answerer_email : "${member.email}"
					   		    	  }
						   		    	$.ajax({// cs 저장
						   		    	  type: 'POST',
						   		    	  url: '/faq/save-cs',
						   		    	contentType: "application/json;charset=UTF-8",
						   		    	  data: JSON.stringify(data),
						   		    	  success: function(data) {
						   		    		alert("답변이 등록되었습니다");
						   		    		loadGrid();
						   		    	  },
						   		    	  error: function(xhr, status, error) {
						   		    		console.log(error);
						   		    	  }
						   		    	});

					   		    	});//답변 등록
						      }
						    },
						    error: function(jqXHR, textStatus, errorThrown) {
						      console.log("AJAX Error: " + textStatus);
						    }
						  });
				    },
				    error: function(jqXHR, textStatus, errorThrown) {
				      console.log("AJAX Error: " + textStatus);
				    }
				  });
    		  }//onSelectRow
    		});
    	}
</script>
</body>
</html>
