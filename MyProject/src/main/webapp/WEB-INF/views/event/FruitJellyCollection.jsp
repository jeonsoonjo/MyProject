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
					<img alt="과일 젤리 컬렉션" src="resources/images/event/Fruit Jelly Collection_2.PNG">
				</p>
				<p class="packageTopTit">
					<img alt="과일 젤리 컬렉션" src="resources/images/event/Fruit Jelly Collection_3.PNG">
				</p>
				<div class="packViewDesc">
					<p class="mTxt">
						상쾌하고 기분 좋은 여름 디저트를 소개합니다
						<br>
						신선한 과일 본연의 단맛과 향기로운 풍미가 돋보이는
						<br class="brPC">
						젤리 컬렉션을 패스트리 부티크에서 만나 보세요.
					</p>
					<p class="mTxt">
						<br>
					</p>
					<p class="mTxt">기 간 : 2021년 6월 7일 ~ 8월 31일</p>
					<p class="mTxt">장 소 : Pastry Boutique (1F)</p>
					<p class="mTxt">문 의 : 02-2230-3377</p>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
