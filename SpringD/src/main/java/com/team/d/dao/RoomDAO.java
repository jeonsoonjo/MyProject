package com.team.d.dao;

import java.util.List;

import com.team.d.dto.RoomDTO;

public interface RoomDAO {

	public List<RoomDTO> selectRoomList();
	public RoomDTO selectRoomByRNo(long rNo);
	
}
