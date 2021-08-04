<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="홈페이지제목" name="title" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/nonMemberPage.css">
<meta  charset=UTF-8>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fn_next();
	});
	
	//확인 클릭
	function fn_next(){
		$('#email_check').click(function(){
			fn_revCheck();
		});
	}
	
	//이메일 예약 확인
	function fn_revCheck(){
		$.ajax({
			url: 'reservationEmail.do',
			type: 'get',
			data: 'reEmail=' + $('#reEmail').val(),
			dataType: 'json',
			success: function(resultMap){
				if(resultMap.nonMemReservation){
					//예약목록에 있는 이메일이면 페이지 이동
					$('#code_f').attr('action','nonMemReservationPage.do');
					$('#code_f').submit();
				} else{
					//없는 이메일시
					alert('존재하지 않는 예약 이메일입니다.');
					return false;
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				
			}
		});
	}
 
</script>
 
</head>
<body>
<div id="box_middle">
	<!-- 비회원 예약 코드 -->
	<h1>비회원 조회</h1>
        <div id="subData">
	        <form id="code_f">
	        	<div id="input_title">예약한 이메일</div>
	        	<input type="text" id="reEmail" name="reEmail" placeholder="xxxxx@naver.com">
	        	<input type="button" value="확인" id="email_check" >
	        </form>
       </div>
</div>
</body>
</html>
<%@ include file="../layout/footer.jsp" %> 