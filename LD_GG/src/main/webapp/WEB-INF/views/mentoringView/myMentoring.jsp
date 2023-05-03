<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이멘토링</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	
	<h2>${member.lol_account} 회원님의 마이멘토링 페이지입니다~~</h2>
	<br>
	<h4>받은 견적서</h4>
	<div id="received_estimate"></div>
	<br>
	<h4>보낸 견적서</h4>
	<div id="sent_estimate"></div>
	<br>
	<h4>나의 멘토링 내역</h4>
	<div id="mentoring_history"></div>
	<br>
	<h4>도움이 필요한 멘티목록</h4>
	<div id="menti_list"></div>
	<br>
	
	<!-- 모달 -->
	<div class="modal fade" id="estimateModal" tabindex="-1" aria-labelledby="estimateModalLabel" aria-hidden="true" style="display: none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="estimateModalLabel"></h5>
      </div>
      <div class="modal-body">
        <form id="estimateForm">
          <div class="mb-3">
            <label for="estimateContent" class="form-label">견적 내용</label>
            <textarea class="form-control" id="estimateContent" rows="5"></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">닫기</button>
            <button type="submit" class="btn btn-primary">전송</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
	
<script>
$(window).on("load", function() {
	$.ajax({
        type: "GET",
        url: "/mentor/recom-menti",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
    	success: function(data) {
    		  let mentiList = $("#menti_list");
    		  let table = $("<table>").addClass("menti-table");
    		  let header = $("<tr>").append(
    		    $("<th>").text("멘티 아이디"),
    		    $("<th>").text("배우고 싶은 포지션"),
    		    $("<th>").text("배우고 싶은 챔피언"),
    		    $("<th>").text("목표 티어"),
    		    $("<th>").text("나만의 목표")
    		  );
    		  table.append(header);
    		  for (let i = 0; i < data.length; i++) {
    		    let menti = data[i];
    		    let row = $("<tr>").append(
    		      $("<td>").text(menti.summoner_name),
    		      $("<td>").text(menti.position_to_learn),
    		      $("<td>").text(menti.champion_to_learn),
    		      $("<td>").text(menti.target_tier),
    		      $("<td>").text(menti.own_goal),
    		      $("<td>").append($("<button>").attr("class", "estimate-btn")
    		    		  .attr("id", menti.summoner_name).text("견적서 작성")
    		    ));
    		    table.append(row);
    		  }
    		  mentiList.empty().append(table);
    		  $(".estimate-btn").click(function() {
    			  let menti_summoner_name = this.id;
    			    $("#estimateModal").modal("show");
    			    $(".modal-title").attr("id",menti_summoner_name);
    			    $(".modal-title").text(menti_summoner_name+"님에게 견적서 보내기");
              });
		},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            console.error(status);
            console.error(error);
        }
    });
	$.ajax({
        type: "GET",
        url: "/mentor/get-received-estimate",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
    	success: function(data) {
    		  let rEstList = $("#received_estimate");
    		  let table = $("<table>").addClass("rEst-table");
    		  let header = $("<tr>").append(
    		    $("<th>").text("견적서를 보낸 멘토"),
    		    $("<th>").text("견적 내용"),
    		    $("<th>").text("보낸 날짜")
    		  );
    		  table.append(header);
    		  for (let i = 0; i < data.length; i++) {
    		    let est = data[i];
    		    let row = $("<tr>").append(
    		      $("<td>").text(est.mentor_email),
    		      $("<td>").text(est.estimate_info),
    		      $("<td>").text(est.estimate_date)
    		    );
    		    table.append(row);
    		  }
    		  mentiList.empty().append(table);
		},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            console.error(status);
            console.error(error);
        }
    });
});
$(document).ready(function() {
	$(".btn-close").click(()=>{
		$("#estimateModal").modal("hide");
	});
	  $("#estimateForm").submit(function(event) {
	    event.preventDefault();
	    let form_data = {
	    	estimate_id: null,
	    	estimate_info: $("#estimateContent").val(),
	      	mentor_email: "${member.email}",
	      	menti_email: $(".modal-title").attr("id"),
	      	estimate_date: null
	    };
	    $.ajax({
	      type: "POST",
	      url: "/mentor/save-estimate",
	      data: JSON.stringify(form_data),
	      contentType: "application/json; charset=utf-8",
	      success: function(data) {
	        alert("견적서가 전송되었습니다.");
	        $("#estimateModal").modal("hide");
	      },
	      error: function(xhr, status, error) {
	        console.error(xhr.responseText);
	        console.error(status);
	        console.error(error);
	      }
	    });
	  });
	});
</script>


	
</body>
</html>