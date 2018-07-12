<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.3/css/bootstrap-select.min.css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<link rel='stylesheet' type = 'text/css' href='index.css'/>
<title>맛집 등록</title>

	<style>
	/* 주소 입력 부분 */
	#input-group_address{				
	width: 100%;
	}
	
	.text_div{
	display: inline-block;
	width: 90.59%;
	}
	
	.button_div{
	display: inline-block;
	float: right;
	}
	
	</style>
	
</head>
<body>

<script>
function si(){										// 주소 (시/도)
	   var xhr1 = new XMLHttpRequest();				// xml 객체 생성	
	   var xhr2 = new XMLHttpRequest();				// xml 객체 생성
	   var url1 = './location/location1.txt';		// 주소(시/도)
	   var url2 = './location/location2.txt';		// 주소(군/구)
	   xhr1.open('get', url1);					// request method, 요구할 페이지의 URL, 비동기식으로 수행될 지 
	   xhr1.send();								// 전송
	   xhr2.open('get', url2);					// get방식으로 군/구 
	   xhr2.send();								// 전송
	   
	   xhr1.onreadystatechange = function(){				// (시/도)
	      if(xhr1.status == 200 && xhr1.readyState==4){		
	    	 // 요구한 상태값이 4와 200이면 서버로 부터 모든 응답을 받았고, 처리할 준비가 됌
	         var rs1 = document.getElementById("result1");	// ID가 result1인 태그를 rs1으로 지정
	         var temp1 = xhr1.responseText;					// 서버의 응답을 텍스트 문자열로 반환하여 temp1에 저장
	         var data1 = JSON.parse(temp1);					// temp1을 JSON 데이터로 파싱하여 data1에 저장
	         var str1 = "";									// str1 초기값 지정
	            str1 += "<select class= 'selectpicker form-control' name  = 'raddress1' id = 'raddress1' onchange = 'gu()'>";
	            // select 태그 생성 name, id, class 지정 클릭시 gu() 메소드 호출
	            str1 += "<option value = ''>전체</option>"
	            // select 태그 옵션 중 제일 위에 전체 옵션 생성
	         for(var i=0; i<data1[0].location1.length; i++){				// JSON으로 파싱한 시/도 데이터 갯수 만큼 반복
	            str1 += "<option >" +data1[0].location1[i]+ "</option>";	// select태그 옵션으로 생성
	         }
	            str1 += "</select>";										// select태그 닫기
	            rs1.innerHTML = str1;										// rs1에 HTML로 입력
	      }
	   }
	   
	   xhr2.onreadystatechange = function(){					// (군/구)
	      if(xhr2.status == 200 && xhr2.readyState==4){			// 정상적인 응답과 준비가 되면
	         var rs2 = document.getElementById("result2");		// id값이 result2인 태그를 rs2로 지정
	         var temp2 = xhr2.responseText;						// 서버의 응답을 텍스트 문자열로 반환하여 temp2에 저장
	         var data2 = JSON.parse(temp2);						// temp2를 JSON 데이터로 파싱하여 data2에 저장
	         
	         var str2 = "<select class= 'selectpicker form-control' name  = 'raddress2' id = 'raddress2'>";
	         	 // name,id,class 지정한 select 태그 생성 텍스트를 str2에 저장
	         	 str2 += "<option value = ''>전체</option>";
	         	 // 첫 번째 옵션으로 '전체'를 생성
	         	 str2 += "</select>";
	         	 // 셀렉트 태그 닫기
	         rs2.innerHTML = str2;		// str2에 있는 텍스트를 rs2에 HTML로 입력
	         
	      }
	   si2();							// si2() 메소드 호출 
	   }
	}

	/* json으로 구 목록 나타내기 */
	   function gu(){										// (시/도) select태그 클릭시 호출 됨
	      var add = document.getElementById("raddress1");	// id값이 raddress1인 태그를 add로 지정
	      var index= add.selectedIndex-1;					// (시/도)의 옵션 갯수에서 한개를 뺀 값 ( 전체 옵션이 추가 되었기 때문에 -1 )
															// 선택한 시/도의 군/구가 나와야하기 때문에 몇번째 데이터인지 맞춰주어야함
	      var xhr = new XMLHttpRequest();					
	      var url = './location/location2.txt';				// (군/구) 텍스트를 url로 지정
	      xhr.open('get', url);								// get방식으로 url을 열어줌
	      xhr.send();										// 서버로 보냄

	      xhr.onreadystatechange = function(){				
	         if(xhr.status == 200 && xhr.readyState==4){	// 정상적인 응답과 준비가 되면
	            var rs = document.getElementById("result2");// id값이 result2인 태그를 rs로 지정
	            var temp = xhr.responseText;				// 서버의 응답을 텍스트 문자열로 temp에 저장
	            var data = JSON.parse(temp);				// temp를 JSON 형식으로 파싱해서 data에 저장
	            
	            var str = "";									// str값 초기화
	               str += "<select class= 'selectpicker form-control' name  = 'raddress2' id ='raddress2'>";
	               // select 태그 생성 및 name, class, id값 지정을 텍스트로 str에 저장
	            if(index==-1){									// (시/도)를 선택 안했으면
	               str += "<option value = ''>전체</option>";		// 옵션 '전체'를 생성하는 텍스트를 str에 저장
	            }else{											// (시/도)를 선택 했으면
	               str += "<option value = ''>전체</option>";		// 옵션 '전체'를 생성하는 텍스트를 str에 저장
	            for(i=0; i<data[index].district.length; i++){	// 데이터의 원래 크기만큼 반복
	               str += "<option >" +data[index].district[i]+ "</option>";	// (군/구) 옵션 생성
	                  }
	            }
	               str += "</select>";											// select태그 끝
	            rs.innerHTML = str;												// rs에 HTML로 입력
	         }
	         gu2();																// gu2() 메소드 호출
	      }
	   }
	
