<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챔피언 상세</title>
</head>
<body>
<h1>championInfo.jsp</h1>
<div>
	<form action="/champion/search.json" accept-charset="utf-8" method="post">
		<input type="text" name="champion_kr_name">
	</form>
</div>



</body>
<script type="text/javascript">
const cm_list = ${cm_list}
console.log(cm_list)
</script>

</html>