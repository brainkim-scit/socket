<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="checkedId" value="-1"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table{
width: 100%;
border-collapse: collapse;
}
 th{
 	border: solid 2px pink;
 	text-align: center;
 	padding: 10px;
 	width: 35%;;
 }
 td{
 	border: solid 2px pink;
 	text-align:left;
 	padding-left:15%;
 	
 	width: 65%;
 }
 fieldset {
 	margin-top: 10%;
	margin-left: 30%;
	margin-right: 30%;
	border-color: red;
}
 input[type="text"],input[type="password"] { 
 	width: 68%; 
 } 
 #a{
 	text-align: center;
 	padding-left: 0em;
 }
</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		$("#id").on("keyup",function(){
			var id = $("#id").val();
			if(id.trim().length < 3 || id.trim().length > 8){
				$("#idcheck").css("color","red");
				$("#idcheck").text("아이디를 3~8자로 입력하세요");
			}else{
				console.log("중복확인");
				$.ajax({
					type : "Post",
					url : "check",
					data : {"id":id},
					success : function(result){
								console.log(result);
								if(result == 0){
									$("#idcheck").css("color","blue");
									$("#idcheck").text("가입 가능한 아이디 입니다.");
								}else{
									$("#idcheck").css("color","red");
									$("#idcheck").text("중복된 아이디 입니다.");
								};
							},
					error : function(){alert("잘못됨");}
				});
			}
		});
	});


	function home(){
		location.href = "./";
	}
</script>
</head>
<body style="background-color: pink;">
	<form action="signup" method="post" id="form">
		<fieldset style="background-color: white;">
			<legend style="background-color:white; text-align: center; font-size: x-large; color: red; border: solid 2px red; border-radius: 15px; padding: 5px;">회원가입</legend>
			<table>
				<tr>
					<th>이름</th>
					<td><input type="text" id="name" name="username"></td>
				</tr>
				
				<tr>
					<th>아이디</th>
					<td>
					<input type="text" id="id" name="id">
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="pw" name="pw"></td>
				</tr>
				
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="checkPw"></td>
				</tr>
				
				<tr>
					<th>Email</th>
					<td><input type="text" id="email" name="email"></td>
				</tr>
				
				<tr>
					<th>회원 구분</th>
					<td id="a">
						<input type="radio" name="division" value="개인" checked="checked" style="width: 5%"> 개인&nbsp;
						<input type="radio" name="division" value="법인" style="width: 5%"> 법인&nbsp;
					</td>
				</tr>
				
				<tr>
					<th>식별번호</th>
					<td><input type="text" id="idNo" name="idNo" placeholder="개인 : 주민번호 / 법인 : 사업자등록번호"></td>
				</tr>
				
				<tr>
					<th>주소</th>
					<td><input type="text" id="address" name="address" placeholder="주소를 입력해주세요"></td>
				</tr>
				
				<tr>
					<th colspan="2" style="border-left: none;border-right: none;border-bottom: none;">
						<input type="hidden" id="onoff">
						<input type="button" id="signup" value="회원가입" style="width: 15%" onclick="notice()">
						<input type="reset" value="다시입력" style="width: 15%">
						<input type="button" value="돌아가기" style="width: 15%" onclick="home()">
					</th>
				</tr>
			</table>
			<div id="idcheck" style="height: 30px; width: 100%;">
					
			</div>
		</fieldset>
	</form>
</body>
</html>