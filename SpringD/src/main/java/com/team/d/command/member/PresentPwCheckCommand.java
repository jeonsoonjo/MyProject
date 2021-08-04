package com.team.d.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.team.d.dto.MemberDTO;
import com.team.d.utils.SecurityUtils;

// 현재 비밀번호 확인
public class PresentPwCheckCommand {

public Map<String, Boolean> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpSession session = (HttpSession)map.get("session");
		MemberDTO memberDTO = (MemberDTO)map.get("memberDTO");
		
		// session에 저장된 암호화 된 비밀번호
		String pw1 = ((MemberDTO)session.getAttribute("loginUser")).getMPw();
		
		// 마이페이지 화면에서 입력한 비밀번호 확인
		String pw2 = SecurityUtils.encodeBase64(memberDTO.getMPw()); // 입력한 비밀번호 암호화
		
		// session에 저장된 비밀번호(pw1)와 현재 입력한 비밀번호 확인하기(pw2)
		Map<String, Boolean> resultMap = new HashMap<>();
		resultMap.put("isCorrect", pw1.equals(pw2)); // pw1과 pw3 비교
		return resultMap;

	}

}
