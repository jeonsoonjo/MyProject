package com.team.d.command.room;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.RoomDAO;
import com.team.d.dto.RoomDTO;

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
