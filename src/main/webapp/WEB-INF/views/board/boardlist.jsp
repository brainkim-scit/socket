<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>게시판</title>
<style type="text/css">
	a:visited {
		color: black;
		text-decoration: none;
	}
	a:hover {
		color: blue;
		text-decoration: underline;
	}

th{
	height: 55px;;
	background-color: navy;
	color: white;
}

td{
	height: 40px;
}
.gray{
	background-color: rgb(221,224,225);
}
}
</style>

<c:choose>
	
	<c:when test="${requestScope.modifyResult == 1}">
		<script>
			alert("게시판 수정에 성공했습니다.");
		</script>
	</c:when>
	
	<c:when test="${requestScope.modifyResult == 0}">
		<script>alert("게시판 수정에 실패했습니다.");</script>
	</c:when>
	
	<c:when test="${requestScope.deleteResult == 1}">
		<script>alert("게시판 삭제에 성공했습니다.");</script>
	</c:when>
	
	<c:when test="${requestScope.deleteResult == 0}">
		<script>alert("게시판 삭제에 실패했습니다.");</script>
	</c:when>
	
</c:choose>

<script type="text/javascript">
	function boardWrite(){
		location.href = "write";
	}

	function boardIn(index){
		location.href = "getin?boardno="+index;
	}
	
</script>
</head>
<body>
	<div id="wrapper" style="width: 850px; margin:0 auto; margin-top: 1%;">
		<div style="text-align: center;">
			<c:url var="home" value="/"/>
				<h2>
				<a href="${home}">
					<img alt="홈으로" src="resources/images/home.jpeg" style="width: 40px; cursor: pointer;">
				</a>
				[ 게 시 판 ]
				</h2>
		</div>
		
		<div class="form-group" style="text-align: center; margin-bottom: 10px;">
			<form id="search" action="boardlist">
					<select id="select" name="select" class="form-control" style="text-align:center; width:100px; display: inline;">
						<option value="title" ${sessionScope.select == 'title' ? 'selected' : ''}>제목</option>
						<option value="writer" ${sessionScope.select == 'writer' ? 'selected' : ''}>글쓴이</option>
						<option value="content" ${sessionScope.select == 'content' ? 'selected' : ''}>내용</option>
					</select>
					
					<input type="text" id="aim" name="aim" class="form-control" value="${sessionScope.aim}" style="width: 400px; display: inline;">
					
					<button type="submit" class="btn btn-dark">검색</button>
			</form>
		</div>
		
		<table style="text-align: center; border-collapse: collapse; width: 750px; margin: 0 auto; align-content: center;">
			<c:if test="${not empty boardlist}">
			<tr>
				<th style="width: 64px;">번호</th>
				<th style="width: 224px;">글제목</th>
				<th style="width: 174px;">글쓴날</th>
				<th style="width: 104px;">글쓴이</th>
				<th style="width: 72px;">조회수</th>
			</tr>
			</c:if>
			
			<c:forEach var="a" items="${boardlist}" varStatus="s">
			<tr ${s.count % 2 == 0 ? 'class="gray"':''}>
				<td style="color: navy; font-size: large;">${s.count+navi.startRecord}</td>
				<td>
					<label for="boardIn" style="cursor: pointer;" onclick="boardIn(${a.boardno})">
						<c:if test="${a.savedfilename != null}">
							<img src="resources/images/clip.png" style="height: 17px;">
						</c:if>
						<span id="boardIn">${a.title} [${a.count}]</span>
					</label>
				</td>
				<td>${a.regdate}</td>
				<td>${a.writer}</td>
				<td>${a.hitcount}</td>
			</tr>
			</c:forEach>
		</table>
		
		<div class="form-group" style="width: 800px; text-align: right; margin-top: 15px;">
			<input type="button" class="btn btn-primary" value="글쓰기" onclick="boardWrite()">
		</div>

		<!--페이징 -->
		<div id="paging" style="width: 500px; margin: 0 auto;">
		
			<ul class="pagination" style="text-align: center; width: 430px; margin: 0 auto;">
				<li class="page-item">
					<a class="page-link" href="boardlist?currentPage=${navi.currentPage-navi.pagePerGroup}&select=${select}&aim=${aim}">
					◁
					</a>
				</li>
					
				<li class="page-item">
					<a class="page-link" href="boardlist?currentPage=${navi.currentPage-1}&select=${select}&aim=${aim}">
					previous
					</a>
				</li>
			
			
				<c:forEach var="list" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
				
				<c:if test="${currentPage != list}">
					<li class="page-item"><a class="page-link" href="boardlist?currentPage=${list}&select=${select}&aim=${aim}">${list}</a></li>
				</c:if>
			
				<c:if test="${currentPage == list}">
					<li class="page-item active"><span class="page-link" style="color: white">${list}</span></li>
				</c:if>
							
				</c:forEach>
				
				
				<li class="page-item" style="width: 86px;">
					<a class="page-link" href="boardlist?currentPage=${navi.currentPage+1}&select=${select}&aim=${aim}">
					next
					</a>
				</li>
						
				<li class="page-item">
					<a class="page-link" href="boardlist?currentPage=${navi.currentPage+navi.pagePerGroup}&select=${select}&aim=${aim}">
					▷
					</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>