<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MOOYA HOTEL</title>
	
	<link rel="stylesheet" href="resources/css/layout.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="http://developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오 API -->
	
	<script type="text/javascript">
		// 페이지 로드
	    onload = function(){
			getDate();
		}
	    
		// 현재 시간 나타내기
	    function getDate() { 
	           date = setInterval(function () { 
	               var dateString = ""; 

	               var newDate = new Date(); 

	               dateString += ("0" + newDate.getHours()).slice(-2) + ":"; 
	               dateString += ("0" + newDate.getMinutes()).slice(-2) ; 
	               //document.write(dateString); 문서에 바로 그릴 수 있다. 
	               $("#date1").text(dateString); 
	               $("#date2").text(dateString); 
	           }, 1000);   // 1초 단위로  
	    }   
		
		// 카카오 API 초기화
		Kakao.init('464a8f29a97a043193116da7f11294e8');	// 발급 받은 javaScript 키
		Kakao.isInitialized(); // 카카오 로그인 정보 초기화
		
		// 카카오 로그인(kakaoLoginPopUp) - 팝업 방식
		function kakaoLoginPopUp() {
		    Kakao.Auth.login({
		        success: function(authObj) { // 카카오계정 인증할 때, 토큰 발급 받음
		            Kakao.Auth.setAccessToken(authObj.access_token); // 발급 받은 토큰 사용하도록 세팅
					setUserEmail(); // 사용자 이메일 조회(이메일 존재 여부에 따라 회원가입 or 로그인)
		        },
		        fail: function(err) { // 카카오계정 인증에 실패할 경우
		            alert('카카오톡과 연결이 완료되지 않았습니다. 다시 시도해주세요.' + JSON.stringify(err));
		        },
		    })
		}
		
		// 사용자 이메일 조회(setUserEmail) : DB에 이메일 존재 여부에 따라 회원가입 or 로그인
		function setUserEmail(){
			Kakao.API.request({ // 카카오에서 가져 올 프로퍼티 요청
			    url: '/v2/user/me', // 사용자 정보 가져오는 api url
			    data: { // 이메일 가져오기
			        property_keys: ["kakao_account.email"]
			    },
			    success: function(response) { // 카카오에서 가져 온 이메일 중복체크
			    	$('#mEmail').val(response.kakao_account.email);
			    	emailCheck(response.kakao_account.email);
			    },
			    fail: function(error) {
			    	
			    }
			});
		}
		
		// 이메일 중복 체크(emailCheck)
		function emailCheck(mEmail){
			$.ajax({
				url: 'emailCheck.do',
				type: 'get',
				data: 'mEmail=' + mEmail,
				dataType: 'json',
				success: function(resultMap){
					if(resultMap.result == 0){ // DB에 일치하는 이메일이 없는 경우 회원가입으로 이동
						alert('첫 방문입니다! 회원가입 화면으로 이동합니다.');
						location.href = 'http://localhost:9090/d/joinPage.do';
					} else{ // DB에 일치하는 이메일이 있는 경우 해당 이메일로 로그인
						alert('카카오 계정으로 로그인합니다.');
						$('#kakaoLogin').val("Y");
						$('#f_mem').submit();
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					
				}
			});
		}
    </script>
</head>
<body>

	<header>
		<div class="header">
			<h1 class="logo">
				<a href="index.do">MOOYA HOTEL</a>
			</h1>
			
			<!-- 1900px 이하 화면일 때 -->
			<div class="small_header_right">
				<span>Seoul</span>
				<span id="date1"></span>
				
				<!-- 비로그인 화면 -->
				<c:if test="${loginUser eq null && loginAdmin eq null}">
					<a href="#" onclick="location.href='index.do'">로그인</a>
					<a href="joinPage.do">회원가입</a>
					<a href="nonMemberPage.do">비회원 예약 확인</a>
		 		</c:if>
		 		
		 		<!-- 로그인 성공 화면 -->
		 		<c:if test="${loginUser ne null || loginAdmin ne null}">
		 			<a href="#" onclick="location.href='logout.do'">로그아웃</a>
		 			<a href="myPage.do">마이페이지</a>
		 			<a href="myReservation.do?mNo=${loginUser.MNo}">예약내역</a>
				</c:if>
				
				<a href="reservationSelectDatePage.do">예약하기</a>
				<a href="boardPage.do">게시판</a>
				<a href="">이벤트</a>
				<a href="infoRoom.do">객실</a>
			</div>
			
			<!-- 1900px 이상 화면일 때 -->
			<!-- right -->
			<div class="header_right"> 
				<span>Seoul</span>
				<span id="date2"></span>
				
				<!-- 비로그인 화면 -->
				<c:if test="${loginUser eq null && loginAdmin eq null}">
					<a href="#" onclick="location.href='index.do'">로그인</a>
					<a href="joinPage.do">회원가입</a>
					<a href="nonMemberPage.do">비회원 예약 확인</a>
		 		</c:if>
		 		
		 		<!-- 로그인 성공 화면 -->
		 		<c:if test="${loginUser ne null || loginAdmin ne null}">
		 			<a href="#" onclick="location.href='logout.do'">로그아웃</a>
		 			<a href="myPage.do">마이페이지</a>
		 			<a href="myReservation.do?mNo=${loginUser.MNo}">예약내역</a>
				</c:if>	
				
				<a href="reservationSelectDatePage.do">예약하기</a>
			</div>
			<!-- left -->
			<div class="header_left"> 
				<a href="boardPage.do">게시판</a>
				<a href="">이벤트</a>
				<a href="infoRoom.do">객실</a>
			</div>
			
		</div>
	</header>
	
	<section id="section">
	