</script>

<%
	if(session.getAttribute("sId") != null){					// session 에 sid 값이 존재하면
		String sId = (String)session.getAttribute("sId");		// sId 에 저장
	}
%>
<br>
<br>
<br>
<br>
<br>

<div class='container'>

 <div id="insert_rest">								
  <form name='rest_insert' id='rest_insert' method='post' 
			enctype="multipart/form-data" >
  
  <!-- 작성자와 음식점 이름 입력 칸 -->
   <div id='a' style="text-align: center;" >
	<label>작성자 : </label>
	<input type='text' name='mid' value='${sId }' readonly/>
	<label>음식점 이름 : </label>
	<input type='text' name='rname' required size='50' placeholder="가게이름을 적어주세요"/><br/>
   </div>
   <p/>

   <!-- 입력페이지 중앙 부분  -->
   <div id='center'>
   
   <!-- 사진 첨부 부분 -->
    <div id="rphoto" >
     <div class="container-fluid">
      <div class="row content">
       <div class="col-lg-12">

	   <hr>
	   <h3 class="text-center">음식점 사진</h3>
	   <p class="text-center"><em>첫 번째 사진은 메인 사진입니다.</em></p>
	   <hr>
	   <p/>
		
		<!-- 사진 슬라이드 부분 -->
        <div id="myCarousel" class="carousel slide" data-interval="0">
        <ol class="carousel-indicators">
         <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
         <li data-target="#myCarousel" data-slide-to="1"></li>
         <li data-target="#myCarousel" data-slide-to="2"></li>
         <li data-target="#myCarousel" data-slide-to="3"></li>
         <li data-target="#myCarousel" data-slide-to="4"></li>
         <li data-target="#myCarousel" data-slide-to="5"></li>
        </ol>
 
        <!-- 메인사진 --> 
        <div class="carousel-inner" role="listbox">
         <div class="item active">
         <div class = "file_input" style = "width:100%; overflow: hidden;">
          <label class = "accommodation_img" style = "width:100%;"> 
          <img class="w3-image" src="./restaurant/main_upload.png" alt="메인사진" style="width:100%; height:100%; overflow:hidden">
          <input type="file" name = "rphoto_main" onchange="readURLM(this)" class = 'file_check'>
          </label>
         </div>
         </div>
 
 		<!-- 서브 사진 1 -->  
        <div class="item">
         <div class = "file_input">
         <label class = "accommodation_img" style = "width:100%"> 
         <img class="w3-image" src="./restaurant/main_upload.png" alt="서브사진1" style="width:100%; height:100%; overflow:hidden">
         <input type="file" name = "rphoto_sub1" onchange="readURLM(this)">
         </label>
         </div>
        </div>
 		
 		<!-- 서브 사진 2 -->      
        <div class="item">
         <div class = "file_input">
         <label class = "accommodation_img" style = "width:100%"> 
         <img class="w3-image" src="./restaurant/main_upload.png" alt="서브사진2" style="width:100%; height:100%; overflow:hidden">
         <input type="file" name = "rphoto_sub2" onchange="readURLM(this)">
         </label>
         </div>
        </div>
         
        <!-- 서브 사진 3 -->
        <div class="item">
         <div class = "file_input">
         <label class = "accommodation_img" style = "width:100%"> 
         <img class="w3-image" src="./restaurant/main_upload.png" alt="서브사진3" style="width:100%; height:100%; overflow:hidden">
         <input type="file" name = "rphoto_sub3" onchange="readURLM(this)">
         </label>
         </div>  
        </div>
        
        <!-- 서브 사진 4 --> 
        <div class="item">
         <div class = "file_input">
         <label class = "accommodation_img" style = "width:100%"> 
         <img class="w3-image" src="./restaurant/main_upload.png" alt="서브사진4" style="width:100%; height:100%; overflow:hidden">
         <input type="file" name = "rphoto_sub4" onchange="readURLM(this)">
         </label>
         </div>     
        </div>
        
        <!-- 서브 사진 5 --> 
        <div class="item">
         <div class = "file_input">
         <label class = "accommodation_img" style = "width:100%"> 
         <img class="w3-image" src="./restaurant/main_upload.png" alt="서브사진5" style="width:100%; height:100%; overflow:hidden">
         <input type="file" name = "rphoto_sub5" onchange="readURLM(this)">
         </label>
         </div>     
        </div>
         
       </div> 
   
       <!-- 사진 슬라이드 앞으로, 뒤로 넘기기 -->
       <a class="left carousel-control" href="#myCarousel" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" ></span>
        <span class="sr-only">Previous</span>
       </a>
       <a class="right carousel-control" href="#myCarousel" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
    </div>
   </div>
  </div> <!-- 사진 첨부 부분 끝 -->

  <!-- 메뉴, 가격 등 설정 부분 -->
  <div id='option'>
   <hr/>
   <div style='text-align: center; width:100%;'>
    <h3 class="text-center">메뉴 등록</h3>
    <input type='button' value='메뉴추가' name='addmenu' 
		style="float:right;" class="btn btn-primary"/>
   </div>
   <hr/>
   <br/>
    
   <div id='menu'>
	<div>
	 <!-- 메뉴 사진 첨부 부분 -->
	 <div style="float:left;">
	  <img src="./restaurant/menu_upload.jpg" 	width='200px' height='200px' 
	       class="rmAttFile0">
	 </div>
	 
	 <!-- 메뉴 이름 -->
	 <div class='input-group' > 
	  <span class='input-group-addon'>메뉴 이름</span>	
	  <input type='text' name='rmName' class='form-control' required >
	 </div>
	 
	 <!-- 메뉴 설명 -->	 	 		
	 <div class='input-group'> 
	  <span class='input-group-addon'>메뉴 설명</span>
	  <input type='text' name='rmExplain' class='form-control' required>
	 </div>
	 
	 <!-- 메뉴 가격 -->	
	 <div class='input-group'> 
	  <span class='input-group-addon'>메뉴 가격</span>
	  <input type='number' name='rmPrice' min='0' class='form-control'  required>
     </div>
	 <br/>
	 
	 <input type='button' name='btnDelete' value='삭제' 
			onclick='delFunc(this)' style="float:right;" class="btn btn-primary"/>
	 <br/>
	 <input type='file' name='rmAttFile0'
		    id="rmAttFile0"  onchange="menuLoadImg(this)">
	 <br/>
	 <br/>
	</div>
    </div>
   <br/> 
   </div>
  </div>  <!-- 메뉴 부분 끝 -->

 
  <div id='detail'> <!-- 음식점 상세 정보 -->
	
  <hr>
  <h3 class="text-center">상세 설명</h3>
  <p class="text-center"><em>자세히</em></p>
  <hr>
  <p/>
  
  <!-- 대표 메뉴 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon'  style="width:150px; text-align:center;">대표 메뉴들</span>
   <input class='form-control' type='text' name='rmenus'  required>
  </div>
  
  <!-- 음식점 간략 설명 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">음식점 간략 설명</span>
   <input class='form-control' type='text' name='rinfo'  required>
  </div>
  
  <!-- 음식점 오픈 시간 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">오픈시간</span>
   <input class='form-control' type='number' min="1" name='rtimeOpen' 
	 	placeholder="예)09 또는 9" required/>
  
  <!-- 음식점 마감 시간 --> 
   <span class='form-group input-group-addon' style="width:150px; text-align:center;">마감시간</span>
   <input class='form-control' type='number' min="1" name='rtimeClose'
	 	placeholder="예)24"  required/>
  </div> 
  
  <!-- 음식점 전체 테이블 수 -->	 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">전체 테이블 수</span>
   <input class='form-control' type='number' min="1" name='rtable' style="width:100%;  placeholder="테이블 1개 당 최대 인원 4명 기준" required/>
  </div>

  <!-- 음식점 휴일 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">휴일</span>
   <select name='rholiday' class="form-control" size='1' style="width:100%;" >
	<option>월</option>
	<option>화</option>
	<option>수</option>
	<option>목</option>
	<option>금</option>
	<option>토</option>
	<option>일</option>
	<option>없음</option>
   </select>
  </div>
  
  <!-- 음식점 화장실 정보 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">화장실</span>
   <input class='form-control' type='text' name='rbathroom' required/><br/>
  </div>

  <!-- 음식점 주류 판매 정보  -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">주류판매</span>
   <input class='form-control' type='text' name='rdrink'  required/><br/>
  </div> 

  <!-- 음식점 기타 시설 정보 -->		 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">기타시설</span>
   <input class='form-control' type='text' name='rfacilities' required/><br/>
  </div> 
	
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">대표전화</span>
   <input class='form-control' type='text' name='rphone' required/><br/>
  </div> 
  <p/>
  </div> <!-- 음식점 상세 정보 끝 -->

  <!-- 주소와 지도 입력 부분 -->
  <hr>
  <h3 class="text-center">주소 입력</h3>
  <p class="text-center"><em>지도</em></p>
  <hr>
 
  <!-- 시/도, 군/구 select 태그 생성하는 곳 -->
  <div id='insert_map'>
   <div id='find'>
    <div id = "result1"></div>
    <div id = "result2"></div>
   </div>
 	 
  <!-- 주소 입력 하는 부분 -->	 	 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12' id="input-group_address" >
   <span class='input-group-addon' style="width:150px; text-align:center;">나머지 주소</span>
   <div class="text_div">
	<input type='text' class='form-control' name='rjuso' id='rjuso' 
	 	   placeholder="(시/군/구를 제외한)전체 주소를 입력해주세요"  required/>
   </div>
   <div class="button_div">	 
	<input type='button' name='btnFindAd' value='주소 찾기' class="btn btn-primary" id="btnFindAd" />
   </div>	
  </div>
  <br/>
 
  <!-- 지도 생성하는 부분 -->	
  <div id='map' style="width:100%;height:400px;">
  </div>	
  </div>
  
  <!-- 입력 후 결과 메시지 출력하는 부분 -->
  <div id="show_msg" class="w3-modal w3-center w3-opacity" style = 'z-index: 100'>
   <div class="w3-modal-content w3-animate-top w3-card-4 w3-round-large w3-padding">
    <span
         onclick="document.getElementById('show_msg').style.display='none'"
         class="w3-button w3-hover-white w3-xxlarge w3-display-topright w3-round-large">×</span>
    <h4 class="w3-wide w3-padding" id='msg'>
    <i class="fa fa-exclamation-circle w3-margin-right"></i>
    </h4>
    <button type="button" onclick="okFunc()" name="ok" class="btn btn-default" data-dismiss="modal" style="text-align: center;">확인</button>
   </div>
  </div>
  <div style="height:100px">
  <p/>
  <p/>
  </div> <!-- 주소, 지도 부분 끝 -->

  <!-- 입력, 취소 버튼, 목록페이지 검색 값 저장 -->
  <div id='tail' style="text-align: center;">
   <p/>
   <input type='hidden' name='nowPage' value='${param.nowPage }'>
   <input type="hidden" name="hiddenAdd1" value="${param.raddress1 }">
   <input type="hidden" name="hiddenAdd2" value="${param.raddress2 }">
   <p/>
   <input type='button' name='btnInsert' value='등록' class="btn btn-primary"/>
   <input type='button' name='btnList' value='취소' class="btn btn-primary"/>
  </div>
  </form>	
 </div>
