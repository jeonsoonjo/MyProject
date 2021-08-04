package com.team.d.command.room;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.RoomDAO;

public class SelectRoomListCommand implements RoomCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		RoomDAO roomDAO = sqlSession.getMapper(RoomDAO.class);
		model.addAttribute("list", roomDAO.selectRoomList());

	}

}
