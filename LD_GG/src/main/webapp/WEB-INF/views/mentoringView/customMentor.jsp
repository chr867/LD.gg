<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>맞춤 멘토</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<style>
.container {
}
		.tag-button.selected {
			background-color: #2196F3;
			color: white;
		}

		.tag-button.mouse-over {
			background-color: #ddd;
		}

		.champ-list {
			height: 336px;
			border-radius: 12px;
			overflow-y: scroll;
			box-sizing: border-box;
			border: 1px solid #d5d5de;
		}

		#position-buttons {
			display: flex;
		}

		#position-buttons button {
			background-color: #f2f2f2;
			border: none;
			color: black;
			padding: 10px;
			margin: 5px;
			cursor: pointer;
		}

		#position-buttons button:hover {
			background-color: #ddd;
		}
	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>

<body>
<div class="container">
	<h2>맞춤 멘토 페이지 입니다~</h2>
	<form id="customMentorForm" onsubmit="return submitForm()">

		<h4>나에게 딱 맞는 멘토님을 찾기위해</h4>
		<h4><img src=""><em>목표를 설정해 볼까요?</em></h4>
		
		<div class="progress">
		<progress value="20" max="100"></progress>
		<em>1</em>/6
		</div>

		<div class="summoner-wrap">
			<!---->
			<h4 class="profile-text1">${member.lol_account} 회원님의 현재 티어는</h4>
			<div class="lol-tier-info" summonername="${member.lol_account}">
				<div class="left-side"><img src="https://online.gamecoach.pro/img/lol/emblem-UNRANKED.svg">
					<!-- 여기에 티어 이미지 -->
				</div>
				<div class="right-side">
					<div class="top">
						<h4 class="tier-text">UNRANKED</h4><span>0LP</span>
					</div>
					<div class="bottom"><span>승률 0%&nbsp;</span><span>(0승 0패)</span></div>
				</div>
			</div>
			<h4 class="profile-text2">입니다.</h4>
		</div>

		<label for="position_to_learn">배우고 싶은 포지션:</label>
		<input type="text" id="position_to_learn" name="position_to_learn"
			value="${mentor_profile.about_mentor}"><br><br>

		<div id="position-buttons" class="btn-group" role="group" aria-label="Basic example">
			<button type="button" id="top-button" class="btn"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_top_grey.svg" 
					class="position-img">탑</button>
			<button type="button" id="jungle-button" class="btn"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_jg_grey.svg" 
					class="position-img">정글</button>
			<button type="button" id="mid-button" class="btn"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_mid_grey.svg"
					class="position-img">미드</button>
			<button type="button" id="bot-button" class="btn"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_ad_grey.svg" 
					class="position-img">바텀</button>
			<button type="button" id="support-button" class="btn"><img
					src="https://online.gamecoach.pro/img/icon/lol/ico_lol_sup_grey.svg"
					class="position-img">서포터</button>
		</div><br><br>

		<label for="champion_to_learn">배우고 싶은 챔피언:</label>
		<input type="text" id="champion_to_learn" name="champion_to_learn"
			value="${mentor_profile.specialized_position}">

		<div class="champ-selector-inner">
			<div class="champ-info"><span><img retry-img="" src="" cdn-img="" class="champ-img">
					<p class="champ-name">배우고 싶은 챔피언을 선택 해주세요</p>
				</span></div><img src="https://online.gamecoach.pro/img/icon/icon-arrow-down-grey.svg"
				class="arrow-icon">
		</div>
		<div class="filter-champ-wrap" style="display: none">
			<div class="filter-title-wrap">
				<div>
					<h4 class="filter-text">챔피언</h4>
				</div>
			</div>
			<div win-rate-filter-champ="">
				<span text-input="" class="input-champ-keyword white">
					<input placeholder="챔피언을 검색하세요" tabindex="0" type="text" class="champ-search">
				</span>
				<div class="champ-list">
				</div>
			</div>
		</div><br><br>

		<label for="target_tier">목표 티어:</label>
		<input type="text" id="target_tier" name="target_tier" value="${mentor_profile.specialized_champion}"><br><br>

		<div class="goal-tier">
			<p>목표 티어는</p>
			<div class="tier-holder"><img src="https://online.gamecoach.pro/img/lol/emblem-UNRANKED.svg">
				<p>UNRANKED</p>
			</div>
			<p>이상입니다.</p>
		</div>
		<div goal-tier-selector="" style="display: none">
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-BRONZE.svg"
						style="bottom: -0.5px;">
				</div>
				<div class="tier-label">
					<p id="BRONZE">브론즈</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-SILVER.svg"
						style="bottom: 4.5px;">
				</div>
				<div class="tier-label">
					<p id="SILVER">실버</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-GOLD.svg"
						style="bottom: 9.5px;">
				</div>
				<div class="tier-label">
					<p id="GOLD">골드</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-PLATINUM.svg"
						style="bottom: 14.5px;">
				</div>
				<div class="tier-label">
					<p id="PLATINUM">플래티넘</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-DIAMOND.svg"
						style="bottom: 19.5px;">
				</div>
				<div class="tier-label">
					<p id="DIAMOND">다이아몬드</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-MASTER.svg"
						style="bottom: 24.5px;">
				</div>
				<div class="tier-label">
					<p id="MASTER">마스터</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-GRANDMASTER.svg"
						style="bottom: 29.5px;">
				</div>
				<div class="tier-label">
					<p id="GRANDMASTER">그랜드 마스터</p>
				</div>
			</div>
			<div class="tier">
				<div class="tier-box">
					<div class="gradient"></div><img src="https://online.gamecoach.pro/img/lol/emblem-CHALLENGER.svg"
						style="bottom: 34.5px;">
				</div>
				<div class="tier-label">
					<p id="CHALLENGER">챌린저</p>
				</div>
			</div>
		</div><br><br>
		<button type="submit">작성</button>
	</form>

	<div class="tag-table">
	
	</div>
	<button class="save_tag" onclick="saveMentiTag()">태그 저장</button><br><br>

	<button id="recom-mentor-btn">추천 멘토 찾기</button>
	<div id="recom_mentor_list">
	</div>
	
