package com.my.myproject.dao;

import java.sql.Date;
import java.util.List;

import com.my.myproject.dto.ReservationDTO;
import com.my.myproject.dto.RoomDTO;

public interface ReservationDAO {
	
	public List<RoomDTO> remainingRoom(String checkIn, String checkOut, long people);
	public RoomDTO selectRoom(long rNo);
	public int insertReservation(long rNo,long mNo,long people,Date checkIn,Date checkOut,long food,long totalSum,String booker,String reEmail,String note);
	public long selectViewReservation();
	public ReservationDTO selectReservation(long reNo);
	public List<ReservationDTO> reservationList(long mNo);
	public int cancelReservation(long reNo);
	public List<ReservationDTO> reservationListNonMember(String reEmail);
	
}
