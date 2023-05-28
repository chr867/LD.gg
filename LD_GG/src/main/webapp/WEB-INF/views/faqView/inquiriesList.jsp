<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의사항</title>
<style>
.modal-backdrop {
    z-index: 0; 
}
#search-box{
width:40%;
}
#search-box button{
width:70px;
}
#inquiriesInfo{
  background-color:white;
  margin-top:120px;
  margin-bottom:100px;
  padding:50px;
  border-radius: 20px;
  box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
}
#inquiriesInfo h2{
  font-weight:bold;
}
#board tbody tr:hover{
background-color: #f8f9fa;
cursor:pointer;
}
#ci-box{
width:50%;
color: white;
background-color: #4b93fa;
border-radius: 20px;
padding:24px;
box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
}
#ci-box p, #cs-box p {
font-weight:bold;
}
#cs-box{
width:50%;
color: black;
background-color: #eaedf0;
border-radius: 20px;
padding:24px;
box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
}
.btn.stand{
font-size:14px;
font-weight: bold;
color:white;
border-radius: 30px;
background-color: #f4a100;
}
.btn.clear{
font-size:14px;
font-weight: bold;
color:#3182f6;
border-radius: 30px;
background-color: #eaf2fe;
}
</style>
<!--BOOTSTRAP CSS-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<!--JQUERY-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--sideBar CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/sideBar.css">
<!--header CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/header.css">
<!--footer CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/footer.css">
<!--loginModal CSS-->
<link rel="stylesheet" type="text/css"
      href="/resources/css/main/loginModal.css">
<!--로그인 및 세션관련 JS-->
<script src="/resources/js/main/loginSession.js" defer></script>
<!-- 채팅 관련 JS-->
<script src="/resources/js/main/chat.js" defer></script>
</head>
<body>
<%@ include file="../header.jsp" %>
<%@ include file="../sidebar.jsp" %>
<%@ include file="../footer.jsp" %>


<div class="container">
	<div id="inquiriesInfo">
		<h2>고객 문의사항</h2>
	    <div class="mt-5">
		    <div class="d-flex justify-content-between">
		        <div id="search-box" class="d-flex mb-2 mx-3">
		            <input type="text" class="form-control" id="keyword" placeholder="검색어 입력">
		            <button type="button" class="btn btn-primary mx-2" id="search">검색</button>
		        </div>
		        <div>
					<button type="button" id="open-inquiries" class="btn btn-success" 
					data-bs-toggle="modal" data-bs-target="#inquiriesModal">글작성</button>
					<button type="button" class="btn btn-light mx-2" id="reload">목록</button>
				</div>
		     </div>   
		     <div id="grid-wrapper">
			    <div id="board" style="width: 100%;"></div>
			    <div id="pager" class="d-flex justify-content-center">
			     <button type="button" class="btn btn-secondary mx-2 d-none" id="prev">이전</button>
			      <button type="button" class="btn btn-secondary mx-2" id="next">다음</button>
			      <button type="button" class="btn btn-secondary mx-2 d-none" id="prevSearch">이전</button>
			      <button type="button" class="btn btn-secondary mx-2 d-none" id="nextSearch">다음</button>
			    </div>
		    </div>
	    </div>
    </div>
</div>

<!-- 문의사항 작성 모달 -->
<div class="modal fade" id="inquiriesModal" tabindex="-1" aria-labelledby="inquiriesModalLabel" aria-hidden="true" style="display: none;">
  <div class="modal-dialog modal-dialog-centered">
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
</div><!-- 모달 -->

<!-- jQuery library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- jqGrid library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<!-- Bootstrap jQuery UI library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-bootstrap/0.5pre/assets/js/bootstrap.min.js"></script>

