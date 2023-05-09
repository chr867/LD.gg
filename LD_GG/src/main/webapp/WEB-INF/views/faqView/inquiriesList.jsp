<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의사항</title>
</head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
    crossorigin="anonymous">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
    src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"
    integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
    crossorigin="anonymous"></script>
<!-- jqGrid CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- jqGrid JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<style type="text/css"></style>

<body>

<h3>고객 문의사항</h3>

<div class="container mt-5">
    <div class="row">
        <div class="col-lg-6">
            <input type="text" class="form-control mb-2 mr-sm-2" id="keyword" placeholder="검색어 입력">
            <button type="button" class="btn btn-primary mb-2" id="search">검색</button>
        </div>
    </div>
    <div class="col-md-6 text-right">
				<a href="/faq/write" class="btn btn-primary">글 작성</a>
			</div>
    
   <div id="grid-wrapper">
    <table id="grid"></table>
    <div id="pager"></div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	$("#grid").jqGrid({
    		  url: "/faq/get-all-ci",
    		  datatype: "json",
    		  colNames: ['번호', '제목', '작성일', '조회수'],
    		  colModel: [
    		    { name: 'inquiries_id', index: 'inquiries_id', width: 50 },
    		    { name: 'inquiries_title', index: 'inquiries_title', width: 300 },
    		    { name: 'date', index: 'date', width: 120 },
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
    			// 이미 생성된 답변 창을 모두 닫음
    			  $('tr.answer-row').remove();
    			
    		    var $selectedRow = $("#grid").jqGrid('getRowData', row_id);
    		    console.log($selectedRow);
    		    $selectedRow = $('#' + row_id); // 수정된 코드
    		    var $newRow = $('<tr>').addClass('answer-row');
    		    var $newCell = $('<td>').attr('colspan', 4);
    		    var $answerForm = $('<form>').addClass('answer-form');
    		    var $answerTextarea = $('<textarea>').attr('name', 'answer');
    		    var $answerSubmit = $('<input>').attr({
    		      'type': 'submit',
    		      'value': '답변 등록'
    		    });
    		    $answerForm.append($answerTextarea, $answerSubmit);
    		    $newCell.append($answerForm);
    		    $newRow.append($newCell);
    		    $selectedRow.after($newRow);
    		    
    		    $answerSubmit.on('click', function(e) {
   		    	  e.preventDefault(); // 폼 전송을 막습니다.
   		    	  
   		    	  var $form = $(this).closest('form'); // 클릭한 버튼의 상위 폼 엘리먼트를 찾습니다.
   		    	  var formData = $form.serialize(); // 폼 데이터를 시리얼라이즈합니다.
   		    	  var inquiriesId = $form.closest('tr').prev().attr('id'); // 현재 행의 바로 위에 있는 행의 inquiries_id 값을 가져옵니다.
   		    	  let data = {
   		    			cs_id: $selectedRow['inquiries_id'],
   		    	        cs_title: $selectedRow['inquiries_title'],
   		    			cs_info : $answerTextarea.text(),
   		    			cs_answerer_id : "${member.email}"
   		    	  }
	   		    	$.ajax({// cs 저장
	   		    	  type: 'POST',
	   		    	  url: '/faq/save-cs',
	   		    	contentType: "application/json;charset=UTF-8",
	   		    	  data: JSON.stirngify,
	   		    	  success: function(data) {
	   		    	    console.log(data);
	   		    	  },
	   		    	  error: function(xhr, status, error) {
	   		    		console.log(data);
	   		    	  }
	   		    	});

   		    	});

    		  }
    		});


        $("#search").on("click", function () {
            var keyword = $("#keyword").val();

            $("#grid").jqGrid('setGridParam', {
                url: "/faq/get-by-keyword-ci",
                datatype: "json",
                postData: { keyword: keyword },
                colNames: ['번호', '제목', '작성일', '조회수'],
                colModel: [
                	{ name: 'inquiries_id', index: 'inquiries_id', width: 50 },
                    { name: 'inquiries_title', index: 'inquiries_title', width: 300 },
                    { name: 'date', index: 'date', width: 120 },
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
                onSelectRow: function (inquiries_id) {
                	console.log(inquiries_id);
                    location.href = `/faq/detail?id=${inquiries_id}`;
                }
            }).trigger("reloadGrid");
        });
        
    });
</script>
</body>
</html>
