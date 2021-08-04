package com.my.myproject.command.room;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.my.myproject.dao.RoomDAO;

public class SelectRoomListCommand implements RoomCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		RoomDAO roomDAO = sqlSession.getMapper(RoomDAO.class);
		model.addAttribute("list", roomDAO.selectRoomList());

	}

}
