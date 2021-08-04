package com.my.myproject.command.room;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.my.myproject.dao.RoomDAO;
import com.my.myproject.dto.RoomDTO;

public class SelectRoomViewCommand implements RoomCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		long rNo = Long.parseLong(request.getParameter("rNo"));
		
		RoomDAO roomDAO = sqlSession.getMapper(RoomDAO.class);
		RoomDTO roomDTO = roomDAO.selectRoomByRNo(rNo);
		model.addAttribute("roomDTO", roomDTO);

	}

}
