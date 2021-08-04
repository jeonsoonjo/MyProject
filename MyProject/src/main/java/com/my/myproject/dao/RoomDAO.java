package com.my.myproject.dao;

import java.util.List;

import com.my.myproject.dto.RoomDTO;

public interface RoomDAO {

	public List<RoomDTO> selectRoomList();
	public RoomDTO selectRoomByRNo(long rNo);
	
}
