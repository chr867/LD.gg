<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<h1>notice_detail.jsp</h1>
${notice.t_b_num}
${notice.t_b_content}
${notice.t_b_views}
${notice.t_b_recom}
${notice.t_b_date}

<button onclick="modify(${notice.t_b_num})">수정</button>
<button onclick="go_list()">목록</button>

<script type="text/javascript">

	function modify(t_b_num) {
		location.href = `/userinterface/notice/modify?t_b_num=\${t_b_num}`
	}

	function go_list(){
		location.href = '/userinterface/notice'
	}

</script>
</body>
</html>