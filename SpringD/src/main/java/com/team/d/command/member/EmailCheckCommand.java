package com.team.d.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;

// 이메일 존재 여부(중복 확인)
public class EmailCheckCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		// 회원가입 시 request에 입력된 mEmail 확인
		String mEmail = request.getParameter("mEmail");

		// memberDAO의 이메일 중복체크 emailCheck메소드 호출
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result", memberDAO.emailCheck(mEmail));
		return resultMap;
		
	}
	
}
