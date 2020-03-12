<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function go() {
		var form = document.getElementById("guestbook");
		var name = document.getElementById("guestname").value;
		var pw = document.getElementById("guestpwd").value;
		var text = document.getElementById("text").value;

		if (name.trim().length == 0) {
			alert("이름을 입력해주세요");
		} else if (pw.trim().length == 0) {
			alert("패스워드를 입력해주세요");
		} else if (text.trim().length == 0) {
			alert("내용을 입력해주세요.")
		} else {
			form.submit();
		}
	}
	function page(index){
		var form = document.getElementById("guest");
		var seqno = document.getElementById("seqno");
		seqno.value = index;
		form.submit();
	}

	function doSearch(){
		var form = document.getElementById("search");
		var select = document.getElementById("select").value;
		var aim = document.getElementById("aim").value;
		if(aim.trim().length!=0){
			form.submit();
		}
	}

	function back(){
		location.href = "guestbook"
	}
	function home(){
		location.href = "./"
	}
</script>
<style type="text/css">
	label:active{
		color: red;
	}
	label:hover {
		background-color: skyblue;
		text-decoration: underline;
		
	}
	label:checked {
		color: blue;
	}
 	th {
		padding-left: 20px;
		padding-right: 20px;
		padding-top: 5px;
		padding-bottom: 5px;
	}
</style>
</head>
<body>
		<div style="text-align: center;"><h2>[ 방명록 ]</h2></div>
			<div style="margin-left: 510px; margin-right: 510px;">
				<form id="guestbook" action="guestbook" method="post">
					<table border="1" style="width: 480px;">
						<tr>
							<th style="width: 140px;">이름</th>
							<td><input type="text" id="guestname" name="guestname" /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" id="guestpwd" name="guestpwd" /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="text" rows="10" cols="40" name="text"
									placeholder="방명록을 입력해주세요."></textarea></td>
						</tr>
						<tr>
							<th colspan="2"><input type="button" value="등록" onclick="go()" />
								<input type="button" value="취소" onclick="home()"/></th>
						</tr>
					</table>
				</form>
			</div>
			
			<div style="text-align: center; margin-left: 510px; margin-right: 510px;">
				<hr>
				<h2>[ 내역 ]</h2>
				<hr>
			</div>
			
			<c:if test="${list.size()==0}">
				<form action="search" id="search">
				<div style="margin-top: 10px; margin-left: 555px;">
					<select id="select" name="select">
						<option value="writer">작성자</option>
						<option value="text">내용</option>
						<option value="writerText">작성자or내용</option>
					</select>
					<input type="text" id="aim" name="aim" style="width: 200px;">
					<input type="button" value="검색" onclick="doSearch()">
					<input type="button" value="목록" onclick="back()">
				</div>
				</form>
			</c:if>
		
		<c:if test="${list.size()!=0}">
			<form action="guest" id="guest" method="get">
				<div style="margin-left: 510px; margin-right: 510px;">
					<input type="hidden" id="seqno" name="seqno">
					<table border="1" style="text-align: center; width: 480px;">
						<tr>
							<th style="width: 40px;">번호</th>
							<th>이름</th>
							<th>내용</th>
							<th>글쓴 날짜</th>
						</tr>
						<c:forEach var="a" items="${list}" varStatus="s">
							<tr>
								<td style="height: 21.2px;">
									<span>${a.seqno}</span>
								</td>
								
								<td>
									<span class="${a.seqno}">${a.guestname}</span>
								</td>
								
								<td>
									<label for="${a.seqno}" onclick="page(${a.seqno})" style="cursor: pointer;">
									<span class="${a.seqno}">${a.text}</span>
									</label>
								</td>
							
								<td>
									<span>${a.regdate}</span>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</form>
			<form action="search" id="search">
				<div style="margin-top: 10px; margin-left: 555px;">
					<select id="select" name="select">
						<option value="writer">작성자</option>
						<option value="text">내용</option>
						<option value="writerText">작성자or내용</option>
					</select>
					<input type="text" id="aim" name="aim" style="width: 200px;">
					<input type="button" value="검색" onclick="doSearch()">
					<input type="button" value="목록" onclick="back()">
				</div>
			</form>
		</c:if>
</body>
</html>