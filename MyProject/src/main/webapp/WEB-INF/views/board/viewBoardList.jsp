<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/loginWindow.css"> 
	<link rel="stylesheet" href="resources/css/viewBoardList.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script>
		$(function(){
			getDate();		// 시간 보여주는 함수
			fn_closeLogin();	// 로그인창에서 x 클릭시 로그인창 닫힘
			fn_toggle_mode(); 	// 관리자 로그인 모드 / 회원 로그인 모드로 변경하는 버튼
			fn_insertBoard();	// 새 글 작성 버튼 클릭시 로그인창 켜지거나 페이지 이동하는 함수
			
			fn_init();	// 전체 목록 불러오기 버튼
			click_search();
			
  	   	 	$('<input type="hidden" name="page" value="board/viewBoardList">')
			.appendTo( $('.form') )
			
			if(${query == null}){	
				// 만약 model을 통해 query가 채워지지 않은 상태라면,
				// search 결과가 아니라 전체 목록을 가져온다.
				fn_showList();	// 관리자의 글 제외하고 글 목록 가져오기			
			} else{
				// 만약 검색 버튼을 통해 검색한 후, paging된 숫자를 눌렀다면,
				// 전체 목록이 아니라 search결과만을 띄워준다.
				fn_search();	// 검색버튼 클릭시 리스트 불러오는 함수
			}
		});	// onload 함수의 끝
		
		// 관리자의 글을 공지사항으로 가져오기
		function fn_get_notice(){
			$.ajax({
				url: 'selectNotice.do',
				type: 'get',
				async: false,
				dataType: 'json',
				success: function(resultMap){
					fn_makeNotice(resultMap.list);
				},	// success
				error: function(){
					alert('공지사항 오류');
				}
			});	// ajax
		}
		
		// 멤버 로그인, 관리자 로그인을 변경해주는 함수
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
		
		function click_search(){
			$('#search_btn').click(function(){
				fn_search();
			});
		}
		
		// 검색 목록 불러오는 ajax
		function fn_search(){
				$('#list').empty();
				fn_get_notice();
				$.ajax({
					url: 'searchBoard.do',
					type: 'get',
					async: false,
					data: 'column=' + $('#column').val() + '&query=' + $('#query').val() + '&page=${page}',
					dataType: 'json',
					success: function(resultMap){
						fn_makeTable(resultMap.list);
						$('#paging').empty();
						$('#paging').html(resultMap.paging);
					},	// success
					error: function(){
						alert('search_btn 오류');
					}
				});	// ajax	
		}	// fn_search 
		
		function fn_init(){
			$('#init_btn').click(function(){
				$('#list').empty();
				fn_get_notice();
				fn_showList();
			});	// onclick
		}	// fn_init
		
		function fn_insertBoard(){
			$('#insert_board_btn').click(function(){
				if(${mode == "member"}){
					if( ${loginUser == null} ){	// 로그인된 상태가 아니라면
						alert('로그인이 필요합니다.');
						$('.form').toggleClass('hide');
					} else{	// 로그인된 상태라면
						location.href= "insertBoardPage.do";
					}
				} // if member
				else if(${mode == "admin"}){
					if( ${loginAdmin == null} ){	// 로그인된 상태가 아니라면
						alert('로그인이 필요합니다.');
						$('.form').toggleClass('hide');
					} else{	// 로그인된 상태라면
						location.href= "insertBoardPage.do";
					}			
				}	// else if admin
				else{
					alert('로그인이 필요합니다.');
					$('.form').toggleClass('hide');
				}	// else
			});	// onclick
		}	// fn_insertBoard
		
		function fn_closeLogin(){	// 로그인창에서 x 클릭시 로그인창 닫힘
			$('#closeLogin').click(function(){
				$('.form').toggleClass('hide');
			});	// onclick#
		}	// fn_closeLogin
		
		function fn_showList(){
			$('#list').empty();
			fn_get_notice();	// 관리자의 글 공지사항으로 가져오기
			$.ajax({
				url: 'showList.do',
				type: 'get',
				async: false,
				data: 'page=${page}',
				dataType: 'json',
				success: function(resultMap){
					fn_makeTable(resultMap.list);
					$('#paging').empty();
					$('#paging').html(resultMap.paging);
				},	// end of success
				error: function(){
					alert('목록 불러오기 오류');
				}
			});
		}	// fn_showList
		
		// list 출력함수
		function fn_makeTable(list){
			$.each(list, function(i, board){
				if(board.bfilename1 == 'null' || board.bfilename2 == 'null' || board.bfilename3 == 'null'){
					$('<tr>')
					.append( $('<td>').text(board.bidx) )
					.append( $('<td>').text(board.mid) )
					.append( $('<td>').html('<a href="selectBoard.do?bIdx=' + board.bidx + '">' + board.btitle + '</a>') )
					.append( $('<td>').text(board.bpostDate) )
					.append( $('<td>').text(board.bhit) )
					.append( $('<td>').text('') )
					.appendTo('#list');
				}
				else{
					$('<tr>')
					.append( $('<td>').text(board.bidx) )
					.append( $('<td>').text(board.mid) )
					.append( $('<td>').html('<a href="selectBoard.do?bIdx=' + board.bidx + '">' + board.btitle + '</a>') )
					.append( $('<td>').text(board.bpostDate) )
					.append( $('<td>').text(board.bhit) )
					.append( $('<td>').html('<i class="far fa-image"></i>') )
					.appendTo( $('#list') ); 
				} 
			});	// each 
		}
		
		// 공지사항 출력 함수
		function fn_makeNotice(list){
			$.each(list, function(i, board){
				if(board.bfilename1 == 'null' || board.bfilename2 == 'null' || board.bfilename3 == 'null'){
					$('<tr id="notice">')
					.append( $('<td>').text(board.bidx) )
					.append( $('<td>').text(board.mid) )
					.append( $('<td>').html('<a href="selectBoard.do?bIdx=' + board.bidx + '">' + board.btitle + '</a>') )
					.append( $('<td>').text(board.bpostDate) )
					.append( $('<td>').text(board.bhit) )
					.append( $('<td>').text('') )
					.appendTo('#list');
				}
				else{
					$('<tr id="notice">')
					.append( $('<td>').text(board.bidx) )
					.append( $('<td>').text(board.mid) )
					.append( $('<td>').html('<a href="selectBoard.do?bIdx=' + board.bidx + '">' + board.btitle + '</a>') )
					.append( $('<td>').text(board.bpostDate) )
					.append( $('<td>').text(board.bhit) )
					.append( $('<td>').html('<i class="far fa-image"></i>') )
					.appendTo( $('#list') ); 
				} 
			});	// each 
		}	// fn_makeNotice
	</script>

	<div class="container">
		<p class="title">게시판</p>
			
		<!-- 검색한 결과를 띄워줄 때는, 그 전에 사용했던 column이 선택되어있도록 해준다. -->
		<div class="search">
			<select id="column">
				<c:if test="${column eq 'BTITLE'}">
					<option value="BTITLE" selected>제목</option>
				</c:if>
				<c:if test="${column ne 'BTITLE'}">
					<option value="BTITLE">제목</option>
				</c:if>
				<c:if test="${column eq 'MID'}">
					<option value="MID" selected>작성자</option>
				</c:if>
				<c:if test="${column ne 'MID'}">
					<option value="MID">작성자</option>
				</c:if>
				<c:if test="${column eq 'BCONTENT'}">
					<option value="BCONTENT" selected>내용</option>
				</c:if>
				<c:if test="${column ne 'BCONTENT'}">
					<option value="BCONTENT">내용</option>
				</c:if>
			</select>
		
			<!-- 검색했을 때 입력한 값 그대로 query를 유지해준다. -->
			<input type="text" id="query" value="${query}" class="input_box">
			
			<input type="button" id="search_btn" value="검색" class="btn">
			<input type="button" id="init_btn" value="전체 목록 보기" class="btn">
		</div>
		
		<table class="table">
			<thead>
				<tr>
					<td class="naming"> 글번호 </td>
					<td class="naming"> 작성자 </td>
					<td class="naming"> 제목 </td>
					<td class="naming"> 작성일 </td>
					<td class="naming"> 조회수 </td>
					<td class="naming"> 첨부파일</td>
				</tr>
			</thead>
		
			<tbody id="list">
				
			</tbody>
			
			<tfoot id="paging">
			
			</tfoot>
		</table>
		<input type="button" id="insert_board_btn" value="새 글 작성" class="btn">
	</div>
	
<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
