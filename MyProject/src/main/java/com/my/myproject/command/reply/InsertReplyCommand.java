package com.my.myproject.command.reply;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.my.myproject.dao.ReplyDAO;
public class InsertReplyCommand implements ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		long bIdx = Long.parseLong(request.getParameter("bIdx"));
		String rContent = request.getParameter("reply");
		String mId = request.getParameter("mId");
		long parent = Long.parseLong(request.getParameter("parent"));
		
		Map<String, Object> container = new HashMap<String, Object>();
		container.put("BIDX", bIdx);
		container.put("RCONTENT", rContent);
		container.put("MID", mId);
		container.put("PARENT", parent);
		
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		dao.insertReply(container);		
	}

}
