package com.team.d.dao;

import java.util.List;
import java.util.Map;

import com.team.d.dto.BoardDTO;
import com.team.d.dto.PageDTO;

public interface BoardDAO {

	//void insertBoard(@Param(value = "mId") String mId, @Param(value = "bTitle") String bTitle, @Param(value = "bContent") String bContent, @Param(value = "bFILENAME1") String bFILENAME1, @Param(value = "bFILENAME2") String bFILENAME2,
	//		@Param(value = "bFILENAME3") String bFILENAME3);

	public void insertBoard(Map<String, Object> container);
	
	public int getTotalRecord();

	public List<BoardDTO> boardList(PageDTO pageDTO);

	public List<BoardDTO> searchList(Map<String, String> container);

	public int getSearchedlRecord(Map<String, String> container);

	public int getTotalInformRecord();

	public List<BoardDTO> getNoticeList();

	public void updateHitByIdx(long BIDX);

	public BoardDTO selectBoardByIdx(long BIDX);

	public void updateBoard(Map<String, Object> container);

	public void deleteBoard(long BIDX);
	
}
