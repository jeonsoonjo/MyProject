<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
  
  	<script type="text/javascript">
	  	onload = function(){
	  		var thumbnails = document.getElementsByClassName('thumbnail');
			// var thumbnails = document.querySelectorAll('.thumbnail');
			for (let i = 0; i < thumbnails.length; i++) {
				thumbnails[i].addEventListener('click', function(){
					// data-img 속성 값을 저장하고 있는 이벤트 객체 : this
					// this.getAttribute('data-img')
					// this.dataset.img
					document.getElementById('large-image').setAttribute('src', this.dataset.img);
				});
			}
		    document.getElementById('amenity').onclick = function(){
		    	window.open('amenity.do', '', 'width=640, height=480, resizable=no');
			}
			document.getElementById('satellite channel').onclick = function(){
		    	window.open('satelliteChannel.do', '', 'width=520, height=520, resizable=no');
			}
			document.getElementById('floorPlan').onclick = function(){
		    	window.open('floorPlan.do', '', 'width=640, height=480, resizable=no');
			}
			document.getElementById('inquire').onclick = function(){
		    	location.href= "inquire.do";
			}
			document.getElementById('reservation').onclick = function(){
		    	location.href= "reservationSelectDatePage.do";
			}
			document.getElementById('privacy').onclick = function(){
		    	window.open('privacy.do', '', 'width=640, height=480, resizable=no');
			}
			document.getElementById('term').onclick = function(){
		    	window.open('term.do', '', 'width=640, height=480, resizable=no');
			}
			document.getElementById('noEmail').onclick = function(){
		    	window.open('noEmail.do', '', 'width=400, height=352, resizable=no');
			} 
			getDate();
			
			$('<input type="hidden" name="page" value="priceRoom.do">')
			.appendTo( $('.form') )
			$('<input type="hidden" name="rNo" value="${roomDTO.RNo}">')
			.appendTo( $('.form') )
	  	}
  	</script>
	
		<div id="container">
			
			<br><br>
			
			<h1>룸 가격 페이지</h1>
			
			<form id="f" method="post">
			
				<input type="hidden" name="no" value="${roomDTO.RNo}" disabled>
				
				룸 이름<br>
				<input type="text" name="rName" value="${roomDTO.RName}" disabled><br><br>
				
				룸 가격<br>
				<input type="number" name="rPrice" value="${roomDTO.RPrice}" disabled><br><br>
				
				룸 등급<br>
				<input type="number" name="rGrade" value="${roomDTO.RGrade}" disabled><br><br>
				
				룸 수용인원<br>
				<input type="number" name="rAccept" value="${roomDTO.RAccept}" disabled><br><br>
				
				룸 사이즈<br>
				<input type="number" name="rSize" value="${roomDTO.RSize}" disabled><br><br>
				
				룸 이미지<br>
				<div>
					<img src="${roomDTO.RImg}" id="large-image">
				</div>
				<ul class="rImg">
					<li><img src="${roomDTO.RImg}" class="thumbnail" data-img="${roomDTO.RImg}"></li>
					<li><img src="${roomDTO.RImg1}" class="thumbnail" data-img="${roomDTO.RImg1}"></li>
					<li><img src="${roomDTO.RImg2}" class="thumbnail" data-img="${roomDTO.RImg2}"></li>
					<li><img src="${roomDTO.RImg3}" class="thumbnail" data-img="${roomDTO.RImg3}"></li>
					<li><img src="${roomDTO.RImg4}" class="thumbnail" data-img="${roomDTO.RImg4}"></li>
					<li><img src="${roomDTO.RImg5}" class="thumbnail" data-img="${roomDTO.RImg5}"></li>
				</ul>
				
			</form>
			
			<hr>
			
			<div class="leftArea">
				<img alt="left" src="resources/images/priceRoom/leftArea.PNG"><br>
				<img style="cursor: pointer;" id="amenity" alt="객실어매니티" src="resources/images/priceRoom/객실어매니티.PNG">
				<table class="tableRoomInfo">
					<tbody>
						<tr class="first">
							<th scope="row">
								객실이용
							</th>
							<td>
								<div class="introList">
									<ul>
										<li class="first">55인치 스마트 TV(위성 TV 48개 채널)  <span style="cursor: pointer;" id="satellite channel"><i class="fas fa-tv">위성채널정보 보기</i></span></li>
										<li>50~100Mbps 초고속 유·무선(wifi) 인터넷 무료</li>
										<li>220V, 110V 전압 사용 가능</li>
										<li>커피·차 티백 무료 제공</li>
										<li>엑스트라 베드 1개 추가 36,300원/1박</li>
										<li>베이비 크립(무료)</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								부대시설
							</th>
							<td>
								<div class="introList">
									<ul>
										<li class="first">
											피트니스 클럽 이용 안내
											<br>
											- 체육관(Gym) 무료 이용(만 16세 이상 입장 가능)
											<br>
											- 실내 수영장 무료 이용(만 13세 이상 입장 가능)
											<br>
											&nbsp;&nbsp;&nbsp;(단, 주말 및 공휴일에는 성인 보호자의 보호 하에
											<br>
											&nbsp;&nbsp;&nbsp;만 13세 미만인 고객이 이용 가능하며,
											<br>
											&nbsp;&nbsp;&nbsp;신장 140cm 미만인 고객은 성인 보호자의 보호 하에
											<br>
											&nbsp;&nbsp;&nbsp;구명조끼 착용 시 이용 가능)
											<br>
											- 사우나 이용시 유료(만 13세 이상 입장 가능)
											<br>
											- 피트니스 클럽은 매월 세 번째 수요일 정기휴일입니다.
										</li>
										<li class="last">투숙 기간 내 무료 주차 가능</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr class="last">
							<th scope="row">
								룸서비스
							</th>
							<td>
								<div class="introList">
									<ul>
										<li class="first">객실에서 즐기실 수 있는 다양한 룸서비스 메뉴가 준비되어 있습니다.</li>
										<li>식사 및 음료 : 24시간 서비스</li>
										<li>중식, 일식 : 점심 12:00~14:00, 저녁 18:00~21:30</li>
										<li class="last"><a href="download.do"><img alt="다운로드" src="resources/images/priceRoom/룸서비스메뉴다운로드.PNG"></a></li>
									</ul>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="rightArea">
				<ul class="btnSet">
					<li class="first">
						<img style="cursor: pointer;" id="floorPlan" src="resources/images/priceRoom/floorPlan.JPG" alt="도면보기">
					</li>
					<li>
						<img style="cursor: pointer;" id="inquire" src="resources/images/priceRoom/inquire.JPG" alt="문의하기">
					</li>
					<li class="last">
						<img style="cursor: pointer;" id="reservation" src="resources/images/priceRoom/reservation.JPG" alt="예약하기">
					</li>
				</ul>
				<div class="HotelInfoBox">
					<div class="HotelBoxTop">
						<div class="conTitle1">
							<h3 class="title">Hotel Info.</h3>
						</div>
						<p class="title">조식 이용 안내</p>
						<div class="useIntro">
							<p>- 더 파크뷰 06:00~10:00(주중/주말/공휴일)</p>
							<p>- 더 라이브러리 08:00~11:30</p>
							<p style="text-indent: -16px; padding-left: 24px;">
							※ 현재 더 라이브러리는 코로나19로 인한 운영시간 
							<br>
							  축소로 조식 운영을 하지 않고 있사오니 이용에 
							<br>
							  참고 부탁드립니다.
							</p>
						</div>
						<div class="introBtm" style="min-height: 0px;">
							<p class="title">체크인/체크아웃 시간</p>
							<div class="useIntro">
								<p>- 체크인 : 오후 3시 이후</p>
								<p>- 체크아웃 : 낮 12시 </p>
								<p>※ 2021년 10월 1일부터 체크인은 오후 2시 이후, 체크아웃은 오전 11시까지로 변경됩니다.</p>
							</div>
						</div>
						<div class="introBtm" style="min-height: 0px;">
							<p class="title">취소/변경 및 노쇼(No-show) 안내</p>
							<div class="useIntro">
								<p style="letter-spacing: -0.3px;">- 숙박 예정일 1일 전 18시까지는 위약금 없음</p>
								<p style="letter-spacing: -0.3px;">- 숙박 예정일 1일 전 18시 이후 취소/변경/노쇼 발생 시</p>
								<p style="padding: 0px 18px;">
								 성수기(5월~10월, 12월 24일~31일) :
								<br>
								 최초 1일 숙박 요금의 80%가 위약금으로 부과
								<br>
								 비수기(성수기 외 기간) :
								<br>
								 최초 1일 숙박 요금의 10%가 위약금으로 부과
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	
<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>