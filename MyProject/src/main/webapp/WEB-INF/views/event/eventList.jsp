<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/eventList.css">
	
	<!-- 이벤트 리스트 -->
	<div class="ctnEvent">
		<div class="packageWrap">
			<div class="packList">
				<ul class="list">
					<li class="packBox first">
						<div class="box">
							<div class="photo">
								<a href="SweetWalkOnTheClouds.do">
									<img class="img" alt="구름 위를 달콤한 산책" src="resources/images/event/Sweet Walk on the Clouds.PNG">
								</a>
								<em class="ico">PSBQ</em>
							</div>
							<div class="packDesc">
								<h5 class="tit">
									<a href="SweetWalkOnTheClouds.do">Sweet Walk on the Clouds</a>
								</h5>
								<p class="date">
									2021-05-17 ~ 2021-08-31
								</p>
								<ul class="packDescList">
									서머 시즌 시그니처 디저트, 다쿠아즈 아이스크림
								</ul>
								<p class="price">
									5,200&nbsp;원
								</p>
							</div>
						</div>
					</li>
					<li class="packBox">
						<div class="box">
							<div class="photo">
								<a href="FruitJellyCollection.do">
									<img class="img" alt="과일 젤리 컬렉션" src="resources/images/event/Fruit Jelly Collection.PNG">
								</a>
								<em class="ico">PSBQ</em>
							</div>
							<div class="packDesc">
								<h5 class="tit">
									<a href="FruitJellyCollection.do">Fruit Jelly Collection</a>
								</h5>
								<p class="date">
									2021-06-07 ~ 2021-08-31
								</p>
								<ul class="packDescList">
									상쾌하고 기분 좋은 여름 디저트
								</ul>
								<p class="price">
									5,500&nbsp;원
								</p>
							</div>
						</div>
					</li>
					<li class="packBox">
						<div class="box">
							<div class="photo">
								<a href="SummerTaste.do">
									<img class="img" alt="여름의 맛" src="resources/images/event/夏味.PNG">
								</a>
								<em class="ico">PSBQ</em>
							</div>
							<div class="packDesc">
								<h5 class="tit">
									<a href="SummerTaste.do">夏味</a>
								</h5>
								<p class="date">
									2021-07-03 ~ 2021-08-31
								</p>
								<ul class="packDescList">
									한여름 보양식 메뉴
								</ul>
								<p class="price">
									160,000&nbsp;원
								</p>
							</div>
						</div>
					</li>
					<li class="packBox">
						<div class="box">
							<div class="photo">
								<a href="CoolSummerFestival.do">
									<img class="img" alt="시원한 여름 축제" src="resources/images/event/Cool Summer Festival.PNG">
								</a>
								<em class="ico">PSBQ</em>
							</div>
							<div class="packDesc">
								<h5 class="tit">
									<a href="CoolSummerFestival.do">Cool Summer Festival</a>
								</h5>
								<p class="date">
									2021-06-21 ~ 2021-08-31
								</p>
								<ul class="packDescList">
									여름 보양식 누들 특선
								</ul>
								<p class="price">
									119,000&nbsp;원
								</p>
							</div>
						</div>
					</li>
					<li class="packBox">
						<div class="box">
							<div class="photo">
								<a href="CoolingSummerDelights.do">
									<img class="img" alt="시원한 여름의 기쁨" src="resources/images/event/Cooling Summer Delights.PNG">
								</a>
								<em class="ico">PSBQ</em>
							</div>
							<div class="packDesc">
								<h5 class="tit">
									<a href="CoolingSummerDelights.do">Cooling Summer Delights</a>
								</h5>
								<p class="date">
									2021-07-15 ~ 2021-08-31
								</p>
								<ul class="packDescList">
									트로피컬 칵테일 이벤트
								</ul>
								<p class="price">
									129,000&nbsp;원
								</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>

<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
