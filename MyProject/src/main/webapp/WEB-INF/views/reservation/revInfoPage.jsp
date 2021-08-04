<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:include page="../layout/header2.jsp">
	<jsp:param value="홈페이지제목" name="title" />
</jsp:include>
<!DOCTYPE html >
<html>
<head>
<meta  charset=UTF-8>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="resources/css/loginWindow.css"> 
	<link rel="stylesheet" href="resources/css/optionPage.css">
 
	<script type="text/javascript">
	$(document).ready(function(){
		fn_check();	//체크박스 누름 => 회원과 같은 정보 뿌려줌
		fn_emailCheck();	//이메일 형식검사
		fn_email_code();	//이메일 확인 버튼 누름
		fn_email_auth();	//이메일 코드 확인 검사
		fn_doReservation();	//예약하기 버튼 누름
		fn_closeLogin();	// 로그인창에서 x 클릭시 로그인창 닫히고 , 열림반복
		fn_toggle_mode(); 	// 관리자 로그인 모드 / 회원 로그인 모드로 변경하는 버튼
	});	
	
	
	// 체크박스('회원정보와 동일하다') 클릭시, 정보 뿌려줌
	function fn_check(){
		$('#sameUser_box').click(function(){
			if($("input:checkbox").is(":checked") == true) {
				
				//로그인 안되어있을시 , 로그인 div보여주기
				<c:if test="${empty loginUser}">
					if(confirm('로그인 하시겠습니까 ?')){
						//로그인 툴 보여주기
						$('.form').toggleClass('hide');
					} 
					$('input').prop("checked", false);	//로그인 안할시, 체크박스 해제	
					//$('.form').toggleClass('hide');	 회원제로만 운영할시 , if문~$('input') 삭제하고 이것만 넣어주면 댐
				</c:if>

				//로그인 되어있을시, 그냥 회원정보 띄워주기
				<c:if test="${ not empty loginUser}">
					authPass = true;
					$('#booker').val('${loginUser.getMName()}');
					$('#reEmail').val('${loginUser.getMEmail()}');
					$('#tel').val('${loginUser.getMPhone()}');
					$('#emailChk').toggleClass('hide');
					$('#email').toggleClass('hide');
				</c:if>
				
			}//if끝
			else{	// 체크 되어있는 상태일 때
				authPass = false;
				$('#booker').val('');
				$('#reEmail').val('');
				$('#tel').val('');
				$('#emailChk').toggleClass('hide');
				$('#email').toggleClass('hide');
			}
		});
	}
	
	//이메일 형식 검사	
	function fn_emailCheck(){
		$('#reEmail').blur(function(){
			var regEmail =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!regEmail.test($('#reEmail').val())){ // reEmail정규식 조건을 통과하지 못 했을 경우
				$('.email_result').text('이메일 형식이 잘못입력되었습니다.');
				return false;
			}else{//정규식 통과시
				$('.email_result').text('');
			}
			fn_email_code();
		});
	}
		
	// 이메일 인증코드 받기(emailCode)
	// 이메일 인증코드 받기(root-context에서 이메일 bean 생성)
	function fn_email_code(){
		$('#email_code_btn').click(function(){
			if($('#reEmail').val() == ''){
				alert('이메일을 입력하세요.');
				$('#reEmail').focus();
				return false;
			}
			$.ajax({
				url: 'emailCode.do',
				type: 'get',
				data: 'mEmail=' + $('#reEmail').val(),
				dataType: 'json',
				success: function(resultMap){
					alert('인증코드가 발송되었습니다. 메일을 확인하세요.');
					fn_email_auth(resultMap.authCode);
					alert(resultMap.authCode);	//편의상 달아놓았습니다.. ^^!
				},
				error: function(xhr, textStatus, errorThrown) {
					
				}
			});
		});
	}
	
	// 이메일 인증(emailAuth)
	var authPass = false;
	function fn_email_auth(authCode){
		$('#email_auth_btn').click(function(){
			if(authCode == $('#user_key').val()){
				$('.emailAuth_result').text('인증되었습니다.');
				authPass = true;
			} else{
				$('.emailAuth_result').text('인증에 실패했습니다. 다시 시도해주세요.');
				authPass = false;
			}
		});
	}
	
	//(1.로그인 했는지) => 2.이메일 인증했는지 + (이름,휴대폰 적었는지) => 3. 됐다면 (영수증)페이지 이동 / 아니라면 안내문자
	function fn_doReservation(){
		$('#doReservation_btn').click(function(){
			
			
				if($('#booker').val()==''){
					alert('예약자명은 필수입니다.');
					return false;
				}else if($('#tel').val()==''){
					alert('전화번호는 필수입니다.');
					return false;
				}else if( authPass==false){
					alert('이메일 인증은 필수입니다.');
					return false;
				}else{
					$('#f').attr('action','receiptPage.do');
					$('#f').submit();
				}
				
		});
	}
	
	//로그인 관련 script
    function fn_closeLogin(){
			$('.cancel_btn').on('click',function(){
				$('.form').toggleClass('hide');
			});
			$('#closeLogin').on('click',function(){
				$('.form').toggleClass('hide');
			});
		}	
	
	function fn_toggle_mode(){
		$('#mem_to_admin').click(function(){
			$('#mem_mode').toggleClass('disabled');
			$('#admin_mode').toggleClass('disabled');
		});
		
		$('#admin_to_mem ').click(function(){
			$('#mem_mode').toggleClass('disabled');
			$('#admin_mode').toggleClass('disabled');
		});
		
	}
	</script>
	 
