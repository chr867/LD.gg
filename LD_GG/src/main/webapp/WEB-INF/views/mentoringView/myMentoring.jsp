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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<style>
.card{
margin:auto;
margin-bottom:1.5rem;
max-width: 1200px;
box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
border-radius: 10px;
}
.card-body{
padding-left:0;
padding-right:0;
}
.numbering{
text-align:center;
}

.btn-td{
width:50px;
}
button{
margin:auto;
}
.over-cell {
width:300px;
max-width:300px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
#menti, #r-est, #s-est,#a-class, #r-class, #w-review, #m-review{
width:850px;
}
#like{
width:250px;
margin-left:16px;
}
tbody tr:hover{
cursor:pointer;
background-color:#e9ecef;
}
th{
font-size: 12px;
}
td{
font-size: 12px;
max-width:150px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
h4{
font-size: 20px;
font-weight:bold;
margin:8px;
}
#current, #target, #menti-tag #menti-tag2{
padding: 12px 24px;
}
#profile-icon{
border: solid 3px white;
border-radius: 50%;
box-shadow: 0 3px 6px rgba(0, 0.5, 0, 0.5);
}
#target-champ img{
border-radius: 10px;
}
#target p{
margin-top:12px;
background-color:black;
color:white;
font-weight: bold;
}
#target span{
font-weight: bold;
}
.modal-title{
font-weight: bold;
}
::-webkit-scrollbar {
    width: 3px;
}
::-webkit-scrollbar-thumb {
    background-color: #888;
}
::-webkit-scrollbar-track {
    background: none;
}
#nav-bar{
width: 850px;
margin:auto;
margin-bottom: 60px;
}
</style>
</head>
<body>

<div class='container'>
	<div id="nav-bar">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">견적 확인</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">수업 관리</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">리뷰 관리</button>
		  </li>
		</ul>
	</div>
	
	<div class="tab-content" id="myTabContent">
	  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
	  		<div class="card" id="r-est">
				<div class="card-header">
					<h4>받은 견적서</h4>
				</div>
				<div id="received_estimate" class="card-body">
				<!-- 받은 견적서 내용 -->
				</div>
			</div>
			<div class="card" id="s-est">
				<div class="card-header">
					<h4>보낸 견적서</h4>
				</div>
				<div id="sent_estimate" class="card-body">
				<!-- 보낸 견적서 내용 -->
				</div>
			</div>
			<div class="card" id="menti">
				<div class="card-header">
					<h4>도움이 필요한 멘티목록</h4>
				</div>
				<div id="menti_list" class="card-body">
				<!-- 도움이 필요한 멘티목록 -->
				</div>
			</div>
	  </div>
	  
	  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
		<div class="d-flex justify-content-center">
			<div >
				<div class="card" id="a-class">
					<div class="card-header">
						<h4>내가 신청한 수업 목록</h4>
					</div>
					<div id="apply_class_history" class="card-body">
					<!-- 내가 신청한 수업 목록 -->
					</div>
				</div>
				<div class="card" id="r-class">
					<div class="card-header">
						<h4>수강 신청한 멘티 목록</h4>
					</div>
					<div id="request_class_history" class="card-body">
					<!-- 수강 신청한 멘티 목록 -->
					</div>
				</div>
			</div>
			<div>
				<div class="card" id="like">
					<div class="card-header">
						<h4>내가 찜한 멘토 목록</h4>
					</div>
					<div id="like_mentor_list" class="card-body">
					<!-- 내가 찜한 멘토 목록 -->
					</div>
				</div>
			</div>	
		</div>
	  </div>
	  
	  <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
  		<div class="card" id="w-review">
			<div class="card-header">
				<h4>내가 작성한 멘토 리뷰</h4>
			</div>
			<div id="written_review" class="card-body">
			<!-- 내가 작성한 멘토 리뷰 -->
			</div>
		</div>
		
		<div class="card" id="m-review">
			<div class="card-header">
				<h4>나에게 달린 리뷰</h4>
			</div>
			<div id="review_for_me" class="card-body">
			<!-- 나에게 달린 리뷰 -->
			</div>
		</div>
	  </div>
	</div>
	
	
	
	
	
	
	
<!-- 견적서 쓰기 모달 -->
	<div class="modal fade" id="estimateModal" tabindex="-1" aria-labelledby="estimateModalLabel" aria-hidden="true" style="display: none;">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="estimateModalLabel"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form id="estimateForm">
	          <div class="mb-3">
	            <label for="estimateContent" class="form-label">견적 내용</label>
	            <textarea class="form-control" id="estimateContent" rows="10"></textarea>
	          </div>
	          <div class="modal-footer d-flex justify-content-between">
	            <button type="button" class="btn btn-secondary" id="get-custom">맞춤멘토 요청서 확인</button>
	            <button type="submit" class="btn btn-primary">견적 보내기</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	
<!-- 견적서 모달 -->
	<div class="modal fade" id="estMo" tabindex="-1" aria-labelledby="estMoLabel" aria-hidden="true" style="display: none;">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="estMoLabel"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	          <div class="mb-3">
	            <label for="estContent" class="form-label">견적 내용</label>
	            <textarea class="form-control" id="estContent" rows="10" disabled></textarea>
	          </div>
	          <div class="modal-footer">
	          <span class="d-flex justify-content-end" id="estDate"></span>
	          </div>
	      </div>
	    </div>
	  </div>
	</div>
	
<!-- 리뷰 쓰기 모달 -->
	<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true" style="display: none;">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="reviewModalLabel"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form id="reviewForm">
	        <div class="mb-3">
			  <label for="grade" class="form-label">평점</label>
			  <div>
			    <span class="star-grade">
			      <input type="radio" name="grade" id="grade-1" value="1" />
			      <label for="grade-1"><i class="fa fa-star"></i>1</label>
			      <input type="radio" name="grade" id="grade-2" value="2" />
			      <label for="grade-2"><i class="fa fa-star"></i>2</label>
			      <input type="radio" name="grade" id="grade-3" value="3" />
			      <label for="grade-3"><i class="fa fa-star"></i>3</label>
			      <input type="radio" name="grade" id="grade-4" value="4" />
			      <label for="grade-4"><i class="fa fa-star"></i>4</label>
			      <input type="radio" name="grade" id="grade-5" value="5" />
			      <label for="grade-5"><i class="fa fa-star"></i>5</label>
			    </span>
			  </div>
			</div>
	          <div class="mb-3">
	            <label for="reviewContent" class="form-label">리뷰 내용</label>
	            <textarea class="form-control" id="reviewContent" rows="5"></textarea>
	          </div>
	          <div class="modal-footer">
	            <button type="submit" class="btn btn-primary">전송</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	
