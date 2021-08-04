package com.team.d.command.member;

import java.io.IOException;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;
import com.team.d.utils.SecurityUtils;

// 비밀번호 찾고 새 비밀번호로 변경
public class ChangePwCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse)map.get("response");

		// 비밀번호 찾기 시 request를 통해 입력된 mPw가 memberDTO에 mPw와 일치하는지 확인
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMPw(SecurityUtils.encodeBase64(request.getParameter("mPw"))); // 입력된 비밀번호 암호화 처리
		memberDTO.setMEmail(request.getParameter("mEmail"));
		
		// memberDAO의 비밀번호 찾기&변경 changePw메소드 호출
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		int result = memberDAO.changePw(memberDTO);
				
		try {
			response.setContentType("text/html; charset=utf-8");
			if (result > 0) { // 새 비밀번호 등록 성공 후 다시 로그인
				response.getWriter().append("<script>");
				response.getWriter().append("alert('비밀번호가 변경되었습니다. 변경된 비밀번호로 로그인하세요.');");
				response.getWriter().append("location.href='index.do';");
				response.getWriter().append("</script>");
			} else {
				response.getWriter().append("<script>");
				response.getWriter().append("alert('비밀번호 변경에 실패했습니다.');");
				response.getWriter().append("history.back();");
				response.getWriter().append("</script>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
