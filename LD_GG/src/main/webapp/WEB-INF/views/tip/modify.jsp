<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>LD.GG</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<!--BOOTSTRAP JavaScript-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous">
    </script>
<!--SWEET-ALERT2 CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!--SWEET-ALERT2 JS-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--JQUERY-->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
<!--AJAX-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!--JQUERY VALIDATE-->
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
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

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
	
	
<style type="text/css">
 .main-container{
	display: flex;
	justify-content: center;
} 
.champion-container{
	margin-top: 90px;
	width: 25%;
	height: 80vh;
	background-color: #fff;
	margin-right: 20px;
	margin-left: 60px;
	box-sizing: border-box;
}
.tip-write-container{
	margin-top: 90px;
	width: 68%;
	height: 80vh;
	background-color: #fff;
	box-sizing: border-box;
	padding: 50px 30px 0 30px;
	box-shadow: 0 0 10px rgba(0,0,0,0.1);
	padding-top: 20xp;
}

.title-box{
	text-align: center;
	margin-bottom: 50px;
	background-color: #202B46;
	color: #fff;
	margin: auto;
	width: 300px;
	height: 70px;
	display: flex;
	border-radius: 3rem;
	justify-content: center;
	align-items: center;
}

.search-container{
	text-align: center;
	justify-content: space-between;
}

 .lane-select-box {
    display: flex;
    height: 50px;
    justify-content: space-between;
    width: 90%;
    margin: auto;
    margin-top: 10px;
    background-color: #E4E6EF;
    box-sizing: border-box;
    padding: 0 50px 0 50px;
    margin-bottom: 20px;
    align-items: center;
}

.lane-img img {
    width: 40px;
    height: 40px;
}

.lane-img {
    border-radius: 0.5rem;
    transition: 0.5s;
}

.lane-img:hover,
.lane-img:active {
    background-color: #fff;
}

.champion-img-container {
    width: 90%;
    background-color: #E4E6EF;
    height: 600px;
    margin: auto;
    box-sizing: border-box;
    overflow-y: auto;
    max-height: 600px;
}

.champions {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    text-align: center;
    box-sizing: border-box;
    flex-wrap: wrap;
    padding: 5px;
}

.champions img {
    width: 60px;
    height: 60px;
    border-radius: 1rem;
    border: 5px solid #fff;
    transition : 0.5s;
}
.champions img:hover{
    transform: scale(1.3);
    z-index: 1;
}

.champion {
    display: flex;
    align-items: center;
    flex-direction: column;
    margin: 5px;
    flex-grow: 1;
}
::-webkit-scrollbar {
  width: 5px; /* 스크롤바의 너비 */
}

::-webkit-scrollbar-track {
  background-color: #f1f1f1; /* 스크롤바의 트랙(배경) 색상 */
}

