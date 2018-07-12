<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<title>맛집 수정(+삭제)</title>

</head>
<body>


<script>

/* (시/도) select 태그 */
function si(){									// (시/도)

	var xhr1 = new XMLHttpRequest();			// (시/도) xml 객체 생성
	var xhr2 = new XMLHttpRequest();			// (군/구) xml 객체 생성
	var url1 = './location/location1.txt';		// (시/도) 텍스트 파일 불러오기
	var url2 = './location/location2.txt';		// (군/구) 텍스트 파일 불러오기
	xhr1.open('get', url1);						// xhr1 에서 열기
	xhr1.send();								// 서버에 전송
	xhr2.open('get', url2);						// xhr2 에서 열기			
	xhr2.send();								// 서버에 전송

	xhr1.onreadystatechange = function() {
		if (xhr1.status == 200 && xhr1.readyState == 4) {		// 서버로 부터 응답과 처리 준비가 정상적이면
			var rs1 = document.getElementById("result1");		// 태그 rs1 지정
			var temp1 = xhr1.responseText;						// 응답을 텍스트로 temp1에 입력
			var data1 = JSON.parse(temp1);						// temp1을 JSON으로 변환
			var str1 = "";										// (시/도) select 태그 생성
				str1 += "<select class= 'selectpicker form-control' name  = 'raddress1' id = 'raddress1' onchange = 'gu()'>";
				str1 += "<option value = ''>전체</option>"
				
			for (var i = 0; i < data1[0].location1.length; i++) {			// (시/도) 갯수만큼
				str1 += "<option >" + data1[0].location1[i] + "</option>";	// 옵션 생성
			}
			str1 += "</select>";
			rs1.innerHTML = str1;											// html형식으로 rs1에 입력
		}
	}

	xhr2.onreadystatechange = function() {
		if (xhr2.status == 200 && xhr2.readyState == 4) {			
			var rs2 = document.getElementById("result2");		// rs2 지정
			var temp2 = xhr2.responseText;						// 응답 temp2에 저장
			var data2 = JSON.parse(temp2);						// json으로 변환
															
			var str2 = "<select class= 'selectpicker form-control' name  = 'raddress2' id = 'raddress2'>";
				str2 += "<option value = ''>전체</option>";		// (군/구) select 태그 생성
				str2 += "</select>";
			rs2.innerHTML = str2;								// html형식으로 rs2에 입력
		}
		si2();													// si2() 메소드 호출
	}
}

/* (군/구) select 태그 */
function gu() {
	var add = document.getElementById("raddress1");			// id값이 raddress1인 태그 지정
	var index = add.selectedIndex-1;						// '전체'옵션 뺀 갯수

	var xhr = new XMLHttpRequest();							// xml 객체 생성
	var url = './location/location2.txt';					// (군/구) 텍스트 파일 불러오기
	xhr.open('get', url);									// get방식으로 파일 열기
	xhr.send();												// 서버에 전송

	xhr.onreadystatechange = function() {
		if (xhr.status == 200 && xhr.readyState == 4) {		// 서버로부터 응답과 처리준비가 정상적이면
			var rs = document.getElementById("result2");	// rs2 태그 지정
			var temp = xhr.responseText;					// 응답을 텍스트로 temp에 저장
			var data = JSON.parse(temp);					// JSON형식으로 변환

			var str = "";									// (군/구) select 태그 생성
			str += "<select class= 'selectpicker form-control' name  = 'raddress2' id='raddress2'>";
				
				
			if(index==-1){									// (시/도를 선택안했으면)
	            str += "<option value = ''>전체</option>";	// '전체' 옵션만 생성
	        }else{
	        	str += "<option value = ''>전체</option>";	// (시/도를 선택했으면)
				for (i = 0; i < data[index].district.length; i++) {		// (군/구) 갯수만큼 옵션 생성
					str += "<option >" + data[index].district[i] + "</option>";
				}
	        }
			str += "</select>";
			rs.innerHTML = str;								// rs2에 HTML형식으로 입력
		}
		gu2();												// gu2() 메소드 실행
	}
}
function select(holiday) {									// 휴일 정보 불러오기
	var frm = document.rest_modify;
	frm.rholiday.value = holiday;
}
</script>


