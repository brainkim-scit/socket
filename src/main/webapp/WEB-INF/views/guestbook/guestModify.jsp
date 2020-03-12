<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function btClick(index){
		var form = document.getElementById("form");
		if(index == 1){
			var answer = confirm("정말로 수정하시겠습니까?");
			if(answer){
			form.action="guestmodify";
			form.method="post";
			document.getElementById("guestname").disabled=false;
			form.submit();
			}
		}else if(index == 2){
			var answer = confirm("정말로 삭제하시겠습니까?");
			if(answer){
				form.action="delete";
				form.method="get";
				form.submit();
			}
		}else if(index == 3){
			location.href="guestbook"
		}
	}
</script>
</head>
<body>
<div style="text-align: center; margin-top: 10%;"><h2>[ 방명록 ]</h2></div>
	<form id="form">
	<input type="hidden" name="seqno" value="${vo.seqno}">
<div id="wrapper" style="margin-left: 37%;">
		<table border="1">
			<tr>
				<th>이름</th>
				<td><input type="text" id="guestname" name="guestname" value="${vo.guestname}" disabled="disabled"/></td>
			</tr>		
			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="guestpwd" name="guestpwd" value="${vo.guestpwd}"/></td>
			</tr>	
			<tr>
				<th>내용</th>
				<td><textarea id="text" rows="10" cols="40" name="text">${vo.text}</textarea></td>
			</tr>	
			<tr>
				<th colspan="2">
					<input type="button" value="수정" onclick="btClick(1)"/>
					<input type="button" value="삭제" onclick="btClick(2)"/>
					<input type="button" value="돌아가기" onclick="btClick(3)">
				</th>
			</tr>
		</table>
	</div>
	</form>
</body>
</html>