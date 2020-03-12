<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
	th,td{
		border: solid 1px gray;
		padding: 3px;
	}
	th{
		text-align: center;
	}
</style>
<script type="text/javascript">
	
	function boardWrite() {
		var form = document.getElementById("form");
		var writer = document.getElementById("writer").value;
		var title = document.getElementById("title").value;
		var content = document.getElementById("content").value;
	
		if (title.trim().length == 0) {
			alert("제목을 입력해주세요.");
		} else {
			form.submit();
		}
	}
</script>
</head>
<body>
<div id="wrapper" style="width: 500px; margin: 0 auto; margin-top: 10%;">
	<div style="text-align: center;"><h2>[ 게시글 쓰기 ]</h2></div>
	<form id="form" action="write" enctype="multipart/form-data" method="post">
		<table style="border-collapse: collapse; width: 500px;">
			<tr class="title">
				<th>이름</th>
				<td style="padding-left: 5px;"><input type="text" id="writer" name="writer" style="border: none; outline: none;" readonly="readonly" value="${sessionScope.member.id}"/></td>
			</tr>		
			<tr class="title">
				<th>제목</th>
				<td><input type="text" id="title" name="title" /></td>
			</tr>	
			<tr class="title">
				<th>첨부 파일</th>
				<td>
					<input type="file" name="upload" value="파일 선택"/>
				</td>
			</tr>				
			
			<tr class="title">
				<th>내용</th>
				<td><textarea id="content" rows="10" cols="40" name="content" style="resize: none;"></textarea></td>
			</tr>
			
			<tr class="title">
				<th colspan="2" style="border-left: none; border-right: none; border-bottom: none; padding-top: 20px;">
					<input type="button" value="등록" class="btn btn-primary" onclick="boardWrite()" />
					<input type="button" value="돌아가기" class="btn btn-danger" onclick="location.href='boardlist?currentPage=${sessionScope.currentPage}&select=${sessionScope.select}&aim=${sessionScope.aim}'"/>
				</th>
			</tr>
		</table>
	</form>
</div>
</body>
</html>