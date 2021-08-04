package com.team.d.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class EventController {

	// field
	private SqlSession sqlSession;
	
	@GetMapping(value="eventPage.do")
	public String eventPage() {
		return "event/eventPage";
	}
	
	@GetMapping(value="eventList.do")
	public String eventList() {
		return "event/eventList";
	}
	
	@GetMapping(value="SweetWalkOnTheClouds.do")
	public String SweetWalkOnTheClouds() {
		return "event/SweetWalkOnTheClouds";
	}
	
	@GetMapping(value="FruitJellyCollection.do")
	public String FruitJellyCollection() {
		return "event/FruitJellyCollection";
	}
	
	@GetMapping(value="SummerTaste.do")
	public String SummerTaste() {
		return "event/SummerTaste";
	}
	
	@GetMapping(value="CoolSummerFestival.do")
	public String CoolSummerFestival() {
		return "event/CoolSummerFestival";
	}
	
	@GetMapping(value="CoolingSummerDelights.do")
	public String CoolingSummerDelights() {
		return "event/CoolingSummerDelights";
	}
	
}