</div>



<!-- 주소 지도 api -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=uJlO5e3KXL6BKDiiZFmv&submodules=geocoder"></script>
<script> 
var frm = document.rest_insert;									// 입력페이지 폼을 frm으로 지정
frm.btnFindAd.onclick = function(){								// 주소 찾기 버튼 클릭시
	var raddress1 = document.getElementById("raddress1").value; // (시/도) select값
	var raddress2 = document.getElementById("raddress2").value; // (군/구) select값
	var rjuso = document.getElementById("rjuso").value;			// 나머지 주소 
	
	var juso = raddress1 + " " + raddress2 + " " + rjuso; 		// 전체 주소

	var map = new naver.maps.Map("map", {	
	    center: new naver.maps.LatLng(37.3595316, 127.1052133),
	    zoom: 10,
	    mapTypeControl: true
	});
	
	var infoWindow = new naver.maps.InfoWindow({
	    anchorSkew: true
	});
	
	map.setCursor('pointer');
	
	// search by tm128 coordinate
	function searchCoordinateToAddress(latlng) {
	    var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);
	
	    infoWindow.close();
	
	    naver.maps.Service.reverseGeocode({
	        location: tm128,
	        coordType: naver.maps.Service.CoordType.TM128
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }
	
	        var items = response.result.items,htmlAddresses = [];
	
	        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	            item = items[i];
	            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';
	
	            htmlAddresses.push((i+1) +'. '+ addrType +' '+ item.address);
	          /*   htmlAddresses.push('&nbsp&nbsp&nbsp -> '+ item.point.x +','+ item.point.y); */
				
	        }
	            var idx = items[0].address.indexOf(" ");		// 전체 주소 ex)서울시 은평구 불광동 248번지
				var a = items[0].address.substring(0, idx);		// 0번째 글자부터 공백이 있는곳 까지 자르기 ex) 은평구 불광동 248번지
				var b = items[0].address.substring(idx+1);		// 전체 주소에서 (시/도)만 자르기 ex)은평구 불광동 248번지
				var idx2 = b.indexOf(" ");						// idx2를 다음 공백이 나오기까지 글자 수로 지정 
				var c=b.substring(idx2+1);						// ex)은평구 불광동 248번지에서 은평구+공백까지 지움

	            document.getElementById("rjuso").value = c;		// (c=나머지주소)를 rjuso값에 저장 
	          
	
	        infoWindow.setContent([
	                '<div style="padding:10px;min-width:200px;line-height:150%;">',
	                /* '<h4 style="margin-top:5px;">검색 좌표 : '+ response.result.userquery +'</h4><br />', */
	                htmlAddresses.join('<br />'),
	                '</div>'
	            ].join('\n'));
	
	        infoWindow.open(map, latlng);
	        
		
	    });
	}
	
	// result by latlng coordinate
	function searchAddressToCoordinate(address) {
	    naver.maps.Service.geocode({
	        address: address
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }
	
	        var item = response.result.items[0],
	            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
	            point = new naver.maps.Point(item.point.x, item.point.y);
	
	        infoWindow.setContent([
	                '<div style="padding:10px;min-width:200px;line-height:150%;">',
	                '<h4 style="margin-top:5px;">검색 주소 : '+ response.result.userquery +'</h4><br />',
	                addrType +' '+ item.address +'<br />',
	                /* '&nbsp&nbsp&nbsp -> '+ point.x +','+ point.y, */
	                '</div>'
	            ].join('\n'));
	
	
	        map.setCenter(point);
	        infoWindow.open(map, point);
	    });
	}
	
	function initGeocoder() {
	    map.addListener('click', function(e) {
	        searchCoordinateToAddress(e.coord);
	    });
	
	    $('#address').on('keydown', function(e) {
	        var keyCode = e.which;
	
	        if (keyCode === 13) { // Enter Key
	            searchAddressToCoordinate($('#address').val());
	        }
	    });
	
	    $('#submit').on('click', function(e) {
	        e.preventDefault();
	
	        searchAddressToCoordinate($('#address').val());
	    });
	
	    searchAddressToCoordinate(juso);
	}
	
	naver.maps.onJSContentLoaded = initGeocoder();

}
</script> <!-- 네이버 지도 API 끝 -->



