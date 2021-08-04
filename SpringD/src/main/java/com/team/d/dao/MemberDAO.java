package com.team.d.dao;

import com.team.d.dto.MemberDTO;

public interface MemberDAO {

	public MemberDTO login(MemberDTO memberDTO); // 로그인
	public MemberDTO kakaoLogin(MemberDTO memberDTO); // 카카오 로그인
	public int join(MemberDTO memberDTO); // 회원가입
	public int idCheck(String mId); // 아이디 중복체크
	public int emailCheck(String mEmail); // 이메일 중복체크
	public int updatePw(MemberDTO memberDTO); // 비밀번호 변경
	public int updateMember(MemberDTO memberDTO); // 회원정보 변경
	public MemberDTO findId(MemberDTO memberDTO); // 아이디 찾기
	public MemberDTO findPw(MemberDTO memberDTO); // 비밀번호 찾기
	public int changePw(MemberDTO memberDTO); // 비밀번호 찾기&변경
	public int leave(long mNo); // 회원탈퇴
	public MemberDTO adminLogin(MemberDTO memberDTO); // 관리자 로그인
	
}
