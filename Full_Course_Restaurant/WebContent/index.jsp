<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<title>FULL COURSE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/jejugothic.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="./icons/flaticon.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel='stylesheet' type = 'text/css' href='css/index.css'/>
<link rel='stylesheet' type = 'text/css' href='css/sidebar.css'/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>

a:link {
    text-decoration: none;
}

a:visited {
    text-decoration: none;
}
a:hover{
    text-decoration: none;

}
</style>

<body>
<script>
<%
request.setCharacterEncoding("utf-8"); 
String inc = "intro.jsp";
if(request.getParameter("inc") != null){
	inc = request.getParameter("inc");
}
%>
</script>

<div class="gtco-loader"></div>
<div class = 'overlay' id = 'overlay' onclick = 'off(); closeNav();'></div>
	<div id="page">
<!-- Navbar (sit on top) -->
	<div class="w3-top" style = 'z-index: 10;'>
		<div class="w3-bar logo-masked" id="myNavbar" style="overflow: visible;">
		<div class="logo">
		<a href="index.jsp">
		<img class="default" src="imgs/logo-default.svg" alt="Full Course" >
		<img class="scrolled" src="./imgs/logo-scroll.svg" alt="Full Course" ></a>
		</div>
			<nav class="nav-holder w3-padding-large" id="holder">
				<a class="w3-bar-item w3-right w3-padding-large w3-text-white w3-hover-text-grey menu-item" onclick="openNav(); on();">&#9776;</a>
				<a href="list.review" class="w3-bar-item w3-right w3-padding-large w3-text-white w3-hover-text-grey menu-item">후기</a> 
				<a href="list.donghwan" class="w3-bar-item w3-right w3-text-white w3-padding-large w3-hover-text-grey menu-item">식당</a> 
				<a href="list.ac" class="w3-bar-item w3-right w3-text-white w3-padding-large w3-hover-text-grey menu-item">호텔</a>
				<c:if test="${sessionScope.sId ==null }">
					<a href="index.jsp?inc=/member/MemberLogin.jsp" class="w3-bar-item w3-right w3-padding-large w3-text-white w3-hover-text-grey menu-item">로그인</a>
				</c:if>
			</nav>
		</div>
	</div>
	
	<jsp:include page="<%=inc %>"></jsp:include>


	<div id="mySidenav" class="sidenav w3-center" style = 'z-index:12; padding-top:100px;'>
	<c:if test="${sessionScope.sId ==null }">
	  <li class = 'w3-block'><a href="index.jsp?inc=/member/MemberLogin.jsp" class = 'w3-block'>로그인</a></li>
	</c:if>
	<c:if test="${sessionScope.sId != null }">
	<c:if test="${sessionScope.selection == 'c' }">
	  <li class = 'w3-block'><a href="list_company.reserve" class = 'w3-block'>내 매장보기</a></li>
	  <li class = 'w3-block'><a href="MemberModify.member" class = 'w3-block'>회원정보 수정</a></li>
	</c:if>
	<c:if test="${sessionScope.selection == 'i' and sId!='admin' }">
	  <li class = 'w3-block'><a href="list_Individual.reserve" class = 'w3-block'>내 예약 목록</a></li>
	   <li class = 'w3-block'><a href="list_cancel_i.reserve" class = 'w3-block'>내 예약 취소목록</a></li>
	  <li class = 'w3-block'><a href="MemberModify.member" class = 'w3-block'>회원정보 수정</a></li>
	</c:if>
	<c:if test="${sId == 'admin' }">
	  <li class = 'w3-block'><a href="MemberIndividualList.member" class = 'w3-block'>개인 회원관리</a></li>
	  <li class = 'w3-block'><a href="MemberCompanyList.member" class = 'w3-block'>사업자 회원관리</a></li>
	</c:if>
	  <li class = 'w3-block'><a href="MemberLogout.member" class = 'w3-block'>로그아웃</a></li>
	</c:if>
	  <li class = 'w3-block'><a href="#" onclick="closeNav(); off()" class = 'w3-block'>닫기</a></li>
	</div>
	<div id="modal01" class="w3-modal w3-black"
		onclick="this.style.display='none'">
		<span class="w3-button w3-large w3-black w3-display-topright"
			title="Close Modal Image"><i class="fa fa-remove"></i></span>
		<div
			class="w3-modal-content w3-animate-zoom w3-center w3-transparent w3-padding-64">
			<img id="img01" class="w3-image">
			<p id="caption" class="w3-opacity w3-large"></p>
		</div>
	</div>
<footer class="w3-center w3-padding-64 w3-opacity w3-hover-opacity-off">
  <a href="#home" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
  <div class="w3-xlarge w3-section">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a></p>
</footer>
</div>
<!-- Add Google Maps -->
<script>
$(".gtco-loader").fadeOut("slow");

// Modal Image Gallery
function onClick(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("modal01").style.display = "block";
  var captionText = document.getElementById("caption");
  captionText.innerHTML = element.alt;
}

// Change style of navbar on scroll

// Used to toggle the menu on small screens when clicking on the menu button
function toggleFunction() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}
	
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}

function on() {
    document.getElementById("overlay").style.display = "block";
}

function off() {
    document.getElementById("overlay").style.display = "none";
}
</script>
</body>
</html>