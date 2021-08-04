package com.team.d.command.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;

// 아이디 찾기
public class FindPwCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MemberDTO memberDTO = (MemberDTO)map.get("memberDTO");
		
		// memberDAO의 비밀번호 찾기 findPw메소드 호출
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO findUser = memberDAO.findPw(memberDTO);
		
		Map<String, Object> resultMap = new HashMap<>();
		if(findUser == null){ // 입력한 정보와 일치하지 않을 경우
			resultMap.put("status", 500);
		} else{ // 입력한 정보가 일치할 경우 
			resultMap.put("status", 200);
		}
		return resultMap;
	}

}
