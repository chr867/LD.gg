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
<!--DROP MEMBER CSS-->
<link rel="stylesheet" type="text/css"
	href="/resources/css/member/dropMember.css">
<!--DROP MEMBER JS-->
<script src="/resources/js/member/dropMember.js" defer></script>
<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
	<!----------------------------------------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------------------------------------------->
	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<div class="drop-member-container">
			<h3>회원탈퇴</h3>
			<input class="input" type="password" id="password" name="password"
				placeholder="비밀번호를 입력해주세요">
			<input type="button" id="dropMember" value="탈퇴하기">
		</div>
	</div>
</body>
</html>