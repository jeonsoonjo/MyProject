package com.team.d.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardDTO {
	
	// field
	private long bIdx;
	private String mId;
	private String bTitle;
	private String bContent;
	private long bHit;
	private String bFileName1;
	private String bFileName2;
	private String bFileName3;
	private String bPostDate;

}
