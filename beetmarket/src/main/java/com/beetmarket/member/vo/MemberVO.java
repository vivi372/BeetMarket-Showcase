package com.beetmarket.member.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {


	private String id;
	private String pw;
	private String name;
	private String gender;
	private String birth;
	private String tel;
	private String email;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate; // 회원 가입일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date conDate; // 최근 접속일
	private String status;
	private String photo;
	private Long newMsgCnt;
	private Integer gradeNo;
	private String gradeName; //grade
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date ship_change_date; // 맴버쉽 변경일자
	private Integer sale_rate; // 등급별 할인율
	private Long shipNo; // 맴버쉽 번호 1 - bronze ,2 - gold ,3 - diamond
	private String shipName; 
	private Long pointlist_no; 
	private String point_entity; 
	private Long point_delta; 
	private String redeemed_date; // 포인트 차감/등록 날짜
	
}
