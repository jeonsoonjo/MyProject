<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../layout/header2.jsp">
	<jsp:param value="마이페이지" name="title" />
</jsp:include>
	
	<link rel="stylesheet" href="resources/css/layout.css">
	<link rel="stylesheet" href="resources/css/myPage.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	
	<!-- script -->
	<script type="text/javascript">
		// 페이지 로드
		$(document).ready(function(){
			fn_updatePw();
			fn_presentPwCheck();
			fn_updateMember();
			fn_phoneCheck();
			fn_emailCheck();
			fn_emailCode();
			fn_leave();
			fn_fromKakao();
		});
	
		// 현재 비밀번호 확인(presentPwCheck)
		var presentPwPass = false;
		function fn_presentPwCheck(){
			$('#mPw0').keyup(function(){
				var obj ={ // 현재 비밀번호 객체 생성
						mpw : $('#mPw0').val()
				}
				$.ajax({
					url: 'presentPwCheck.do',
					type: 'post',
					data: JSON.stringify(obj), // 보내는 data 문자열화
					contentType: 'application/json', // 보내는 data가 json일 때, 필수 옵션
					dataType: 'json', // 받는 data
					success: function(resultMap){
						if (resultMap.isCorrect) { // 현재 비밀번호가 일치할 경우
							$('.mPw0_result').text('현재 비밀번호와 일치합니다.');
							$('.mPw0_result').css('color', '#804040');
							presentPwPass = true;
						} else {
							$('.mPw0_result').text('현재 비밀번호가 일치하지 않습니다. 확인하세요.');
							$('.mPw0_result').css('color', 'red');
							presentPwPass = false;
						}
					},
					error: function(xhr, textStatus, errorThrown) {
						
					}
				});
			});
		}
	
		// 비밀번호 변경(updatePw)
		function fn_updatePw(){
			$('#updatePw_btn').click(function(){
				if($('#mPw0').val() == ''){ // 현재 비밀번호를 입력하지 않을 경우
					alert('현재 비밀번호를 입력하세요.');
					$('#mPw0').focus();
					return false;
				} else if(!presentPwPass){ // 위 현재 비밀번호 통과하지 못 했을 경우(기존 비밀번호와 일치하지 않을 경우)
					alert('현재 비밀번호가 일치하지 않습니다. 확인해주세요.');
					$('#mPw0').focus();
					return false;
				} else if($('#mPw').val() == ''){ // 새로운 비밀번호를 입력하지 않을 경우
					alert('새 비밀번호를  입력하세요.');
					$('#mPw').focus();
					return false;
				} else if($('#mPw').val() != $('#mPw1').val()){ // 새로 입력한 비밀번호와 확인 검증이 이뤄지지 않을 경우
					alert('새로 입력한 비밀번호가 일치하지 않습니다. 확인해주세요.');
					return false;
				} else{
					$('#f').attr('action', 'updatePw.do');
					$('#f').submit();
				}
			});
		}
	
		// 전화번호 유효성 검사(phoneCheck)
		var phonePass = false;
		function fn_phoneCheck(){
			$('#mPhone').keyup(function(){
				// 전화번호 정규식
				var regPhone = /^010[0-9]{3,4}[0-9]{4}$/;
				if(regPhone.test($('#mPhone').val())){ // 전화번호 정규식 조건을 통과 했을 경우
					$('.phone_result').text('');
					phonePass = true;
				} else{
					$('.phone_result').text('010을 포함하여 -(하이픈) 없이 입력하세요.');
					$('.phone_result').css('color', 'red');
					phonePass = false;
				}
			});
		}
	
		// 이메일 중복 체크(emailCheck)
		var emailPass = false;
		function fn_emailCheck(){
			// 이메일 인증코드 버튼 비활성화(이메일을 변경하지 않을 경우 인증절차를 막기 위함)
			$('#emailCode_btn').click(function(){ }).prop("disabled", true); 
			$('#mEmail').keyup(function(){
				// 이메일 정규식
				var regEmail = /^[a-z0-9][a-z0-9_-]*@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
				if(!regEmail.test($('#mEmail').val())){ // 이메일 정규식 조건을 통과하지 못 했을 경우
					$('.email_result').text('이메일 형식에 맞지 않습니다. 다시 입력하세요.');
					$('.email_result').css('color', 'red');
					return false;
				}
				$.ajax({
					url: 'emailCheck.do',
					type: 'get',
					data: 'mEmail=' + $('#mEmail').val(),
					dataType: 'json',
					success: function(resultMap){
						if(resultMap.result == 0){ // DB에 일치하는 email이 없는 경우 인증버튼 활성화
							$('#emailCode_btn').click(function(){ }).prop("disabled", false);
							$('.email_result').text('사용 가능한 이메일입니다. 인증코드를 받으세요.');
							$('.email_result').css('color', '#804040');
							emailPass = true;
						} else if($('#mEmail').val() == '${loginUser.MEmail}'){ // 기존 이메일과 같을 경우 인증버튼 비활성화
							$('#emailCode_btn').click(function(){ }).prop("disabled", true);
							$('.email_result').text('이미 인증된 이메일입니다.');
							$('.email_result').css('color', '#804040');
							emailPass = false;
						} else{ // DB에 일치하는 email이 있는 경우 인증버튼 비활성화
							$('#emailCode_btn').click(function(){ }).prop("disabled", true);
							$('.email_result').text('이미 사용 중인 이메일입니다. 이메일 주소를 확인하세요.');
							$('.email_result').css('color', 'red');
							emailPass = false;
						}
					},
					error: function(xhr, textStatus, errorThrown) {
						
					}
				});
			});
		}
	
		// 이메일 인증코드 받기(emailCode)
		function fn_emailCode(){
			$('#emailCode_btn').click(function(){
				if($('#mEmail').val() == ''){ // 이메일을 입력하지 않을 경우
					alert('수정할 이메일을 입력하세요.');
					$('#mEmail').focus();
					return false;
				}
				$.ajax({
					url: 'emailCode.do',
					type: 'get',
					data: 'mEmail=' + $('#mEmail').val(),
					dataType: 'json',
					success: function(resultMap){
						alert('인증코드가 발송되었습니다. 메일을 확인하세요.');
						fn_emailAuth(resultMap.authCode);
					},
					error: function(xhr, textStatus, errorThrown) {
						
					}
				});
			});
		}
	
		// 이메일 인증(emailAuth)
		var authPass = false;
		function fn_emailAuth(authCode){
			$('#emailAuth_btn').click(function(){
				if(authCode == $('#userKey').val()){ // 받은 인증코드와 입력된 값이 같을 경우
					$('.emailAuth_result').text('인증되었습니다.');
					$('.emailAuth_result').css('color', '#804040');
					authPass = true;
				} else{
					$('.emailAuth_result').text('인증에 실패했습니다. 다시 시도해주세요.');
					$('.emailAuth_result').css('color', 'red');
					$('#mEmail').val() == '';
					authPass = false;
				}
			});
		}
	
		// 회원 정보 변경(updateMember)
		function fn_updateMember(){
			$('#update_btn').click(function(){
				// 이름, 전화번호, 이메일 중 하나라도 공백일 경우
				if($('#mName').val() == '' 
				   || $('#mPhone').val() == ''
				   || $('#mEmail').val() == ''){ 
					  alert('이름, 전화번호, 이메일은 필수정보 입니다. 내용을 입력하세요.');
					  return false;
				}
				// 기존에 값과 동일할 경우(하나라도 변경 하지 않았을 경우)
				if($('#mName').val() == '${loginUser.MName}'
			   	 	  && $('#mPhone').val() == '${loginUser.MPhone}'
				      && $('#mEmail').val() == '${loginUser.MEmail}'){ 
				      alert('변경된 정보가 없습니다.');
				      return false;
				}
				// 하나라도 변경된 정보가 있을 경우 회원정보 변경 성공(단, 이메일 변경 시에는 인증 필수)
				if($('#mName').val() != '${loginUser.MName}'
		   		   || $('#mPhone').val() != '${loginUser.MPhone}'
		   		   || $('#mEmail').val() != '${loginUser.MEmail}'){ 
						// 그중 이메일이 변경됐는데 이메일 인증을 안 했을 경우(회원정보 변경 불가)
						if($('#mEmail').val() != '${loginUser.MEmail}' && !authPass){
							alert('이메일 변경 시, 이메일 인증은 필수입니다.');
							return false;
					  	}
						$('#f').attr('action', 'updateMember.do');
						$('#f').submit();
				}
			});
		}
	
		// 회원 탈퇴(leave)
		function fn_leave(){
			$('#leave_btn').click(function(){
				if (confirm('정말 탈퇴하시겠습니까?')) {
					var inputPw = prompt("탈퇴하려면 비밀번호를 입력하세요.");
					/*  
						javaScript window 객체(Explorer 10 이상 지원) 사용
						atob() -> base64 스트링 디코딩(복호화)
						btoa() -> base64 스트링 인코딩(암호화)
					*/
					// prompt창에서 입력한 값(inputPw)을 암호화해서 기존 비밀번호와 비교
					if(btoa(inputPw) == '${loginUser.MPw}'){ // 비밀번호가 일치할 경우 탈퇴
						location.href = 'leave.do?mNo=${loginUser.MNo}';	
					} else{
						alert('비밀번호를 확인하세요.');
					} 
				}
			});
		}
	
		// 카카오 로그인일 경우 이메일 변경 불가
		function fn_fromKakao(){
			if($('#mId').val().indexOf('@K') > -1){
				$('#mEmail').keyup(function(){ }).prop("readonly", true); // 이메일 읽기만 가능
				$('.kakao_email').text('이메일 변경 불가(인증 필요 없음)');
				$('#mId, #mEmail').css('color', '#c0c0c0');
			}
		}
	</script>

	<!-- 마이페이지 화면 -->
	<div class="myPage_form">
		<form id="f" method="post">
			<h3>${loginUser.MId} 님 환영합니다!</h3>
			<input type="hidden" name="mNo" value="${loginUser.MNo}">
			
			<span class="naming">이름</span><br>
			<input type="text" name="mName" id="mName" value="${loginUser.MName}"><br><br>
			
			<span class="naming">아이디<span class="condition">(아이디는 수정 불가)</span></span><br>
			<input type="text" name="mId" id="mId" value="${loginUser.MId}" readonly><br><br>
			
			<span class="naming">현재 비밀번호</span><br>
			<input type="password" name="mPw0" id="mPw0"><br>
			<span class="mPw0_result"></span><br>
			<span class="naming">새 비밀번호</span><br>
			<input type="password" name="mPw" id="mPw"><br><br>
			<span class="naming">새 비밀번호 확인</span><br>
			<input type="password" name="mPw1" id="mPw1"><br><br>
			<input type="button" id="updatePw_btn" value="비밀번호 변경하기"><br><br>
			
			<span class="naming">전화번호</span><br>
			<input type="text" name="mPhone" id="mPhone" value="${loginUser.MPhone}"><br>
			<span class="phone_result"></span><br><br>
			
			<span class="naming">이메일</span><br>
			<input type="text" name="mEmail" id="mEmail" value="${loginUser.MEmail}"><br>
			<span class="email_result kakao_email"></span><br>
			<input type="button" id="emailCode_btn" value="인증코드 받기"><br>
			<input type="text" name="userKey" id="userKey" style="width:180px;">
			<input type="button" id="emailAuth_btn" value="인증하기" style="width:108px; height:45px;"><br>
			<span class="emailAuth_result"></span><br><br><br>
				
			<span class="naming">가입일 : ${loginUser.MRegdate}</span><br><br>
			
			<input type="button" id="update_btn" value="정보변경하기" style="width:150px; height:45px;">
			<input type="button" id="leave_btn" value="회원탈퇴" style="width:150px; height:45px;">
			<input type="button" id="reserv_btn" value="예약 내역 확인" onclick="location.href='myReservation.do?mNo=${loginUser.MNo}'" style="width:150px; height:45px;">
			<input type="button" value="돌아가기" onclick="location.href='index.do'" style="width:150px; height:45px;">
		</form>
	</div>
	
<%@ include file="../layout/footer.jsp" %>