::-webkit-scrollbar-thumb {
  background-color: #888; /* 스크롤바의 썸(막대) 색상 */
}
</style>
<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<div class="champion-container">
			<div class="lane-select-box">
				<div class="lane-img lane-top" onclick="selectLane('TOP')"><img src="/resources/img/ranked-positions/Position_Silver-Top.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-jungle" onclick="selectLane('JUNGLE')"><img src="/resources/img/ranked-positions/Position_Silver-Jungle.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-middle" onclick="selectLane('MIDDLE')"><img src="/resources/img/ranked-positions/Position_Silver-Mid.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-bottom" onclick="selectLane('BOTTOM')"><img src="/resources/img/ranked-positions/Position_Silver-Bot.png" alt="로그인 이미지"></div>
				<div class="lane-img lane-support" onclick="selectLane('UTILITY')"><img src="/resources/img/ranked-positions/Position_Silver-Support.png" alt="로그인 이미지"></div>
			</div>
			<div class="champion-img-container">
				<div class="champions">

				</div>
			</div>
		</div>
		<div class="tip-write-container">
			<div class="title-box">
				<h3 class="text-center">공략 글 수정</h3>
			</div>
		  
		    <form method="post" action="/tip/modify_tip" class="form-group mx-auto w-75">
		        <input type="text" name="t_b_title" class="form-control mb-3" placeholder="제목" value="${title}" style="margin-top: 20px;">
		        <textarea id="summernote" name="t_b_content" class="form-control mb-3">${content}</textarea>
		        <input type="number" name="champion_id" class="form-control mb-3" placeholder="챔피언아이디" value="${champion}">
		        <div class="d-flex justify-content-between">
		            <input id="subBtn" type="button" class="btn btn-primary" value="글 작성" onclick="goWrite(this.form)" />
		            <input id="reset" type="reset" class="btn btn-secondary" value="취소">
		            <input type="hidden" name="t_b_num" value="${num}"/>
		        </div>
		    </form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
    $('#summernote').summernote({
        height : 300, // 에디터 높이
        minHeight : null, // 최소 높이
        maxHeight : null, // 최대 높이
        focus : true, // 에디터 로딩후 포커스를 맞출지 여부
        lang : "ko-KR", // 한글 설정
        placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
        callbacks: {
            onInit: function() {
                var editable = $('.note-editable');
                var toolbar = $('.note-toolbar');

                editable.css({
                    backgroundColor: 'rgba(255, 255, 255, 0.9)' // 에디터 부분 배경색 설정
                });

                toolbar.css({
                    backgroundColor: 'rgba(255, 255, 255, 0.9)' // 툴바 부분 배경색 설정
                });
            }
        }
    });
});




	function goWrite(frm) {
		let title = frm.t_b_title.value;
		let email = '${sessionScope.lol_account}';
		if (email==''){
			alert('로그인을 해주세요')
			return false;
		}
		console.log(title);
		let contents = frm.t_b_content.value; //공백 => &nbsp 
		console.log(contents);
		let champion = frm.champion_id.value;
		console.log(champion);
		if (title.trim() == '') {
			alert('제목을 입력해주세욧!!')
			return false;
		}
		if (contents.trim() == '') {
			alert('내용을 입력해주세욧!!!')
			return false;
		}
		if (champion.trim() == '') {
			alert('챔피언을 입력해주세욧!!!')
			return false;
		}
		frm.submit();
	}
	
	function championList() {
	    $.ajax({
	        method: 'get',
	        url: '/tip/champion/list'
	    }).done(res => {
	        var championHTML = '';
	        res.forEach(function(champion) {
	            championHTML += '<div class="champion">';
	            championHTML += '<img alt="' + champion.champion_en_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/'
	            + champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_id + '\')">'; 
	            championHTML += '</div>';
	        });

	        $('.champions').html(championHTML);
	    }).fail(err => {
	        console.log(err);
	    });
	}

	championList();


	function selectLane(team_position) {
		$('.champions').empty();
		$.ajax({
			method: 'get',
			url: '/tip/champion/lane',
			data: {team_position:team_position},
		}).done(res=>{
	        var championHTML = '';
	        res.forEach(function(champion) {
	            championHTML += '<div class="champion">';
	            championHTML += '<img alt="' + champion.champion_en_name + '" class="bg-image champion-img" src="/resources/img/champion_img/square/'
	            + champion.champion_img + '" onclick="selectChampion(\'' + champion.champion_id + '\')">'; 
	            championHTML += '</div>';
	        });

	        $('.champions').html(championHTML);
		}).fail(err=>{
			console.log(err);
		})
	} 
	
	function selectChampion(champion_id) {
	    var inputField = document.querySelector('input[name="champion_id"]');
	    inputField.value = champion_id;
	    inputField.readOnly = true;  // 변경: disabled -> readOnly
	}
	
	
$(document).ready(function(){
    $(document).on('click', '.champion-img', function(){
        var altText = $(this).attr('alt');
        $('.tip-write-container').css('background-image', 'url(/resources/img/champion_img/splash/'+altText+'_0.jpg)');
    });
});

	

</script>
</html>