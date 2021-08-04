package com.team.d.command.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.team.d.dao.BoardDAO;
import com.team.d.dto.BoardDTO;

public class SelectNoticeCommand {
	
	public Map<String, Object> execute(SqlSession sqlSession) {
		
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		
		// 전체 게시물을 list에 담아주는 함수.
		List<BoardDTO> list = dao.getNoticeList();
		
		// dto의 날짜형식 변경
		for(BoardDTO dto : list) {
			dto.setBPostDate(dto.getBPostDate().substring(2,11));
		}
		
		// json 형태로 반환해줄 Map 그릇
		Map<String, Object> resultMap =  new HashMap<String, Object>();
		resultMap.put("list", list);
		return resultMap;
	} 
	
}
