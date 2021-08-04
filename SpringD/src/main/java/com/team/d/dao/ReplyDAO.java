package com.team.d.dao;

import java.util.List;
import java.util.Map;

import com.team.d.dto.ReplyDTO;

public interface ReplyDAO {

	public void insertReply(Map<String, Object> container);

	public List<ReplyDTO> getReplyListByBidx(Map<String, Object> container);

	public List<ReplyDTO> getChildListByRidx(Map<String, Object> container);

	public void insertReReply(Map<String, Object> container);

	public int getTotalReplyByBIDX(long bIdx);

	public int getTotalChildReplyByBIDX(Map<String, Object> container);
	
}
