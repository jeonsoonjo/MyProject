package com.team.d.command.member;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;
import com.team.d.utils.SecurityUtils;

// 회원 정보 변경
public class UpdateMemberCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse)map.get("response");
		HttpSession session = request.getSession();

		// request를 통해 입력된 회원정보가 memberDTO에 회원정보와 일치하는지 확인
		MemberDTO memberDTO = (MemberDTO)map.get("memberDTO");
		memberDTO.setMName(SecurityUtils.xxs(request.getParameter("mName"))); // 이름 XXS 처리
		memberDTO.setMEmail(SecurityUtils.xxs(request.getParameter("mEmail"))); // 이메일 XXS 처리
		memberDTO.setMPhone(request.getParameter("mPhone"));
		memberDTO.setMNo(Long.parseLong(request.getParameter("mNo")));
		
		// memberDAO의 회원정보 변경 updateMember메소드 호출
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		int result = memberDAO.updateMember(memberDTO);
		
		// 변경된 회원정보 session에 등록
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");
		loginUser.setMName(memberDTO.getMName());
		loginUser.setMEmail(memberDTO.getMEmail());
		loginUser.setMPhone(memberDTO.getMPhone());
		
		try {
			response.setContentType("text/html; charset=utf-8");
			if (result > 0) { // 회원정보 변경 성공
				response.getWriter().append("<script>");
				response.getWriter().append("alert('회원 정보가 변경되었습니다.');");
				response.getWriter().append("location.href='myPage.do'");
				response.getWriter().append("</script>");
			} else {
				response.getWriter().append("<script>");
				response.getWriter().append("alert('회원 정보 변경에 실패했습니다.');");
				response.getWriter().append("history.back();");
				response.getWriter().append("</script>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
