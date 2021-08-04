package com.team.d.command.event;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface EventCommand {

	public void execute(SqlSession sqlSession, Model model);
	
}
