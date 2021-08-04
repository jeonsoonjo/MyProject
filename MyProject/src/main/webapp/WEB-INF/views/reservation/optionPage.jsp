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
<link rel="stylesheet" href="resources/css/optionPage.css">
<meta  charset=UTF-8>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		fn_de();	// 초기화 함수
		fn_cal();	// 숙박비 + 조식 비용 계산 함수
		fn_next();	// 다음페이지로 이동
	});
	
	// 초기화 함수
	function fn_de(){
		$('#people_count').text(0);	//다이닝 인원 초기화 (0)
		$('#dining_price').text(0);	//다이닝 총가격 초기화 (0)
		$('#totalPay').text($('#totalRoom_price').text());	//총 금액 초기화 (총 숙박가격 + 조식인원)
	}
	
	
	// 조식 몇명인지 입력받을 때,
	// 숙박비 + 조식 비용 계산해서 출력해주는 함수
	function fn_cal(){
		$('#food').keyup(function(){
			$('#dining_price').val('');
			$('#people_count').val('');
			
			$('#people_count').text($('#food').val());
			
			var food_sum=$('#food').val()*50000;
			$('#dining_price').text(food_sum);
			
			var total=($('#food').val()*50000)+Number($('#totalRoom_price').text());
			$('#totalPay').val(total);
		});
	}
	
	// 다음 버튼 클릭시 form을 제출하고 이동
	function fn_next(){
		$('#next_btn').click(function(){
			$('#f').attr('action','revInfoPage.do');
			$('#f').submit();
		});	
	}
	
	</script>
	 
<title>Insert title here</title>
</head>
<body>
<div id="box_middle">
 	
 	<h1>옵션</h1>
 	
 	<form id="f">
	 	조식<br> 
	 	<input type="text" id="food" name="food" value="0"> 명
	 	
	 	<!-- hidden으로 선택한 방번호,체크인/체크아웃,방예약인원 넘김 -->
	 	<input type="hidden" name="rNo" value="${selectRoom.RNo}">
	 	<input type="hidden" name="checkIn" value="${checkIn}">
	 	<input type="hidden" name="checkOut" value="${checkOut}">
	 	<input type="hidden" name="people" value="${people}">
 	<br><br>
 	
 	<table>
 		<thead>
 			<tr>
 				<td colspan="5"><h3>총 가격</h3></td>
 			</tr>
 		</thead>
 		<tbody>
 			<tr>
 				<td>선택</td>
 				<td>수량</td>
 				<td> </td>
 				<td>개당 가격 </td>
 				<td>가격</td>
 			<tr>
 			<tr>
 				<td>${selectRoom.RName}</td>
 				<td>${sleepDate } 박</td>
 				<td>*</td>
 				<td> ${selectRoom.RPrice}원</td>
 				<td><span id="totalRoom_price"> ${selectRoom.RPrice * sleepDate} </span>원</td>
 			</tr>
 			<tr>
 				<td>조식 	</td>
 				<td><span id="people_count"> </span> 명 </td>
 				<td> *</td>
 				<td>50000원</td>
 				<td><span id="dining_price"> </span>원</td>
 			<tr>
 		</tbody>
 		<tfoot>
 			<tr>
 				<td colspan="5"><h1>총  	 <input type="text"  id="totalPay" name="totalPay" value="${selectRoom.RPrice * sleepDate}" readonly >  원</h1> 	 </td>
 			</tr>
 		</tfoot>
 	</table>
 	<input type="button" value="다음" id="next_btn">
 	</form>
</div>			 		 
 	
</body>
</html>
<%@ include file="../layout/footer.jsp" %> 