<!-- 리뷰 모달 -->
	<div class="modal fade" id="rMo" tabindex="-1" aria-labelledby="rMoLabel" aria-hidden="true" style="display: none;">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="rMoLabel"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <div class="mb-3">
			  <span>평점:</span>
			    <span id="r-grade"></span>
			</div>
	          <div class="mb-3">
	            <label for="reviewContent" class="form-label"></label>
	            <strong></strong>
	            <textarea class="form-control" id="rContent" rows="5" disabled></textarea>
	          </div>
	          <div class="modal-footer">
	          <span id="rDate" class="d-flex justify-content-end"></span>
	          </div>
	      </div>
	    </div>
	  </div>
	</div>
	
<!-- 도움이 필요한 멘티 목록 -->
	<div class="modal fade" id="customMo" tabindex="-1" aria-labelledby="customMoLabel" aria-hidden="true">
	  <div id="customMoDialog" class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
        	<h3 class="modal-title" id="customMoLabel">Modal title</h3>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	         <div class="container-fluid">
	         
			    <div class="row" id="current">
			      <div class="d-flex align-item-center justify-content-center">
			      	<img id="profile-icon" class="mx-2" style="width: 72px" src="http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/29.png">
			      	<span class="my-auto">회원님의 현재 티어는</span>
						<div class="my-auto">
							<img id="member-tier-img" class="mx-2" style="width: 72px" src="https://online.gamecoach.pro/img/lol/emblem-UNRANKED.svg">
						</div>
						<div class="my-auto">
							<div>
								<h4 class="text-center">
									<strong id="member-tier">UNRANKED</strong>
								</h4>
								<div id="member-stat">
									<strong>승률 0%</strong>
									<span>(0승 0패)</span>
								</div>
							</div>
						</div>
						<div class="my-auto">
							<span id="member-lp" class="mx-2">0LP</span>
						</div>
						<span class="my-auto">입니다.</span>
					</div>
			    </div>
			    <hr>
			    <div class="row" id="target">
				    <div class="d-flex text-center align-item-center justify-content-center">
				      <div id="target-lane" class="col">
				      	<img class="mx-2" style="width: 72px" src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top.svg">
				      	<p>탑</p>
				      	<span>배우고 싶은 포지션</span>
				      </div>
				      <div id="target-champ" class="col">
				      	<img class="mx-2" style="width: 72px" src="https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/Garen.png?&amp;retry=0">
				      	<p>가렌</p>
				      	<span>배우고 싶은 챔피언</span>
				      </div>
				      <div id="target-tier" class="col">
				      	<img class="mx-2" style="width: 72px" src="https://online.gamecoach.pro/img/lol/emblem-GRANDMASTER.svg">
				      	<p>GRANDMASTER</p>
				      	<span>목표 티어</span>
				      </div>
				    </div>
			    </div>
			    <hr>
			    <h4>이런 수업을 듣고싶어요</h4>
			    <div class="row" id="menti-tag">
			    </div>
			    <hr>
			    <h4>이런 멘토님을 원해요</h4>
			    <div class="row" id="menti-tag2">
			    </div>
			    
			  </div>
	      </div>
	      <div class="modal-footer d-flex justify-content-between">
	      	<button type="button" class="btn btn-secondary" id="go-record-btn">소환사 전적 보기</button>
	        <button type="button" class="btn btn-primary" id="write-est-btn">견적서 작성</button>
	      </div>
	    </div>
	  </div>
	</div>

