package com.team.d.command.board;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.team.d.dao.BoardDAO;
import com.team.d.utils.FileUtils;

public class InsertBoardCommand implements BoardCommand {

	private Map<String, Object> map;
	private MultipartHttpServletRequest multipartRequest;
	private String mId;
	private String bTitle;
	private String bContent;
	private String BFILENAME1 = "null";
	private String BFILENAME2 = "null";
	private String BFILENAME3 = "null";
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		map = model.asMap();
		multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");
		
		mId = multipartRequest.getParameter("m_id");
		bTitle = multipartRequest.getParameter("bTitle");
		bContent = multipartRequest.getParameter("bContent");
		
		MultipartFile file1 = multipartRequest.getFile("chooseFile1");
		MultipartFile file2 = multipartRequest.getFile("chooseFile2");
		MultipartFile file3 = multipartRequest.getFile("chooseFile3");
		
		BoardDAO boardDAO = sqlSession.getMapper(BoardDAO.class);
		
		BFILENAME1 = FileUtils.fileUpload(multipartRequest, file1, 1);
		BFILENAME2 = FileUtils.fileUpload(multipartRequest, file2, 2);
		BFILENAME3 = FileUtils.fileUpload(multipartRequest, file3, 3);
		
		Map<String, Object> container = new HashMap<>();
		container.put("MID", mId);
		container.put("BTITLE", bTitle);
		container.put("BCONTENT", bContent);
		container.put("BFILENAME1", BFILENAME1);
		container.put("BFILENAME2", BFILENAME2);
		container.put("BFILENAME3", BFILENAME3);
		//boardDAO.insertBoard(mId, bTitle, bContent, BFILENAME1, BFILENAME2, BFILENAME3);
		boardDAO.insertBoard(container);
		
	}
	
}
