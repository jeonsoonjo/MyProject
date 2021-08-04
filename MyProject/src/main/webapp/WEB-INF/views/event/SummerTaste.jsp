<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/summerTaste.css">
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
					<img alt="여름의 맛" src="resources/images/event/夏味_2.PNG">
				</p>
				<p class="packageTopTit">
					<img alt="여름의 맛" src="resources/images/event/夏味_3.PNG">
				</p>
				<div class="packViewDesc">
					<p class="mTxt">
						아리아께에서 한여름 원기회복을 위해 보양식 특선 코스 메뉴를 선보입니다.
						<br>
						장어, 민어, 전복 등 다양한 제철 메뉴와 함께
						<br class="brPC">
						여름의 미각 여행을 즐겨보시기 바랍니다.
					</p>
					<p class="mTxt">
						<br>
					</p>
					<p class="mTxt">기간: 2021년 7월3일 ~ 8월 31일</p>
					<p class="mTxt">장소 : Ariake (2F)</p>
					<p class="mTxt">문의 : 02.2230.3356</p>
				</div>
				<div class="packProductDesc">
					<div class="packProductDesc">
						<ul>
							<li class="first">
								<dl>
									<dt>| 점심</dt>
									<dd class="descImg"> </dd>
									<dd class="descTxt">
										<li class="first">단호박찜</li>
										<li>제철 생선회</li>
										<li>꼬치고기 보리된장구이</li>
										<li>한치 물회 (국내산 오징어)</li>
										<li>장어덮밥 (국내산 장어 │ 국내산 쌀)</li>
										<li>토마토 셔벗</li>
										<br>
										<li>
											<b>160,000원</b>
										</li>
										<div class="detailBtnBox"></div>
									</dd>
								</dl>
							</li>
							<li class="last">
								<dl>
									<dt>| 저녁</dt>
									<dd class="descImg"> </dd>
									<dd class="descTxt">
										<li class="first">3종 전채</li>
										<li>하모 도빙무시</li>
										<li>제철 생선회</li>
										<li>민어 스테이크</li>
										<li>새우와 한우등심 튀김 (국내산 쇠고기)</li>
										<li>한치 물회 (국내산 오징어)</li>
										<li>전복 솥밥 (국내산 쌀)</li>
										<li>토마토 셔벗</li>
										<br>
										<li>
											<b>230,000원</b>
										</li>
										<div class="detailBtnBox"></div>
									</dd>
								</dl>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
