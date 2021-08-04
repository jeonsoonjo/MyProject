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

public class GetChildListCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		long parent = Long.parseLong(request.getParameter("parent"));
		long bIdx = Long.parseLong(request.getParameter("bIdx"));
		
		String p = request.getParameter("re_page");
		int re_re_page;
		if(p.equals("")) {
			re_re_page = 1;
		} else if(p.equals("undefined")){
			re_re_page = 1;
		} else {
			
			Optional<String> opt = Optional.ofNullable(p);
			// page로 null값이 입력된다면 시작페이지로 지정
			re_re_page = Integer.parseInt(opt.orElse("1"));
		}
		
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		
		Map<String, Object> container = new HashMap<>();
		container.put("PARENT", parent);
		container.put("BIDX", bIdx);

		int totalReReply = dao.getTotalChildReplyByBIDX(container);

		PageDTO paging = PagingUtils.getPageByAjax(totalReReply, re_re_page);

		container.put("beginRecord", paging.getBeginRecord());
		container.put("endRecord", paging.getEndRecord());
		
		Map<String, Object> resultMap = new HashMap<>();
		
		List<ReplyDTO> list = dao.getChildListByRidx(container);
		resultMap.put("list", list);
		resultMap.put("exists", list.size() > 0);
		resultMap.put("paging", paging);
		return resultMap;
	}

}
