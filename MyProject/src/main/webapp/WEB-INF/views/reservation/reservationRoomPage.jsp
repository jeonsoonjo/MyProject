<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="홈페이지제목" name="title" />
</jsp:include>

<!DOCTYPE html >
<html>
<head>
<link rel="stylesheet" href="resources/css/reservationRoomPage.css">
<meta  charset=UTF-8>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>
<div id="box_middle">
	 
	<!-- 예약가능한 방이 없는 경우 -->
 	<c:if test="${empty room}">
 		예약가능한 방이 없습니다.
 		<input type="button" value="이전으로" id="pre">
 	</c:if>
 	
 	<!-- 예약 가능한 방 리스트 -->
 	<c:if test="${not empty room}">
 		<c:forEach var="r" items="${room}">
 			 
	 			${r.RNo}
	 			<h1>${r.RName}</h1>
	 			<img alt="" src="">
	 			가격   ${r.RPrice} ￦/
	 			등급  ${r.RGrade} /
	 			최대 인원   [ ${r.RAccept} ]/
	 			방 크기 ${r.RSize} <br>
 			 	<div class="btn_box"> 
 			 		<a href="optionPage.do?rNo=${r.RNo}&checkIn=${checkIn}&checkOut=${checkOut}&people=${people}">예약하기</a>
 			 	</div>
 			 	<div class="btn_box"> 
 			 		<a href="priceRoom.do?rNo=${r.RNo}">자세히 보기</a>
 			 	</div>
 			 
 			<hr>
 			
 		</c:forEach>
 	</c:if>
 </div>
 <br><br><br><br><br><br><br><br><br><br><br><br>

</body>
</html>
<%@ include file="../layout/footer.jsp" %> 
