package com.team.d.command.board;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.BoardDAO;

public class UpdateBoardPageCommand implements BoardCommand{

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		long bIdx = Long.parseLong(request.getParameter("bIdx"));
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		model.addAttribute("Board", dao.selectBoardByIdx(bIdx));
	}
}