</head>
<body>
<div id="box_middle">
	<h1>예약정보</h1>
	<form id="f">
	<!-- 파라미터 값들(hidden) -->
		<input type="hidden" id="rNo" name="rNo" value="${rNo}">
	 	<input type="hidden" name="checkIn" value="${checkIn}">
	 	<input type="hidden" name="checkOut" value="${checkOut}">
	 	<input type="hidden" name="people" value="${people}">
	 	<input type="hidden" name="food" value="${food}">
	 	<input type="hidden" name="totalPay" value="${totalPay}">
	 	
		<table>
			<thead>
				<tr>
					<!-- 체크시 ${loginUser}의 이름/이메일/휴대폰  뿌려줌 -->
					<td colspan="2"> <label><input type="checkbox" id="sameUser_box"> 회원정보와 동일합니다 </label> </td> 
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>이름</td>
					<td><input type="text" name="booker" id="booker"> </td>
				</tr>
				<tr id="email">
					<td>이메일</td>
					<!-- 이메일 인증할 계정 + 이메일 정규식 적용 -->
					<td> 
					<input type="text" name="reEmail" id="reEmail"> 
					<input type="button" id="email_code_btn"  value="인증번호 전송"><br>
					<span class="email_result"></span>  
					</td>
				</tr>
				<tr id="emailChk">
					<td>이메일 인증코드</td>
					<!-- 이메일 인증하기 -->
					<td> 
						<input type="text" id="user_key">
						<input type="button" id="email_auth_btn" value="인증확인"> <br>
						<span class="emailAuth_result"></span> 
					</td>
				</tr>
				<tr>
					<td>휴대폰 </td>
					<td><input type="text" name="tel" id="tel"> </td>
				</tr>
				<tr>
					<td>요청사항</td>
					<td><textarea rows="10" cols="40" name="note"></textarea> </td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"> <input type="button" id="doReservation_btn" value="예약하기"> </td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

	<div id="mem_mode" class="myMenu">
		<form action="login.do" method="post">
			<input type="hidden" id="rNo" name="rNo" value="${rNo}">
		 	<input type="hidden" name="checkIn" value="${checkIn}">
		 	<input type="hidden" name="checkOut" value="${checkOut}">
		 	<input type="hidden" name="people" value="${people}">
		 	<input type="hidden" name="food" value="${food}">
		 	<input type="hidden" name="totalPay" value="${totalPay}">
		 	
  	   	 	<div class="form hide">
  	   	 		<input type="hidden" name="page" value="revInfoPage.do">
  	   	 		<h2 style="text-align:center">회원 로그인</h2>
				<a id="closeLogin"><i class="fas fa-times fa-3x"></i></a>
   				 <div class="form2">
     				<div class="form3">
     					<label for="id">아이디</label><input type="text" name="mId" id="mId">
      					<div class="clear"></div>
      					<label for="password">비밀번호</label><input type="password" name="mPw" id="mPw">
     				</div>	<!-- form3 -->
     				<input type="submit" id="login_btn" value="로그인">
     				<div class="clear"></div>
     				<div class="form4">
      					<div class="clear"></div>
     						<label><input type="button" value="회원가입"></label>
     						<label><input type="button" value="아이디/비밀번호 찾기"></label>
     						<label><input type="button" id="mem_to_admin" value="관리자로 로그인하기"></label>
					</div>	<!-- form4 -->
				</div>	<!-- form2 -->
			</div>	<!-- form -->
			</form>
		</div>	<!-- myMenu -->
		
		<div id="admin_mode" class="myMenu disabled">
			<form action="loginAdmin.do" method="post">
  	   	 	<div class="form hide">
  	   	 		<input type="hidden" name="page" value="revInfoPage.do">
  	   	 		<h2 style="text-align:center">관리자 로그인</h2>
				<a id="closeLogin"><i class="fas fa-times fa-3x"></i></a>
   				 <div class="form2">
     				<div class="form3">
     					<label for="id">아이디</label><input type="text" name="mId" id="mId">
      					<div class="clear"></div>
      					<label for="password">비밀번호</label><input type="password" name="mPw" id="mPw">
     				</div>	<!-- form3 -->
     				<input type="submit" id="login_btn" value="로그인">
     				<div class="clear"></div>
     				<div class="form4">
      					<div class="clear"></div>
     						<label><input type="button" id="admin_to_mem" value="회원으로 로그인하기"></label>
					</div>	<!-- form4 -->
				</div>	<!-- form2 -->
			</div>	<!-- form -->
			</form>
		</div>	<!-- myMenu -->
</body>
</html>
<%@ include file="../layout/footer.jsp" %> 
