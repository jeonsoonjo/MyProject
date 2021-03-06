package com.my.myproject.controller;

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

import com.my.myproject.command.board.ShowBoardCommand;
import com.my.myproject.command.member.AdminLoginCommand;
import com.my.myproject.command.member.ChangePwCommand;
import com.my.myproject.command.member.EmailAuthCommand;
import com.my.myproject.command.member.EmailCheckCommand;
import com.my.myproject.command.member.FindIdCommand;
import com.my.myproject.command.member.FindPwCommand;
import com.my.myproject.command.member.IdCheckCommand;
import com.my.myproject.command.member.JoinCommand;
import com.my.myproject.command.member.LeaveCommand;
import com.my.myproject.command.member.LoginCommand;
import com.my.myproject.command.member.LogoutCommand;
import com.my.myproject.command.member.PresentPwCheckCommand;
import com.my.myproject.command.member.UpdateMemberCommand;
import com.my.myproject.command.member.UpdatePwCommand;
import com.my.myproject.command.reservation.RevInfoCommand;
import com.my.myproject.command.room.SelectRoomListCommand;
import com.my.myproject.command.room.SelectRoomViewCommand;
import com.my.myproject.dto.MemberDTO;

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
	
	// ??????????????? index.jsp ????????????
	@GetMapping(value={"/", "index.do"})
	public String index() {
		return "index";
	}
	// ????????? ????????? login.jsp ????????????
	@GetMapping(value="loginPage.do")
	public String loginPage(){
		return "member/login";
	}
	// ??????????????? myPage.jsp ????????????
	@GetMapping(value="myPage.do")
	public String myPage() {
		return "member/myPage";
	}
	// ???????????? ????????? join.jsp ????????????
	@GetMapping(value="joinPage.do")
	public String joinPage() {
		return "member/join";
	}
	// ?????????/???????????? ?????? findIdAndPw.jsp ????????????
	@GetMapping(value="findIdAndPwPage.do")
	public String findIdAndPwPage() {
		return "member/findIdAndPw";
	}
	// ???????????? ?????? ????????? changePw.jsp ????????????
	@GetMapping(value="changePwPage.do")
	public String changePwPage() {
		return "member/changePw";
	}
	
	// ?????????(login)
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
	
	// ????????????(logout)
	@GetMapping(value="logout.do")
	public String logout(HttpSession session, Model model) {
		model.addAttribute("session", session);
		logoutCommand.execute(sqlSession, model);
		return "redirect:/";
	}
	
	// ????????????(join)
	@PostMapping(value="join.do")
	public void join(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		joinCommand.execute(sqlSession, model);
	}
	
	// ????????? ????????????(idCheck) 
	@ResponseBody // AJAX??????
	@GetMapping(value="idCheck.do", produces="application/json; charset=utf-8") // ?????? ?????? ??? JSON????????? ??????
	public Map<String, Object> idCheck(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		return idCheckCommand.execute(sqlSession, model);
	}
	
	// ????????? ????????????(emailCheck) 
	@ResponseBody // AJAX??????
	@GetMapping(value="emailCheck.do", produces="application/json; charset=utf-8") // ?????? ?????? ??? JSON????????? ??????
	public Map<String, Object> emailCheck(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		return emailCheckCommand.execute(sqlSession, model);
	}
	
	// ????????? ???????????? ??????(emailCode)
	@ResponseBody // AJAX??????
	@GetMapping(value="emailCode.do", produces="application/json; charset=utf-8") // ???????????? ?????? ??? JSON????????? ??????
	public Map<String, String> emailCode(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		return emailAuthCommand.execute(sqlSession, model);
	}
	
	// ?????? ???????????? ??????(presentPwCheck)
	@ResponseBody // AJAX ??????
	@PostMapping(value="presentPwCheck.do", produces="application/json; charset=utf-8")
	public Map<String, Boolean> presentPwCheck(@RequestBody MemberDTO memberDTO, HttpSession session, Model model){
		model.addAttribute("session", session);   
		model.addAttribute("memberDTO", memberDTO);
		return presentPwCheckCommand.execute(sqlSession, model);
	}
	
	// ???????????? ??????(updatePw)
	@PostMapping(value="updatePw.do")
	public void updatePw(MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		updatePwCommand.execute(sqlSession, model);
	}
	
	// ???????????? ??????(updateMember)
	@PostMapping(value="updateMember.do")
	public void updateMember(MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		updateMemberCommand.execute(sqlSession, model);
	}
	
	// ????????? ??????(findId)
	@ResponseBody // AJAX??????
	@PostMapping(value="findId.do", produces="application/json; charset=utf-8")
	public Map<String, Object> findId(@RequestBody MemberDTO memberDTO, Model model) { 
		model.addAttribute("memberDTO", memberDTO);
		return findIdCommand.execute(sqlSession, model);
	}
	
	// ???????????? ??????(findPw)
	@ResponseBody // AJAX??????
	@PostMapping(value="findPw.do", produces="application/json; charset=utf-8")
	public Map<String, Object> findPw(@RequestBody MemberDTO memberDTO, Model model) {
		model.addAttribute("memberDTO", memberDTO);
		return findPwCommand.execute(sqlSession, model);
	}
	
	// ???????????? ?????? ??? ???????????? ?????? ????????? changePw.jsp??? ??????????????? ????????? ??????(@ModelAttribute)
	@PostMapping(value="changePwPage.do")
	public String changePwPage(@ModelAttribute MemberDTO memberDTO) {
		return "member/changePw";
	}
	
	// ???????????? ??????&??????(changePw)
	@PostMapping(value="changePw.do")
	public void changePw(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		changePwCommand.execute(sqlSession, model);
	}
	
	// ????????????(leave)
	@GetMapping(value="leave.do")
	public void leave(HttpSession session, HttpServletResponse response, Model model) {
		model.addAttribute("session", session);
		model.addAttribute("response", response);
		leaveCommand.execute(sqlSession, model);
	}
	
	// ????????? ?????????(loginAdmin)
	@PostMapping(value="loginAdmin.do")
	public String adminLogin(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return adminLoginCommand.execute(sqlSession, model);
	}
	
}
