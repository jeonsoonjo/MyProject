<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/infoRoom.css">
	<script>
		$(function(){			
	 	 	$('<input type="hidden" name="page" value="infoRoom.do">')
			.appendTo( $('.form') )
		});
	</script>
	<style>
		.room-description > p {
			color: white;
		}
	</style>
	
    <div class="container">
        <div class="room-list">
        	<c:forEach var="room" items="${list}">
	            <div class="room">
	                <img onclick="location.href='priceRoom.do?rNo=${room.RNo}';" style="cursor:pointer;" alt="룸 이미지" src="${room.RImg}" >
	                <div class="room-description">
	                    <h2>${room.RName}</h2>
	                    <p>수용인원 : ${room.RAccept}</p>
	                    <p>가격 : ${room.RPrice}</p>
	                </div>
	            </div>
            </c:forEach>
        </div>
    </div>
    
<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
