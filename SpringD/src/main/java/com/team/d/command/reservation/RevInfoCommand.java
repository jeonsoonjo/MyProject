package com.team.d.command.reservation;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public class RevInfoCommand implements ReservationCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		// 방 번호
		long rNo = Long.parseLong(request.getParameter("rNo"));
		// 숙박인원 수
		long people = Long.parseLong(request.getParameter("people"));
		// 체크인 날짜
		String checkIn = request.getParameter("checkIn");
		// 체크아웃 날짜
		String checkOut = request.getParameter("checkOut");
		// 조식 신청인원
		long food=Long.parseLong( request.getParameter("food"));
		long totalPay=Long.parseLong( request.getParameter("totalPay"));
		
		// 파라미터로 넘어오고 넘어갈 값들
		model.addAttribute("rNo",rNo);
		model.addAttribute("checkIn",checkIn);
		model.addAttribute("checkOut",checkOut);
		model.addAttribute("people",people);
		model.addAttribute("food",food);
		model.addAttribute("totalPay",totalPay);
		
	}

}
