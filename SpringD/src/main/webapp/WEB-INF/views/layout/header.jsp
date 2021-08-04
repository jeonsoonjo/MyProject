<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MOOYA HOTEL</title>
	
	<link rel="stylesheet" href="resources/css/loginWindow.css"> 
	<link rel="stylesheet" href="resources/css/layout.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="http://developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오 API -->
	
	<script type="text/javascript">
		// 페이지 로드
	    onload = function(){
			getDate();
			
			document.getElementById('privacy').onclick = function(){
		    	window.open('privacy.do', '', 'width=640, height=480, resizable=no');
			}
			document.getElementById('term').onclick = function(){
		    	window.open('term.do', '', 'width=640, height=480, resizable=no');
			}
			document.getElementById('noEmail').onclick = function(){
		    	window.open('noEmail.do', '', 'width=400, height=352, resizable=no');
			}
			fn_toggle_mode();
			fn_login();
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
		
		// 회원 로그인, 관리자 로그인을 변경해주는 함수
		function fn_toggle_mode(){
			// 관리자 모드로 전환
			$('#mem_to_admin').click(function(){
				$('#mem_mode').toggleClass('hide');
				$('#admin_mode').toggleClass('hide');
			});
			// 회원 모드로 전환
			$('#admin_to_mem').click(function(){
				$('#mem_mode').toggleClass('hide');
				$('#admin_mode').toggleClass('hide');
			});
		}
		
		// 로그인 화면 보여주기
		function fn_showLogin(){
			$('.form').toggleClass('hide');
		}	
		
		// 로그인(login)
		function fn_login(){
			$('#login_btn').click(function(e){
				 if($('#kakaoLogin').val != "Y"){ // 회원 로그인일 때만 유효성 검사
					if($('#mId').val() == '' || $('#mPw').val() == ''){ // 아이디, 비밀번호 입력 값이 없을 경우
						alert('아이디와 비밀번호는 필수입니다.');
						e.preventDefault();
						$('#mId').focus();
						return false;
					} else if($('#kakaoLogin').val == "Y"){ // 카카오 로그인
						$('#f_mem').submit();
					}
				 }
			});
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
					<a href="#" onclick='fn_showLogin();'>로그인</a>
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
				<a href="eventPage.do">이벤트</a>
				<a href="infoRoom.do">객실</a>
			</div>
			
			<!-- 1900px 이상 화면일 때 -->
			<!-- right -->
			<div class="header_right"> 
				<span>Seoul</span>
				<span id="date2"></span>
				
				<!-- 비로그인 화면 -->
				<c:if test="${loginUser eq null && loginAdmin eq null}">
					<a href="#" onclick='fn_showLogin();'>로그인</a>
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
				<a href="eventPage.do">이벤트</a>
				<a href="infoRoom.do">객실</a>
			</div>
			
		</div>
	</header>
		
		<!-- 회원 화면 -->
		<div id="mem_mode" class="myMenu">
			<form id="f_mem" action="login.do" method="post">
				<!-- 카카오 계정으로 로그인 시 값을 전달해주기 위함(일반 로그인: N, 카카오 로그인: Y)-->
				<input type="hidden" name="kakaoLogin" id="kakaoLogin" value="N">
				<input type="hidden" name="mEmail" id="mEmail">
				
	  	   	 	<div class="form hide">
	  	   	 		<!-- 입력 화면 -->
	  	   	 		<h2 style="text-align:center">회원 로그인</h2>
					<a href="#" onclick='fn_showLogin();'><i class="fas fa-times fa-3x"></i></a>
					
					<!-- form2 -->
	   				<div class="form2">
	   				 	<!-- form3 : 아이디, 비밀번호-->
	     				<div class="form3">
	     					<label for="id">아이디</label><input type="text" name="mId" id="mId">
	      					<div class="clear"></div>
	      					<label for="password">비밀번호</label><input type="password" name="mPw" id="mPw">
	     				</div>
	     				
	     				<input type="submit" id="login_btn" value="로그인">
	     				<div class="clear"></div>
	     				
	     				<!-- form4 : 회원가입, 아이디/비밀번호 찾기, 카카오계정 로그인-->
	     				<!-- 회원 로그인 => 관리자로 로그인 전환 화면 -->
	     				<div class="form4">
	      					<div class="clear"></div>
    						<label><input type="button" value="회원가입" onclick="location.href='joinPage.do'"></label>
    						<label><input type="button" value="아이디/비밀번호 찾기" onclick="location.href='findIdAndPwPage.do'"></label>
    						<label><input type="button" id="mem_to_admin" value="관리자로 로그인하기"></label>
	    						
			     			<!-- 카카오계정 로그인 -->
							<a id="kakaoLogin_btn" href="javascript:kakaoLoginPopUp()">
								<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222">
							</a><br>
						</div> <!-- form4 -->
					</div> <!-- form2 -->
				</div>	<!-- form -->
			</form> 
		</div>	<!-- myMenu  -->
		
		<!-- 관리자 화면 -->
		<div id="admin_mode" class="myMenu hide">
			<form id="f_admin" action="loginAdmin.do" method="post">
	  	   	 	<div class="form hide">
	  	   	 		<!-- 입력 화면 -->
	  	   	 		<h2 style="text-align:center">관리자 로그인</h2>
					<a href="" onclick='fn_showLogin();'><i class="fas fa-times fa-3x"></i></a>
					
					<!-- form2 -->
	   				<div class="form2">
	   					<!-- form3 : 아이디, 비밀번호-->
	     				<div class="form3">
	     					<label for="id">아이디</label><input type="text" name="mId" id="mId2">
	      					<div class="clear"></div>
	      					<label for="password">비밀번호</label><input type="password" name="mPw" id="mPw2">
	     				</div>
	     				
	     				<input type="submit" id="login_btn2" value="로그인">
	     				<div class="clear"></div>
	     				
	     				<!-- form4 : 관리자 로그인 => 회원으로 로그인 전환 화면 -->
	     				<div class="form4">
	      					<div class="clear"></div>
	     					<label><input type="button" id="admin_to_mem" value="회원으로 로그인하기"></label>
						</div> <!-- form4 -->
					</div>	<!-- form2 -->
				</div>	<!-- form-->
			</form>
		</div>	<!-- myMenu -->
		
	<section id="section">
	