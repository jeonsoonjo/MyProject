package com.team.d.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

 
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReservationDTO {
	
	// field
	private long reNo;	// 예약번호
	private long rNo;	// 방번호
	private long mNo;	// 회원번호
	private long people;	// 예약인원
	private Date checkIn;
	private Date checkOut;
	private long food;		// 조식
	private long totalPay;	
	private String booker;	// 실제 예약자명
	private String reEmail;	
	private String note;	// 요청사항
	private String state;	// 예약상태
	
}
