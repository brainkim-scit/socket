<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
th, td {
	border: solid 1px gray;
	padding: 3px;
}

.rep {
	border: none;
	border-bottom: solid 1px gray;
}

.check:active{
	background-color: rgb(211,211,211);
}

#all {
	width: 1150px;
	margin: 0 auto;
}

#table{
	border-collapse:collapse;
	width:550px;
	text-align: center;
}

#currentPage{
	text-align: center;
}

input[type=button], input[type=submit]{
	padding-left: 10px; padding-right: 10px;
	padding-top: 5px; padding-bottom: 5px;
	border-radius: 15px;
	border:none;
	background-color: threedshadow;
	color: white;
}

input[type=button]:focus{
border: none;
outline: none;
}

input[type=button]:hover{
	cursor: pointer;
}

input[type=submit]:hover{
	cursor: pointer;
}

input[type=button]:active {
	background-color: black;
}
input[type=submit]:active {
	background-color: black;
}
</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		replyList();

		$("#btnReply").on("click",function(){
			replysend();
		});
	});
	
	// 게시판 삭제 메소드
	function deleteboard(){
		var form = document.getElementById("form");
		var check = confirm("정말로 삭제하시겠습니까?");
	
		if(check){
			location.href = "boardDelete?boardno="+${board.boardno};
		}
	}
	
	function replyList(current){
		var boardno = ${board.boardno};
		var currentPage = current;

		var data = {"boardno":boardno, "currentPage":currentPage};
		$.ajax({
			type : "GET",
			url : "replyList",
			data : data,
			success : list,
			error : function(){
						alert("에러");
			}
		});
	};

	function replysend(){
		var status = $("#btnReply").val()=="수정하기" ? "modify":"insert";
		console.log(currentPage);
		if(status == "insert"){
			replyInsert();
		}else{
			modify($(".selectedPage").val());
		}
	};

	function replyInsert(){
		var data = {
					"replytext":$("#replytext").val(),
					"boardno":${board.boardno}
					};

		// clear하기
		$("#replytext").val("");
		
		$.ajax({
			type : "POST",
			url : "reply",
			data : data,
			success : function(result){
							if(result == 1){
								replyList();
							}else{
								alert("댓글 추가 실패");
								};
							},
			error : function(){alert("잘못됨");}
		});
	}


	function delReply(currentPage){
		$(".delReply").on("click",function(){
			var data = {"boardno":${board.boardno},"replyno":$(this).attr("data-num")};
			$.ajax({
				type : "GET",
				url : "deleteReply",
				data : data,
				success : replyList(currentPage),
				error : function(){alert("에러");}
			});
		});
	};

	function modify(currentPage){
		var replyno = $("#btnReply").attr("data-num");
		var data = {
					"boardno":${board.boardno},
					"replyno":replyno,
					"replytext": $("#replytext").val()
					};
		console.log(currentPage);
		console.log(data);
		$.ajax({
			type : "POST",
			url : "modifyReply",
			data : data,
			success : function(result){
						if(result == 1){
							replyList(currentPage);
						}else{
							alert("수정실패");
						}
					},
			error : function(){alert("에러");}
		});
	$("#replytext").val("");
	$(".modiReply[data-num='"+replyno+"']").val("댓글수정").css("background-color","threedshadow");
	$(".modiReply").prop("disabled",false);
	$("#btnReply").val("등록하기");
	$("#btnReply").attr("data-num","");
};

	function list(replylist){
		console.log(JSON.stringify(replylist));
		var loginid = "${sessionScope.member.id}";
		if(replylist.list.length==0){
			$("#wrapper2").text("없음");
		}else{
			var replyOut = "";
			replyOut += "<table id='table'><tr>";
			replyOut += "<th>번호</th>";
			replyOut += "<th>내용</th>";
			replyOut += "<th>작성자</th>";
			replyOut += "<th>작성날짜</th>";
			replyOut += "<th>수정</th>";
			replyOut += "<th>삭제</th></tr>";

			$.each(replylist.list,function(index,item){
				replyOut += "<tr>";
				replyOut += "<td>"+(index+1+parseInt(replylist.navi.startRecord));
				replyOut += "<td>"+item.replytext+"</td>";
				replyOut += "<td>"+item.writer+"</td>";
				replyOut += "<td>"+item.regdate+"</td>";
				if(loginid == item.writer){
					replyOut += "<td><input type='button' class='modiReply' value='댓글수정' data-text='"+item.replytext+"' data-num='"+item.replyno+"'/></td>";
					replyOut += "<td><input type='button' class='delReply' value='댓글삭제' data-num='"+item.replyno+"'/></td>";
				}else{
					replyOut += "<td>못함</td>";
					replyOut += "<td>못함</td>";
				};
				replyOut += "</tr>";
			});
			replyOut += "</table>";

			replyOut += "<div id='currentPage'>";
			replyOut += "<input type='button' class='preGroup' value='◀◀'/>";
			replyOut += "<input type='button' class='prePage' value='◁'/>";
			for(var currentPage = replylist.navi.startPageGroup; currentPage <= replylist.navi.endPageGroup; currentPage++){
				if(currentPage == replylist.navi.currentPage){
					replyOut += "<input type='button' class='selectedPage' style='background:black;' value='"+currentPage+"' disabled/>";
				}else{
					replyOut += "<input type='button' class='currentPage' value='"+currentPage+"'/>";
				};
			}
			replyOut += "<input type='button' class='nextPage' value='▷'/>";
			replyOut += "<input type='button' class='nextGroup' value='▶▶'/>";
			replyOut += "</div>";
			$("#wrapper2").html(replyOut);
		};
		paging(replylist);
		delReply(replylist.navi.currentPage);
		modifyReply();
	};


	function modifyReply(){
		$(".modiReply").on("click",function(){
			var replyno = $(this).attr("data-num");
			
			$("#replytext").val($(this).attr("data-text"));
			$(".modiReply").not(this).prop("disabled",true);
			$(this).val("수정중").css("background-color","black");
			$("#btnReply").val("수정하기");
			$("#btnReply").attr({"data-num":replyno});
			$("#replytext").focus();
		});
	};



	function paging(replylist){
		$(".currentPage").on("click",function(){
			var current = $(this).attr("value");
			console.log(current);
			replyList(current);
		});

		$(".preGroup").on("click",function(){
			var current = replylist.navi.currentPage-5;
			console.log(current);
			replyList(current);
		});

		$(".prePage").on("click",function(){
			var current = replylist.navi.currentPage-1;
			console.log(current);
			replyList(current);
		});

		$(".nextGroup").on("click",function(){
			var current = replylist.navi.currentPage+5;
			console.log(current);
			replyList(current);
		});

		$(".nextPage").on("click",function(){
			var current = replylist.navi.currentPage+1;
			console.log(current);
			replyList(current);
		});
	}
