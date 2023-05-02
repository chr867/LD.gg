<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미니게임</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous"></script>
</head>
<body>

<button onclick="connect()">접속</button>
<button onclick="disconnect()">접속 종료</button>
<hr>
<input type="text" id="chat-input">
<button onclick="send()">전송</button>
<button onclick="timeline2()">추가정보</button>
<button onclick="answer()">정답 제출</button>

<script>

	let predict = 1
	function answer(){
		$.ajax({
			data : predict,
			method : 'post',
			url : '/minigame/submit.json',
			contentType: "application/json; charset=utf-8",
		}).done(res=>{
			console.log(res)
		}).fail(err=>{
			console.log(err)
		})
	}

	
	let time = 5
	function timeline2(){
		$.ajax({
			data : time,
			method : 'post',
			url : '/minigame/timeline.json',
			dataType : 'json',
		}).done(res=>{
			console.log(res)
		}).fail(err=>{
			console.log(err)
		})
		
		time += 5 
	}


$.ajax({
	method : 'get',
	url : '/minigame/data.json',
	dataType : 'json',
}).done(res=>{
	console.log(res)
}).fail(err=>{
	console.log(err)
})


// 채팅
	let socket;
	function connect() {
		let url = "ws://"
		url += location.host;
		url += "${pageContext.request.contextPath}";
		url += "/minigame";
		
		socket = new WebSocket(url);
		
	 	socket.onopen = function(){
			console.log("서버와 연결 중");
		}

		socket.onclose= function(){
			console.log("서버와 연결 종료");
		}

		socket.onerror = function(){
			console.log("서버와 연결 중 오류 발생");
		}

		socket.onmessage = function(evt){
			onMessage(evt);
		}
	}
	
	function onMessage(evt) {
		console.log(evt.data);
	}
	
	
	function disconnect(){
		socket.close();
	}
	
	function send(){
		let text = document.querySelector("#chat-input").value;
		if(!text){
			return;
		}
		
		socket.send(text);
		document.querySelector("#chat-input").value = ""
	}
// 채팅 끝
</script>
</body>
</html>