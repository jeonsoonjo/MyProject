package com.team.d.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

import com.team.d.utils.SecurityUtils;

// 이메일 인증코드 전송
public class EmailAuthCommand {

	@Autowired
	private JavaMailSender mailSender;

	public Map<String, String> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		// 회원가입 시 request에 입력된 mEmail 확인
		String mEmail = request.getParameter("mEmail");
		String authCode = null;
		MimeMessage mMsg = mailSender.createMimeMessage(); // 이메일 작성 클래스(MimeMessage)

		try {
			mMsg.setHeader("Content-Type", "text/plain; charset=utf-8");
			mMsg.setFrom(new InternetAddress("jeonsoonjo@gmail.com", "관리자")); // 보내는 사람
			mMsg.setRecipient(Message.RecipientType.TO, new InternetAddress(mEmail)); // 받는 사람
			mMsg.setSubject("인증코드 메일입니다."); // 메일 제목
			authCode = SecurityUtils.getAuthCode(6); // 6자리 인증코드
			mMsg.setText("인증코드는 " + authCode + "입니다."); // 메일 내용
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 이메일 전송
		mailSender.send(mMsg);
		
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("authCode", authCode);
		return resultMap;
		
	}
	
}
