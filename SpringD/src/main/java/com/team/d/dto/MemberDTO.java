package com.team.d.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {

	// field
	private long mNo; // 회원 번호
	private String mName; // 이름
	private String mId; // 아이디
	private String mPw; // 비밀번호
	private String mEmail; // 이메일
	private String mPhone; // 전화번호
	private String mGrade; // 등급
	private Date mRegdate; // 가입일
	private int status; // 회원 상태(탈퇴 여부 : -1)
	private String kakaoLogin; // 카카오 로그인 여부  
	
}
