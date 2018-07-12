<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>맛집 수정 결과</title>
</head>
<body>


	<div>
		<h3> 공갈 맛집 수정 결과 페이지</h3>
		${rvo.msg }
		<form name='rest_mr' method='post'>
			<input type='button' name='btnList' value='목록으로가기'>
			
		</form>
		
	</div>
	
<script>
	var frm = document.rest_mr;
	
	frm.btnList.onclick = function(){
		frm.action = "list.donghwan";
		frm.submit();
	}
</script>
</body>
</html>