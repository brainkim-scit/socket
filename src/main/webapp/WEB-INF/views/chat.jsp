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
<script src="resources/js/sockjs.js"></script>
<script src="resources/js/stomp.js"></script>
<script type="text/javascript">
	$(function(){
// 		SockJSconnect();
		StompConnect();
		$("#exit").on("click",function(){
			disconnect();
		});

		$("#message").on("keyup",function(key){
			if(key.keyCode == 13){
				send();
			};
		});
	});

	var sock;
	var isStomp = false;
	function StompConnect(){
		sock = new SockJS("stomp");
		console.log(sock);
		var client = Stomp.over(sock);
		console.log(client);
		isStomp = true;
		sock = client;

		client.connect({}, function(){
			console.log("Connected Stomp");
			client.send("/board/TTT", {}, "message : haha");
			client.subscribe("/topic/message", function(event){
				onMessage(event);
			});
		});
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

		sock.send("/board/TTT", {}, message);

		$("#message").val("");
	}

	function onMessage(event){
		var input = '';
		if(event.data.split(":").length == 1){
			input += '<div class="a" style="width: 350px; text-align:center; line-height:50px; margin-top: 15px; display:inline-block;">';
			input += event.body;
			input += '</div>';
		}else{
			input += '<div class="a" style="width: 350px; line-height:50px; margin-top: 15px; display:inline-block;">';
			input += '<div style="float: left; background-color:skyblue; padding-left: 15px; padding-right: 15px;">';
			input += event.body;
			input += '</div></div>';
		}
		$("#chatarea").append(input);
		$("#chatarea").scrollTop($("#chatarea")[0].scrollHeight);
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