</div> <!-- container -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
$(document).ready(function() {
	
	$("#go-record-btn").click(function() {
		  let summoner_name = $(this).closest(".modal").find(".modal-title").text();
		  window.location.href = '/summoner/info?summoner_name=' +summoner_name;
		});
	$("#write-est-btn").click(function() {
		  let summoner_name = $(this).closest(".modal").find(".modal-title").text();
		  $("#customMo").modal("hide");
		  $("#menti_list table td").filter(function() {
			  return $(this).text() === summoner_name;
			}).closest("tr").find("button").click();
		});
	$("#get-custom").click(function() {
		  let summoner_name = $(this).closest(".modal").find(".modal-title").text();
		  $("#estimateModal").modal("hide");
		  $("#menti_list table td").filter(function() {
			  return $(this).text() === summoner_name;
			}).closest("tr").click();
		});
	
	getRequestHistory(); //나에게 수강 신청한 멘티 
	getSentEstimate(); //보낸 견적서
	getReceivedEstimate(); //받은 견적서
	getWrittenReview(); //내가 쓴 리뷰
	getClassApplyList(); //내가 신청한 수업
	
	$.ajax({ //도움이 필요한 멘티 목록 가져오기
        type: "GET",
        url: "/mentor/recom-menti",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
    	success: function(data) {
    		  let mentiList = $("#menti_list");
    		  let table = $("<table>").addClass("table");
    		  let header = $("<thead>");
    		  let tr = $("<tr>").append(
    				  $("<th>").attr("scope","col"),
    		    $("<th>").attr("scope","col").text("멘티 닉네임"),
    		    $("<th>").attr("scope","col").text("배우고 싶은 포지션"),
    		    $("<th>").attr("scope","col").text("배우고 싶은 챔피언"),
    		    $("<th>").attr("scope","col").text("목표 티어"),
    		    $("<th>").attr("scope","col")
    		  );
    		  header.append(tr);
    		  table.append(header);
    		  for (let i = 0; i < data.length; i++) {
    		    let menti = data[i];
    		    $.ajax({
    		    	type: "GET",
    		        url: "/mentor/get-champ-name-by-id?id="+menti.champion_to_learn,
    		        contentType: "application/json; charset=utf-8",
    		        dataType: "json",
    		        success: function(data){
    		        	let champion_to_learn = data.champion_kr_name
    		        	if (menti.lol_account !== "${member.lol_account}"){ //현재 조회중인 사람이 아닌 멘티 정보
    	    		    	let tbody = $("<tbody>");
    	    		    let row = $("<tr>").append(
    	    		      $("<td>").text(" "),
    	    		      $("<td>").text(menti.lol_account),
    	    		      $("<td>").text(menti.position_to_learn),
    	    		      $("<td>").text(champion_to_learn),
    	    		      $("<td>").text(menti.target_tier),
    	    		      $("<td>").addClass("btn-td").append(
    	    		    		  $("<button>").attr("type","button")
      	                		.addClass("btn btn-outline-primary btn-sm")
      	   		    		  .attr("id", menti.lol_account).text("견적서 작성")
      	   		    		  .on('click', function() {
      	   		    			event.stopPropagation(); // 이벤트 버블링 제어
      	   		    			  let menti_summoner_name = $(this).attr('id');
      	   		    			    $("#estimateModal").modal("show");
      	   		    			    $("#estimateModalLabel").attr("data",menti_summoner_name);
      	   		    			    $("#estimateModalLabel").text(menti_summoner_name);
      	   		              })	  
    	    		      ),
    	    		      
    	    		    );

    		         	// <tr> 클릭 이벤트 핸들러 추가
    		            row.on('click', function() {
    		            	$("#customMoLabel").text(menti.lol_account);
    		            	
	    		            	$.ajax({
	    		            		  url: "/mentor/get-summoner-info",
	    		            		  type: "GET",
	    		            		  data: {
	    		            		    summoner_name: menti.lol_account
	    		            		  },
	    		            		  success: function(response) {
	    		            		    var som = JSON.parse(response);
	    		            		    $("#profile-icon").attr("src","http://ddragon.leagueoflegends.com/cdn/13.10.1/img/profileicon/"+som.profile_icon_id+".png")
	    		            		    $("#member-tier-img").attr("src","https://online.gamecoach.pro/img/lol/emblem-"+som.tier+".svg")
		    		            		    if(som.tier_int>6){
		    		            		    	$("#member-tier").text(som.tier)
		    		            		    }else{
		    		            		    	$("#member-tier").text(som.tier +" "+som.ranking)
		    		            		    }
	    		            		    let winrate= (som.wins/som.games)*100
	    		            		    winrate = winrate.toFixed(1)
	    		            		    if(winrate == "NaN"){
	    		            		    	winrate=0;
	    		            		    }
	    		            		    $("#member-stat strong").text("승률 "+winrate+"%")
	    		            		    $("#member-stat span").text("("+som.wins+"승 "+som.losses+"패)")
	    		            		    $("#member-lp").text(som.lp+" LP")
	    		            		    
	    		            		  },
	    		            		  error: function(xhr, status, error) {
	    		            		    console.log("에러 발생:", error);
	    		            		  }
	    		            		});
	    		            	
    		            	let pos = menti.position_to_learn;
    		            	if(pos=="탑"){pos="top"}
    		            	else if(pos=="정글"){pos="jg"}
    		            	else if(pos=="미드"){pos="mid"}
    		            	else if(pos=="바텀"){pos="ad"}
    		            	else{pos="sup"};
    		            	$("#target-lane img").attr("src","https://online.gamecoach.pro/img/icon/lol/ico_lol_"+pos+".svg");
    		            	$("#target-lane p").text(menti.position_to_learn);
    		            	$("#target-champ img").attr("src","https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/"+data.champion_en_name+".png?&retry=0");
    		            	$("#target-champ p").text(champion_to_learn);
    		            	$("#target-tier img").attr("src","https://online.gamecoach.pro/img/lol/emblem-"+menti.target_tier+".svg");
    		            	$("#target-tier p").text(menti.target_tier);
    		            	$("#customMo").modal("show");
    		            	
	    		            	$.ajax({ 
	    		    		        type: "POST",
	    		    		        url: "/mentor/get-menti-tag",
	    		    		        data: JSON.stringify({"menti_email": menti.menti_email}),
	    		    		        contentType: "application/json; charset=utf-8",
	    		    		        dataType: "json",
	    		    		        success: function(response) {
	    		    		            const mentiTags = $("#menti-tag");
	    		    		            const mentiTags2 = $("#menti-tag2");
	    		    		            mentiTags.text("");
	    		    		            $.each(response, function(i,tag){
	    		    		            	let $tagButton = $("<button>").addClass("btn btn-outline-primary")
								    		            			.css('margin', "3px")
								    		            			.prop('disabled', true)
								    		            			.text(tag.tag_info);
								    		if(tag.tag_id == 0){
								    			$tagButton.text(champion_to_learn+tag.tag_info)
								    		}else if(tag.tag_id == 1){
								    			$tagButton.text(menti.position_to_learn+" "+tag.tag_info)
								    		}else if(tag.tag_id == 5){
								    			$tagButton.text(tag.tag_info+": "+tag.tag_note)
								    		}else if(tag.tag_id == 26){
								    			$tagButton.text(tag.tag_info+": "+tag.tag_note)
								    		}
								    		
								    		if(tag.tag_type=="target" || tag.tag_type=="class_method"){
								    			mentiTags.append($tagButton);
								    		}else{
								    			mentiTags2.append($tagButton);
								    		}
	    		    		            	
	    		    		            })
	    		    		        },
	    		    		        error: function(error) {
	    		    		            console.error(error);
	    		    		            // 오류 처리 로직
	    		    		        }
	    		    		    })
    		            });
    	    		    tbody.append(row);
    	    		    table.append(tbody);
    	    		    }
    	    		  }
    		        	
    		        })
  			  }
    		    
    		  mentiList.empty().append(table);
		},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            console.error(status);
            console.error(error);
        }
    });

	function getClassApplyList(){
	$.ajax({ //수업 신청 내역 가져오기
	    type: "POST",
	    url: "/mentor/get-mentoring-history",
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    data: JSON.stringify({
			email: "${member.email}"
		}),
	    success: function(data) {
	        let myMtList = $("#apply_class_history");
	        let table = $("<table>").addClass("table");
	        let header = $("<thead>");
	        let tr = $("<tr>").append(
	        		$("<th>").attr("scope","col").text(""),
	            $("<th>").attr("scope","col").text("수업 이름"),
	            $("<th>").attr("scope","col").text("멘토 닉네임"),
	            $("<th>").attr("scope","col").text("신청 날짜"),
	            $("<th>").attr("scope","col").text("완료 날짜"),
	            $("<th>").attr("scope","col").text("상태"),
	            $("<th>").attr("scope","col")
	        );
	        header.append(tr);
	        table.append(header);
	        for (let i = 0; i < data.length; i++) {
	            let myMt = data[i];
	            let tbody = $("<tbody>");
	            let row = $("<tr>").append(
	            		$("<th>").addClass("numbering").attr("scope","row").text(i+1),
	                $("<td>").text(myMt.class_name),
	                $("<td>").text(myMt.mentor_lol_account),
	                $("<td>").text(myMt.apply_date),
	                $("<td>").text(myMt.done_date),
	                $("<td>").text(myMt.menti_state === 0 ? "대기중" : myMt.menti_state === 1 ? "진행중" : "수업 완료"),
	                $("<td>").addClass("btn-td").append(
	                myMt.menti_state === 0 ? $("<button>").attr("type","button")
	               
	                		.addClass("btn btn-outline-warning btn-sm")
	                    .attr("id", myMt.mentoring_id)
	                    .text("신청 취소").on('click', function(event) { //수업 신청 취소
	                    	event.stopPropagation(); // 이벤트 버블링 제어
	                		let mentoring_id = $(this).attr("id");
	                	    let mentiEmail = "${member.email}";
	                	    let data ={
	                	    	menti_email: mentiEmail,
	                	    	mentoring_id: mentoring_id
	                	    }
	                		$(this).closest('tr').remove();
	                		$.ajax({
	                            url: "/mentor/delete-mentoring-history",
	                            type: "DELETE",
	                            data: JSON.stringify(data),
	                            contentType: "application/json; charset=utf-8",
	                            success: function() {
	                                alert("수업 신청이 취소되었습니다");
	                            },
	                            error: function() {
	                                alert("수업 신청 취소 실패");
	                            }
	                        });
	                		
	                	}) : null,
	                myMt.menti_state === 1 ? $("<button>").attr("type","button")
	                		.addClass("btn btn-outline-danger btn-sm")
	                    .attr("id", myMt.mentoring_id)
	                    .text("환불").on('click', function(event) { //수업 환불
	                    	event.stopPropagation(); // 이벤트 버블링 제어
	                		let mentoring_id = $(this).attr("id");
	                	    let mentiEmail = "${member.email}";
	                	    let data ={
	                		    	menti_email: mentiEmail,
	                		    	mentoring_id: mentoring_id
	                		    }
	                		$(this).closest('tr').remove();
	                	    $.ajax({
	                            url: "/mentor/refund-mentoring-history",
	                            type: "DELETE",
	                            data: JSON.stringify(data),
	                            contentType: "application/json; charset=utf-8",
	                            success: function() {
	                                alert("수업 환불 완료");
	                            },
	                            error: function() {
	                                alert("환불 실패");
	                            }
	                        });
	                		
	                	}) : null,
	                myMt.menti_state === 2 ? $("<button>").attr("type","button")
	                		.addClass("btn btn-outline-primary btn-sm")
	                    .attr("id", myMt.mentor_lol_account)
	                    .attr("name", myMt.mentoring_id)
	                    .attr("data", myMt.class_id)
	                    .text("리뷰 쓰기").on('click', function() {
	                    	event.stopPropagation(); // 이벤트 버블링 제어
	        	            let mentor_name = this.id;
	        	            let mentoring_id = this.name;
	        	            $("#reviewModal").modal("show"); //리뷰 모달 켜기
	        	            $(".modal-title").attr("id",mentor_name);
	        	            $(".modal-title").attr("name",mentoring_id);
	        	            $(".modal-title").attr("data", myMt.class_id);
	        	            $(".modal-title").text(mentor_name+"님에게 리뷰 쓰기");
	        	        }) : null
	                )
	            );
	            
	         	// <tr> 클릭 이벤트 핸들러 추가
	            row.on('click', function() {
	            // 다른 페이지로 이동하는 코드 작성
	             window.location.href = '/mentor/profile/' + myMt.mentor_lol_account;
	            });
	         
	            tbody.append(row)
	            table.append(tbody);
	            if (myMt.menti_state === 2) {
	                $.ajax({
	                    url: "/mentor/get-review-by-reviewer",
	                    type: "POST",
	                    contentType: "application/json; charset=utf-8",
	                    dataType: "json",
	                    data: JSON.stringify({
	                        reviewer_email: "${member.email}"
	                    }),
	                    success: function(data) {
	                        for (let i = 0; i < data.length; i++) {
	                            let myReview = data[i];
	                            if (myReview.mentoring_id === myMt.mentoring_id) {
	                            	row.find("[name='" + myMt.mentoring_id + "']").hide();
	                                break;
	                            }
	                        }
	                    },
	                    error: function(xhr, status, error) {
	                        console.error(xhr.responseText);
	                        console.error(status);
	                        console.error(error);
	                    }
	                });
	            }
	        }
	        myMtList.empty().append(table);
	        
	    },
	    error: function(xhr, status, error) {
	        console.error(xhr.responseText);
	        console.error(status);
	        console.error(error);
	    }
	});
	}

	
	$(".btn-close").click(()=>{ //리뷰 모달 끄기
		$("#reviewModal").modal("hide");
	});
	$(function() { 
		let grade = 0;
		  $('.star-grade input').change(function() {//리뷰 평점 바꿀때마다 적용
		    grade = $(this).val();
		  });
		
	  $("#reviewForm").submit(function(event) {
	    event.preventDefault();
	    let form_data = {
    		reviewer_email: "${member.email}",
    		mentoring_id: $(".modal-title").attr('name'),
    		class_id: $(".modal-title").attr('data'),
	    	review_content: $("#reviewContent").val(),
	    	mentor_email: $(".modal-title").attr("id"),
	      	grade: grade
	    };
	    console.log(form_data);
	    $.ajax({ //리뷰 보내기 기능
	      type: "POST",
	      url: "/mentor/save-review",
	      data: JSON.stringify(form_data),
	      contentType: "application/json; charset=utf-8",
	      success: function(data) {
	        alert("리뷰 작성 완료.");
	        $("#reviewModal").modal("hide");
	        getWrittenReview();
	        getClassApplyList();
	      },
	      error: function(xhr, status, error) {
	        console.error(xhr.responseText);
	        console.error(status);
	        console.error(error);
	      }
	    });
	  });
	});
	
	$.ajax({ //내가 찜한 멘토 가져오기
		url: "/mentor/get-like-mentor",
		type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
			email: "${member.email}"
		}),
        success: function(data) {
    		  let likeMentorList = $("#like_mentor_list");
    		  let table = $("<table>").addClass("table");
    		  let header = $("<thead>");
    		  let tr = $("<tr>").append(
    				$("<th>").attr("scope","col"),
   		    		$("<th>").text("찜한 멘토"),
   		    		$("<th>")
    		  );
    		  header.append(tr);
    		  table.append(header);
    		  for (let i = 0; i < data.length; i++) {
    		    let like_mentor = data[i];
    		    let tbody = $("<tbody>");
    		    let row = $("<tr>").append(
    		    		$("<th>").addClass("numbering").attr("scope","row").text(i+1),
    		      $("<td>").text(like_mentor.mentor_lol_account),
    		      $("<td>").addClass("btn-td").append(
	    		      $("<button>").attr("type","button")
		          		.addClass("btn btn-outline-secondary btn-sm")
		    		      .text("찜 해제").on("click", function() {
		    		    	  event.stopPropagation(); // 이벤트 버블링 제어
		    		          $(this).closest('tr').remove(); // 클릭한 버튼이 속한 행 삭제
		    		          let data ={
		    		        	email: "${member.email}",
				                like_mentor: ""+like_mentor.like_mentor
		    		          }
		    		          $.ajax({
				                    url: "/mentor/delete-like-mentor",
				                    type: "DELETE",
				                    data: JSON.stringify(data),
				                    contentType: "application/json; charset=utf-8",
				                    success: function() {
				                        alert("찜 목록에서 삭제 되었습니다.");
				                    },
				                    error: function() {
				                        alert("삭제 실패.");
				                    }
				                });
		    		      	})
	    		     ) 	
    		    );
    		 	// <tr> 클릭 이벤트 핸들러 추가
	            row.on('click', function() {
	            // 찜한 멘토 like_mentor.mentor_lol_account 의 멘토프로필로 이동
	             window.location.href = '/mentor/profile/' + like_mentor.mentor_lol_account;
	            });
    		    tbody.append(row);
    		    table.append(tbody);
    		  }
    		  likeMentorList.empty().append(table);
		},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            console.error(status);
            console.error(error);
        }
    });
	function getWrittenReview() {
	$.ajax({ //내가 쓴 리뷰
		url: "/mentor/get-review-by-reviewer",
		type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
			reviewer_email: "${member.email}"
		}),
        success: function(data) {
    		  let writtenReviewList = $("#written_review");
    		  let table = $("<table>").addClass("table");
    		  let header = $("<thead>");
    		  let tr = $("<tr>").append(
    		    $("<th>").attr("scope","col"),
    		    $("<th>").attr("scope","col").text("멘토 닉네임"),
    		    $("<th>").attr("scope","col").text("수업 이름"),
    		    $("<th>").attr("scope","col").text("리뷰 내용"),
    		    $("<th>").attr("scope","col").text("작성일"),
    		    $("<th>").attr("scope","col").text("평점"),
    		    $("<th>").attr("scope","col")
    		  );
    		  header.append(tr);
    		  table.append(header);
    		  for (let i = 0; i < data.length; i++) {
    		    let written_review = data[i];
    		    let tbody = $("<tbody>");
    		    let row = $("<tr>").append(
    		      $("<th>").addClass("numbering").attr("scope","row").text(i+1),
    		      $("<td>").text(written_review.mentor_lol_account),
    		      $("<td>").text(written_review.class_name),
    		      $("<td>").addClass("over-cell").text(written_review.review_content),
    		      $("<td>").text(written_review.review_date),
    		      $("<td>").text(written_review.grade+'점'),
    		      $("<td>").addClass("btn-td").append(
    		      $("<button>").attr("type","button")
          		.addClass("btn btn-outline-danger btn-sm")
    		      .text("리뷰 삭제").on("click", function() {
    		    	  event.stopPropagation(); // 이벤트 버블링 제어
    		          $(this).closest('tr').remove(); // 클릭한 버튼이 속한 행 삭제
    		          let data ={
   		        		  review_num: written_review.review_num
    		          }
    		          $.ajax({//리뷰 삭제
		                    url: "/mentor/delete-review",
		                    type: "DELETE",
		                    data: JSON.stringify(data),
		                    contentType: "application/json; charset=utf-8",
		                    success: function() {
		                        alert("리뷰가 삭제 되었습니다.");
		                    },
		                    error: function() {
		                        alert("삭제 실패.");
		                    }
		                });
    		      	})
    		      )
    		    );
    		 	// <tr> 클릭 이벤트 핸들러 추가
	            row.on('click', function() {
    	            $("#rMoLabel").text(written_review.reviewer_lol_account+" 멘토님");
    	            $("#rDate").text(written_review.review_date+" 작성됨");
    	            $("#r-grade").text(written_review.grade+'점');
    	            $("#rContent").prev("strong").text(written_review.class_name);
    	            $("#rContent").text(written_review.review_content);
    	            // 내가 쓴 리뷰 모달창 띄우기
    	             $("#rMo").modal("show");
	            });
    		    tbody.append(row);
    		    table.append(tbody);
    		  }
    		  writtenReviewList.empty().append(table);
		},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            console.error(status);
            console.error(error);
        }
    });
	}
	
	$.ajax({ //내게 달린 리뷰
		url: "/mentor/get-review-for-me",
		type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
			mentor_email: "${member.email}"
		}),
        success: function(data) {
    		  let reviewForMeList = $("#review_for_me");
    		  let table = $("<table>").addClass("table");
    		  let header = $("<thead>");
    		  let tr = $("<tr>").append(
    		    $("<th>").attr("scope","col"),
    		    $("<th>").attr("scope","col").text("작성자"),
    		    $("<th>").attr("scope","col").text("수업 이름"),
    		    $("<th>").attr("scope","col").text("리뷰 내용"),
    		    $("<th>").attr("scope","col").text("작성일"),
    		    $("<th>").attr("scope","col").text("평점"),
    		    $("<th>").attr("scope","col")
    		  );
    		  header.append(tr);
    		  table.append(header);
    		  for (let i = 0; i < data.length; i++) {
    		    let review_for_me = data[i];
    		    let tbody =$("<tbody>");
    		    let row = $("<tr>").append(
    		    		$("<th>").addClass("numbering").attr("scope","row").text(i+1),
    		      $("<td>").text(review_for_me.reviewer_lol_account),
    		      $("<td>").text(review_for_me.class_name),
    		      $("<td>").addClass("over-cell").text(review_for_me.review_content),
    		      $("<td>").text(review_for_me.review_date),
    		      $("<td>").text(review_for_me.grade+'점'),
    		      $("<td>").addClass("btn-td").append(
    		      $("<button>").attr("type","button")
	          		.addClass("btn btn-outline-danger btn-sm")
	    		      .text("리뷰 삭제").on("click", function() {
	    		    	  event.stopPropagation(); // 이벤트 버블링 제어
	    		          $(this).closest('tr').remove(); // 클릭한 버튼이 속한 행 삭제
	    		          let data ={
	   		        		  review_num: review_for_me.review_num
	    		          }
	    		          $.ajax({//리뷰 삭제
			                    url: "/mentor/delete-review",
			                    type: "DELETE",
			                    data: JSON.stringify(data),
			                    contentType: "application/json; charset=utf-8",
			                    success: function() {
			                        alert("리뷰가 삭제 되었습니다.");
			                    },
			                    error: function() {
			                        alert("삭제 실패.");
			                    }
			                });
	    		      })
    		      )
    		    );
    		 	// <tr> 클릭 이벤트 핸들러 추가
	            row.on('click', function() {
	            $("#rMoLabel").text(review_for_me.reviewer_lol_account+" 님의 리뷰");
	            $("#rDate").text(review_for_me.review_date+" 작성됨");
	            $("#r-grade").text(review_for_me.grade+'점');
	            $("#rContent").prev("strong").text(review_for_me.class_name);
	            $("#rContent").text(review_for_me.review_content);
	            // 나에게 달린 리뷰 모달창 띄우기
	             $("#rMo").modal("show");
	            });
    		    tbody.append(row)
    		    table.append(tbody);
    		  }
    		  reviewForMeList.empty().append(table);
		},
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            console.error(status);
            console.error(error);
        }
    });
	
	$(".btn-close").click(()=>{ //견적서 모달 끄기
		$("#estimateModal").modal("hide");
	});
	  $("#estimateForm").submit(function(event) {
	    event.preventDefault();
	    let form_data = {
	    	estimate_info: $("#estimateContent").val(),
	      	mentor_email: "${member.email}",
	      	menti_email: $(".modal-title").attr("data")
	    };
	    $.ajax({ //견적서 보내기 기능
	      type: "POST",
	      url: "/mentor/save-estimate",
	      data: JSON.stringify(form_data),
	      contentType: "application/json; charset=utf-8",
	      success: function(data) {
	        alert("견적서가 전송되었습니다.");
	        $("#estimateModal").modal("hide");
	        getSentEstimate();
	        getReceivedEstimate();
	      },
	      error: function(xhr, status, error) {
	        console.error(xhr.responseText);
	        console.error(status);
	        console.error(error);
	      }
	    });
	  });
	  
	  
	  function getRequestHistory() {
			$.ajax({ //수업 요청 내역 가져오기
				type: "POST",
			    url: "/mentor/get-request-history",
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    data: JSON.stringify({
					email: "${member.email}"
				}),
		    	success: function(data) {
		    		  let myMtList = $("#request_class_history");
		    		  let table = $("<table>").addClass("table");
		    		  let header = $("<thead>");
		    		  let tr = $("<tr>").append(
		  				$("<th>").attr("scope","col"),
		  				$("<th>").attr("scope","col").text("신청한 멘티"),
		  				$("<th>").attr("scope","col").text("수업 이름"),
		    		    $("<th>").attr("scope","col").text("상태"),
		    		    $("<th>").attr("scope","col").text("신청 날짜"),
		    		    $("<th>").attr("scope","col").text("완료 날짜"),
		    		    $("<th>").attr("scope","col")
		    		  );
		    		  header.append(tr);
		    		  table.append(header);
		    		  for (let i = 0; i < data.length; i++) {
		    			  let myMt = data[i];
		    			  let tbody = $("<tbody>");
		    			  let row = $("<tr>").append(
		    					  $("<th>").addClass("numbering").attr("scope","row").text(i+1),
		    			    $("<td>").text(myMt.menti_lol_account),
		    			    $("<td>").text(myMt.class_name),
		    			    $("<td>").text(myMt.menti_state === 0 ? "대기중" : myMt.menti_state === 1 ? "진행중" : "수업 완료"),
		    			    $("<td>").text(myMt.apply_date),
		    			    $("<td>").text(myMt.done_date),
		    			    $("<td>").addClass("btn-td").append(
		    			    myMt.menti_state === 0 ? 
		    			    		$("<div>").append(
		    			    		    $("<button>").attr("type","button").addClass("btn btn-outline-primary btn-sm")
		    			    		        .attr("id", myMt.mentoring_id)
		    			    		        .attr("data", myMt.class_id)
		    			    		        .text("수락").on('click', function(event) { //수락 버튼 누를떄 멘토링 내역 수정
		    			    		        	event.stopPropagation(); // 이벤트 버블링 제어
		    			    		    		let mentiEmail = $(this).closest('tr').find('td:eq(0)').text(); //소환사명
		    			    		    		let mentoring_id = $(this).attr("id");
		    			    		    		let class_id = $(this).attr("data");
		    			    		    		let mentor_email = "${member.email}"
		    			    		    		$.ajax({
		    			    		    		    type: "PUT",
		    			    		    		    url: "/mentor/update-mentoring-history", 
		    			    		    		    contentType: "application/json; charset=utf-8",
		    			    		    		    data: JSON.stringify({
		    			    		    		    	menti_email: mentiEmail, //소환사명
		    			    		    		    	mentoring_id: mentoring_id,
		    			    		    		        menti_state: 1, // 상태를 업데이트 합니다.
		    			    		    		    }),
		    			    		    		    success: function() {
		    			    		    		      // 성공적으로 업데이트 되었을 경우 처리할 내용을 작성합니다.
		    			    		    		      	console.log("클래스 아이디: "+class_id)
		    			    		    		      	$.ajax({// 클래스 아이디로 클래스 정보 가져오기
		    			    		    				    url: "/mentor/select-by-id-mentor-class?class_id=" + class_id,
		    			    		    				    type: "GET",
		    			    		    				    contentType: "application/json;charset=UTF-8",
		    			    		    				    success: function (mentor_class) {
		    			    		    				    	let mentor_class_info = JSON.parse(mentor_class)
		    			    		    				    	class_price = mentor_class_info.price
		    			    		    						let chargedPoint = parseInt(class_price - (class_price / 10));
		    			    		    				 		$.ajax({
		    			    		    							method : 'post',
		    			    		    							url : '/mentor/myMentoring/tx.json',
		    			    		    							contentType : "application/json; charset=utf-8",
		    			    		    							data : JSON.stringify({
		    			    		    								sender_id : mentiEmail,
		    			    		    								receiver_id : mentor_email,
		    			    		    								points_sent : class_price,
		    			    		    								points_received : chargedPoint
		    			    		    							})
		    			    		    						}).done(res=>{
		    			    		    							console.log(res);
		    			    		    							alert("승인 되었습니다!");
		    			    		    						}).fail(err=>{
		    			    		    						})
		    			    		    				    },
		    			    		    				    error: function (xhr, status, error) {
		    			    		    				      console.error(error);
		    			    		    				    },
		    			    		    				  });
		    			    		    		      	getRequestHistory();
		    			    		    		    },
		    			    		    		    error: function(xhr, status, error) {
		    			    		    		      console.error(xhr.responseText);
		    			    		    		      console.error(status);
		    			    		    		      console.error(error);
		    			    		    		    }
		    			    		    		  });
		    			    		    	}),
		    			    		    $("<button>").attr("type","button").addClass("btn btn-outline-danger btn-sm")
		    			    		        .attr("id", myMt.mentoring_id)
		    			    		        .text("거절").on('click', function(event) { //거절 버튼 누를떄 멘토링 내역 수정
		    			    		        	event.stopPropagation(); // 이벤트 버블링 제어
		    			    		    		let mentoringId = $(this).attr("id");
		    			    		    		let mentiEmail = $(this).closest('tr').find('td:eq(0)').text(); //멘티 소환사명
		    			    		    	    let data ={
		    			    		    	    	menti_email: mentiEmail,
		    			    		    	    	mentoring_id: mentoringId
		    			    		    	    }
		    			    		    		$(this).closest('tr').remove();
		    			    		    		$.ajax({
		    			    		                url: "/mentor/reject-mentoring-history",
		    			    		                type: "DELETE",
		    			    		                data: JSON.stringify(data),
		    			    		                contentType: "application/json; charset=utf-8",
		    			    		                success: function() {
		    			    		                    alert("수업이 거절되었습니다");
		    			    		                },
		    			    		                error: function() {
		    			    		                    alert("거절 실패");
		    			    		                }
		    			    		            });
		    			    		    	})
		    			    		) : null,
		    			    myMt.menti_state === 1 ? $("<button>")
		    			    		.attr("type","button").addClass("btn btn-outline-success btn-sm")
		    			    		.attr("id", myMt.mentoring_id)
		    			    		.text("수업 완료").on('click', function(event) { //수업완료 버튼 누를떄 멘토링 내역 수정
		    			    			event.stopPropagation(); // 이벤트 버블링 제어
		    			    			let mentiEmail = ""+$(this).closest('tr').find('td:eq(0)').text();
		    			    			const date = new Date();
		    			    			const kstDate = new Date(date.getTime() + (9 * 60 * 60 * 1000)); //로컬 시간으로 변경
		    			    			const localeTime = kstDate.toISOString();
		    			    			$.ajax({
		    			    			    type: "PUT",
		    			    			    url: "/mentor/update-mentoring-history", 
		    			    			    contentType: "application/json; charset=utf-8",
		    			    			    data: JSON.stringify({
		    			    			    	menti_email: mentiEmail, //소환사명
		    			    			    	mentoring_id: $(this).attr("id"),
		    			    			        mentor_email: "${member.email}",
		    			    			        menti_state: 2, // 상태를 업데이트 합니다.
		    			    					done_date: localeTime
		    			    			    }),
		    			    			    success: function() {
		    			    			      // 성공적으로 업데이트 되었을 경우 처리할 내용
		    			    			    	getRequestHistory();
		    			    			    },
		    			    			    error: function(xhr, status, error) {
		    			    			      console.error(xhr.responseText);
		    			    			      console.error(status);
		    			    			      console.error(error);
		    			    			    }
		    			    			  });
		    			    		}) : null
		    			    	)
		    			  );
		    			// <tr> 클릭 이벤트 핸들러 추가
		  	            row.on('click', function() {
		  	            // 수강 신청한 멘티의 요청서 모달 띄우기
		  	             window.location.href = '/summoner/info?summoner_name=' + myMt.menti_lol_account;
		  	            });
		    			  tbody.append(row);
		    		    table.append(tbody);
		    		  }
		    		  myMtList.empty().append(table);
				},
		        error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		            console.error(status);
		            console.error(error);
		        }
		    });
			}
	  
	  function getReceivedEstimate() {
	  $.ajax({ //받은 견적서 목록 가져오기
	        type: "GET",
	        url: "/mentor/get-received-estimate",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	    	success: function(data) {
	    		  let rEstList = $("#received_estimate");
	    		  let table = $("<table>").addClass("table");
	    		  let header = $("<thead>");
	    		  let tr = $("<tr>").append(
	    		    $("<th>").attr("scope","col"),
	    		    $("<th>").attr("scope","col").text("견적서를 보낸 멘토"),
	    		    $("<th>").attr("scope","col").text("견적 내용"),
	    		    $("<th>").attr("scope","col").text("보낸 날짜"),
	    		    $("<th>").attr("scope","col")
	    		  );
	    		  header.append(tr);
	    		  table.append(header);
	    		  for (let i = 0; i < data.length; i++) {
	    		    let est = data[i];
	    		    let tbody = $("<tbody>");
	    		    let row = $("<tr>").append(
	    		    		$("<th>").addClass("numbering").attr("scope","row").text(i+1),
	    		      $("<td>").text(est.mentor_lol_account),
	    		      $("<td>").addClass("over-cell").text(est.estimate_info),
	    		      $("<td>").text(est.estimate_date),
	    		      $("<td>").addClass("btn-td").append(
	    		       $("<button>").attr("type","button").addClass("btn btn-outline-danger btn-sm")
		    		       .attr("id",est.estimate_id).text("견적서 삭제").on("click", function() {
		    		    	   event.stopPropagation(); // 이벤트 버블링 제어
		    		          $(this).closest('tr').remove(); // 클릭한 버튼이 속한 행 삭제
		    		          let estid = this.id;
		    		          let data ={
		    		        	estimate_id: estid
		    		          }
		    		          $.ajax({
				                    url: "/mentor/delete-estimate",
				                    type: "DELETE",
				                    data: JSON.stringify(data),
				                    contentType: "application/json; charset=utf-8",
				                    success: function() {
				                        alert("견적서가 삭제 되었습니다.");
				                    },
				                    error: function() {
				                        alert("삭제 실패.");
				                    }
				                });
		    		      })
	    		      )
	    		    );
	    		 // <tr> 클릭 이벤트 핸들러 추가
	  	            row.on('click', function() {
	  	            $("#estMoLabel").text(est.mentor_lol_account);
	  	          $("#estContent").prev("label").text(" 멘토님께서 보내신 견적입니다.");
	  	            $("#estContent").text(est.estimate_info);
	  	            $("#estDate").text(est.estimate_date+" 작성됨");
	  	            $("#estMo").modal("show");
	  	            });
	    		    tbody.append(row)
	    		    table.append(tbody);
	    		  }
	    		  rEstList.empty().append(table);
			},
	        error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	            console.error(status);
	            console.error(error);
	        }
	    });
	  }
	  
	  function getSentEstimate() {
	  $.ajax({ //보낸 견적서 목록 가져오기
	        type: "GET",
	        url: "/mentor/get-sent-estimate",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	    	success: function(data) {
	    		  let sEstList = $("#sent_estimate");
	    		  let table = $("<table>").addClass("table");
	    		  let header = $("<thead>");
	    		  let tr = $("<tr>").append(
   				    $("<th>").attr("scope","col"),
	    		    $("<th>").attr("scope","col").text("내 견적서를 받은 멘티"),
	    		    $("<th>").attr("scope","col").text("견적 내용"),
	    		    $("<th>").attr("scope","col").text("보낸 날짜"),
	    		    $("<th>").attr("scope","col")
	    		  );
	    		  header.append(tr);
	    		  table.append(header);
	    		  for (let i = 0; i < data.length; i++) {
	    		    let est = data[i];
	    		    let tbody = $("<tbody>");
	    		    let row = $("<tr>").append(
	    		    		$("<th>").addClass("numbering").text(i+1),
	    		      $("<td>").text(est.menti_lol_account),
	    		      $("<td>").addClass("over-cell").text(est.estimate_info),
	    		      $("<td>").text(est.estimate_date),
	    		      $("<td>").addClass("btn-td").append( $("<button>").attr("type","button").addClass("btn btn-outline-danger btn-sm")
			    		      .attr("id",est.estimate_id).text("견적서 삭제").on("click", function() {
			    		    	  event.stopPropagation(); // 이벤트 버블링 제어
			    		          $(this).closest('tr').remove(); // 클릭한 버튼이 속한 행 삭제
			    		          let estid = this.id;
			    		          let data ={
			    		        	estimate_id: estid
			    		          }
			    		          $.ajax({
					                    url: "/mentor/delete-estimate",
					                    type: "DELETE",
					                    data: JSON.stringify(data),
					                    contentType: "application/json; charset=utf-8",
					                    success: function() {
					                        alert("견적서가 삭제 되었습니다.");
					                    },
					                    error: function() {
					                        alert("삭제 실패.");
					                    }
					                });
			    		      })
	    		      ),
	    		    );
	    		 // <tr> 클릭 이벤트 핸들러 추가
	  	            row.on('click', function() {
	  	            // 보낸 견적서 모달 띄우기
  	            	$("#estMoLabel").text(est.menti_lol_account);
  	            	$("#estContent").prev("label").text(" 멘티님께 작성해드린 견적입니다.");
	  	            $("#estContent").text(est.estimate_info);
	  	            $("#estDate").text(est.estimate_date+" 작성됨");
	  	            $("#estMo").modal("show");
	  	            });
	    		    tbody.append(row)
	    		    table.append(tbody);
	    		  } 
	    		  sEstList.empty().append(table);
			},
	        error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	            console.error(status);
	            console.error(error);
	        }
	    });
	  }
	});
</script>


	
</body>
</html>