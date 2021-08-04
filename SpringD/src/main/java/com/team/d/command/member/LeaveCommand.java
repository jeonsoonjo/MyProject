package com.team.d.command.member;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;

// 회원탈퇴
public class LeaveCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletResponse response = (HttpServletResponse)map.get("response");
		HttpSession session = (HttpSession)map.get("session");
		
		// session에 등록된 회원 mNo 확인
		long mNo = ((MemberDTO)session.getAttribute("loginUser")).getMNo();
		
		// memberDAO의 회원탈퇴 leave메소드 호출
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		int result = memberDAO.leave(mNo);
		
		try {
			response.setContentType("text/html; charset=utf-8");
			if (result > 0) { // 탈퇴 성공 시 session 비우기
				session.invalidate();
				response.getWriter().append("<script>");
				response.getWriter().append("alert('탈퇴되었습니다. 이용해주셔서 감사합니다.');");
				response.getWriter().append("location.href='index.do';");
				response.getWriter().append("</script>");
			} else{
				response.getWriter().append("<script>");
				response.getWriter().append("alert('탈퇴에 실패했습니다.');");
				response.getWriter().append("history.back();");
				response.getWriter().append("</script>");
			}
		} catch(IOException e) {
			e.printStackTrace();
		}

	}

}
