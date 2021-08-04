package com.team.d.command.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.BoardDAO;
import com.team.d.dto.BoardDTO;
import com.team.d.dto.PageDTO;
import com.team.d.utils.PagingUtils;

public class SearchBoardCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model){
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String p =request.getParameter("page");
		
		int page;
		if(p == "") {
			page = 1;
		} else {
			Optional<String> opt = Optional.ofNullable(p);
			// page로 null값이 입력된다면 시작페이지로 지정
			page = Integer.parseInt(opt.orElse("1"));
			
		}

		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);

		// boardDAO의 함수를 사용하기 위해 임시로 사용할 Map 그릇
		Map<String, String> container = new HashMap<>();
		container.put("column", column);
		container.put("query", query);
		
		// 검색 결과의 개수를 받아오는 함수
		int searchedRecord = dao.getSearchedlRecord(container);
		
		PageDTO pageDTO = PagingUtils.getPage(searchedRecord, page);
		
		// 검색할 당시 사용했던 column과 query를 paging처리할 목록에도 더해준다.
		String path = "searchList.do?column=" + column + "&query=" + query;
		String paging = PagingUtils.getPaging(path, page);
		
		container.put("endRecord", "" + pageDTO.getEndRecord());
		container.put("beginRecord", "" + pageDTO.getBeginRecord());
		
		// 검색결과를 list에 담아주는 함수
		List<BoardDTO> list = dao.searchList(container);		
		for(BoardDTO dto : list) {
			dto.setBPostDate(dto.getBPostDate().substring(2,11));
		}
		
		// 결과를 json형태로 전달해줄 Map 그릇
		Map<String, Object> resultMap =  new HashMap<String, Object>();
		resultMap.put("list", list);
		resultMap.put("paging", paging);
		
		return resultMap;
	}
}