<script>

// CSS
$(document).ready(function(){								// body코드 이후에 호출되는 코드
	$('input').attr('autocomplete','off');				// 자동완성 기능 x
	var navbar = document.getElementById("myNavbar");	// navbar 지정
	var holder = document.getElementById("holder");		// holder 지정
	navbar.className = "w3-bar" + " w3-card" + " w3-animate-top" + " w3-white";	// class 설정
	holder.className = "nav-holder" + " w3-padding-large" + " nav_small";		// class 설정
	$(".default").css("display","none");				// 안보이기
	$(".scrolled").css("display","block");				// 보이기
	$("#nameTest").keypress(function (e) {				
		if (e.which == 13){
			nameTest();  // 실행할 이벤트
		}
	});
});

	
si(); 												// si() 메소드 호출 ( 주소 select 태그 생성 )
	
/* 메뉴 추가 버튼 클릭 시 */
var frm = document.rest_insert;						// form태그를 frm으로 지정
var cnt=1;											// 기본으로 메뉴가 한개(0부터 시작)가 만들어져있으므로 1로 지정
frm.addmenu.onclick = function(){					// *메뉴 추가 버튼 클릭시
	var menu = document.getElementById("menu");		// id가 menu인 태그를 menu로 지정
	var topdiv = document.createElement("div");		// (menu 바로 아래 자식 태그) div 생성
	var div = document.createElement("div");		// (topdiv 자식 태그) div 생성
	var img  = document.createElement("img");		// img태그 생성
	
	var div2 = document.createElement("div");		// 메뉴 이름 부분 태그들 생성
	var span2 = document.createElement("span");		
	var inputname = document.createElement("input");
		
	var div3 = document.createElement("div");		// 메뉴 설명 부분 태그들 생성
	var span3 = document.createElement("span");
	var inputex   = document.createElement("input");
		
	var div4 = document.createElement("div");		// 메뉴 가격 부분 태그들 생성
	var span4 = document.createElement("span");
	var inputprice= document.createElement("input");
		
	var inputdel  = document.createElement("input");// 메뉴 삭제 버튼 태그 생성
	var inputfile = document.createElement("input");// 메뉴 사진 태그 생성
		
	var br = document.createElement("br");			// 간격을 위한 br태그
	var br2 = document.createElement("br");
	var br3 = document.createElement("br");
	var br4 = document.createElement("br");
		
	/* 생성한 태그들 속성 및 위치 설정 */
	img.setAttribute("src", "./restaurant/menu_upload.jpg"); // img태그 사진 설정하기전 기본사진 설정	 
	img.setAttribute("width", "200px");						 // 넓이 200px	
	img.setAttribute("height", "200px");					 // 높이 200px
	img.setAttribute("class", "rmAttFile"+cnt);				 // 추가한 메뉴는 rmAttFile1부터 시작
	div.setAttribute("style", "float:left");				 // div 왼쪽에 배치
	div.appendChild(img);									 // img태그를 div자식태그로 지정
		
	span2.setAttribute("class", "input-group-addon");		 // class 지정
	span2.innerHTML = "메뉴 이름";								 // span태그에 텍스트 "메뉴 이름" 기록 
	inputname.setAttribute("type", "text");					 // input태그 text 타입으로 지정
	inputname.setAttribute("name", "rmName");				 // 태그 이름 설정
	inputname.setAttribute("class", "form-control");		 // class 지정
	inputname.setAttribute("required", "");					 // 빈칸일 경우 메시지 출력되는 속성

	div2.setAttribute("class", "input-group");				 // 메뉴 이름 div 태그 속성 설정 
	div2.appendChild(span2);
	div2.appendChild(inputname);
		
		
	span3.setAttribute("class", "input-group-addon");		// 메뉴 설명 input태그, span태그 속성 설정
	span3.innerHTML = "메뉴 설명";
	inputex.setAttribute("type", "text");
	inputex.setAttribute("name", "rmExplain");
	inputex.setAttribute("class", "form-control");
	inputex.setAttribute("required", "");
		
	div3.setAttribute("class", "input-group");				// 메뉴 설명 div 태그 속성 설정
	div3.appendChild(span3);
	div3.appendChild(inputex);
		
	span4.setAttribute("class", "input-group-addon");		// 메뉴 가격 span태그, input태그 속성 설정
	span4.innerHTML = "메뉴 가격";
	inputprice.setAttribute("type", "number");
	inputprice.setAttribute("name", "rmPrice");
	inputprice.setAttribute("class", "form-control");
	inputprice.setAttribute("required", "");
	inputprice.setAttribute("min", "0");
	
	div4.setAttribute("class", "input-group");				// 메뉴 가격 div 태그 설정
	div4.appendChild(span4);
	div4.appendChild(inputprice);
		
	inputdel.setAttribute("type", "button");				// 메뉴 삭제 버튼 속성 설정
	inputdel.setAttribute("name", "btnDelete");
	inputdel.setAttribute("value", "삭제");
	inputdel.setAttribute("onclick", "delFunc(this)");
	inputdel.setAttribute("style", "float:right");
	inputdel.setAttribute("class", "btn btn-primary");
	
	
	inputfile.setAttribute("type", "file");					// 메뉴 사진 첨부 input 태그 속성 설정
	inputfile.setAttribute("name", "rmAttFile"+cnt);
	inputfile.setAttribute("id", "rmAttFile"+cnt);
	inputfile.setAttribute("onchange", "menuLoadImg(this)");
	
	topdiv.appendChild(div);								// topdiv에 메뉴 관련 태그들 자식 부모 설정
	topdiv.appendChild(div2);
	topdiv.appendChild(div3);
	topdiv.appendChild(div4);
	topdiv.appendChild(br4);
	topdiv.appendChild(inputdel);
	topdiv.appendChild(br);
	topdiv.appendChild(inputfile);
	topdiv.appendChild(br2);
	topdiv.appendChild(br3);
	
	menu.appendChild(topdiv);								// topdiv를 menu의 자식으로 설정
	
	cnt++;													// cnt 1 증가
	
}
	
