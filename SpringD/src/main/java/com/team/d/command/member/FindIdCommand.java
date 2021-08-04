package com.team.d.command.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dao.MemberDAO;
import com.team.d.dto.MemberDTO;

// 아이디 찾기
public class FindIdCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MemberDTO memberDTO = (MemberDTO)map.get("memberDTO"); // memberDTO에서 이름, 이메일 가져오기

		// memberDAO의 아이디 찾기 findId메소드 호출
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO findUser = memberDAO.findId(memberDTO);

		Map<String, Object> resultMap = new HashMap<>();
		if(findUser == null) { // 입력한 정보와 일치하는 mId가 없을 경우
			resultMap.put("status", 500);
		} else { // 입력한 정보와 일치하는 mId가 있을 경우 반환
			resultMap.put("status", 200);
			resultMap.put("mId", findUser.getMId());
		}
		return resultMap;

	}

}
