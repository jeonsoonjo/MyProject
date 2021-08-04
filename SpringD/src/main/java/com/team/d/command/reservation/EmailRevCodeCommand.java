package com.team.d.command.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReservationDAO;
import com.team.d.dto.ReservationDTO;

public class EmailRevCodeCommand{
	
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		// 비회원 예약한 이메일 
		String reEmail = request.getParameter("reEmail");
		ReservationDAO reservationDAO = sqlSession.getMapper(ReservationDAO.class);
		
		// 비회원 예약정보 list
		Map<String, Object> resultMap = new HashMap<>();
		List<ReservationDTO> dto=reservationDAO.reservationListNonMember(reEmail);
		
		if(dto.size() <1) { // 이메일 결과 값이 없으면 false
			resultMap.put("nonMemReservation",false);
		}
		else { // 이메일 결과 값이 있으면 true
			resultMap.put("nonMemReservation",true);
		}
		return resultMap;

	}

}
