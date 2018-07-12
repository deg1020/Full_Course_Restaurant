<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>맛집 목록</title>
</head>

<!-- 목록페이지 윗부분 배경사진  -->
<style>
.restaurant-pic{
   background-size: cover;
   width: 100%;
}
</style>

<body>

<form name='rest_list' method='post'>
 
 <!-- 히든 값  -->
 <input type="hidden" name="hiddenAdd1" value="${param.raddress1 }">
 <input type="hidden" name="hiddenAdd2" value="${param.raddress2 }">
 <input type='hidden' name='serial' value='1'>
 <input type='hidden' name='nowPage' value='1'> 
 
 <!-- 상단 부분  -->
 <div class="container restaurant-pic" style = "background-image: url(./imgs/restaurant.jpg)">
  <div class="visual-text w3-center" style = 'z-index: 4; height: 30%'>
   <h1
       style="background-image: url('./imgs/full_course.svg'); margin-top: -5%;">Full
       Course Trip</h1>
   <div style = "margin-top: -3%">
    <div class="w3-row" style='width: 40%; margin-right: 30%; margin-left: 30%;'>
     <div class="w3-half" id="result1"></div>
     <div class="w3-half" id="result2"></div>
    </div>
    
   <!-- 검색 부분 -->
   <div class="w3-row search"
         style='width: 40%; margin-right: 30%; margin-left: 30%;'>
    <input type="text" placeholder="검색할 레스토랑명 입력.." name="findStr" 
           style="border: 0px; border-radius: 3px; padding-left: 16px; z-index: 3;" value="${param.findStr}">
    <button type="button" class="w3-teal" name='btnFind'>
    <i class="fa fa-search"></i>
    </button>
   </div>
   </div>
  </div>
 </div>
 
 <!-- 정렬 부분 -->
 <div class = 'w3-right'id='list_range'>
  <select name='orderBy' size='1' onchange="submit()" class="w3-select w3-border" style="width:150px;">
   <option value="등록순" ${param.orderBy eq "등록순" ? "selected" :""}>등록순</option>
   <option value='조회순' ${param.orderBy eq "조회순" ? "selected" :""}>조회순</option>
  </select>
 </div>

 <!-- 제목 부분 -->
 <div class="row">
  <div class="col-md-8 col-md-offset-2 text-center gtco-heading">
   <h2 class="cursive-font primary-color">Restaurant</h2>
  </div>
 </div>


 <!-- 음식점 리스트 부분 -->
 <div class=container>
  <div class="row">
   <c:forEach var="rvo" items="${list}">
    <div class="col-lg-4 col-md-4 col-sm-6">
     <div class="fh5co-card-item image-popup" onclick="serialFunc(this)" id='${rvo.pserial}'>
     <figure>
      <div class="overlay"></div>
      <img src="./restaurant/thumbnail/thumb_${rvo.rmAttFile}" alt="Image" class="img-responsive">
     </figure>
      <div class="fh5co-text">
       <h2>${rvo.rname}</h2>
       <p>${rvo.rmenus }</p>
       <p>${rvo.rinfo }</p>
      </div>
     </div>
    </div>
   </c:forEach>
  </div>
 </div>
 
 <!-- 아이디, 사업자&일반회원 구분 가져오기 -->  
 <% 
 	if(session.getAttribute("sId") != null){							// 아이디 가져오기
    	String sId = (String)session.getAttribute("sId");       
    }
    if(session.getAttribute("selection") != null){						// 사업자&일반회원 가져오기
		String selection = (String)session.getAttribute("selection");
	}
 %>
 
 <!-- 페이지 분리 부분 -->
 <br><br>
 <div class='w3-center'>
  <ul class="pagination pagination-sm">
   <c:if test="${dao.nowBlock>1 }">
   <li class="page-item"><a class="page-link"
       onclick='movePage(1);return false;'>First</a></li>
   <li class="page-item"><a class="page-link"
       onclick='movePage(${dao.startPage-1});return false;'>Previous</a></li>
   </c:if>
   
   <c:forEach var='i' begin="${dao.startPage}" end="${dao.endPage}">
   <c:if test="${dao.nowPage == i}">
   <li class="page-item active"><a class="page-link"
       onclick='movePage(${i});return false;'>${i}</a></li>
   </c:if>
   
   <c:if test="${dao.nowPage != i}">
   <li class="page-item"><a class="page-link"
       onclick='movePage(${i});return false;' >${i}</a></li>
   </c:if>
   </c:forEach>

   <c:if test="${dao.nowBlock < dao.totBlock}">
   <li class="page-item"><a class="page-link"
       onclick='movePage(${dao.endPage+1});return false;'>Next</a></li>
   <li class="page-item"><a class="page-link"
       onclick='movePage(${dao.totPage});return false;'>Last</a></li>
   </c:if>
  </ul>
 </div>
 
 <!-- 음식점 입력 버튼 부분 -->
 <c:if test="${sId != null and selection == 'c'}">
  <div id='insert'>
   <input type='button' value='맛집 등록하기' name='btnInsert' class="btn btn-primary" onclick = 'insert()'>
  </div>
 </c:if>
</form>   


<script>
$(document).ready(function(){													// body 코드 출력 이후에 호출되는 코드
	$('input').attr('autocomplete','off');										// 자동완성 기능 x	
    var navbar = document.getElementById("myNavbar");							// Id값이 myNavbar인 태그를 지정
    var holder = document.getElementById("holder");								// Id값이 holder인 태그를 지정
    navbar.className = "w3-bar" + " w3-card" + " w3-animate-top" + " w3-white";	// navbar 태그의 className지정
    holder.className = "nav-holder" + " w3-padding-large" + " nav_small";		// holder 태그의 className지정
    $(".default").css("display","none");										// class가 default인 태그 CSS지정
    $(".scrolled").css("display","block");										// class가 scrolled인 태그 css지정
});
si();											// si메소드 호출

