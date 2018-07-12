<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inconsolata">
<title>맛집 상세 보기</title>

</head>
<body>
<div class='container'>
	
 <!-- form 태그 시작 -->
 <form name='rest_view'>
	
  <!-- 히든 값 -->
  <input type='hidden' name='serial' value='${param.serial }'>
  <input type='hidden' name='mid' value='${rvo.mid }'>
  <input type='hidden' name='nowPage' value='1'>
  <input type='hidden' name='store' value='${rvo.rname }'>
  
  <!-- 작성자, 음식점 이름 페이지 상단 부분 -->
  <div id='a' style="text-align: center;">
   <label>작성자 : </label>
   <span>${rvo.mid }</span>
   <p/>
   <label>음식점 이름 : </label>
   <span>${rvo.rname }</span>
  </div>
  <p/>
 
  <!-- 페이지 중간 부분 -->
  <div id='center'>
  
  
  <!-- 사진 부분 시작 -->
   <div id='rphoto'>
 	<div class="container-fluid">
 	 <div class="row content">
 	  <div class="col-lg-12">
 	  <hr>
	  <h3 class="text-center">음식점 사진</h3>
	  <p class="text-center"><em>첫 번째 사진은 메인 사진입니다.</em></p>
	  <hr/>
	  <p/>
 		
 	   <!-- 음식점 사진 슬라이드 부분 -->
 	   <div id="myCarousel" class="carousel slide" data-interval="0">
       <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <c:set var="i" value="1"></c:set>
        <c:forEach var="i" begin="1" end="${rphotoList2.size() }">
         <li data-target="#myCarousel" data-slide-to="${i }"></li>
       	 <c:set var="i" value="${i+1 }"></c:set>
        </c:forEach>
       </ol>
       
        <!-- 음식점 메인 사진 부분 -->
        <div class="carousel-inner" role="listbox">
 	     <div class="item active">
 	      <div class = "file_input" style = "width:100%; overflow: hidden;">
 	  	   <label class = "accommodation_img" style = "width:100%;">
 		    <c:forEach var='rphoto_main' items='${rphotoList}'>
 			 <img class="w3-image" src="./restaurant/download/${rphoto_main }" 
 				  style="width:100%; height:100%; overflow:hidden" >
 		    </c:forEach>
 		   </label>
 	      </div>
 	     </div>
 		
 		 <!-- 음식점 서브 사진 부분 -->
 		 <c:forEach var='rphoto_sub' items='${rphotoList2 }'>
 	      <div class="item">
 	       <div class = "file_input" style = "width:100%; overflow: hidden;">
 			<label class = "accommodation_img" style = "width:100%">
 			<img class="w3-image" src="./restaurant/download/${rphoto_sub }" 
 				 style="width:100%; height:100%; overflow:hidden">
 			</label> 
 	       </div>
 	      </div>
 		 </c:forEach>
        </div>

        <!-- 사진 슬라이드 왼쪽, 오른쪽 버튼 부분 -->
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
   </div> <!-- 사진 부분 끝 -->


   <!-- 메뉴 시작 -->
   <hr>
   <h3 class="text-center">메뉴</h3>
   <p class="text-center"><em>Menu</em></p>
   <hr/>
   <p/>
   
   <!-- 메뉴, 가격, 설명, 사진 부분 -->
   <div id='option'>
    <c:set var="cnt" value="0"></c:set>
    <div id='menu'>
	 <div class="w3-container w3-padding-64 w3-xxlarge" id="menu">
 	  <div class="w3-content">
 	   
 	   <!-- 메뉴 사진들 -->	 
	   <c:forEach var="rmvo" items='${menuList }'>
		<div style="float:left;">
		 <img src="./restaurant/download/${menuPhotoList[cnt] }" 
			 width='200px' height='200px' style="margin-right:30px">
		</div> 
		<!-- 메뉴 이름, 가격, 설명 -->
		<h1><b>${rmvo.rmName }</b> <span class="w3-right w3-tag w3-dark-grey w3-round">${rmvo.rmPrice }</span></h1>
      	<p class="w3-text-grey">${rmvo.rmExplain }</p>
      	<br/>
		<br/>
	    <hr>
		<c:set var="cnt" value="${cnt+1 }"></c:set>
	   </c:forEach>
	  </div>
     </div>
    </div>
   </div>
  </div>
  
  <!-- 음식점 상세 정보 시작 -->
  <hr>
  <h3 class="text-center">음식점 정보</h3>
  <p class="text-center"><em>Information</em></p>
  <hr>
  <p/>
  
  <!-- 음식점 상세 정보 부분  -->
  <div class="w3-container" id="menu" style="margin-left: 60px; text-align: center">
   <div class="w3-content col-lg-12" >
    <div class="w3-row w3-center w3-card w3-padding">
     <a href="javascript:void(0)" onclick="openMenu(event, 'Eat');" id="myLink">
      <div class="w3-col s12 tablink">음식점 상세 정보</div>
     </a>
    </div>
    
    <div id="Eat" class="w3-container menu w3-padding-48 w3-card">  
     <h5>대표 메뉴들</h5>
     <p class="w3-text-grey">${rvo.rmenus }</p>
     <hr>
	 
     <h5>음식점 간략 설명</h5>
     <p class="w3-text-grey">${rvo.rinfo }</p>
     <hr>
       
     <h5>영업시간</h5>
     <p class="w3-text-grey">${rvo.rtimeOpen }시　~　${rvo.rtimeClose }시</p>
     <hr>
     
	 <h5>테이블 수</h5>
     <p class="w3-text-grey">${rvo.rtable }</p>
     <br><hr> 
    
     <h5>휴일</h5>
     <p class="w3-text-grey">${rvo.rholiday }</p>
     <hr>
      
     <h5>화장실</h5>
     <p class="w3-text-grey">${rvo.rbathroom }</p>
     <hr>
      
     <h5>주류판매</h5>
     <p class="w3-text-grey">${rvo.rdrink }</p>
     <hr>
      
     <h5>기타시설</h5>
     <p class="w3-text-grey">${rvo.rfacilities }</p>
     <hr>
      
     <h5>대표전화</h5>
     <p class="w3-text-grey">${rvo.rphone }</p>
     <br> 
    </div>
   </div>  
  </div>			<!-- 음식점 상세 정보 부분 끝 -->
  <br/>
  <br/>
  <br/>
 
  <!-- 주소와 지도 부분 시작 -->
  <div id='detail'>
   
   <div id='map'>
 	<!-- 지도 출력되는 부분 -->
 	<div id='map' style="width:100%;height:400px;">
 	</div>
 	
 	<!-- 주소 히든 값 -->
 	<input type='hidden' name='raddress1' id='raddress1' value='${rvo.raddress1 }'/>
 	<input type='hidden' name='raddress2' id='raddress2' value='${rvo.raddress2 }'/>
 	<input type='hidden' name='rjuso' id='rjuso' value='${rvo.rjuso }'
 		   size='50'/>	
   </div> 
  </div>
  <p/>
  
  <!-- 간격 조정 -->
  <div style="height:100px">
   <p/>
   <p/>
  </div> 
 
 
  <!-- 하단 버튼 부분 -->
  <div id='bottom' style='text-align:center;'>
  	<% 
	if(session.getAttribute("sId") !=null){					// 아이디 값 가져오기
	 	String sId = (String)session.getAttribute("sId"); 
	}
 	if(session.getAttribute("selection") !=null){			// (사업자/일반회원) 구분 가져오기
 		String selection = (String)session.getAttribute("selection"); 
 	}
	%>
 	
   <!-- 보고있는 음식점이 자신의 음식점이면 수정, 삭제 버튼 보이기 -->
   <c:if test="${sId == rvo.mid }">
	<input type='button' name='btnModify' id='btnModify' value='수정' class="btn btn-primary"/>
	<input type='button' name='btnDelete' id='btnDelete' value='삭제' class="btn btn-primary"/>
   </c:if>

   <!-- 그 외에는 -->
   <input type='button' name='btnList'	id='btnList' value='목록' class="btn btn-primary"/>
   <c:if test="${selection == 'i' and sId != 'admin'}">
 	<input type='button' name='btnBook' id='btnBook' value='예약하러가기' class="btn btn-primary"/>
 	<input type='button' name='btnReview' id='btnReview' value='후기등록하기' class="btn btn-primary"/>
   </c:if>
  </div>
 </form>
