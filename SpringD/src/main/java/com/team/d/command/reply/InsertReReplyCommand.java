package com.team.d.command.reply;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReplyDAO;

public class InsertReReplyCommand implements ReplyCommand{
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		long bIdx = Long.parseLong(request.getParameter("bIdx"));
		String content = request.getParameter("content");
		long parent = Long.parseLong(request.getParameter("parent"));
		String mId = request.getParameter("mId");
		Map<String, Object> container = new HashMap<String, Object>();
		container.put("BIDX", bIdx);
		container.put("CONTENT", content);
		container.put("PARENT", parent);
		container.put("MID", mId);
		
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		dao.insertReReply(container);		
	}
	
}
