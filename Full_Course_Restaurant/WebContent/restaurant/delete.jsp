<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>맛집 삭제 결과 페이지</title>
</head>
<body>
	<div>
		<h3> 공갈 맛집 삭제 결과 페이지</h3>
		
		${rvo.msg }						<!-- 삭제 처리 결과 메시지 출력 -->
		${param.serial }				<!-- 삭제된 게시글의 음식점 테이블 PK를 출력 -->
		<form name='rest_delete' method='post'>
			<input type='button' name='btnList' value='목록으로'>	
		</form>
		
	</div>
	
<script>
	var frm = document.rest_delete;			// form태그를 frm으로 지정
	frm.btnList.onclick = function(){		// 목록으로 버튼 클릭시
		frm.action = "list.donghwan";		// 목록페이지로 가는 액션 설정
		frm.submit();						// 전송
	}
</script>

</body>
</html>