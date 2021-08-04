package com.team.d.command.reservation;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReservationDAO;
import com.team.d.dto.ReservationDTO;

public class ReceiptCommand2 implements ReservationCommand {

	// 영수증.jsp 로 보내줄 list 가져오는 command
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		 
		// request로 reno값 받아와서 모델에 뿌려주기
		long reNo = Long.parseLong(request.getParameter("reno"));
		
		ReservationDAO reservationDAO=sqlSession.getMapper(ReservationDAO.class);
		ReservationDTO dto =reservationDAO.selectReservation(reNo);
		model.addAttribute("book",dto); 
		model.addAttribute("selectRoom",reservationDAO.selectRoom(dto.getRNo())); 
 
	}

}
