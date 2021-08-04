package com.team.d.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;
import com.team.d.utils.SecurityUtils;

//MOOYA HOTEL 일반 로그인과 카카오계정 로그인
public class LoginCommand {

	public String execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();

		// 입력된 mId, mPw 
		String mId = request.getParameter("mId");
		String mPw = SecurityUtils.encodeBase64(request.getParameter("mPw")); // 비밀번호 암호화
		
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO memberDTO = new MemberDTO();
		MemberDTO loginUser = null;
		
		// 카카오 로그인일 경우 mEmail이 memberDTO에 mEmail과 일치하는지 확인 
		if("Y".equals(request.getParameter("kakaoLogin"))){
			
			// 일치하면 memberDAO의 카카오 로그인 kakaoLogin메소드 호출
			memberDTO.setMEmail(request.getParameter("mEmail"));
			loginUser = memberDAO.kakaoLogin(memberDTO);
			
		} else { // 일반 로그인일 경우 memberDTO에 mId, mPw와 일치하는지 확인
			
			memberDTO.setMId(mId);
			memberDTO.setMPw(mPw);
			loginUser = memberDAO.login(memberDTO);
			
		}
		
		String page = request.getParameter("page");
		//수진수정 시작
		long rNo;
		String checkIn;
		String checkOut;
		long people;
		String food;
		long totalPay;
		if(page=="revInfoPage.do") {
			rNo=Long.parseLong(request.getParameter("rNo"));
			checkIn=request.getParameter("checkIn");
			checkOut=request.getParameter("checkOut");
			people=Long.parseLong(request.getParameter("people"));
			food=request.getParameter("food");
			totalPay=Long.parseLong(request.getParameter("totalPay"));
			
			model.addAttribute("rNo",rNo);
			model.addAttribute("checkIn",checkIn);
			model.addAttribute("checkOut",checkOut);
			model.addAttribute("people",people);
			model.addAttribute("food",food);
			model.addAttribute("totalPay",totalPay);
		
		}
		//수정끝
		if(page == null)
			page = "index";
		
		String result = null;
		if(loginUser != null) { // 로그인 성공의 경우, session에 등록
			session.setAttribute("loginMsg", "로그인 성공");
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("mode", "member");
			result = page;
		} else{	// 로그인 실패의 경우
			session.setAttribute("loginMsg", "로그인 실패");
			session.setAttribute("loginUser", null);
			session.setAttribute("mode", null);
			result = page;
		}
		return result;

	}

}
