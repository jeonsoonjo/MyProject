package com.team.d.command.reservation;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.ReservationDAO;


import java.text.ParseException;
import java.text.SimpleDateFormat;


public class SelectRoomCommand implements ReservationCommand {

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
		
		ReservationDAO reservationDAO = sqlSession.getMapper(ReservationDAO.class);
		// rNo를 이용해 그 방의 구체적인 정보(가격)를 가져오는 함수
		model.addAttribute("selectRoom", reservationDAO.selectRoom(rNo));
		//체크인 체크아웃 날짜 model로 넘김
		model.addAttribute("checkIn",checkIn);
		model.addAttribute("checkOut",checkOut);
		model.addAttribute("people",people);
		
		// 숙박일 계산
        String strFormat = "yyyyMMdd";    //strStartDate 와 strEndDate 의 format
        // 숙박일 계산을 위해 받아온 데이터안 문자'-'삭제
      	String strCheckInYMD=checkIn.replace("-","");
      	String strCheckOutYMD=checkOut.replace("-","");
        // SimpleDateFormat 을 이용하여 startDate와 endDate의 Date 객체를 생성한다.
        SimpleDateFormat sdf = new SimpleDateFormat(strFormat);
        
        try{
            Date checkInYMD = sdf.parse(strCheckInYMD);
            Date CheckOutYMD = sdf.parse(strCheckOutYMD);
 
            // 두날짜 사이의 시간 차이(ms)를 하루 동안의 ms(24시*60분*60초*1000밀리초) 로 나눈다.
            long diffDay = ( CheckOutYMD.getTime() - checkInYMD.getTime()) / (24*60*60*1000);
            model.addAttribute("sleepDate",diffDay);
        }catch(ParseException e){
            e.printStackTrace();
        }
	}

}
