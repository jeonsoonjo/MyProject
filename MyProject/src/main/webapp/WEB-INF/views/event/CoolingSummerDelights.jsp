<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/SweetWalkOnTheClouds.css">
	<style>
		.btnGoPkg .btnGoPkgList {
			width: 86px;
		    height: 27px;
		    display: inline-block;
		    vertical-align: middle;
		    background: url(
		    resources/images/event/목록보기.PNG) no-repeat;
		    line-height: 100px;
		    overflow: hidden;
		}
	</style>

	<!-- 이벤트 내용 -->
	<div class="contents" id="contents">
		<div class="packViewWrap">
			<div class="packViewHead">
				<span class="btnGoPkg">
					<a class="btnGoPkgList" href="eventList.do">목록</a>
				</span>
			</div>
			<div class="packViewContent">
				<p class="packageTopImg">
					<img alt="시원한 여름의 기쁨" src="resources/images/event/Cooling Summer Delights_2.PNG">
				</p>
				<p class="packageTopTit">
					<img alt="시원한 여름의 기쁨" src="resources/images/event/Cooling Summer Delights_3.PNG">
				</p>
				<div class="packViewDesc">
					<p class="mTxt">
						더 파크뷰에서 한여름 더위를 식힐 시원한 음료를 선보입니다.
						<br>
						산뜻한 풍미와 넘치는 청량감이 매력적인 트로피컬 칵테일과
						<br class="brPC">
						함께 시원한 여름밤을 즐겨보시기 바랍니다.
					</p>
					<p class="mTxt">
						<br>
					</p>
					<p class="mTxt">기 간: 2021년 7월 15일 ~ 8월 31일 (월~목, 저녁)</p>
					<p class="mTxt">장 소 : The Parkview (1F)</p>
					<p class="mTxt">문 의 : 02-2230-3374</p>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
