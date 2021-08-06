<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/layout.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="http://developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오 API -->
	
	<!-- CSS -->
	<style>
		.container{
			margin: 0 auto;
			width: 1200px;
			height: 500px;
			margin-top: 100px;
		}
		.login_form{
			margin: 0 auto;
			width: 400px;
			padding-top: 100px;
			text-align: center;
		}
		#f input{
			width: 300px;
			height: 50px;
			border: 1px solid black;
		}
		#f button{
			width: 300px;
			height: 50px;
			background-color: #f1e3c4;
			border: none;
		}
		#f button:hover {
			cursor: pointer;
		}
	</style>

	<!-- script -->
	<script type="text/javascript">
		// 페이지 로드
		$(document).ready(function(){
			fn_login();
		});
		
		// 로그인(login)
		function fn_login(){
			$('#f').submit(function(e){
				if($('#kakaoLogin').val == "N"){ // 일반 로그인일 때만 유효성 검사
					if($('#mId').val() == '' || $('#mPw').val() == ''){ // 아이디, 비밀번호 입력 값이 없을 경우
						alert('아이디와 비밀번호는 필수입니다.');
						e.preventDefault();
						$('#mId').focus();
						return false;
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
			        console.log(error);
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
						alert('회원가입 화면으로 이동합니다.');
						location.href = 'http://localhost:9090/myproject/joinPage.do';
					} else{ // DB에 일치하는 이메일이 있는 경우 해당 이메일로 로그인
						alert('카카오 계정으로 로그인합니다.');
						$('#kakaoLogin').val("Y");
						$('#f').submit();
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					
				}
			});
		}
		
		// 로그아웃(logout)
		/* 		
			function fn_logout(){
				if (!Kakao.Auth.getAccessToken()) {
					  location.href = 'logout.do';
				} else{
			     	Kakao.Auth.logout(function() {
			        	location.href = 'logout.do';
			    	});
				}
			}
		*/
	</script>
	
	<!-- 화면 -->
	<div class="container">
		<div class="login_form">
			<!-- 비로그인 화면 -->
			<c:if test="${loginUser == null}">
				<form id="f" action="login.do" method="post">
					<!-- MOOYA HOTEL 로그인(일반) -->
					<input type="text" name="mId" id="mId" placeholder="ID"><br><br>
					<input type="password" name="mPw" id="mPw" placeholder="Password"><br><br>
					
					<!-- 카카오 계정으로 로그인 시 값을 전달해주기 위함(일반 로그인: N, 카카오 로그인: Y)-->
					<input type="hidden" name="kakaoLogin" id="kakaoLogin" value="N"> 
					<input type="hidden" name="mEmail" id="mEmail">
					<button>로그인</button>
				</form>
				<br>
				
				<!-- 카카오 로그인 -->
				<a id="kakaoLogin_btn" href="javascript:kakaoLoginPopUp()">
					<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222">
				</a><br>

				<!-- 아이디&비번 찾기 -->
				<div class="find_form">
					<a href="findIdAndPwPage.do">아이디/비밀번호 찾기</a>
				</div><br>
			</c:if>
			
			<!-- 로그인 성공 화면 -->
			<c:if test="${loginUser != null}">
				<h3>${loginUser.MId} 님 환영합니다!</h3>
				<a href="myPage.do">마이페이지</a>
				<a href="logout.do">로그아웃</a>
				<!-- <a href="javascript:fn_logout()">(카카오)로그아웃</a> -->
			</c:if>

		</div>
	</div>
	
<%@ include file="../layout/footer.jsp" %> 

