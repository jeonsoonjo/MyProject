package com.team.d.command.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReplyDAO;
import com.team.d.dto.PageDTO;
import com.team.d.dto.ReplyDTO;
import com.team.d.utils.PagingUtils;

public class GetReplyListCommand  {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		long bIdx = Long.parseLong(request.getParameter("bIdx"));
		
		String p = (String) map.get("page");
		
		int re_page;
		if(p.equals("")) {
			re_page = 1;
		} else if(p.equals("undefined")){
			re_page = 1;
		} else {
			Optional<String> opt = Optional.ofNullable(p);
			// page로 null값이 입력된다면 시작페이지로 지정
			re_page = Integer.parseInt(opt.orElse("1"));
		}
		
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		// 전체 게시물의 개수를 반환하는 함수, 공지사항 제외
		int totalReply = dao.getTotalReplyByBIDX(bIdx);
		
		PageDTO pageDTO = PagingUtils.getPage(totalReply, re_page);
		
		String paging = PagingUtils.getPaging("selectBoard.do?bIdx=" + bIdx , re_page);
		
		Map<String, Object> container = new HashMap<>();
		container.put("BIDX", bIdx);
		container.put("beginRecord", pageDTO.getBeginRecord());
		container.put("endRecord", pageDTO.getEndRecord());

		// 전체 게시물을 list에 담아주는 함수.
		List<ReplyDTO> list = dao.getReplyListByBidx(container);

		for(ReplyDTO dto : list) {
			dto.setRPostDate(dto.getRPostDate().substring(2,11));
		}

		// json 형태로 반환해줄 Map 그릇
		Map<String, Object> resultMap =  new HashMap<String, Object>();
		resultMap.put("list", list);
		resultMap.put("paging", paging);
		resultMap.put("totalReply", totalReply);
		return resultMap; 
	} 

}
