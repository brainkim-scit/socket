<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 서버영역에 첨부파일 삭제 후 결과를 보내기 -->
	<c:if test="${result == 1}">
		<c:set var="result" value="${result}"/>
	</c:if>
	
	<c:if test="${result != 1}">
		<c:set var="result" value="0"/>
	</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	th,td{
		border: solid 1px gray;
		padding: 3px;
	}
	th{
		width: 150px;
	}
</style>

<script type="text/javascript">
	// 첨부파일 삭제되었을 경우 서버영역의 결과 값을 확인 후 리프레쉬
// 	window.onload = function(){
// 		if(${result} == 1){
// 		 	if (self.name != 'reload') {
// 	 		self.name = 'reload';
// 	 		self.location.reload(true);
// 		 	}
// 		 	else {
// 			 	self.name = '';
// 		 	}
// 			boardModify();
// 		}
// 	}

	// 수정 메소드
	function boardModify() {
		var form = document.getElementById("form");
		var title = document.getElementById("title");
		var content = document.getElementById("content");
		
			if (title.value.trim().length == 0) {
				alert("제목을 입력해주세요.");
			} else {
				var check = confirm("정말로 수정하시겠습니까?")
				if(check){
				form.submit();
				}
			}
	}

</script>
</head>
<body>
<div id="wrapper" style="width: 500px; margin: 0 auto; margin-top: 10%;">
	<div style="text-align: center;"><h2>[ 게시글 수정하기 ]</h2></div>
	<form id="form" action="boardModify" enctype="multipart/form-data" method="post">
	<input type="hidden" name="boardno" value="${board.boardno}">
		<table style="border-collapse: collapse; width: 500px;">
			<tr class="title">
				<th colspan="2" style="border-left: none; border-right: none; border-top: none; text-align: right;">
					<input type="button" id="modify" value="수정완료" onclick="boardModify()" />
				</th>
			</tr>
			<tr class="title">
				<th>이름</th>
				<td>${board.writer}</td>
			</tr>
			<tr class="title">
				<th>제목</th>
				<td><input type="text" id="title" name="title" value="${board.title}" readonly="readonly"/></td>
			</tr>
			
			<tr class="title">
				<th>첨부 파일</th>
				<td>
					<input type="file" id="upload" name="upload" value="파일 선택"/>
				</td>
			</tr>
			
			<tr class="title">
				<th>내용</th>
				<td><textarea id="content" rows="10" cols="40" name="content" style="resize: none; width: 380px; height: 157px; margin: 0 auto;">${board.content}</textarea></td>
			</tr>
			
			<tr class="title">
				<th colspan="2" style="border-left: none; border-right: none; border-bottom: none; padding-top: 20px;">
					<input type="button" value="돌아가기" onclick="history.back(-1)"/>
				</th>
			</tr>
		</table>
	</form>
</div>
</body>
</html>