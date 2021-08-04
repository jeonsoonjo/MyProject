package com.team.d.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;

// 관리자 로그인
public class AdminLoginCommand  {

	public String execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		String mId = request.getParameter("mId");
		String mPw = request.getParameter("mPw");
		
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMId(mId);
		memberDTO.setMPw(mPw);
		
		MemberDTO loginAdmin = memberDAO.adminLogin(memberDTO);
		
		HttpSession session = request.getSession();
		
		String page = request.getParameter("page");
		if(page == null)
			page = "index";
		
		if(loginAdmin != null) { // 로그인 성공의 경우, Session에 등록
			session.setAttribute("loginAdmin", loginAdmin);
			session.setAttribute("mode", "admin");
		} else{	// 로그인 실패의 경우
			session.setAttribute("loginAdmin", loginAdmin);
			session.setAttribute("mode", null);
		}
		return page;
	}

}
