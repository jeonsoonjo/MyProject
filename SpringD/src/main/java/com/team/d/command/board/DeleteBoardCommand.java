package com.team.d.command.board;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.team.d.dao.BoardDAO;
import com.team.d.utils.FileUtils;

public class DeleteBoardCommand implements BoardCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");
		BoardDAO boardDAO = sqlSession.getMapper(BoardDAO.class);
		long bIdx = Long.parseLong(multipartRequest.getParameter("bIdx"));
		
		String bFileName1 = multipartRequest.getParameter("bFileName1");
		String bFileName2 = multipartRequest.getParameter("bFileName1");
		String bFileName3 = multipartRequest.getParameter("bFileName1");
		
		// 파일이 존재한다면 삭제
		if(bFileName1 != "null" && bFileName1 != null)
			FileUtils.deleteFile(multipartRequest, bFileName1, "board");
		if(bFileName2 != "null" && bFileName2 != null)
			FileUtils.deleteFile(multipartRequest, bFileName2, "board");
		if(bFileName3 != "null" && bFileName3 != null)
			FileUtils.deleteFile(multipartRequest, bFileName3, "board");
		
		boardDAO.deleteBoard(bIdx);
	}
	
}
