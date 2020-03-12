<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	// 처음 페이지를 열었을 땐 넘어온 객체 정보가 아무것도 없으므로
	//		자동으로 check()메소드를 한번 돌림
	// check()메소드가 끝나면 객체 정보가 넘어오므로 딱 한번만 실행
	window.onload = function(){
		if(${member == null}){
		document.getElementById("id").value= window.opener.document.getElementById("id").value
		check();
		}
	}

	//중복 검사 메소드
	function check(){
		var form = document.getElementById("form");
		var id = document.getElementById("id").value;
	
		if(id.trim().length==0){
			alert("아이디를 입력하세요");
		}else{
			form.action="check";
			form.method="post";
			form.submit();
		}
	}

	// 중복 검사 후 아이디 사용하기 위해 부모창인 회원가입 창의 ID value 값을 보내줌
	function send(){
		opener.document.getElementById("id").value = document.getElementById("id").value;
		opener.document.getElementById("onoff").value = 1;
		window.close();
	}
</script>
</head>
<body>
<div id="wrapper" style="text-align: center;">
	<h2>[ 중복 확인 ]</h2>
	<form action="check" method="post" id="form">
		<input type="text" id="id" name="id" value="${member.id}">
		<input type="button" value="중복확인" onclick="check()">
	</form>
	
	<c:if test="${result==1}">
	<div>
	${member.id}은 사용할 수 없습니다.
	</div>
	</c:if>
	
	<c:if test="${result==0}">
	<div>
	${member.id}은 사용 가능합니다.<br>
	<input type="button" value="사용하기" onclick="send()">
	</div>
	</c:if>
</div>
</body>
</html>