</div>
 
 
<!-- 지도 api 출력 부분 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=uJlO5e3KXL6BKDiiZFmv&submodules=geocoder"></script>
<script> 
window.onload=function(){										// 주소 찾기 버튼 클릭시
	var raddress1 = document.getElementById("raddress1").value; // (시/도) 값
	var raddress2 = document.getElementById("raddress2").value; // (군/구) 값
	var rjuso = document.getElementById("rjuso").value;			// 나머지 주소 값	
	var juso = raddress1 + " " + raddress2 + " " + rjuso;		// 전체 주소 값
	
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
</script>	

 
 
<script>
	var frm = document.rest_view;
	/* 버튼 처리를 위한 지정 */
	var btnModify = document.getElementById("btnModify");		
	var btnDelete = document.getElementById("btnDelete");
	var btnList	  = document.getElementById("btnList");
	var btnReview = document.getElementById("btnReview");
	var btnBook = document.getElementById("btnBook");
	
	/* 수정 버튼 클릭시 */
	if(btnModify!=null){					
		btnModify.onclick = function(){		
		 	frm.action = "modify.donghwan"; // 수정 페이지로 이동
		 	frm.submit();
		}
	}
	
	/* 삭제 버튼 클릭시 */
	if(btnDelete!=null){
		btnDelete.onclick = function(){				
			var yn = confirm('정말 삭제 하시겠습니까?');  // 메시지 출력 (반환값 true, false)
			if(yn){									// 예를 누르면
				frm.action = "delete.donghwan";
				frm.submit();
			}else{									// 아니오를 누르면
				alert("삭제가 취소되었습니다");
			}
		}
	}
	
	/* 목록 버튼 클릭시 */
	btnList.onclick = function(){					// 제일 밑부분 목록 버튼 클릭시
		location.href = "list.donghwan";
	}
	
	/* 예약 버튼 클릭시 */
	if(btnBook!=null){
		btnBook.onclick = function(){		
			frm.action = "reservation_res.reserve";	// 예약 페이지로 이동
			frm.submit();
		}
	}
	
	/* 후기 버튼 클릭시 */
	if(btnReview!=null){	
		btnReview.onclick = function(){		
			frm.action = "insert.review";
			frm.submit();
		}
	}
	

	/* function openMenu(evt, menuName) {
		  var i, x, tablinks;
		  x = document.getElementsByClassName("menu");
		  for (i = 0; i < x.length; i++) {
		     x[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablink");
		  for (i = 0; i < x.length; i++) {
		     tablinks[i].className = tablinks[i].className.replace("w3-blue", "");
		  }
		  document.getElementById(menuName).style.display = "block";
		  evt.currentTarget.firstElementChild.className += " w3-blue";
	}
	document.getElementById("myLink").click(); */
	
</script>
 
 
</body>
</html>