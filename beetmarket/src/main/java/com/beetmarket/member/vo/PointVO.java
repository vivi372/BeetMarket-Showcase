package com.beetmarket.member.vo;

import lombok.Data;

@Data
public class PointVO {
	
	private String id; 
	private Long pointlist_no; 
	private String point_entity; 
	private Long point_delta; 
	private Long gradeNo; 
	private String redeemed_date; // 포인트 차감/등록 날짜
}
