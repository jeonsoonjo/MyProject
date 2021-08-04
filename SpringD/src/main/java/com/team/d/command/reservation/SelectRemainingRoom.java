package com.team.d.command.reservation;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReservationDAO;


public class SelectRemainingRoom implements ReservationCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
			
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		// 체크인 날짜
		String checkIn = request.getParameter("checkIn");
		// 체크아웃 날짜
		String checkOut = request.getParameter("checkOut");
		// 숙박 인원
		long people = Long.parseLong(request.getParameter("people"));
		
		ReservationDAO reservationDAO = sqlSession.getMapper(ReservationDAO.class);
		
		// 예약가능한 방 불러오는 함수
		model.addAttribute("room",reservationDAO.remainingRoom(checkIn,checkOut,people));
		
		model.addAttribute("checkIn",checkIn);
		model.addAttribute("checkOut",checkOut);
		model.addAttribute("people",people);
	 
	}

}
