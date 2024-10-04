package com.beetmarket.showdown.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ShowdownVO {
	private Long no;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDate;
	private Long event_no;
	private String pw;
}