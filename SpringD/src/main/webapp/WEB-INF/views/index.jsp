<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 동적 페이지 포함(파라미터 title을 전달할 수 있다) --%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="layout/header.jsp">
	<jsp:param value="홈페이지제목" name="title" />
</jsp:include>

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	
	<!-- script -->
	<script type="text/javascript">
		// 이미지 페이드인, 페이드아웃
		$(document).ready(function(){
			$('.imgs > ul > li').hide();
			$('.imgs > ul > li:first-child').show();
			setInterval(function(){ 
				$('.imgs > ul > li:first-child').fadeOut() 
				.next().fadeIn().end(1000) 
				.appendTo('.imgs > ul'); 
			}, 4000);
		});
	</script>

	<!-- 메인 이미지 -->
	<div id="imageSlide" class="all">
		<div class="imgs">
			<ul id="slides">
		    	<li><img src="resources\images\imageSlide\image(1).jpg" alt="no"></li>
			    <li><img src="resources\images\imageSlide\image(2).jpg" alt="no"></li>
			    <li><img src="resources\images\imageSlide\image(3).jpg" alt="no"></li>
			    <li><img src="resources\images\imageSlide\image(4).jpg" alt="no"></li>
			    <li><img src="resources\images\imageSlide\image(5).jpg" alt="no"></li>
			    <li><img src="resources\images\imageSlide\image(6).jpg" alt="no"></li>
		    </ul>
	
		    <!-- 이미지 문구 -->
			<div id="imgText">
				<span>Welcome To</span><br>
				<span>MOOYA HOTEL</span>
			</div>
		</div>
	</div>
	
<%-- 정적 페이지 포함(파라미터 전달이 불가능하다) --%>
<%@ include file="layout/footer.jsp" %> 
