package com.beetmarket.notice.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NoticeVO {
	private Long no;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDate;
	private String status;
	private String pw;
}