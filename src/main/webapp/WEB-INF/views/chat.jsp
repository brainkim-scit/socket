<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		connect();

		$("#exit").on("click",function(){
			disconnect();
		});

		$("#message").on("keyup",function(key){
			if(key.keyCode == 13){
				send();
			};
		});
	});

	var websocket;
	function connect(){
		websocket = new WebSocket("ws://203.233.199.155:8089/board/chat-ws");

		websocket.onopen = onOpen;
		websocket.onmessage = onMessage;
		websocket.onclose = onClose;
		websocket.onerror = onError;
	}

	function disconnect(){
		var msg = "${sessionScope.member.username}";
		websocket.send(msg+"님이 퇴장하셨습니다.");
		websocket.close();
	}

	function send(){
		var nickname = "${sessionScope.member.username}";
		var message = $("#message").val();

		var input = '';
		input += '<div class="a" style="width: 350px; line-height:50px; margin-top: 15px; display:inline-block;">';
		input += '<div style="float: right; background-color:yellow; padding-left: 15px; padding-right: 15px;">';
		input += message;
		input += '</div></div>';

		$("#chatarea").append(input);
		$("#chatarea").scrollTop($("#chatarea")[0].scrollHeight);

		websocket.send(nickname+":"+message);

		$("#message").val("");
	}

	function onOpen(){
		var nickname = "${sessionScope.member.username}";
		websocket.send(nickname+"님이 입장하셨습니다.");
	}

	function onMessage(event){
		var input = '';
		if(event.data.split(":").length == 1){
			input += '<div class="a" style="width: 350px; text-align:center; line-height:50px; margin-top: 15px; display:inline-block;">';
			input += event.data;
			input += '</div>';
		}else{
			input += '<div class="a" style="width: 350px; line-height:50px; margin-top: 15px; display:inline-block;">';
			input += '<div style="float: left; background-color:skyblue; padding-left: 15px; padding-right: 15px;">';
			input += event.data;
			input += '</div></div>';
		}
		$("#chatarea").append(input);
		$("#chatarea").scrollTop($("#chatarea")[0].scrollHeight);
	}

	function onError(event){
		console.log(event);
	}

	function onClose(event){
		console.log(event);
		var nickname = "${sessionScope.member.username}";
		websocket.send(nickname+"님이 퇴장하셨습니다.");
	}
</script>
</head>
<body>
	<div id="chatarea" style="width: 400px; height: 500px; border: 1px solid; text-align: center; overflow: auto;">
	
	</div>
	<div id="input" style="width: 370px; height: 100px; border: 1px solid; margin-top: 20px; padding: 15px;">
		<textarea id="message" rows="4" cols="30" draggable="false" style="resize: none; height: 95px; width: 363px;"></textarea>
	</div>
	<div style="margin-top: 10px; text-align: center; width: 400px;">
		<input type="button" id="exit" value="나가기">
	</div>
</body>
</html>
