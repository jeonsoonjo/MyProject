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
<link rel="stylesheet" href="resources/css/nonMemReservationPage.css">
<meta  charset=UTF-8>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fn_next();
	});
	
	function fn_next(){
		$('#code_check').click(function(){
			$('#code_f').attr('action','nonMemReservationPage.do');
			$('#code_f').submit();
			 
		});
	}
	

 
</script>
<style type="text/css">
	body{
		padding: auto;
		margin: auto;
	}
	#subData{
		padding: auto;
		margin: auto;
		border: 1px solid black;
		width: 500px;
		height:100px;
		text-align: center;
		line-height: 50px;
	}
</style>
</head>
<body>

	<!-- 비회원 예약 내역 -->
       
	       
	      
	      
<div id="box_middle">  
<h1>예약내역</h1>
	   <div class="row">
        <table id="example-table-2" width="100%" class="table table-bordered table-hover text-center">
            <thead>
                <tr>
                    <th>예약번호 </th>
                    <th>방번호</th>
                    <th>예약 이메일</th>
                    <th>예약자</th>
                    <th>인원</th>
                     <th>체크인</th>
                      <th>체크아웃</th>
                       <th>조식</th>
                        <th>요청사항</th>
                         <th>총가격</th>
                         <th>예약 상태</th>
                </tr>
            </thead>
            <tbody>  
            <c:forEach var="my" items="${nonMemRevList}">              
                <tr>
                    <td>${my.reNo}</td>
                    <td>${my.getRNo()}</td>
                    <td> ${my.getReEmail()}</td>
                    <td> ${my.booker}</td>
                    <td> ${my.people }</td>
                    <td>  [ ${my.checkIn } ]</td>
                    <td>  [ ${my.checkOut } ]</td>
                    <td> ${my.food }</td>
                    <td>${my.note}</td>
                    <td> ${my.totalPay }</td>
                    <td> ${my.state }</td>
                </tr>
               </c:forEach>
                 
            </tbody>
        </table>
        <br>
	       *비회원 취소시 고객센터 연락바랍니다.
       </div>
       </div>
</body>
</html>
<%@ include file="../layout/footer.jsp" %> 