<div class='container'>	
 <!-- form 태그 생성 -->
 <form name='rest_modify' id='rest_modify' method = "post" 
	   enctype="multipart/form-data">
 	
  <!-- 히든 값  -->	
  <input type='hidden' name='serial' 	value='${param.serial }'>
  <input type='hidden' name='rhit' 	value='${rvo.rhit }'>
  <input type="hidden" name="hiddenAdd1" value="${rvo.raddress1 }">
  <input type="hidden" name="hiddenAdd2" value="${rvo.raddress2 }">
  <p/> 
  
  <!-- 작성자, 음식점 이름 상단 부분 -->	
  <div id='a' style="text-align: center;">
   <label>작성자 : </label>
   <input type='text' name='mid' value='${rvo.mid }' readonly/>
   <label>음식점 이름 : </label>
   <input type='text' name='rname' size='50' 
 		  placeholder="가게이름" value='${rvo.rname }' required/><br/>
  </div>
  <p/>
 
  <div id='center'>
  
  <!-- 음식점 사진 부분 -->
   <div id='rphoto'>
 	<div class="container-fluid">
 	 <div class="row content">
 	  <div class="col-lg-12">
 	  <hr>
	  <h3 class="text-center">음식점 사진</h3>
	  <p class="text-center"><em>첫 번째 사진은 메인 사진입니다.</em></p>
	  <hr>
	  <p/>
      
      <!-- 음식점 사진 첨부, 업로드 출력 되는 슬라이드 부분 -->
 	  <div id="myCarousel" class="carousel slide" data-interval="0">
       <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
        <li data-target="#myCarousel" data-slide-to="3"></li>
        <li data-target="#myCarousel" data-slide-to="4"></li>
        <li data-target="#myCarousel" data-slide-to="5"></li>
       </ol>
       
 	   <!-- 음식점 메인 사진 부분 -->
       <div class="carousel-inner" role="listbox">
        <div class="item active">
 		 <div class = "file_input" style = "width:100%; overflow: hidden;">
 		  <label class = "accommodation_img" style = "width:100%;">
 		  <c:forEach var='main' items='${rphotoList}'>
	 	   <img class="w3-image" src="./restaurant/download/${main}"  
	 			alt="메인사진" style="width:100%; height:100%; overflow:hidden" >
		   <input type="file" name='rphoto_main' 
				  onchange="mainLoadImg(this)">
	 	  </c:forEach>
 		  </label>
 		 </div>
 		</div>
 		
 		<!-- 음식점 서브사진 1~4 -->	
 		<c:set var="c" value="1"></c:set>		
 		<c:forEach var='sub' items='${rphotoList2 }'>
		 <div class="item">
		  <div class = "file_input">
		   <label class = "accommodation_img" style = "width:100%"> 
	 	    <img class="w3-image" src="./restaurant/download/${sub }" 
	 			 alt="서브사진2" style="width:100%; height:100%; overflow:hidden" id="rphoto_sub${c }">  				
			<input type="file" name='rphoto_sub${c }'
				   onchange="readURLM(this)">
			</label>
 		  </div>
 		 </div>		
 		 <c:set var="c" value="${c+1 }"></c:set>
 	    </c:forEach>
 		
 		<!-- 음식점 서브 사진 5~8 -->
 		<c:forEach begin="${c }" end="5" >
 		 <div class="item">
 		  <div class = "file_input">
 		   <label class = "accommodation_img" style = "width:100%">
 		    <img class="w3-image" 
 			     src="./restaurant/main_upload.png" alt="서브사진3" style="width:100%; height:100%; overflow:hidden" id="rphoto_sub${c }"> 
		    <input type="file" name='rphoto_sub${c }'
				   onchange="readURLM(this)">
		   </label>
		  </div>
		 </div>
		 <c:set var="c" value="${c+1 }"></c:set>
 		</c:forEach>
 	   </div> 

	   <!-- 슬라이드 왼쪽으로, 오른쪽으로 부분 -->
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
  </div> <!-- 음식점 사진 부분 끝 -->

  <!-- 메뉴 설정 부분 -->
  <div id='option'> 	
  <hr/>
  
  <!-- 메뉴 추가 버튼 부분 -->
  <div style='text-align: center; width:100%;'>
   <h3 class="text-center">메뉴 등록</h3>
   <input type='button' value='메뉴추가' name='addmenu' 
		  style="float:right;" class="btn btn-primary"/>
  </div>
  <hr/>
  <br/>
  
  	 
  <c:set var="cnt" value="0"></c:set>
  <div id='menu'>
   <c:forEach var="rmvo" items='${menuList }'>
   <div>
   
   <!-- 메뉴 사진 부분 --> 	 
   <div style="float:left;">
	<img src="./restaurant/download/${menuPhotoList[cnt] }" 
		 width='200px' height='200px' 
		 class="rmAttFile${cnt }">
   </div>
   
   <!-- 메뉴 이름 부분  -->			
   <div class='input-group'>
	<span class='input-group-addon'>메뉴 이름</span>
	<input type='text' name='rmName' class='form-control'	 
	 	   value='${rmvo.rmName }' required>
   </div>
   
   <!-- 메뉴 설명 부분 -->	 			
   <div class='input-group'>
	<span class='input-group-addon'>메뉴 설명</span>
	<input type='text' name='rmExplain'
	 	   value='${rmvo.rmExplain }' class='form-control' required>
   </div>
   
   <!-- 메뉴 가격 부분  -->	 			
   <div class='input-group'>
	<span class='input-group-addon'>메뉴 가격</span>
	<input type='number' name='rmPrice' min='0' class='form-control'
	 	   value='${rmvo.rmPrice }' size='10' required>
   </div>	
   <br/>	
   
   <!-- 메뉴 삭제 버튼 부분 -->
   <input type='button' name='btnDelete' 
	 	  value='삭제' onclick='delFunc(this)' style="float:right;" class="btn btn-primary"/>
   <br/>
   
   <!-- 파일 첨부 버튼 부분 -->
   <input type='file' name='rmAttFile${cnt }' 
	 	  id="rmAttFile${cnt }"  onchange="menuLoadImg(this)">
   <br/>
   <br/>
   <c:set var="cnt" value="${cnt+1 }"></c:set>
   </div>
   </c:forEach>
   <input type='hidden' name='menuCount' id="menuCount"value="${cnt }">  
  </div>
  <br/> 
  </div>
  </div> <!-- 메뉴 부분 끝 -->

 <!-- 음식점 상세 정보 부분 -->
 <div id='detail'>
 
 <hr>
 <h3 class="text-center">상세 설명</h3>
 <p class="text-center"><em>자세히</em></p>
 <hr>
 <p/>
 
  <!-- 음식점 대표 메뉴 -->	
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12' >
   <span class='input-group-addon'  style="width:150px; text-align:center;">대표 메뉴들</span>
   <input class='form-control' type='text' name='rmenus' value='${rvo.rmenus }' required>
  </div>

  <!-- 음식점 간략 설명 -->	 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon'  style="width:150px; text-align:center;">음식점 간략 설명</span>
   <input class='form-control' type='text' name='rinfo' value='${rvo.rinfo }' required>
  </div>
  
  <!-- 음식점 오픈, 마감 시간 -->	
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">오픈시간</span>
   <input class='form-control' type='number' min="0" name='rtimeOpen' value='${rvo.rtimeOpen }'
   	 	  placeholder="예)09 또는 9" required/>
   <span class='input-group-addon' style="width:150px; text-align:center;">마감시간</span>	 
   <input class='form-control' type='number' min="1" name='rtimeClose' value='${rvo.rtimeClose }' 
	   	  placeholder="예)24"  required/>
  </div>
  
  <!-- 음식점 전체 테이블 수 -->	 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">전체 테이블 수</span>
   <input class='form-control' type='number' min="1" name='rtable' value='${rvo.rtable }'
 	  	  placeholder="테이블 1개 당 최대 인원 4명 기준" required/>
  </div>
  
  <!-- 음식점 휴일 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
   <span class='input-group-addon' style="width:150px; text-align:center;">휴일</span>
   <select name='rholiday' class="form-control" size='1' >
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
   <input class='form-control' type='text' name='rbathroom'  value='${rvo.rbathroom }' required/><br/>
  </div>
  
  <!-- 음식점 주류 판매 정보 -->	 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">주류판매</span>
   <input class='form-control' type='text' name='rdrink' value='${rvo.rdrink }' required/><br/>
  </div>
  
  <!-- 음식점 기타 시설 정보 -->	 
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">기타시설</span>
   <input class='form-control' type='text' name='rfacilities' value='${rvo.rfacilities }' required/><br/>
  </div>
  	
  <!-- 음식점 대표 전화 정보 -->
  <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12'> 
   <span class='input-group-addon' style="width:150px; text-align:center;">대표전화</span>
   <input class='form-control' type='text' name='rphone' value='${rvo.rphone }' required/><br/>
  </div> 
  <p/>	 
 </div>
 
 <!-- 음식점 정보 수정 처리 결과 메시지 부분 -->
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

 <!-- 음식점 주소와 지도 정보 부분 -->
 <hr>
 <h3 class="text-center">주소 입력</h3>
 <p class="text-center"><em>지도</em></p>
 <hr>
 
 <!-- 음식점 지도 부분 -->
 <div id='insert_map' class='form-group input-group col-ms-12 col-xs-12 col-lg-12'>
  <!-- (시/도),(군/구) select 태그 생성되는 부분 -->
  <div id='find'>
   <div id = "result1"></div>
   <div id = "result2"></div>
  </div>
 
 <!-- 음식점 주소 입력 부분 -->	
 <div class='form-group input-group col-ms-12 col-xs-12 col-lg-12' > 	 	
  <span class='input-group-addon' style="width:150px; text-align:center;">나머지 주소</span>
  <input type='text' class='form-control' name='rjuso' id='rjuso' value='${rvo.rjuso }'
 		 placeholder="(시/군/구를 제외한)전체 주소를 입력해주세요"  required/>
  <input type='button' name='btnFindAd' value='주소 찾기' class="btn btn-primary" style="float:right;" />
 </div>
 <br/>
 
 <!-- 음식점 지도 출력되는 부분 -->
 <div id='map' style="width:100%;height:400px;">
 </div>
 </div>	
 
 <!-- 간격 조절 -->
 <div style="height:100px">	
 </div>
 
 <!-- 하단 저장,취소 버튼 부분  -->
 <div id='tail' style="text-align: center;">
  <p/>
  <p/>
  <input type='button' name='btnModify' value='저장' class="btn btn-primary"/>
  <input type='button' name='btnView' value='취소' class="btn btn-primary"/>	 
 </div> 
