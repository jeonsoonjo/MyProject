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
					<img alt="구름 위를 달콤한 산책" src="resources/images/event/Sweet Walk on the Clouds_2.PNG">
				</p>
				<p class="packageTopTit">
					<img alt="구름 위를 달콤한 산책" src="resources/images/event/Sweet Walk on the Clouds_3.PNG">
				</p>
				<div class="packViewDesc">
					<p class="mTxt">
						패스트리 부티크의 서머 시즌 시그니처 디저트인 다쿠아즈 아이스크림을 소개합니다.
						<br>
						폭신한 다쿠아즈와 홈메이드 아이스크림이 만나 입안에 신선한 즐거움을 선사합니다.
						<br class="brPC">
						이 계절에만 만날 수 있는 다쿠아즈 아이스크림으로 구름 위를 걷는 듯한 부드러운 달콤함을 즐겨 보시기 바랍니다.
					</p>
					<p class="mTxt">
						<br>
					</p>
					<p class="mTxt">기 간 : 2021년 5월 17일 ~ 8월 31일</p>
					<p class="mTxt">장 소 : Pastry Boutique(1F)</p>
					<p class="mTxt">문 의 : 02-2230-3377</p>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
