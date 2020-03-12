<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">

<title>login</title>
<style>
</style>

<c:choose>
	<c:when test="${not empty notice}">
		<script type="text/javascript">
			alert('${notice}');
		</script>
	</c:when>
</c:choose>
<script type="text/javascript">

	// 자동로그인 로직
	// 쿠키에 ID와 password 값이 저장되어 있을 경우
	// 해당 value 값을 이용 바로 submit 진행
	window.onload = function(){
		var form = document.getElementById("form");
		var id = document.getElementById("id").value;
		var pw = document.getElementById("pw").value;
		var savedId = document.getElementById("savedId");
		var auto = document.getElementById("auto");
		if(id.trim().length!=0&&pw.trim().length!=0){
			//쿠키 연장
			savedId.checked = true;
			auto.checked = true;
			form.submit();
		}
	}
	function send(){
		var form = document.getElementById("form");
		var id = document.getElementById("id").value;
		var pw = document.getElementById("pw").value;
		var savedId = document.getElementById("savedId");
		var auto = document.getElementById("auto");

		if(id.trim().length==0||pw.trim().length==0){
			alert("정보를 입력해주세요");
			return false;
		}else if(auto.checked==true){
			savedId.checked=true;
			return true;
		}else{
			return true;
		}
	}

	function home(){
		location.href = "./";
	}
</script>
</head>
<body>
<c:if test="${cookie.containsKey('savedId')}"><c:set var="checked" value="checked"/></c:if>
<c:if test="${not cookie.containsKey('savedId')}"><c:set var="checked" value="unchecked"/></c:if>

<c:url var="root" value="/"/>

<form action="login" id="form" method="POST" onsubmit="return send()">
		<fieldset>
			<legend>로그인</legend>
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" id="id" name="id" value="${cookie['savedId'].value}"></td>
				</tr>
				
				<tr>
					<th>Password</th>
					<td><input type="password" id="pw" name="pw" value="${cookie['savedPw'].value}"></td>
				</tr>
				
				<tr>
					<th colspan="2">
						<label for="savedId" style="cursor: pointer;">
							<input type="checkbox" id="savedId" name="saveRequest" style="cursor: pointer;" ${checked}>아이디 저장
						</label>
						<label for="auto" style="cursor: pointer;">
							<input type="checkbox" id="auto" name="autoLogin" style="cursor: pointer;">자동 로그인
						</label>
					</th>
				</tr>
				
				<tr>
					<th colspan="2">
						<input type="submit" value="로그인">
						<input type="button" value="돌아가기" onclick="home()">
					</th>
				</tr>
				
				<c:if test="${not empty notice}">
				<tr>
					<th colspan="2">
						<span style="color: red;">${notice}</span>
					</th>
				</tr>
				</c:if>
			</table>
		</fieldset>

</form>