package com.team.d.command.room;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface RoomCommand {

	public void execute(SqlSession sqlSession, Model model);
	
}
