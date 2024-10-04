package com.beetmarket.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EventVO {
	private Long no;
	private String title;
	private String content;
	private String image;
	private String id;
	private String pw;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
}