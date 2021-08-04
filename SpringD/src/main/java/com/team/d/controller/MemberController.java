package com.team.d.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.d.command.board.ShowBoardCommand;
import com.team.d.command.member.AdminLoginCommand;
import com.team.d.command.member.ChangePwCommand;
import com.team.d.command.member.EmailAuthCommand;
import com.team.d.command.member.EmailCheckCommand;
import com.team.d.command.member.FindIdCommand;
import com.team.d.command.member.FindPwCommand;
import com.team.d.command.member.IdCheckCommand;
import com.team.d.command.member.JoinCommand;
import com.team.d.command.member.LeaveCommand;
import com.team.d.command.member.LoginCommand;
import com.team.d.command.member.LogoutCommand;
import com.team.d.command.member.PresentPwCheckCommand;
import com.team.d.command.member.UpdateMemberCommand;
import com.team.d.command.member.UpdatePwCommand;
import com.team.d.command.reservation.RevInfoCommand;
import com.team.d.command.room.SelectRoomListCommand;
import com.team.d.command.room.SelectRoomViewCommand;
import com.team.d.dto.MemberDTO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class MemberController {

	// field
	private SqlSession sqlSession;
	private LoginCommand loginCommand;
	private LogoutCommand logoutCommand;
	private JoinCommand joinCommand;
	private IdCheckCommand idCheckCommand;
	private EmailCheckCommand emailCheckCommand;
	private EmailAuthCommand emailAuthCommand;
	private PresentPwCheckCommand presentPwCheckCommand;
	private UpdatePwCommand updatePwCommand;
	private FindIdCommand findIdCommand;
	private FindPwCommand findPwCommand;
	private UpdateMemberCommand updateMemberCommand;
	private ChangePwCommand changePwCommand;
	private LeaveCommand leaveCommand;
	private AdminLoginCommand adminLoginCommand;
	private ShowBoardCommand showBoardCommand;
	private SelectRoomListCommand selectRoomListCommand;
	private SelectRoomViewCommand selectRoomViewCommand;
	private RevInfoCommand revInfoCommand;
	
	// 메인페이지 index.jsp 단순이동
	@GetMapping(value={"/", "index.do"})
	public String index() {
		return "index";
	}
	// 마이페이지 myPage.jsp 단순이동
	@GetMapping(value="myPage.do")
	public String myPage() {
		return "member/myPage";
	}
	// 회원가입 페이지 join.jsp 단순이동
	@GetMapping(value="joinPage.do")
	public String joinPage() {
		return "member/join";
	}
	// 아이디/비밀번호 찾기 findIdAndPw.jsp 단순이동
	@GetMapping(value="findIdAndPwPage.do")
	public String findIdAndPwPage() {
		return "member/findIdAndPw";
	}
	// 비밀번호 변경 페이지 changePw.jsp 단순이동
	@GetMapping(value="changePwPage.do")
	public String changePwPage() {
		return "member/changePw";
	}
	
	// 로그인(login)
	@PostMapping(value="login.do")
	public String login(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		String page = loginCommand.execute(sqlSession, model);
		
		if(page.equals("selectBoard.do")) {
			showBoardCommand.execute(sqlSession, model);
			return "board/selectBoard";
		} else if(page.equals("infoRoom.do")) {
			selectRoomListCommand.execute(sqlSession, model);
			return "room/infoRoom";
		} else if(page.equals("priceRoom.do")) {
			selectRoomViewCommand.execute(sqlSession, model);
			return "room/priceRoom";
		} else if(page.equals("revInfoPage.do")) {
			revInfoCommand.execute(sqlSession, model);
			return "reservation/revInfoPage";
		}
		return page;
	}
	
	// 로그아웃(logout)
	@GetMapping(value="logout.do")
	public String logout(HttpSession session, Model model) {
		model.addAttribute("session", session);
		logoutCommand.execute(sqlSession, model);
		return "redirect:/";
	}
	
	// 회원가입(join)
	@PostMapping(value="join.do")
	public void join(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		joinCommand.execute(sqlSession, model);
	}
	
	// 아이디 중복체크(idCheck) 
	@ResponseBody // AJAX매핑
	@GetMapping(value="idCheck.do", produces="application/json; charset=utf-8") // 중복 체크 후 JSON형태로 반환
	public Map<String, Object> idCheck(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		return idCheckCommand.execute(sqlSession, model);
	}
	
	// 이메일 중복체크(emailCheck) 
	@ResponseBody // AJAX매핑
	@GetMapping(value="emailCheck.do", produces="application/json; charset=utf-8") // 중복 체크 후 JSON형태로 반환
	public Map<String, Object> emailCheck(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		return emailCheckCommand.execute(sqlSession, model);
	}
	
	// 이메일 인증코드 받기(emailCode)
	@ResponseBody // AJAX매핑
	@GetMapping(value="emailCode.do", produces="application/json; charset=utf-8") // 인증코드 확인 후 JSON형태로 반환
	public Map<String, String> emailCode(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		return emailAuthCommand.execute(sqlSession, model);
	}
	
	// 현재 비밀번호 확인(presentPwCheck)
	@ResponseBody // AJAX 매핑
	@PostMapping(value="presentPwCheck.do", produces="application/json; charset=utf-8")
	public Map<String, Boolean> presentPwCheck(@RequestBody MemberDTO memberDTO, HttpSession session, Model model){
		model.addAttribute("session", session);   
		model.addAttribute("memberDTO", memberDTO);
		return presentPwCheckCommand.execute(sqlSession, model);
	}
	
	// 비밀번호 변경(updatePw)
	@PostMapping(value="updatePw.do")
	public void updatePw(MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		updatePwCommand.execute(sqlSession, model);
	}
	
	// 회원정보 변경(updateMember)
	@PostMapping(value="updateMember.do")
	public void updateMember(MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		updateMemberCommand.execute(sqlSession, model);
	}
	
	// 아이디 찾기(findId)
	@ResponseBody // AJAX매핑
	@PostMapping(value="findId.do", produces="application/json; charset=utf-8")
	public Map<String, Object> findId(@RequestBody MemberDTO memberDTO, Model model) { 
		model.addAttribute("memberDTO", memberDTO);
		return findIdCommand.execute(sqlSession, model);
	}
	
	// 비밀번호 찾기(findPw)
	@ResponseBody // AJAX매핑
	@PostMapping(value="findPw.do", produces="application/json; charset=utf-8")
	public Map<String, Object> findPw(@RequestBody MemberDTO memberDTO, Model model) {
		model.addAttribute("memberDTO", memberDTO);
		return findPwCommand.execute(sqlSession, model);
	}
	
	// 비밀번호 찾고 새 비밀번호 변경 페이지 changePw.jsp로 파라미터값 가지고 이동(@ModelAttribute)
	@PostMapping(value="changePwPage.do")
	public String changePwPage(@ModelAttribute MemberDTO memberDTO) {
		return "member/changePw";
	}
	
	// 비밀번호 찾기&변경(changePw)
	@PostMapping(value="changePw.do")
	public void changePw(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		changePwCommand.execute(sqlSession, model);
	}
	
	// 회원탈퇴(leave)
	@GetMapping(value="leave.do")
	public void leave(HttpSession session, HttpServletResponse response, Model model) {
		model.addAttribute("session", session);
		model.addAttribute("response", response);
		leaveCommand.execute(sqlSession, model);
	}
	
	// 관리자 로그인(loginAdmin)
	@PostMapping(value="loginAdmin.do")
	public String adminLogin(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return adminLoginCommand.execute(sqlSession, model);
	}
	
}
