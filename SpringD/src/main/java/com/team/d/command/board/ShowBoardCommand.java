package com.team.d.command.board;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.BoardDAO;

public class ShowBoardCommand implements BoardCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		// 전달받은 데이터 옮겨담음
		long bIdx = Long.parseLong(request.getParameter("bIdx"));
		
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		
		// 조회시마다 조회수 1만큼 올려주는 함수
		dao.updateHitByIdx(bIdx);
		
		// model을 통해 BoardDTO 전달
		model.addAttribute("Board", dao.selectBoardByIdx(bIdx));
	}

}