/* (시/도) select 태그 */
function si(){								
	var xhr1 = new XMLHttpRequest();			// XML (시/도) 객체 생성
	var xhr2 = new XMLHttpRequest();			// XML (군/구) 객체 생성
	var url1 = './location/location1.txt';		// (시/도) 텍스트 파일 url1로 지정
	var url2 = './location/location2.txt';		// (군/구) 텍스트 파일 url2로 지정
	xhr1.open('get', url1);						// get방식으로 url1 열기
	xhr1.send();								// xhr1을 서버에 전송
	xhr2.open('get', url2);						// get방식으로 url2 열기
	xhr2.send();								// xhr2를 서버에 전송
	   
	xhr1.onreadystatechange = function(){								
		if(xhr1.status == 200 && xhr1.readyState==4){					// 응답과 처리준비가 정상적이면
	    	var rs1 = document.getElementById("result1");				// Id값이 result인 태그를 rs1로 지정
	        var temp1 = xhr1.responseText;								// 응답을 text로 temp1에 입력
	        var data1 = JSON.parse(temp1);								// temp1을 JSON으로 파싱해서 data1에 저장
	        var str1 = "";												// (시/도) select 태그 만들기
	            str1 += "<select class= 'selectpicker form-control' "+
	            		" name  = 'raddress1' id = 'raddress1' " + 
	            		" onchange = 'gu()'>";
	            str1 += "<option value = ''>전체</option>"
	            
	        for(var i=0; i<data1[0].location1.length; i++){				// (시/도) 갯수만큼
	        	str1 += "<option >" +data1[0].location1[i]+ "</option>";
	        }
	            str1 += "</select>";
	            rs1.innerHTML = str1;
	    }
	}
	   
	   xhr2.onreadystatechange = function(){							
	      if(xhr2.status == 200 && xhr2.readyState==4){					// 서버로 부터 응답과 처리준비가 정상적이면
	         var rs2 = document.getElementById("result2");				// Id값이 result2인 태그를 rs2로 지정
	         var temp2 = xhr2.responseText;								// 응답을 text로 temp2에 입력
	         var data2 = JSON.parse(temp2);								// JSON 형식으로 변환
	         
	         var str2 =  "<select class= 'selectpicker form-control'"+	// (군/구) select태그 생성
	         			 " name  = 'raddress2' id = 'raddress2' >";
	         	 str2 += "<option value = ''>전체</option>";
	         	 str2 += "</select>";
	         rs2.innerHTML = str2;										// html형식으로 입력
	         
	   }
	si2();																// si2() 호출
	}
}

/* (군/구) select태그  */
function gu(){
	var add = document.getElementById("raddress1");			// Id값이 raddress1인태그를 add로 지정
	var index= add.selectedIndex-1;							// 선택전 '전체'옵션을 뺀 개수 (시/도 데이터의 원래 갯수)

	var xhr = new XMLHttpRequest();							// XML 객체 생성
	var url = './location/location2.txt';					// (군/구) 파일 불러옴
	xhr.open('get', url);									// get방식으로 파일 열기
    xhr.send();												// 서버에 전송

	xhr.onreadystatechange = function(){
		if(xhr.status == 200 && xhr.readyState==4){			// 서버 응답과 처리준비가 정상적이면
	    	var rs = document.getElementById("result2");	// rs 지정
	        var temp = xhr.responseText;					// 응답을 text로 저장
	        var data = JSON.parse(temp);					// JSON형식으로 변환
	        
	        
	        var str = "";												// select 태그 생성
	            str += "<select class= 'selectpicker form-control'"+
	            	   " name  = 'raddress2' >";
	               
	        if(index==-1){												// (시/도)를 선택안했으면
	        	str += "<option value = ''>전체</option>";
	        }else{														// 선택 했으면
	           	str += "<option value = ''>전체</option>";	
	        for(i=0; i<data[index].district.length; i++){				// (군/구) 옵션 생성
	            str += "<option >" +data[index].district[i]+ "</option>";
	            }
	        }
	        str += "</select>";
	        rs.innerHTML = str;											// html형식으로 입력
	    }
	    gu2();															// gu2() 메소드 호출
	}
}
	
   
   
   var frm = document.rest_list;
   frm.btnFind.onclick = function() {      	// 상단 검색 버튼 클릭시
      frm.action = "list.donghwan";
      frm.submit();
   }

   
   function insert(){      					// 맛집 등록하기 버튼 클릭시
      frm.action = "insert.donghwan";
      frm.submit();
   }
   
   function serialFunc(obj){
      frm.serial.value = obj.id;			// 음식점 목록 중 클릭시 상세보기 페이지로 serial 전송  			
      frm.action = "view.donghwan";
      frm.submit();
   }
   
   function submit(){
      frm.action = "list.donghwan";			// 정렬 변경 시에 목록 다시 가져오기
      frm.submit();
   }
   
   function movePage(nowPage){
      frm.nowPage.value = nowPage;			// 페이지 번호 변경 시에 목록 다시 가져오기
      frm.submit();
   }
   
   function si2(){
      frm.raddress1.value=frm.hiddenAdd1.value;		// 히든 값이 존재하면 불러오기
      gu();      
   }
   function gu2(){
      if(frm.hiddenAdd2.value!=""&& frm.raddress1.value==frm.hiddenAdd1.value){	// (시/도)의 히든값이 있으면
         frm.raddress2.value=frm.hiddenAdd2.value;								// (군/구)의 히든값 입력
      }
   }
</script>
</body>
</html>