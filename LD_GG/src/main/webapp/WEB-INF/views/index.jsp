<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LD.GG</title>
</head>
<body>
<h1>index.jsp</h1>

<form action="/champion/champ-recom.json">
	<input type="text" name="lane">
	<input type="text" name="tag">
	<input type="text" name="right_champion">
	<button>추천 챔피언</button>
</form>

<form action="/champion/build-recom.json">
	<input type="text" name="left_champion">
	<input type="text" name="right_champion">
	<button>빌드</button>
</form>
</body>
</html>