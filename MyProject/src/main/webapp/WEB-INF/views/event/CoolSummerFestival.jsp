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
					<img alt="시원한 여름 축제" src="resources/images/event/Cool Summer Festival_2.PNG">
				</p>
				<p class="packageTopTit">
					<img alt="시원한 여름 축제" src="resources/images/event/Cool Summer Festival_3.PNG">
				</p>
				<div class="packViewDesc">
					<p class="mTxt">
						더 파크뷰에서 시원하고 건강한 여름을 위한 보양식 면요리를 선보입니다.
						<br class="brPC">
						면 전문 셰프가 즉석으로 만들어 드리는 다채로운 여름의 별미를 즐겨보시길 바랍니다.
						<br>
					</p>
					<p class="mTxt">
						<br>
					</p>
					<p class="mTxt">기 간 : 2021년 6월 21일 ~ 2021년 8월 31일</p>
					<p class="mTxt">장 소 : The Parkview(1F)</p>
					<p class="mTxt">문 의 : 02.2230.3374</p>
					<p class="mTxt">
						<br>
					</p>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
