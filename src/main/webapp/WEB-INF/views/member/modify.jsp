<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
 	text-align:center;
 	padding: 5px;
 	width: 65%;
 }
 fieldset {
 	margin-top: 10%;
	margin-left: 30%;
	margin-right: 30%;
	border-color: red;
}
input {
	width: 80%;
}

</style>
<script type="text/javascript">
	function send(){
		var form = document.getElementById("form");
		var name = document.getElementById("name");
		var id = document.getElementById("id");
		var pw = document.getElementById("pw").value;
		var checkPw = document.getElementById("checkPw").value;
		var email = document.getElementById("email").value;
		var idNo = document.getElementById("idNo");
		var address = document.getElementById("address").value;

		if(name.value.trim().length==0||
				id.value.trim().length==0||
				pw.trim().length==0||
				email.trim().length==0||
				idNo.value.trim().length==0||
				address.trim().length==0){
			alert("정보를 입력해주세요");
		}else if(pw!=checkPw){
			alert("패스워드가 맞지 않습니다.")
		}else{
			name.disabled = false;
			id.disabled = false;
			idNo.disabled = false;
			form.submit();
		}
	}

	function home(){
		location.href="./";
	}
</script>
</head>
<body style="background-color: pink;">
	<form action="modify" method="post" id="form">
		<fieldset style="background-color: white;">
			<legend style="background-color:white; text-align: center; font-size: x-large; color: red; border: solid 2px red; border-radius: 15px; padding: 5px;">회원정보 수정</legend>
			<table>
				<tr>
					<th>이름</th>
					<td><input type="text" id="name" name="username" value="${sessionScope.member.username}" disabled="disabled"></td>
				</tr>
				
				<tr>
					<th>아이디</th>
					<td><input type="text" id="id" name="id" value="${sessionScope.member.id}" disabled="disabled"></td>
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
					<td><input type="text" id="email" name="email" value="${sessionScope.member.email}"></td>
				</tr>
				
<!-- 				<tr> -->
<!-- 					<th>회원 구분</th> -->
<!-- 					<td align="center"> -->
<!-- 						<input type="radio" name="division" value="개인" checked="checked" style="width: 5%"> 개인&nbsp; -->
<!-- 						<input type="radio" name="division" value="법인" style="width: 5%"> 법인&nbsp; -->
<!-- 					</td> -->
<!-- 				</tr> -->
				
				<tr>
					<th>식별번호</th>
					<td><input type="text" id="idNo" name="idNo" value="${sessionScope.member.idNo}" disabled="disabled"></td>
				</tr>
				
				<tr>
					<th>주소</th>
					<td><input type="text" id="address" name="address" value="${sessionScope.member.address}"></td>
				</tr>
				
				<tr>
					<th colspan="2" style="border-left: none;border-right: none;border-bottom: none;">
						<input type="button" value="회원정보 수정" style="width: 20%" onclick="send()">
						<input type="button" value="돌아가기" onclick="home()" style="width: 15%">
					</th>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>