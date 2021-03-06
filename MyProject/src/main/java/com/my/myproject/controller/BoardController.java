package com.my.myproject.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.my.myproject.command.board.BoardListCommand;
import com.my.myproject.command.board.DeleteBoardCommand;
import com.my.myproject.command.board.InsertBoardCommand;
import com.my.myproject.command.board.SearchBoardCommand;
import com.my.myproject.command.board.SelectNoticeCommand;
import com.my.myproject.command.board.ShowBoardCommand;
import com.my.myproject.command.board.UpdateBoardCommand;
import com.my.myproject.command.board.UpdateBoardPageCommand;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class BoardController {

	// field
	private SqlSession sqlSession;
	private InsertBoardCommand insertBoardCommand;
	private BoardListCommand boardListCommand;
	private SearchBoardCommand searchBoardCommand;
	private SelectNoticeCommand selectNoticeCommand;
	private ShowBoardCommand showBoardCommand;
	private UpdateBoardPageCommand updateBoardPageCommand;
	private UpdateBoardCommand updateBoardCommand;
	private DeleteBoardCommand deleteBoardCommand;
	
	@GetMapping(value= {"boardPage.do", "inquire.do"})
	public String BoardPage(HttpServletRequest request, Model model) {
		String page = request.getParameter("page");
		if(page != null) {
			model.addAttribute("page", page);
		} else {
			model.addAttribute("page", "1");
		}
		return "board/viewBoardList";
	}
	
	@GetMapping(value="insertBoardPage.do")
	public String insertBoardPage() {
		return "board/insertBoard";
	}
	
	@PostMapping(value="insertBoard.do")
	public String insertBoard(MultipartHttpServletRequest multipartRequest, Model model) {		
		model.addAttribute("multipartRequest", multipartRequest);
		
		insertBoardCommand.execute(sqlSession, model);
		return "board/viewBoardList";
	}

	@GetMapping(value="showList.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> boardList(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		// ?????? ????????? ??? ????????? ????????? ??????????????? ??????
		model.addAttribute("page", "1");
		return boardListCommand.execute(sqlSession, model);
	}

	@GetMapping(value="searchBoard.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> searchBoard(HttpServletRequest request, Model model){
		model.addAttribute("request", request);
		model.addAttribute("column", request.getParameter("column"));
		model.addAttribute("query", request.getParameter("query"));
		model.addAttribute("page", request.getParameter("page"));
		
		return searchBoardCommand.execute(sqlSession, model);
	}

	@GetMapping(value="searchList.do")
	public String searchList(HttpServletRequest request, Model model) {
		model.addAttribute("column", request.getParameter("column"));
		model.addAttribute("query", request.getParameter("query"));
		model.addAttribute("page", request.getParameter("page"));
		return "board/viewBoardList";
	}
	
	@GetMapping(value="selectNotice.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> selectInform(){
		
		return selectNoticeCommand.execute(sqlSession);
	}
	
	// ????????? ?????? ????????? ???????????? ????????? ???????????? ??????
	@GetMapping(value="selectBoard.do")
	public String showBoard(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("page", request.getParameter("page"));
		showBoardCommand.execute(sqlSession, model);
		return "board/selectBoard";
	}
	
	@PostMapping(value="updateBoardPage.do")
	public String updateBoardPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("page", "1");
		updateBoardPageCommand.execute(sqlSession, model);
		return "board/updateBoard";
	}
	
	@PostMapping(value="updateBoard.do")
	public String updateBoard(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		updateBoardCommand.execute(sqlSession, model);
		return "board/viewBoardList";
	}
	
	@PostMapping(value="deleteBoard.do")
	public String deleteBoard(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		model.addAttribute("page", "1");
		deleteBoardCommand.execute(sqlSession, model);
		return "board/viewBoardList";
	}
	
}