</form>		
</div>



<!-- 주소 지도 api 불러오기-->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=uJlO5e3KXL6BKDiiZFmv&submodules=geocoder"></script>
<script> 
si();									// (시/도) select태그 생성하는 메소드 호출
select("${rvo.rholiday}");				// db에있는 휴일정보를 가져와서 select 메소드 실행
 
// css 설정
window.onload=function(){										// body코드 출력 후 호출되는 코드
	$('input').attr('autocomplete','off');
	var navbar = document.getElementById("myNavbar");
	var holder = document.getElementById("holder");
	navbar.className = "w3-bar" + " w3-card" + " w3-animate-top" + " w3-white";
	holder.className = "nav-holder" + " w3-padding-large" + " nav_small";
	$(".default").css("display","none");
	$(".scrolled").css("display","block");
	rholiday_val = $('select.rholiday').attr('id');		// 요일 불러오는 제이쿼리
	$('select.rholiday option[value=' + rholiday_val + ']').attr('selected', 'selected');
	
	/* 네이버 지도 API */
	var frm = document.rest_modify;								// form 태그 지정
	var raddress1 = document.getElementById("raddress1").value;	// (시/도) 주소 값
	var raddress2 = document.getElementById("raddress2").value; // (군/구) 주소 값
	var rjuso = document.getElementById("rjuso").value;			// 나머지 주소 값
	var juso = raddress1 + " " + raddress2 + " " + rjuso;		// 전체 주소 값
	
	// 네이버 지도 소스 
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
	
	        var items = response.result.items,
	            htmlAddresses = [];
	
	        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	            item = items[i];
	            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';
	
	            htmlAddresses.push((i+1) +'. '+ addrType +' '+ item.address);
	          /*   htmlAddresses.push('&nbsp&nbsp&nbsp -> '+ item.point.x +','+ item.point.y); */
	        }
	
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