</script>
</head>
<body>
	<div style="text-align: center; padding-top: 2%;">
		<a href="./" style="text-decoration: none;">
			
			<span style="font-size: x-large;">home</span>
			
			<img alt="home" src="<c:url value='/resources/images/home.jpeg'/>" style="width: 100px; cursor: pointer;">
			
			<span style="font-size: x-large;">button</span>
			
		</a>
	</div>

	<div id="all">

		<div id="wrapper" style="width: 550px; margin: 0 auto;">

			<div style="text-align: center;">
				<h2>[ 게시글 ]</h2>
			</div>
			
			<form id="form" action="boardDetail">
				<table style="border-collapse: collapse; width: 500px; height: 348px; margin: 0 auto;">
					<tr class="title">
						<th colspan="2" style="border-left: none; border-right: none; border-top: none; text-align: right;">
							<c:if test="${sessionScope.member.id == requestScope.board.writer}">
								
								<input type="button" id="modify" value="수정"
									onclick="location.href='boardModify?boardno=${board.boardno}'" />
								
								<input type="button" id="boardDelete" value="삭제"
									onclick="deleteboard()" />
							</c:if>
						</th>
					</tr>
					<tr class="title">
						<th>이름</th>
						<td>${board.writer}</td>
					</tr>
					<tr class="title">
						<th>제목</th>
						<td>${board.title}</td>
					</tr>
					<tr class="title">
						<th>작성일</th>
						<td>${board.regdate}</td>
					</tr>

					<tr class="title">
						<th>첨부 파일</th>
						<td>
							<!-- 현재 객체에 저장된 파일 값이 없을 경우 -->
							<c:if test="${board.originalfilename == null}">
								<span id="nofile">파일 없음</span>
							</c:if>
							
							<!-- 현재 객체에 저장된 파일 값이 있을 경우 -->
							<c:if test="${board.originalfilename != null}">
								<a href="download?boardno=${board.boardno}">${board.originalfilename}</a>
							</c:if>
						</td>
					</tr>

					<tr class="title">
						<th>내용</th>
						<td><pre> ${board.content}</pre></td>
					</tr>
					
					<!-- 해당페이지 돌아가기 -->					
					<tr class="title">
						<th colspan="2" style="border-left: none; border-right: none; border-bottom: none; padding-top: 20px;">
							<input type="button" value="돌아가기"
							onclick="location.href='boardlist?currentPage=${sessionScope.currentPage}&select=${sessionScope.select}&aim=${sessionScope.aim}'" />
						</th>
					</tr>
				</table>
			</form>

			<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			 -->

				<fieldset style="text-align: center; width: 450px; margin: 0 auto;">
					<legend id="legendChange">댓글달기</legend>
					<textarea rows="8" cols="40" placeholder="멋대로 입력하세요"
						style="resize: none; width: 480px; height: 50px;" id="replytext"
						name="replytext"></textarea>
					<input type="button" value="등록하기" id="btnReply">
				</fieldset>
		</div>

		<div id="wrapper2" style="width: 550px; margin: 0 auto;">
		</div>
	</div>
</body>
</html>