</div><!-- container -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function () {

			$("form").on("keydown", function (event) {
				if (event.keyCode === 13) {
					event.preventDefault();
					// 엔터 이벤트 처리 로직
				}
			});

			$(".champ-search").on("keydown", function (event) {
				if (event.keyCode === 13) {
					event.preventDefault(); // 엔터 키 이벤트 전파 막기
					let champions = $(".champ-search").val();
					$("#champion_to_learn").val(champions);
				}
			});

			$(".champ-selector-inner").click(function () {
				if ($(".filter-champ-wrap").css('display') === 'none') {
					$(".filter-champ-wrap").css('display', 'block');
				} else {
					$(".filter-champ-wrap").css('display', 'none');
				}
			});

			$(".goal-tier").click(function () {
				if ($('div[goal-tier-selector]').css('display') === 'none') {
					$('div[goal-tier-selector]').css('display', 'block');
				}
			});

			$(".tier").click(function () {
				let tier = $(this).find("p").attr("id");
				let imgURL = $(this).find("img").attr("src");
				$(".tier-holder p").text(tier);
				$(".tier-holder img").attr("src", imgURL);
				$("#target_tier").val(tier);
				$('div[goal-tier-selector]').css('display', 'none');
			});

			// 선택한 포지션 값을 저장할 배열
			let positions = [];

			$("#position-buttons button").click(function () {
				$(this).toggleClass("selected");
			});
			$("#position-buttons button").hover(function () {
				$(this).addClass("mouse-over");
			}, function () {
				$(this).removeClass("mouse-over");
			});


			// 버튼 클릭 이벤트 추가
			$("#top-button").on("click", function () {
				if (positions.includes("top")) {
					// 선택한 포지션 배열에서 삭제
					positions.splice(positions.indexOf("top"), 1);
				} else {
					// 선택한 포지션 배열에 추가
					positions.push("top");
				}
				$("#position_to_learn").val("탑");
			});

			// 나머지 버튼들도 동일하게 추가
			$("#jungle-button").on("click", function () {
				if (positions.includes("jungle")) {
					positions.splice(positions.indexOf("jungle"), 1);
				} else {
					positions.push("jungle");
				}
				$("#position_to_learn").val("정글");
			});

			$("#mid-button").on("click", function () {
				if (positions.includes("mid")) {
					positions.splice(positions.indexOf("mid"), 1);
				} else {
					positions.push("mid");
				}
				$("#position_to_learn").val("미드");
			});

			$("#bot-button").on("click", function () {
				if (positions.includes("bot")) {
					positions.splice(positions.indexOf("bot"), 1);
				} else {
					positions.push("bot");
				}
				$("#position_to_learn").val("바텀");
			});

			$("#support-button").on("click", function () {
				if (positions.includes("support")) {
					positions.splice(positions.indexOf("support"), 1);
				} else {
					positions.push("support");
				}
				$("#position_to_learn").val("서포터");
			});

			$.ajax({ //챔피언 목록 가져오기
				url: "/mentor/get-all-champ",
				type: "GET",
				success: function (data) {
					let championList = JSON.parse(data);
					championList.forEach(function (champion) {
						let imageUrl =
							"https://d3hqehqh94ickx.cloudfront.net/prod/images/thirdparty/riot/lol/13.9.1/champion/" +
							champion.champion_en_name + ".png?&amp;retry=0";
						let champItem = $("<div>").addClass("champ-item").click(function () {
							$(".champ-name").text(champion.champion_kr_name);
							$(".champ-img").attr("src", imageUrl);
							$(".filter-champ-wrap").css('display', 'none');
							$("#champion_to_learn").val(champion.champion_id);
						});
						let championDiv = $("<div>").attr("id", "champion");
						let champImg = $("<img>").addClass("champ-icon").attr("src", imageUrl);
						let champName = $("<span>").text(champion.champion_kr_name);
						championDiv.append(champImg);
						championDiv.append(champName);
						champItem.append(championDiv);
						let rateWrap = $("<div>").addClass("rate-wrap");
						let rateBarWrap = $("<div>").addClass("rate-bar-wrap");
						let rateBarBg = $("<div>").addClass("rate-bar-bg");
						rateBarWrap.append(rateBarBg);
						rateWrap.append(rateBarWrap);
						let pickRate = $("<p>").addClass("pick-rate").text("픽률 " + 0 + "%");
						rateWrap.append(pickRate);
						champItem.append(rateWrap);
						$(".champ-list").append(champItem);
					});
				},
				error: function () {
					console.error("챔피언 정보를 불러오는데 실패했습니다.");
				}
			});
			
			$.ajax({ //목표 태그 가져오기
				  url: "/mentor/get-target-tag/",
				  type: "GET",
				  success: function (result) {
				    let tagList = JSON.parse(result);
				    let tagDiv = $("<div>").addClass("target");
				    let tagTable = $("<table>").append(
				      $("<thead>").append(
				        $("<tr>").append(
				          $("<th>").text("그리고 (중복선택 가능)")
				        )
				      )
				    );
				    let tagBody = $("<tbody>");
				    let isFriendsSummonerWrapShown = false;
				    let isOwnGoalShown = false;
				    tagList.forEach(function (tag) {
				      let tagRow = $("<tr>");
				      let tagCell = $("<td>");
				      let tagButton = $("<button>")
				        .addClass("tag-button")
				        .attr("data-tag-id", tag.tag_id)
				        .text(tag.tag_info);
				      if (tag.tag_id == 5) {
				        tagButton.click(function () {
				          let friendsSummonerWrap = $(".friends-summoner-wrap");
				          if (isFriendsSummonerWrapShown) {
				            friendsSummonerWrap.remove();
				            isFriendsSummonerWrapShown = false;
				          } else {
				            friendsSummonerWrap = $("<div>").addClass("friends-summoner-wrap");
				            let friendsSummoner = $("<div>")
				              .addClass("friends-summoner")
				              .attr("underline-text-input", "");
				            let friendsSummonerInput = $("<input>").attr("placeholder", "친구의 소환사명을 입력해주세요.").attr("id",'friendsSummonerInput');
				            let clearBtn = $("<button>").addClass("clear-btn").css("display", "none");
				            friendsSummoner.append(friendsSummonerInput, clearBtn);
				            let confirmBtn = $("<button>").addClass("basic-button").attr("data-size", "m").attr("to", "").addClass("dark").text("확인");
				            friendsSummonerWrap.append(friendsSummoner, confirmBtn);
				            $(".friends-summoner-wrap").remove();
				            $(this).after(friendsSummonerWrap);
				            isFriendsSummonerWrapShown = true;
				          }
				          tagButton.toggleClass("selected");
				        }).mouseenter(function () {
				          $(this).addClass("mouse-over");
				        }).mouseleave(function () {
				          $(this).removeClass("mouse-over");
				        });
				      } 
				      else if (tag.tag_id == 26) {
				    	  tagButton.click(function () {
				    	    let ownGoalWrap = $(".own-goal-wrap");
				    	    if (isOwnGoalShown) {
				    	      ownGoalWrap.remove();
				    	      isOwnGoalShown = false;
				    	    } else {
				    	      ownGoalWrap = $("<div>").addClass("own-goal-wrap");
				    	      let ownGoal = $("<div>")
				    	        .addClass("own-goal")
				    	        .attr("memo-text-area", "");
				    	      let input_info = $("<p>").addClass("input-info");
				    	      let textArea = $("<textarea>").attr("id", "ownGoalText");
				    	      ownGoal.append(input_info, textArea);
				    	      ownGoalWrap.append(ownGoal);
				    	      $(".own-goal-wrap").remove();
				    	      $(this).after(ownGoalWrap);
				    	      isOwnGoalShown = true;
				    	    }
				    	    tagButton.toggleClass("selected");
				    	  }).mouseenter(function () {
				    	    $(this).addClass("mouse-over");
				    	  }).mouseleave(function () {
				    	    $(this).removeClass("mouse-over");
				    	  });
				    	}
				      else {
				        tagButton.click(function () {
				          $(this).toggleClass("selected");
				        }).mouseenter(function () {
				          $(this).addClass("mouse-over");
				        }).mouseleave(function () {
				          $(this).removeClass("mouse-over");
				        });
				      }
				      tagCell.append(tagButton);
				      tagRow.append(tagCell);
				      tagBody.append(tagRow);
				    });
				    tagTable.append(tagBody);
				    tagDiv.append(tagTable);
				    $(".tag-table").append(tagDiv);
				  },
				  error: function () {
				    console.error("목표 태그 가져오기 실패");
				  }
				});




			$.ajax({ //수업 방식 태그 가져오기
				url: "/mentor/get-class-method-tag/",
				type: "GET",
				success: function (result) {
					let tagList = JSON.parse(result);
					let tagDiv = $("<div>").addClass("class-method")
					let tagTable = $("<table>").append(
						$("<thead>").append(
							$("<tr>").append(
								$("<th>").text("그리고 (중복선택 가능)")
							)
						)
					);
					let tagBody = $("<tbody>");
					tagList.forEach(function (tag) {
						let tagRow = $("<tr>");
						let tagCell = $("<td>");
						let tagButton = $("<button>")
							.addClass("tag-button")
							.attr("data-tag-id", tag.tag_id)
							.text(tag.tag_info)
							.click(function () {
								$(this).toggleClass("selected");
							})
							.mouseenter(function () {
								$(this).addClass("mouse-over");
							})
							.mouseleave(function () {
								$(this).removeClass("mouse-over");
							});
						tagCell.append(tagButton);
						tagRow.append(tagCell);
						tagBody.append(tagRow);
					});
					tagTable.append(tagBody);
					tagDiv.append(tagTable);
					$(".tag-table").append(tagDiv);
				},
				error: function () {
					console.error("수업방식 태그 가져오기 실패");
				}
			});
			$.ajax({ //스타일 태그 가져오기
				url: "/mentor/get-style-tag/",
				type: "GET",
				success: function (result) {
					let tagList = JSON.parse(result);
					let tagDiv = $("<div>").addClass("style")
					let tagTable = $("<table>").append(
						$("<thead>").append(
							$("<tr>").append(
								$("<th>").text("(중복선택 가능)")
							)
						)
					);
					let tagBody = $("<tbody>");
					tagList.forEach(function (tag) {
						let tagRow = $("<tr>");
						let tagCell = $("<td>");
						let tagButton = $("<button>")
							.addClass("tag-button")
							.attr("data-tag-id", tag.tag_id)
							.text(tag.tag_info)
							.click(function () {
								$(this).toggleClass("selected");
							})
							.mouseenter(function () {
								$(this).addClass("mouse-over");
							})
							.mouseleave(function () {
								$(this).removeClass("mouse-over");
							});
						tagCell.append(tagButton);
						tagRow.append(tagCell);
						tagBody.append(tagRow);
					});
					tagTable.append(tagBody);
					tagDiv.append(tagTable);
					$(".tag-table").append(tagDiv);
				},
				error: function () {
					console.error("스타일 태그 가져오기 실패");
				}
			});
			$.ajax({ //스타일2 태그 가져오기
				url: "/mentor/get-style2-tag/",
				type: "GET",
				success: function (result) {
					let tagList = JSON.parse(result);
					let tagDiv = $("<div>").addClass("style2")
					let tagTable = $("<table>").append(
						$("<thead>").append(
							$("<tr>").append(
								$("<th>").text("어떤 스타일의 멘토를 선호하세요")
							)
						)
					);
					let tagBody = $("<tbody>");
					tagList.forEach(function (tag) {
						let tagRow = $("<tr>");
						let tagCell = $("<td>");
						let tagButton = $("<button>")
							.addClass("tag-button")
							.attr("data-tag-id", tag.tag_id)
							.text(tag.tag_info)
							.click(function () {
								$(this).toggleClass("selected");
							})
							.mouseenter(function () {
								$(this).addClass("mouse-over");
							})
							.mouseleave(function () {
								$(this).removeClass("mouse-over");
							});
						tagCell.append(tagButton);
						tagRow.append(tagCell);
						tagBody.append(tagRow);
					});
					tagTable.append(tagBody);
					tagDiv.append(tagTable);
					$(".tag-table").append(tagDiv);
				},
				error: function () {
					console.error("스타일2 태그 가져오기 실패");
				}
			});
			$.ajax({ //경력 태그 가져오기
				url: "/mentor/get-careers-tag/",
				type: "GET",
				success: function (result) {
					let tagList = JSON.parse(result);
					let tagDiv = $("<div>").addClass("careers")
					let tagTable = $("<table>").append(
						$("<thead>").append(
							$("<tr>").append(
								$("<th>").text("(중복선택 가능)")
							)
						)
					);
					let tagBody = $("<tbody>");
					tagList.forEach(function (tag) {
						let tagRow = $("<tr>");
						let tagCell = $("<td>");
						let tagButton = $("<button>")
							.addClass("tag-button")
							.attr("data-tag-id", tag.tag_id)
							.text(tag.tag_info)
							.click(function () {
								$(this).toggleClass("selected");
							})
							.mouseenter(function () {
								$(this).addClass("mouse-over");
							})
							.mouseleave(function () {
								$(this).removeClass("mouse-over");
							});
						tagCell.append(tagButton);
						tagRow.append(tagCell);
						tagBody.append(tagRow);
					});
					tagTable.append(tagBody);
					tagDiv.append(tagTable);
					$(".tag-table").append(tagDiv);
				},
				error: function () {
					console.error("경력 태그 가져오기 실패");
				}
			});

			$("#recom-mentor-btn").click(function () { //추천 멘토 가져오기
				$.ajax({
					type: "GET",
					url: "/mentor/recom-mentor",
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						let mentorList = $("#recom_mentor_list");
						let table = $("<table>").addClass("mentor-table");
						let header = $("<tr>").append(
							$("<th>").text("멘토명"),
							$("<th>").text("멘토 소개")
						);
						table.append(header);
						for (let i = 0; i < data.length; i++) {
							let mentor = data[i];
							let row = $("<tr>").append(
								$("<td>").text(mentor.mentor_email),
								$("<td>").text(mentor.about_mentor)
							);
							table.append(row);
						}
						mentorList.empty().append(table);
					},
					error: function (xhr, status, error) {
						console.error(xhr.responseText);
						console.error(status);
						console.error(error);
					}
				});
			});
		});


		function submitForm() {
			let formData = new FormData($("#customMentorForm")[0]);
			let customMentorDTO = {
				menti_email: "${member.email}",
				position_to_learn: formData.get("position_to_learn"),
				champion_to_learn: formData.get("champion_to_learn"),
				target_tier: formData.get("target_tier")
			};
			$.ajax({
				url: "/mentor/save-custom-mentor/",
				type: "POST",
				contentType: "application/json;charset=UTF-8",
				data: JSON.stringify(customMentorDTO),
				success: function (data) {
					alert("성공");
				},
				error: function (error) {
					alert("실패");
				}
			});
			return false;
		}


		function saveMentiTag() {
			let tagButtons = $(".tag-button");
			let tagList = [];
			tagButtons.each(function () {
				if ($(this).hasClass("selected")) {
					let tag = $(this).data("tag-id");
					let tag_note5 = $("#friendsSummonerInput").val();
					let tag_note26 = $("#ownGoalText").val();
					if (tag == 5){
						let data = {
								menti_email: "${member.email}",
								tag_id: tag,
								tag_note: tag_note5
							};
						tagList.push(data);
					}else if(tag == 26){
						let data = {
								menti_email: "${member.email}",
								tag_id: tag,
								tag_note: tag_note26
							};
						tagList.push(data);
					}else{
						let data = {
								menti_email: "${member.email}",
								tag_id: tag
							};
						tagList.push(data);
					}
				}
			});
			let jsonData = JSON.stringify(tagList);
			$.ajax({
				url: "/mentor/save-menti-tag/",
				type: "POST",
				contentType: "application/json;charset=UTF-8",
				data: jsonData,
				success: function () {
					alert("멘티 태그가 저장되었습니다.");
				},
				error: function () {
					alert("멘티 태그 저장에 실패했습니다.");
				}
			});
			return false;
		}

		$(".tag-button").click(function () {
			$(this).toggleClass("selected");
		});
		$(".tag-button").hover(function () {
			$(this).addClass("mouse-over");
		}, function () {
			$(this).removeClass("mouse-over");
		});
	</script>
</body>

</html>