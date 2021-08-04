<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>

	<link rel="stylesheet" href="resources/css/loginWindow.css"> 
	<link rel="stylesheet" href="resources/css/updateBoard.css"> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

	<script>
	
	function loadFile(input, span_file, div_img) {
		
		$(div_img).empty();
		$(span_file).empty();	// 초기화
		
	    var file = input.files[0];	//선택된 파일리스트 가져오기
	    //미리 만들어 놓은 div에 text(파일 이름) 추가
	    
	
		if(file != null){
			var name = file.name;
			
			$(span_file).text(name);
			$(div_img).empty();
			$('<img>')	
			.attr('src', URL.createObjectURL(file))		//이미지 source 가져오기
			.css('width', '200px')
			.css('height', '120px')
			.css('objectFit', 'contain')
			.appendTo(div_img);
			//이미지를 showImgs div에 추가
		}
	  	//새로운 이미지 div 추가
	};
	</script>

	<div class="container">
		<h1> 게시글 작성(수정)</h1>
		<form id="f" action="updateBoard.do" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="bIdx" value="${Board.BIdx}">
			<input type="hidden" name="content" value="${Board.BContent}">
			<input type="hidden" name="replyWriter" value="${loginUser.MId}">
			<input type="hidden" name="originalFile1" value="${Board.BFileName1}">
			<input type="hidden" name="originalFile2" value="${Board.BFileName2}">
			<input type="hidden" name="originalFile3" value="${Board.BFileName3}">
			
			<c:if test="${loginUser eq null && loginAdmin ne null}">
				<input type="hidden" name="m_id" value="${loginAdmin.MId}"><br>
			</c:if>
			<c:if test="${loginUser ne null && loginAdmin eq null}">
				<input type="hidden" name="m_id" value="${loginUser.MId}"><br>
			</c:if>
			
			
			<h3>제목</h3>
			<input type="text" name="bTitle" value="${Board.BTitle}" class="input_box"><br>
			<h3>내용</h3>
			<textarea rows="20" cols="100" name="bContent">${Board.BContent}</textarea>
			<div class="button">
				<div class="fileAdd">
		       		<label for="chooseFile1">  
			       		👉 Img File 1 👈 
			       		<input type="file" id="chooseFile1" name="chooseFile1" accept="image/*" onchange="loadFile(this,'#fileName1', '#showImgs1')">
		       		</label>
		   			<span id="fileName1">${Board.BFileName1}</span>
		   			<div id="showImgs1">
			   			<c:if test="${Board.BFileName1 ne 'null'}">
			   				<img id="image1" name="image1" alt="${Board.BFileName1}" src="resources/archive/board/${Board.BFileName1}" style="width: 200px">
			   			</c:if>
			   			<c:if test="${Board.BFileName1 eq 'null'}">
			   				<img id="image1" name="image1" alt="이미지 없음" style="width: 200px">
			   			</c:if>
		   			</div>
	   			</div>
	       	
	       		<div class="fileAdd">
		       		<label for="chooseFile2">  
			       		👉 Img File 2 👈 
			       		<input type="file" id="chooseFile2" name="chooseFile2" accept="image/*" onchange="loadFile(this,'#fileName2', '#showImgs2')">
		       		</label>
		   			<span id="fileName2">${Board.BFileName2}</span>
		   			<div id="showImgs2">
		   				<c:if test="${Board.BFileName2 ne 'null'}">
			   				<img id="image2" name="image2" alt="${Board.BFileName2}" src="resources/archive/board/${Board.BFileName2}" style="width: 200px">
			   			</c:if>
			   			<c:if test="${Board.BFileName2 eq 'null'}">
			   				<img id="image2" name="image2" alt="이미지 없음" style="width: 200px">
			   			</c:if>
		   			</div>
	   			</div>
	   			
	   			<div class="fileAdd">
		       		<label for="chooseFile3">  
			       		👉 Img File 3👈 
			       		<input type="file" id="chooseFile3" name="chooseFile3" accept="image/*" onchange="loadFile(this,'#fileName3', '#showImgs3')">
		       		</label>
		   			<span id="fileName3">${Board.BFileName3}</span>
		   			<div id="showImgs3">
		   				<c:if test="${Board.BFileName3 ne 'null'}">
			   				<img id="image3" name="image3" alt="${Board.BFileName3}" src="resources/archive/board/${Board.BFileName3}" style="width: 200px">
			   			</c:if>
			   			<c:if test="${Board.BFileName3 eq 'null'}">
			   				<img id="image3" name="image3" alt="이미지 없음" style="width: 200px">
			   			</c:if>
		   			</div>
	   			</div>
	    	</div>
			<button id="send">수정 완료</button>
		</form>
	</div>
	
<jsp:include page="../layout/footer.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>
