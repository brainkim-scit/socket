<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="5;url=${pageContext.request.contextPath}/">
<title>Insert title here</title>
<style type="text/css">
	#wrapper{
		width: 800px;
		margin: 0 auto;
		text-align: center;
	}
</style>
</head>
<body>
	<div id="wrapper">
		<h1>Error</h1>
		<h3>${errmsg}</h3>
		<div>5초 후 첫 페이지로 이동합니다. 잠시 후에 다시 사용해 주세요.</div>
		<div>
			<img alt="에러가 발생" src="resources/images/error.jpg">
		</div>
	</div>
</body>
</html>