package com.team.d.command.board;

import java.util.HashMap;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.team.d.dao.BoardDAO;
import com.team.d.utils.FileUtils;

public class UpdateBoardCommand implements BoardCommand {

	private Map<String, Object> map;
	private MultipartHttpServletRequest multipartRequest;
	private String mId;
	private Long bIdx;
	private String bTitle;
	private String bContent;
	private String BFILENAME1 = "null";
	private String BFILENAME2 = "null";
	private String BFILENAME3 = "null";
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		map = model.asMap();
		multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");
		
		mId = multipartRequest.getParameter("mId");
		bTitle = multipartRequest.getParameter("bTitle");
		bContent = multipartRequest.getParameter("bContent");
		bIdx = Long.parseLong(multipartRequest.getParameter("bIdx"));
		String originalFile1 = multipartRequest.getParameter("originalFile1");
		String originalFile2 = multipartRequest.getParameter("originalFile2");
		String originalFile3 = multipartRequest.getParameter("originalFile3");
		
		MultipartFile file1 = multipartRequest.getFile("chooseFile1");
		if (file1 != null && !file1.isEmpty()) {	
			// file1에 파일이 들어왔을 때 원래의 file1을 지우고 새로운 파일 저장
			FileUtils.deleteFile(multipartRequest, originalFile1, "board");
			BFILENAME1 = FileUtils.fileUpload(multipartRequest, file1, 1);
		} else if(originalFile1 != "null" && (file1 == null || file1.isEmpty())) {
			// file1의 변경이 없을 때
			// do nothing
			BFILENAME1 = originalFile1;
		}
		
		MultipartFile file2 = multipartRequest.getFile("chooseFile2");
		if (file2 != null && !file2.isEmpty()) {	
			// file1에 파일이 들어왔을 때 원래의 file1을 지우고 새로운 파일 저장
			FileUtils.deleteFile(multipartRequest, originalFile2, "board");
			BFILENAME2 = FileUtils.fileUpload(multipartRequest, file2, 1);
		} else if(originalFile2 != "null" && (file2 == null || file2.isEmpty())) {
			// file2의 변경이 없을 때
			// do nothing
			BFILENAME2 = originalFile2;
		}
		
		MultipartFile file3 = multipartRequest.getFile("chooseFile3");
		if (file3 != null && !file3.isEmpty()) {	
			// file1에 파일이 들어왔을 때 원래의 file1을 지우고 새로운 파일 저장
			FileUtils.deleteFile(multipartRequest, originalFile1, "board");
			BFILENAME3 = FileUtils.fileUpload(multipartRequest, file3, 1);
		} else if(originalFile3 != "null" && (file3 == null || file3.isEmpty())) {
			// file3의 변경이 없을 때
			// do nothing
			BFILENAME3 = originalFile3;
		}
		
		BoardDAO boardDAO = sqlSession.getMapper(BoardDAO.class);
		
		Map<String, Object> container = new HashMap<>();
		container.put("BIDX", bIdx);
		container.put("MID", mId);
		container.put("BTITLE", bTitle);
		container.put("BCONTENT", bContent);
		container.put("BFILENAME1", BFILENAME1);
		container.put("BFILENAME2", BFILENAME2);
		container.put("BFILENAME3", BFILENAME3);

		boardDAO.updateBoard(container);
		
	}

}
