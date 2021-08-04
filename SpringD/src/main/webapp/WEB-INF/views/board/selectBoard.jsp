<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/loginWindow.css"> 
	<link rel="stylesheet" href="resources/css/selectBoard.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	
	<script>
		$(function(){
			fn_delete();	// 삭제 버튼 클릭시
			fn_update();	// 수정 버튼 클릭시
			fn_reply_no_login();	// 로그인 없이 댓글 달기 시도할 때
			fn_reply_btn();	// 로그인 후 댓글 달기 클릭시


			fn_getReplyList();	// 댓글 출력 함수
			
  	   	 	$('<input type="hidden" name="page" value="selectBoard.do">')
			.appendTo( $('.form') )
			
			$('<input type="hidden" name="bIdx" value="${Board.BIdx}">')
			.appendTo( $('.form') )
		});	// onload


		
		// 댓글 불러오기 함수
		function fn_getReplyList(){
				$.ajax({
					url: 'getReplyList.do',
					type: 'get',
					async: false,
					data: 'bIdx=${Board.BIdx}&page=${page}',
					dataType: 'json',
					success: function(resultMap){
						fn_makeReply(resultMap.list);		
						$('#reply_paging').empty();
						$('#reply_paging').html(resultMap.paging);
						
						totalReply = resultMap.totalReply;
						
						for( let k = 0; k < resultMap.totalReply; k++ ){
							page_arr[k] = 1;	// 페이징, 일단 모두 1로 초기화
						}
						
					},	// end of success
					error: function(){
						alert('목록 불러오기 오류');
					}
				})	// ajax
		} 
		
		function fn_paging() {
			
			for(let k = 0; k < totalReply; k++){
			
				// 각 댓글마다 대댓글 페이징 링크 걸기
					$('.re_reply_paging:eq(' + k + ')').on('click', '.previous_block', function(){
					page_arr[k] = $(this).attr('data-page');
					var box = $(this).parent().parent().parent().children('.btn');	
					$(box).parent().children('.re_reply').toggleClass('hide');
					fn_child_reply(box, parent[k]);
				}); 
				
				$('.re_reply_paging:eq(' + k + ')').on('click', '.go_page', function(){
					page_arr[k] = $(this).attr('data-page');
					var box = $(this).parent().parent().parent().children('.btn');
							
					$(box).parent().children('.re_reply').toggleClass('hide');
					fn_child_reply(box, parent[k]);
				});
				
					$('.re_reply_paging:eq(' + k + ')').on('click', '.next_block', function(){
					page_arr[k] = $(this).attr('data-page');
					var box = $(this).parent().parent().parent().children('.btn');
					$(box).parent().children('.re_reply').toggleClass('hide');
					fn_child_reply(box, parent[k]);
				}); 
			}
		}
 				
		// 각 댓글의 대댓글 페이징을 위한 변수
		let page_arr = [];
		let parent = [];
		// 게시물의 총 댓글 수 저장.
		var totalReply;
		
		// 답글 버튼 클릭시 펼치기
		function fn_child_reply(box ,parent){
			
			// 숨겨놨던 대댓글 부분 보이게 해주기.
			$(box).parent().children('.re_reply').toggleClass('hide');
			
			var paging = null;
			var index = $('.btn').index(box);
			
			$.ajax({
				url: 'getChildList.do',
				type: 'post',
				async: false,
				data: 're_page=' + page_arr[index] + '&parent=' + parent + '&bIdx=${Board.BIdx}',
				dataType: 'json',
				success: function(resultMap){
					fn_makeReReply(box, resultMap.list, parent);
					
					// 대댓글 페이징 만들기
 					var paging = resultMap.paging;
					
					var paging_box = $(box).parent().children('.re_reply').children('.re_reply_paging');
					
					paging_box.empty();
					
					// 대댓글이 없다면 함수 끝냄
					if(paging.endPage == 0){ return; } 
					
					if(paging.beginPage <= paging.pagePerBlock){
						$('<div>')
						.addClass('disable')
						.text('◀')
						.appendTo(paging_box);
					} else {  // 이전('◀')이 있음
						// class
						// 1. previous_block : click 이벤트에서 활용
						// 2. link : cursor pointer
						$('<div>')
						.addClass('previous_block').addClass('link')
						.attr('data-page', paging.beginPage - 1)
						.text('◀')
						.appendTo(paging_box);
					}
					for(let p = paging.beginPage; p <= paging.endPage; p++){
						if(p == paging.page) {
							$('<div>')
							.addClass('now_page')
							.text(p)
							.appendTo(paging_box);
						} else {
							// class
							// 1. go_page : click 이벤트에서 활용
							// 2. link : cursor pointer
							$('<div>')
							.addClass('go_page').addClass('link')
							.attr('data-page', p)
							.text(p)
							.appendTo(paging_box);
						}
					}
					// 4) 다음('▶')
					if (paging.endPage == paging.totalPage) {  // 다음('▶')이 없음(마지막 블록)
						// class
						// 1. disable : color silver
						$('<div>')
						.addClass('disable')
						.text('▶')
						.appendTo(paging_box);
					} else {  // 다음('▶')이 있음
						// class
						// 1. next_block : click 이벤트에서 활용
						// 2. link : cursor pointer
						$('<div>')
						.addClass('next_block').addClass('link')
						.attr('data-page', paging.endPage + 1)
						.text('▶')
						.appendTo(paging_box);
					} 
			
					fn_paging();

					
				},	// success
			}) 

		} 
		
		
		// 대댓글 출력함수
		function fn_makeReReply(box, list, parent){
			// 원래 있던 대댓글 지우고 다시 출력(중복해서 쌓이는것을 방지)
			$(box).parent().children('.re_reply').children('#child' + parent).remove();
			
			$.each(list, function(i, reply){
				
				$('<div class="child" id="child' + parent + '">')
				.append( $('<div class="child_writer_box">').append( $('<i class="fab fa-replyd fa-2x"></i>') ).append( $('<span style="margin-left:10px">').text(reply.mid) )  )
				.append( $('<div class="child_content_box">').append( $('<span>').text(reply.rcontent) )  )
				.append( $('<div class="child_date_box">').append( $('<span>').text(reply.rpostDate) )  )
				.appendTo( $(box).parent().children('.re_reply') );
				
			});	// each
		}
		
		// 대댓글 삽입 함수
		function fn_insert_re_re(parent){
			var content = $('#re_re' + parent).val();
			
			if(${loginUser == null && loginAdmin == null}){
				$('.form').toggleClass('hide');	
				$('#mId').focus();
				return;
			}
			
			if(content == null || content == ""){
				alert('댓글 내용을 입력하세요.')
				return;
			}
			
			if(confirm('대댓글을 등록하시겠습니까?')){		
				$.ajax({
					url: 'insertReReply.do',
					type: 'get',
					data: 'bIdx=${Board.BIdx}' + '&mId=${loginUser.MId}' + '&parent=' + parent + '&content=' + content,
					async: false,
					success: function(){
						$('#reply_list').empty();
						fn_getReplyList();
					},
					error: function(){
						
					}
				})
			}
		}	// fn_insert_re_re(parent)
		
		// 댓글 불러오기 함수
		function fn_makeReply(list, paging){

			$.each(list, function(i, reply){
				parent[i] = reply.ridx;
				
				$('<div class="reply_box">')
				.append( $('<div class="writer_box">').append( $('<span>').text(reply.mid) )  )
				.append( $('<div class="content_box">').append( $('<span>').text(reply.rcontent) )  )
				.append( $('<div class="date_box">').append( $('<span>').text(reply.rpostDate) )  )
				.append( $('<input type="button" value=">> 답글" class="btn" onclick="fn_child_reply(this,' + parent[i] + ')">'))
				.append( $('<div class="hide re_reply" id=re_reply' + parent[i] + '>')
				.append( $('<div class="re_re_box">')
					.append( $('<i class="fab fa-replyd fa-2x"></i>') )	
					.append( $('<input type="text" class="re_re_content" id="re_re' + parent[i] + '">') )		
					.append( $('<input type="button" value="작성" class="re_btn" onclick="fn_insert_re_re(' + parent[i] +')">') )
						)
						.append( $('<div class="re_reply_paging">') )
						.append( $('<input type="hidden" id="re_reply_paging_no' + i + '" value="' + i + '">') )
				)
				.appendTo( $('#reply_list') );
			});	// each 
		}
		
		// 댓글 달기 버튼 클릭시
		function fn_reply_btn(){
			$('#reply_btn').click(function(){
				if(confirm('댓글을 등록하시겠습니까?')){
					$('#f_reply').attr('action', 'insertReply.do');
					$('#f_reply').submit();
				}
			});	// onclick
			
		}
		
		// 로그인 없이 댓글 달려고 할 때,
		function fn_reply_no_login(){
			$('#reply_no_login').focus(function(){
				$('.form').toggleClass('hide');		
			});	// onfocus
		}
		
		//
		function fn_update(){
			$('#update_btn').click(function(){
				if(confirm('게시물 수정 페이지로 이동하시겠습니까?')){
					$('#f').attr('action', 'updateBoardPage.do');
					$('#f').submit();
				}
			});	// onclick
		}	// fn_update
		
		// 삭제 버튼 클릭시 작동 함수
		function fn_delete(){
			$('#delete_btn').click(function(){
				if(confirm('정말 게시물을 삭제하시겠습니까?')){
					$('#f').attr('action', 'deleteBoard.do');
					$('#f').submit();
				}
			});	// onclick
		}	// fn_delete
		
		// 댓글 달기, 데이터베이스에 삽입
		function fn_reply(){
			$('#reply_btn').click(function(){
				$.ajax({
					url: 'writeReply.do',
					data: $('#f').serialize(), 
					type: 'get',
					dataType: 'json',
					success: function(resultMap){
						alert('댓글 달기 성공');
					},
					error: function(){
						alert('댓글 오류 발생');
					}
				});	// ajax
			});	// onclick
		}	// fn_reply
		
	</script>

	<div class="container">
		<!-- 게시글 상세 화면 -->
		<form id="f" method="post" enctype="multipart/form-data" class="viewBoard">
			<input type="hidden" name="page" value="${page}">
			<input type="hidden" name="bIdx" value="${Board.BIdx}">
			<span class="naming">작성자</span><input type="text" name="mId" value="${Board.MId}" disabled><br><br>
			<input type="hidden" name="bHit" value="${Board.BHit}" disabled>
			<span class="naming">제목&nbsp;&nbsp;</span><input type="text" class="margin" name="bTitle" value="${Board.BTitle}" disabled><br><br>
			<span class="naming">작성일</span><input type="text" name="bPostdate" value="${Board.BPostDate}" disabled><br><br>
			<span class="naming">내용</span><br>
			<textarea name="bContent" cols="50" rows="10"  style="width: 400px" disabled>${Board.BContent}</textarea><br><br>
			
			<c:if test="${Board.BFileName1 ne 'null'}">
				<span class="naming">첨부 이미지</span><br>
				<img name="image1" alt="${Board.BFileName1}" src="resources/archive/board/${Board.BFileName1}" style="width: 400px" class="img">
				<input type="hidden" name="bFileName1" value="${Board.BFileName1}">
			</c:if>
			<c:if test="${Board.BFileName2 ne 'null'}">
				<span class="naming">첨부 이미지</span><br>
				<img name="image2" alt="${Board.BFileName2}" src="resources/archive/board/${Board.BFileName2}" style="width: 400px" class="img">
				<input type="hidden" name="bFileName2" value="${Board.BFileName2}">
			</c:if>
			<c:if test="${Board.BFileName3 ne 'null'}">
				<span class="naming">첨부 이미지</span><br>
				<img name="image3" alt="${Board.BFileName3}" src="resources/archive/board/${Board.BFileName3}" style="width: 400px" class="img">
				<input type="hidden" name="bFileName3" value="${Board.BFileName3}">
			</c:if>
			<br><br>
			
			<c:if test="${mode eq 'member'}">
				<c:if test="${loginUser.MId == Board.MId}">
					<input id="update_btn" type="button" value="수정하기">
					<input id="delete_btn" type="button" value="삭제하기" >
				</c:if>
			</c:if>
			
			<c:if test="${mode eq 'admin'}">
				<c:if test="${loginAdmin.MId == Board.MId}">
					<input id="update_btn" type="button" value="수정하기">
					<input id="delete_btn" type="button" value="삭제하기" >
				</c:if>
			</c:if>
			
			<input type="button" value="목록으로 돌아가기" onclick='location.href="boardPage.do"'><br><br>
			
		</form>
			
		<c:if test="${loginUser eq null && loginAdmin eq null}">
			<textarea rows="2" cols="30" id="reply_no_login" name="reply" placeholder="댓글을 입력하시려면 로그인하세요." style="width: 600px"></textarea>
		</c:if>
			
		<!-- 댓글 화면 -->
		<form id="f_reply" method="post"> 
			<input type="hidden" name="bIdx" value="${Board.BIdx}">
			<input type="hidden" name="mode" value="${mode}">
			
			<c:if test="${mode eq 'member'}">
				<c:if test="${loginUser ne null}">
					<input type="hidden" name="mId" value="${loginUser.MId}">
					<textarea rows="2" cols="30" id="reply" name="reply" placeholder="댓글을 입력하세요" style="width: 600px"></textarea>
					<input type="hidden" name="parent" value="0">
					<input type="button" id="reply_btn" value="댓글 달기" class="reply_btn">
				</c:if>
			</c:if>
			
			<c:if test="${mode ne 'admin'}">
				<c:if test="${loginAdmin ne null}">
					<input type="hidden" name="mId" value="${loginAdmin.MId}">
					<textarea rows="2" cols="30" id="reply" name="reply" placeholder="댓글을 입력하세요" style="width: 600px"></textarea>
					<input type="hidden" name="parent" value="0">
					<input type="button" id="reply_btn" value="댓글 달기" class="reply_btn">
			</c:if>
			</c:if>
			
			<div id="reply_list"></div>
			
			<div id="reply_paging"></div>
		</form>
	</div>
	
<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