/* 음식점 메인 사진 등록하면 불러오는 메소드 */
function mainLoadImg(value){								// input태그를 매개변수로 가져옴
	if(value.files && value.files[0]){						// 파일이 존재하면
		var reader = new FileReader();						// 파일리더 생성
		reader.onload = function (e) {						// 파일리더가 실행되면
			$('#rphoto_main').attr('src', e.target.result);	// input태그의 파일이름을 받아서 메인사진 img태그 src에 입력
		}
		reader.readAsDataURL(value.files[0]);				// 등록시 바로 사진 보여주기(미리보기)
	}
}

/* 음식점 서브 사진 등록하면 불러오는 메소드 */
function subLoadImg(value){									// input태그를 매개변수로							
	var targetId = value.name;								// 태그의 이름을 저장
	if(value.files && value.files[0]){						// 파일이 있으면
		var reader = new FileReader();
		reader.onload = function (e) {
			$("#"+targetId).attr('src', e.target.result);	// 서브사진 img태그 src에 파일이름 입력
		}
		reader.readAsDataURL(value.files[0]);				// 등록시에 바로 사진 보여주기
	}
}

/* 음식점 메뉴 사진 등록하면 불러오는 메소드 */
function menuLoadImg(value){								// input태그를 매개변수로
	var targetId = value.id;								// 태그의 id를 저장
	if(value.files && value.files[0]){						
		var reader = new FileReader();
		reader.onload = function (e) {
			$("."+targetId).attr('src', e.target.result);	// 해당 클래스를 가진 태그(메뉴사진img태그)에 입력
		}
		reader.readAsDataURL(value.files[0]);				// 등록 시에 바로 사진 보여주기
	}
}
</script>	



