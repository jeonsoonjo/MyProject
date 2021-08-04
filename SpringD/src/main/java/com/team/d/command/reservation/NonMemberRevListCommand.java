package com.team.d.command.reservation;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReservationDAO;

public class NonMemberRevListCommand implements ReservationCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		// 비회원 예약한 이메일 
		String reEmail = request.getParameter("reEmail");
		
		// 비회원 예약정보 list
		ReservationDAO reservationDAO = sqlSession.getMapper(ReservationDAO.class);
		model.addAttribute("nonMemRevList",reservationDAO.reservationListNonMember(reEmail));

	}

}
