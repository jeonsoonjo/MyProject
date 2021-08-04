package com.team.d.command.reservation;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface ReservationCommand {

	public void execute(SqlSession sqlSession, Model model);
	
}
