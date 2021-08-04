<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../layout/header2.jsp">
	<jsp:param value="비밀번호 변경" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/layout.css">
	<link rel="stylesheet" href="resources/css/changePw.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	
	<!-- script -->
	<script type="text/javascript">
		// 페이지 로드
		$(document).ready(function(){
			fn_pwCheck();
			fn_pwCheck2();
			fn_changePw();
		})
	
		// 새 비밀번호 검증(pwCheck)
		var pwPass = false;
		function fn_pwCheck(){
			$('#mPw').keyup(function(){
				// 비밀번호 정규식
				var regPW = /^[0-9]{4}$/; 
				if(regPW.test($('#mPw').val())){ // 비밀번호 정규식 조건을 통과 했을 경우
					$('.pw_result').text('사용 가능한 비밀번호입니다.');
					$('.pw_result').css('color', '#804040');
					pwPass = true;
				} else{
					$('.pw_result').text('비밀번호는 숫자(0~9) 4자리만 입력 가능합니다.');
					$('.pw_result').css('color', 'red');
					// 실제 사용할 PW 정규식
					// ^[A-Za-z0-9`~!@#$%^&*]{4,19}$
					// 비밀번호는 영어 대,소문자/숫자/특수기호 포함 5~20자리 입니다.
					pwPass = false;
				}
			});
		}
	
		// 새 비밀번호 확인 검증(pwCheck2)
		var pwPass2 = false;
		function fn_pwCheck2(){
			$('#mPw2').keyup(function(){
				if($('#mPw').val() == $('#mPw2').val()){ // 입력한 비밀번호와 비밀번호 확인 값이 일치할 경우
					$('.pw2_result').text('비밀번호가 일치합니다.');
					$('.pw2_result').css('color', '#804040');
					pwPass2 = true;
				} else{
					$('.pw2_result').text('새로 입력한 비밀번호가 일치하지 않습니다. 확인하세요.');
					$('.pw2_result').css('color', 'red');
					$('#mPw2').focus();
					pwPass2 = false;
				}
			});
		}
	
		// 비밀번호 변경(changePw)
		function fn_changePw(){
			$('#changePw_btn').click(function(){
				if($('#mPw').val() == ''){ // 비밀번호 입력하지 않을 경우
					alert('비밀번호를 입력하세요.');
					$('#mPw').focus();
					return false;
				} else if(!pwPass){ // 비밀번호 정규식 조건을 통과하지 못 했을 경우
					alert('비밀번호 조건을 확인하세요!');
					$('#mPw').focus();
					return false;
				} else if($('#mPw2').val() == ''){ // 비밀번호 확인 입력하지 않을 경우
					alert('비밀번호 확인 검증을 해주세요!');
					$('#mPw2').focus();
					return false;
				} else if(!pwPass2){ // 비밀번호 확인 검증이 이뤄지지 않을 경우
					alert('새로 입력한 비밀번호가 일치하지 않습니다!');
					return false;
				} else{
					$('#f').attr('action', 'changePw.do');
					$('#f').submit();
				}
			});
		}
	</script>
	
	<!-- 비밀번호 변경 화면 -->
	<div class="container">
		<div class="changePw_from">
			<form id="f" method="post">
				<h3>비밀번호 변경</h3><br><br>
				<span class="naming">새 비밀번호</span><br>
				<input type="password" name="mPw" id="mPw"><br>
				<span class="pw_result"></span><br><br>
				
				<span class="naming">비밀번호 확인</span><br>
				<input type="password" name="mPw2" id="mPw2"><br>
				<span class="pw2_result"></span><br><br>
				
				<input type="hidden" name="mEmail" value="${memberDTO.MEmail}">
				<input type="button" id="changePw_btn" value="비밀번호 변경">
				<input type="button" value="돌아가기" onclick="location.href='index.do'">
			</form>
		</div>
	</div>

<%@ include file="../layout/footer.jsp" %> 