<!-- 주소 지도 api 재 등록시  -->
<script> 
var frm = document.rest_modify;									// form태그 frm으로 지정
frm.btnFindAd.onclick = function(){								// 주소 찾기 버튼 클릭시
	var raddress1 = document.getElementById("raddress1").value; // (시/도) 주소 값
	var raddress2 = document.getElementById("raddress2").value; // (군/구) 주소 값
	var rjuso = document.getElementById("rjuso").value;			// 나머지 주소
	var juso = raddress1 + " " + raddress2 + " " + rjuso;		// 전체 주소

	// 네이버 지도 API 소스
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
	
	        var items = response.result.items,
	            htmlAddresses = [];
	
	        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	            item = items[i];
	            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';
	
	            htmlAddresses.push((i+1) +'. '+ addrType +' '+ item.address);
	          /*   htmlAddresses.push('&nbsp&nbsp&nbsp -> '+ item.point.x +','+ item.point.y); */
	        }
	        
	        var idx = items[0].address.indexOf(" ");	// 주소의 첫번째 ""가 나오는 글자 번째를 idx로 저장
			var a = items[0].address.substring(0, idx); // 전체 주소에서 처음글자부터 idx번째까지 글자를 잘라서 a에 저장
			var b = items[0].address.substring(idx+1);  // (시/도)공백까지 같이 자르기
			var idx2 = b.indexOf(" ");					// (군/구)뒤의 공백까지 글자수를 idx2로 지정
			var c=b.substring(idx2+1);					// idx2 글자수만큼 (군/구) 공백도 같이 자르기 
            document.getElementById("rjuso").value = c; // 나머지 주소 값에 c입력
	        
	
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
	var frm = document.rest_modify;									// form 태그 frm으로 지정
	var menuCount = document.getElementById("menuCount").value;		// 메뉴 갯수 값 가져오기
	var cnt = menuCount;											// cnt로 지정
	
	frm.addmenu.onclick = function(){					// 메뉴 추가 버튼 클릭시
		var menu = document.getElementById("menu");		// 메뉴 부분 최상위 바로 아래 태그
		var topdiv = document.createElement("div");		// menu태그의 자식노드
		
		var div = document.createElement("div");		// 메뉴 사진 부분 (topdiv 태그의 자식 노드)
		var img  = document.createElement("img");
			
		var div2 = document.createElement("div");		// 메뉴 이름 부분 (topdiv 태그의 자식 노드)
		var span2 = document.createElement("span");
		var inputname = document.createElement("input");
		
		var div3 = document.createElement("div");		// 메뉴 설명 부분 (topdiv 태그의 자식 노드)
		var span3 = document.createElement("span");
		var inputex   = document.createElement("input");	
		
		var div4 = document.createElement("div");		// 메뉴 가격 부분 (topdiv 태그의 자식 노드)
		var span4 = document.createElement("span");
		var inputprice= document.createElement("input");	
		
		var inputdel  = document.createElement("input");	// 메뉴 삭제 버튼
		var inputfile = document.createElement("input");	// 메뉴 사진 첨부 파일 부분
		var br = document.createElement("br");				// 간격 조정
		var br2 = document.createElement("br");
		var br3 = document.createElement("br");
		var br4 = document.createElement("br");
		
		/* 메뉴 사진 이미지 태그 속성 설정 */
		img.setAttribute("src", "./restaurant/menu_upload.jpg");	// 메뉴 사진 기본이미지 설정
		img.setAttribute("width", "200px");
		img.setAttribute("height", "200px");
		img.setAttribute("class", "rmAttFile"+cnt);					// class 설정
		div.setAttribute("style", "float:left");
		div.appendChild(img);										// 자식노드로 추가
		
		/* 메뉴 이름 태그 속성 및 텍스트 입력 */
		span2.setAttribute("class", "input-group-addon");			
		span2.innerHTML = "메뉴 이름";
		inputname.setAttribute("type", "text");						
		inputname.setAttribute("name", "rmName");
		inputname.setAttribute("class", "form-control");
		inputname.setAttribute("required", "");	// element.required = true
		
		div2.setAttribute("class", "input-group");			
		div2.appendChild(span2);
		div2.appendChild(inputname);							
		
		/* 메뉴 설명 태그 속성 및 텍스트 입력 */
		span3.setAttribute("class", "input-group-addon");
		span3.innerHTML = "메뉴 설명";
		inputex.setAttribute("type", "text");
		inputex.setAttribute("name", "rmExplain");
		inputex.setAttribute("class", "form-control");
		inputex.setAttribute("required", "");
		
		div3.setAttribute("class", "input-group");
		div3.appendChild(span3);
		div3.appendChild(inputex);
		
		/* 메뉴 가격 태그 속성 및 텍스트 입력 */
		span4.setAttribute("class", "input-group-addon");
		span4.innerHTML = "메뉴 가격";
		inputprice.setAttribute("type", "number");
		inputprice.setAttribute("name", "rmPrice");
		inputprice.setAttribute("class", "form-control");
		inputprice.setAttribute("required", "");
		inputprice.setAttribute("min", "0");
	
		div4.setAttribute("class", "input-group");
		div4.appendChild(span4);
		div4.appendChild(inputprice);
		
		/* 삭제, 사진 첨부 태그 설정 부분 */
		inputdel.setAttribute("type", "button");
		inputdel.setAttribute("name", "btnDelete");
		inputdel.setAttribute("value", "삭제");
		inputdel.setAttribute("onclick", "delFunc(this)");
		inputdel.setAttribute("style", "float:right");
		inputdel.setAttribute("class", "btn btn-primary");
				
		inputfile.setAttribute("type", "file");// input type 지정
		inputfile.setAttribute("name", "rmAttFile"+cnt);// name 지정
		inputfile.setAttribute("id", "rmAttFile"+cnt);
		inputfile.setAttribute("onchange", "menuLoadImg(this)");
		
		/* topdiv에 자식노드로 모두 추가 */
		topdiv.appendChild(div);
		topdiv.appendChild(div2);
		topdiv.appendChild(div3);
		topdiv.appendChild(div4);
		topdiv.appendChild(br4);
		topdiv.appendChild(inputdel);
		topdiv.appendChild(br);
		topdiv.appendChild(inputfile);
		topdiv.appendChild(br2);
		topdiv.appendChild(br3);
		
		menu.appendChild(topdiv);	// 메뉴 부분의 최상위 부분인 menu에 자식노드로 지정
		
		cnt++;						// 메뉴 갯수 1증가
		
	}
	
	/* 음식점 수정 버튼 등록시 예외처리 */
	frm.btnModify.onclick = function(){				// 글 저장 버튼 누를시
		if(frm.rname.value == ""){
			$('#msg').text("음식점 상호명을 입력해주세요.");
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
		}else if(cnt==1){				// 메뉴가 1개 일때
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
				$('#msg').text("맛집이 정상적으로 수정 되었습니다.");
				document.getElementById('show_msg').style.display='block';
			}
		}else if(cnt!=1){			// 메뉴가 1개 이상일때
			for(i=0;i<cnt;i++){		// 메뉴 갯수 만큼
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
			$('#msg').text("맛집이 정상적으로 수정 되었습니다.");
			document.getElementById('show_msg').style.display='block';		// 메시지 결과 출력
		}
	}
	
	/* 음식점 수정이 정상적으로 db에 등록되면 */
	function okFunc(){			
		if($('#msg').text() =="맛집이 정상적으로 수정 되었습니다."){		// 정상적으로 수정되면
			frm.action = "modifyR.donghwan";					// 수정 결과 페이지로 이동
			frm.submit();										// 전송
		}else{															// 비정상일 경우
			document.getElementById('show_msg').style.display='none';	// 결과 메시지 보이지않음 (예외처리로 출력)			
		}
	}
	
	frm.btnView.onclick = function(){		// 취소 버튼 누를시
		frm.action = "list.donghwan";		// 음식점 목록 페이지로 이동
		frm.submit();
	}
	
	function readURLM(input) {					// 음식점 사진 변경시 호출되는 메소드 (매개변수는 input=file 태그)
		if (input.files && input.files[0]) { // 파일이 존재하면
	    var reader = new FileReader();
	    var sibling = input.previousSibling.previousSibling;		// 이전의 이전 형제노드를 sibling으로 지정 (img태그)
	    console.log(sibling.outerHTML);							// sibling 태그요소와 함께 콘솔에 출력
	    reader.onload = function (e) {														
	    	$(sibling).attr('src', e.target.result);			// 해당 img태그의 src를 sibling값으로 입력
	        }
	    reader.readAsDataURL(input.files[0]);					// 등록시 사진 바로 보여주기
	    }
	}
	
	function delFunc(obj){					// 메뉴 삭제 버튼 클릭시
		var parent = obj.parentNode;		// menu최상위 바로 아래 div
		var granpar = parent.parentNode;	// menu최상위 태그
		granpar.removeChild(parent);		// 메뉴 이름,가격,사진,설명,버튼 등 삭제
		cnt--;								// 메뉴 갯수 -1
	}
	
	function si2(){									// (시/도) 히든값이 존재하면
		frm.raddress1.value=frm.hiddenAdd1.value;	// 히든값으로 입력
		gu();										// (군/구) select 태그 생성 메소드
	}
	function gu2(){									
		if(frm.hiddenAdd2.value!=""&& frm.raddress1.value==frm.hiddenAdd1.value){
			// (시/도) 히든값이 존재하면
			frm.raddress2.value=frm.hiddenAdd2.value;
			// (군/구)값도 히든값으로 입력
		}
	}
</script>


</body>
</html>