/* 음식점 저장 버튼 클릭 시 예외처리 */
frm.btnInsert.onclick = function(){									// 글 등록 버튼 누를시 (예외처리)
	if(frm.rname.value == ""){
		$('#msg').text("음식점 상호명을 입력해주세요.");					
        document.getElementById('show_msg').style.display='block';
		return false;	        	
       
	}else if(!frm.rphoto_main.value){
		$('#msg').text("메인 사진을 반드시 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rmenus.value){
		$('#msg').text("대표 메뉴를 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rinfo.value){
		$('#msg').text("음식점 소개를 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rtimeOpen.value){
		$('#msg').text("오픈 시간을 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rtimeClose.value){
		$('#msg').text("마감 시간을 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rtable.value){
		$('#msg').text("전체 테이블 수를 입력해주세요.")
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rbathroom.value){
		$('#msg').text("화장실 내용을 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rdrink.value){
		$('#msg').text("주류판매 내용을 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rfacilities.value){
		$('#msg').text("기타시설 내용을 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rphone.value){
		$('#msg').text("대표전화를 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(!frm.rjuso.value){
		$('#msg').text("나머지 주소를 입력해주세요.");
		document.getElementById('show_msg').style.display='block';
		return false;
	}else if(cnt==1){					// 메뉴가 1개이면
		if(!frm.rmName.value){	
			$('#msg').text("메뉴 항목을 확인해주세요.1");
			document.getElementById('show_msg').style.display='block';
			return false;
		}else if(!frm.rmExplain.value){
			$('#msg').text("메뉴 항목을 확인해주세요.2");
			document.getElementById('show_msg').style.display='block';
			return false;
		}else if(!frm.rmPrice.value){
			$('#msg').text("메뉴 항목을 확인해주세요.3");
			document.getElementById('show_msg').style.display='block';
			return false;
		}else{
			$('#msg').text("맛집이 정상적으로 등록 되었습니다.");
			document.getElementById('show_msg').style.display='block';
		}
	}else if(cnt!=1){				// 메뉴가 1개가 아니면
		for(i=0;i<cnt;i++){			// 메뉴 갯수 만큼
			if(!frm.rmName[i].value){	
				$('#msg').text("메뉴 항목을 확인해주세요.1");
				document.getElementById('show_msg').style.display='block';
				return false;
			}else if(!frm.rmExplain[i].value){
				$('#msg').text("메뉴 항목을 확인해주세요.2");
				document.getElementById('show_msg').style.display='block';
				return false;
			}else if(!frm.rmPrice[i].value){
				$('#msg').text("메뉴 항목을 확인해주세요.3");
				document.getElementById('show_msg').style.display='block';
			return false;
			}
		}
		$('#msg').text("맛집이 정상적으로 등록 되었습니다.");
		document.getElementById('show_msg').style.display='block';		// 메시지 창 다시 보이기
	}
}
	
function okFunc(){													// 입력 후 확인 결과 메시지와 동시에 호출
	if($('#msg').text() =="맛집이 정상적으로 등록 되었습니다."){				// DB에 정상적으로 입력되면
		frm.action = "insertR.donghwan";							// 목록페이지로 이동
		frm.submit();										
	}else{															// 비정상이면
		document.getElementById('show_msg').style.display='none';	// 결과 메시지를 안보이게함	
	}
}
	
frm.btnList.onclick = function(){		// 글 취소 버튼 누를시
	frm.action = "list.donghwan";
	frm.submit();
}
	
function delFunc(obj){								// 메뉴 삭제 버튼 클릭시
	if(cnt==1){										// 메뉴가 1개 일때
		$('#msg').text("메뉴는 한 개 이상이여야 합니다.");	// 메시지 텍스트 설정
		document.getElementById('show_msg').style.display='block'; // 메시지 출력 			
	}else{											// 메뉴가 1개가 아닐때
		var menu = document.getElementById("menu");	// id값이 menu인 태그를 menu로 지정
		var parent = obj.parentNode;				// 버튼의 부모태그 = 메뉴 가격,설명,이름을 감싼 div태그
		var granpar = parent.parentNode;			// 그 div를 감싼 id값이 menu인 div 
		
		granpar.removeChild(parent);				// 선택한 버튼의 메뉴 자식들(가격,설명,이름)을 삭제
		cnt--;										// cnt 1 감소
	}
}
	
function readURLM(input) {								// 음식점 사진을 첨부하면 실행되는 메소드  		
    if (input.files && input.files[0]) {				// 첨부한 사진이 1개 이상이면
    var reader = new FileReader();						// FileReader 객체 생성
    var sibling = input.previousSibling.previousSibling;// 이전의 이전 형제노드를 sibling으로 지정
    console.log(sibling.outerHTML);						// sibling의 태그 요소 까지 포함해서 console에 출력
    reader.onload = function (e) {						
    	$(sibling).attr('src', e.target.result);		// input태그에 첨부한 파일을 img태그의 src로 입력	
    }
	reader.readAsDataURL(input.files[0]);				// 첨부한 사진 url 방식으로 읽기
	}
}
	
function menuLoadImg(value){								// 메뉴사진 추가시
	var targetId = value.id;								// 해당 input태그의 id = rmAttFile(i) 
	if(value.files && value.files[0]){						// 사진이 존재하면
		var reader = new FileReader();						// FileReader 생성
		reader.onload = function (e) {						
			$("."+targetId).attr('src', e.target.result);	// 메뉴 사진 img태그의 src에 파일 이름을 입력 
		}
		reader.readAsDataURL(value.files[0]);				// 파일을 url방식으로 읽어서 불러옴 (미리보기)
	}
}
	
function si2(){								// (시/도)를 선택한 후 실행되는 메소드 			
	frm.raddress1.value=frm.hiddenAdd1.value;	// 목록페이지에서 선택했던 (시/도)값이 있으면 불러오기
	gu();										// 그리고 해당 시/도의 군/구 불러오기
}
	
function gu2(){									// (군/구)를 선택한 후 실행되는 메소드
	if(frm.hiddenAdd2.value!=""&& frm.raddress1.value==frm.hiddenAdd1.value){
		// 선택한 (군/구) 값이 ""이고, (시/도) 선택 값이 목록페이지에서 선택한 (시/도)값과 같은 상태가 아니라면
		frm.raddress2.value=frm.hiddenAdd2.value;
		// (군/구)값에 목록페이지에서 선택한 (군/구)값을 입력
	}
}
	
</script>

</body>
</html>