<script type="text/javascript">
var currentPage = 1; // 현재 페이지 번호    
var currentSearchPage = 1; // 현재 검색 페이지 번호    

    $(document).ready(function () {
    	loadTable();
    	
    	$(document).on('click', '.table tbody tr', function () {
    		var ci_num = $(this).find('td:first-child').text();
    		if(!isNaN(ci_num)){
    			console.log(ci_num)
    			$('.word-box').remove();
    			var $ci = $('<div>').addClass("d-flex justify-content-end mx-5 my-3"); //질문 상자
        		var $cs = $('<div>').addClass("d-flex justify-content-start mx-5 my-3"); //답변 상자
        		  $(this).after('<tr class="word-box"><td colspan="6"></td></tr>');
        		var wordBox = $(this).next().find('td');
        		wordBox.append($ci,$cs);
        		
    	    		$.ajax({//질문 내용 가져오기
    					    type: "GET",
    					    url: "/faq/get-by-id-ci/"+ci_num,
    					    dataType: "json",
    					    success: function(res) {
    					    	var ciHeader = $('<p>').text("문의 내용");
    					    	var ciInfo = $('<span>').text(res.inquiries_info);
    					    	var ciCom = $('<div>').attr("id","ci-box").append(ciHeader,ciInfo)
    					    	$ci.append(ciCom);
    					    	
    					    	 $.ajax({//고객 응대 가져오기
    								    type: "GET",
    								    url: "/faq/get-cs/"+ci_num,
    								    dataType: "json",
    								    success: function(response) {
    								    	if(response !== "" && response !== null){
    									    	var csHeader = $('<p>').text("답변 내용");
    									    	var csInfo = $('<span>').text(response.cs_info);
    									    	var csDate = $('<em>').addClass("d-flex justify-content-end").text(response.date);
    									    	var csCom = $('<div>').addClass("d-flex flex-column").attr("id","cs-box").append(csHeader,csInfo,csDate)
    									    	$cs.append(csCom);
    								    	}else{ // 답변이 없을 경우
    								    		if(${member.user_type}==3){ // 관리자 회원인경우
    								    			var asHeader = $('<div>').addClass("d-flex justify-content-between my-2 px-1").append(
        									    			$('<p>').addClass("my-auto").text("답변 작성"),
        									    			$('<button>').attr("id","answer-btn").addClass("btn btn-dark").text("작성")
        									    			);
        									    	var asInfo = $('<textarea>').attr("id","answer-text").attr("rows","5").addClass("form-control");
        									    	var asCom = $('<div>').attr("id","cs-box").append(asHeader,asInfo);
        									    	$cs.append(asCom);
        									    	
        									    	$("#answer-btn").on('click', function() { //저장 버튼을 눌렀을때
        								   		    	  let cs_id = res.inquiries_id;
        								   		    	  let cs_title = res.inquiries_title;
        								   		    	  let cs_info = $('#answer-text').val();
        								   		    	  
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
        									   		    		loadTable();
        									   		    	  },
        									   		    	  error: function(xhr, status, error) {
        									   		    		console.log(error);
        									   		    	  }
        									   		    	});

        								   		    	});//답변 등록
    								    		}
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
    		}
    	  });
    	
    	$('#reload').on('click', function() {
    		  location.reload();
    		});
    	
    	$("#next").click(function(){
    		currentPage = currentPage+9;
    		loadTable();
    		var start = (currentPage+9 - 1); // 페이지의 시작 인덱스
    	  	  $.ajax({
    	  	    type: "GET",
    	  	    url: "/faq/get-all-ci", // 고객 문의사항 가져오기
    	  	    dataType: "json",
    		  	data: {
    		  		start: start
    		  	},
    	  	    success: function (res) {
    	  	    	if(res==""){
    	  	    		$("#next").addClass("d-none")
    	  	    	}
    	  	  	},
    	  	    error: function (jqXHR, textStatus, errorThrown) {
    	  	      console.log("AJAX Error: " + textStatus);
    	  	    }
    	  	  });
    	  	$("#prev").removeClass("d-none");
    	})
    	$("#prev").click(function(){
    		currentPage = currentPage-9;
    		if(currentPage==1){
    			$("#prev").addClass("d-none")
    		}
    		loadTable();
    		$("#next").removeClass("d-none")
    	})
    	
    	$("#nextSearch").click(function(){
    		currentSearchPage = currentSearchPage+9;
    		searchLoadTable();
    		var start = (currentSearchPage+9 - 1); // 페이지의 시작 인덱스
    		 var keyword = $("#keyword").val();
    	  	  $.ajax({
    	  	    type: "GET",
    	  	  	url: "/faq/get-by-keyword-ci",
    		    dataType: "json",
    		    data: { 
    		    	keyword: keyword, 
    		    	start: start	
    		    },
    	  	    success: function (res) {
    	  	    	if(res==""){
    	  	    		$("#nextSearch").addClass("d-none")
    	  	    	}
    	  	  	},
    	  	    error: function (jqXHR, textStatus, errorThrown) {
    	  	      console.log("AJAX Error: " + textStatus);
    	  	    }
    	  	  });
    	  	$("#prevSearch").removeClass("d-none");
    	});
    	$("#prevSearch").click(function(){
    		currentSearchPage = currentSearchPage-9;
    		if(currentSearchPage==1){
    			$("#prevSearch").addClass("d-none")
    		}
    		searchLoadTable();
    		$("#nextSearch").removeClass("d-none")
    	});
    	
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
    		    $.ajax({ //질문 작성 기능
    		      type: "POST",
    		      url: "/faq/save-ci",
    		      data: JSON.stringify(form_data),
    		      contentType: "application/json; charset=utf-8",
    		      success: function(data) {
    		        alert("질문이 등록되었습니다.");
    		        $("#inquiriesModal").modal("hide");
    		        loadTable();
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
    	
    	$("#search").on("click", function () {
    		$("#next").addClass("d-none")
    		$("#nextSearch").removeClass("d-none")
    		$("#prevSearch").addClass("d-none")
    		currentSearchPage = 1;
    		searchLoadTable();
    	});
    });//ready
    
function searchLoadTable(){
	var start = (currentSearchPage - 1);
	  var keyword = $("#keyword").val();
	  $.ajax({
	    type: "GET",
	    url: "/faq/get-by-keyword-ci",
	    dataType: "json",
	    data: { 
	    	keyword: keyword, 
	    	start: start	
	    },
	    success: function (res) {
	    	if(res==""){
  	    		$("#nextSearch").addClass("d-none")
  	    	}
	      let tableData = res; // 받아온 데이터 (예시로 전체 데이터를 사용)
	      let $table = $('<table>').addClass('table');
	      let $thead = $('<thead>');
	      let $tbody = $('<tbody>');

	      // 테이블 헤더 생성
	      let $trHeader = $('<tr>');
	      let headers = ['번호', '상태', '제목', '작성일', '작성자'];
	      for (let i = 0; i < headers.length; i++) {
	        let $th = $('<th>').text(headers[i]);
	        $trHeader.append($th);
	      }
	      $thead.append($trHeader);
	      $table.append($thead);

	      // 테이블 바디 생성
	      for (let i = 0; i < tableData.length; i++) {
	        let rowData = tableData[i];
	        let $tr = $('<tr>');
	        let dataKeys = ['inquiries_id', 'state', 'inquiries_title', 'date', 'lol_account'];
  	        for (let j = 0; j < dataKeys.length; j++) {
  	          let $td = $('<td>').text(rowData[dataKeys[j]]);
  	          if(rowData[dataKeys[j]]=="답변 대기중"){
  	        	$td = $('<td>').append($('<button>').addClass("btn stand").text(rowData[dataKeys[j]]));
  	          }else if(rowData[dataKeys[j]]=="답변 완료"){
  	        	$td = $('<td>').append($('<button>').addClass("btn clear").text(rowData[dataKeys[j]]));  
  	          }
  	          $tr.append($td);
	        }
	        $tbody.append($tr);
	      }
	      $table.append($tbody);

	      // 기존 그리드 대신 테이블로 교체
	      $('#board').html("");
	      $('#board').append($table);
	    },
	    error: function (jqXHR, textStatus, errorThrown) {
	      console.log("AJAX Error: " + textStatus);
	    }
	  });
    }
    
function loadTable() {
	var start = (currentPage - 1); // 페이지의 시작 인덱스
	
  	  $.ajax({
  	    type: "GET",
  	    url: "/faq/get-all-ci", // 고객 문의사항 가져오기
  	    dataType: "json",
	  	data: {
	  		start: start
	  	},
  	    success: function (res) {
  	      let tableData = res; // 받아온 데이터 (예시로 전체 데이터를 사용)
  	      let $table = $('<table>').addClass('table');
  	      let $thead = $('<thead>');
  	      let $tbody = $('<tbody>');

  	      // 테이블 헤더 생성
  	      let $trHeader = $('<tr>');
  	      let headers = ['번호', '상태', '제목', '작성일', '작성자'];
  	      for (let i = 0; i < headers.length; i++) {
  	        let $th = $('<th>').text(headers[i]);
  	        $trHeader.append($th);
  	      }
  	      $thead.append($trHeader);
  	      $table.append($thead);

  	      // 테이블 바디 생성
  	      for (let i = 0; i < tableData.length; i++) {
  	        let rowData = tableData[i];
  	        let $tr = $('<tr>');
  	        let dataKeys = ['inquiries_id', 'state', 'inquiries_title', 'date', 'lol_account'];
  	        for (let j = 0; j < dataKeys.length; j++) {
  	          let $td = $('<td>').text(rowData[dataKeys[j]]);
  	          if(rowData[dataKeys[j]]=="답변 대기중"){
  	        	$td = $('<td>').append($('<button>').addClass("btn stand").text(rowData[dataKeys[j]]));
  	          }else if(rowData[dataKeys[j]]=="답변 완료"){
  	        	$td = $('<td>').append($('<button>').addClass("btn clear").text(rowData[dataKeys[j]]));  
  	          }
  	          $tr.append($td);
  	        }
  	        $tbody.append($tr);
  	      }
  	      $table.append($tbody);

  	      // 기존 그리드 대신 테이블로 교체
  	      $('#board').html("");
  	      $('#board').append($table);
  	    },
  	    error: function (jqXHR, textStatus, errorThrown) {
  	      console.log("AJAX Error: " + textStatus);
  	    }
  	  });
  	}

</script>
</body>
</html>
