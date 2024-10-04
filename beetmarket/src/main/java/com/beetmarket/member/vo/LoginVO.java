package com.beetmarket.member.vo;

import lombok.Data;

@Data
public class LoginVO {
	
	private String id;
	private String pw;
	private String name;
	private String photo;
	private Long newMsgCnt;
	private Integer gradeNo;
	private String gradeName;
	private String email;
	private Integer shipNo;
	private Integer sell_no;
	private String shipName;
	
}
