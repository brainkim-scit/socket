<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 th{
 	text-align: center;
 }
 fieldset {
 	margin-top: 15%;
	margin-left: 42%;
	margin-right: 42%;
}
</style>
<script type="text/javascript">
	function send(){
		var form = document.getElementById("form");
		var guestpwd = document.getElementById("guestpwd").value;

		if(guestpwd!='${vo.guestpwd}'){
			alert("입력한 패스워드가 다릅니다.");
		}else{
			form.submit();
		}
	}
</script>
</head>
<body>
	<form action="guestlogin" method="post" id="form">
		<input type="hidden" id="seqno" name="seqno" value="${vo.seqno}"/>
		<input type="hidden" id="guestname" name="guestname" value="${vo.guestname}"/>
		<input type="hidden" id="text" name="text" value="${vo.text}"/>
		<fieldset>
			<legend style="text-align: center;">방명록 로그인</legend>
			<table>
				<tr>
					<th>Password</th>
					<td><input type="password" id="guestpwd" name="guestpwd"></td>
				</tr>
				
				<tr>
					<th colspan="2">
						<input type="button" value="로그인" onclick="send()">
						<input type="button" value="돌아가기" onclick="history.back(-1)">
					</th>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>