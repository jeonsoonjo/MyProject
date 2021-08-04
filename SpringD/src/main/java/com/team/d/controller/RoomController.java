package com.team.d.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.team.d.command.room.DownloadRoomServiceMenuCommand;
import com.team.d.command.room.SelectRoomListCommand;
import com.team.d.command.room.SelectRoomViewCommand;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class RoomController {

	// field
	private SqlSession sqlSession;
	private SelectRoomListCommand selectRoomListCommand;
	private SelectRoomViewCommand selectRoomViewCommand;
	private DownloadRoomServiceMenuCommand downloadRoomServiceMenuCommand;
	
	@GetMapping(value="amenity.do")
	public String amenity() {
		return "room/amenity";
	}
	
	@GetMapping(value="satelliteChannel.do")
	public String satelliteChannel() {
		return "room/satelliteChannel";
	}
	
	@GetMapping(value="floorPlan.do")
	public String floorPlan() {
		return "room/floorPlan";
	}
	
	@GetMapping(value="privacy.do")
	public String privacy() {
		return "room/privacy";
	}
	
	@GetMapping(value="term.do")
	public String term() {
		return "room/term";
	}
	
	@GetMapping(value="noEmail.do")
	public String noEail() {
		return "room/noEmail";
	}
	
	@GetMapping(value="download.do")
	public void download(HttpServletRequest request,
						 HttpServletResponse response,
						 Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		downloadRoomServiceMenuCommand.execute(model);
	}
	
	@GetMapping(value="infoRoom.do")
	public String infoRoom(Model model) {
		selectRoomListCommand.execute(sqlSession, model);
		return "room/infoRoom";
	}
	
	@GetMapping(value="priceRoom.do")
	public String priceRoom(HttpServletRequest request,
							Model model) {
		model.addAttribute("request", request);
		selectRoomViewCommand.execute(sqlSession, model);
		return "room/priceRoom";
	}
	
}
