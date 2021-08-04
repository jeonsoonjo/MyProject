package com.team.d.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.d.command.reservation.CancelRevCommand;
import com.team.d.command.reservation.EmailRevCodeCommand;
import com.team.d.command.reservation.MyReservationCommand;
import com.team.d.command.reservation.NonMemberRevListCommand;
import com.team.d.command.reservation.ReceiptCommand;
import com.team.d.command.reservation.ReceiptCommand2;
import com.team.d.command.reservation.RevInfoCommand;
import com.team.d.command.reservation.SelectRemainingRoom;
import com.team.d.command.reservation.SelectRoomCommand;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class ReservationController {

	// field
	private SqlSession sqlSession;
	private SelectRemainingRoom selectRemainingRoom;
	private SelectRoomCommand selectRoomCommand;
	private ReceiptCommand receiptCommand;
	private ReceiptCommand2 receiptCommand2;
	private RevInfoCommand revInfoCommand;
	private MyReservationCommand myReservationCommand;
	private CancelRevCommand cancelRevCommand;
	private EmailRevCodeCommand emailRevCodeCommand;
	private NonMemberRevListCommand nonMemberRevListCommand;
	 
	// 조회 페이지로 이동
	@GetMapping(value="reservationSelectDatePage.do")
	public String reservationSelectDatePage() {
		return "reservation/reservationSelectDatePage";
	}
	
	// 체크인 체크아웃 입력 후 조회 버튼 클릭시
	@GetMapping(value="reservationRoomPage.do")
	public String reservationRoomPage(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		selectRemainingRoom.execute(sqlSession, model);
		return "reservation/reservationRoomPage";
	}
	
	// 예약하기 버튼 클릭시 이동 
	@GetMapping(value="optionPage.do")
	public String optionPage(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		selectRoomCommand.execute(sqlSession, model);
		return "reservation/optionPage";
	}
	
	// 예약정보인 입력페이지 이동
	@GetMapping(value="revInfoPage.do")
	public String revInfo(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		revInfoCommand.execute(sqlSession, model);
		return "reservation/revInfoPage";
	}
	
	// 예약 삽입만 하는 코드 
	@GetMapping(value="receiptPage.do")
	public String receiptPage(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		receiptCommand.execute(sqlSession, model);
		return "redirect:realreceiptPage.do";	//redirect
	}
	
	// 최종 예약 보여주는 페이지 이동
	@GetMapping(value="realreceiptPage.do")
	public String realreceiptPage(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		receiptCommand2.execute(sqlSession, model);
		return "reservation/receiptPage";
	}
	
	// 회원의 예약 목록 보여줌
	@GetMapping(value="myReservation.do")
	public String myReservation(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		myReservationCommand.execute(sqlSession, model);
		return "reservation/myReservation";
	}
	
	// 예약 취소
	@GetMapping(value="cancelPage.do")
	public String cancelPage(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		cancelRevCommand.execute(sqlSession, model);
		return "reservation/cancelPage";
	}
	
	
	/* 아래 코드들은 검토중 */
	
	//비회원 이메일 확인 페이지 이동
	@GetMapping(value="nonMemberPage.do")
	public String nonMemberPage( ) {
		return "reservation/nonMemberPage";
	}
	
	//이메일 예약번호 확인
	@ResponseBody
	@GetMapping(value="reservationEmail.do",produces="application/json; charset=utf-8")
	public Map<String, Object> reservationEmail(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		return emailRevCodeCommand.execute(sqlSession, model);
	}
	
	//비회원으로 예약된 정보 페이지 이동
	@GetMapping(value="nonMemReservationPage.do")
	public String nonMemReservationPage(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		nonMemberRevListCommand.execute(sqlSession, model);
		return "reservation/nonMemReservationPage";
	}
	
}
