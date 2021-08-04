<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/eventPage.css">
	
	<script>
		onload = function(){
			document.getElementById('slider').onclick = function(){
		    	location.href= "eventList.do";
			}
		}
		function imgslider(imgsrc, title){
	        // 클릭한 요소의 이미지와 사진 제목을 변경해 준다.
	        document.getElementById("slider").src  = imgsrc;
	        document.getElementById("title").textContent = title;
	    }
	</script>
	
	<img src="resources/images/event/Sweet Walk on the Clouds.PNG" id="slider">
        <!-- 썸네일 -->
        <ul class="navigation">
            <li id="m1" onclick="imgslider('resources/images/event/Sweet Walk on the Clouds.PNG', '구름 위를 달콤한 산책')"><img src="resources/images/event/Sweet Walk on the Clouds.PNG"></li>
            <li onclick="imgslider('resources/images/event/Fruit Jelly Collection.PNG', '과일 젤리 컬렉션')"><img src="resources/images/event/Fruit Jelly Collection.PNG"></li>
            <li onclick="imgslider('resources/images/event/夏味.PNG', '여름의 맛')"><img src="resources/images/event/夏味.PNG"></li>
            <li onclick="imgslider('resources/images/event/Cool Summer Festival.PNG', '시원한 여름 축제')"><img src="resources/images/event/Cool Summer Festival.PNG"></li>
            <li onclick="imgslider('resources/images/event/Cooling Summer Delights.PNG', '시원한 여름의 기쁨')"><img src="resources/images/event/Cooling Summer Delights.PNG"></li>
        </ul>
        <h1 id="title">EVENT</h1>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
