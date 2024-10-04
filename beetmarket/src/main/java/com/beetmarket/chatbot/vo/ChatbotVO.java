package com.beetmarket.chatbot.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatbotVO {
	private Long chatno;
	private Long roomno;
	private String partner;
	private String sender;
	private String content;
	private Date acceptdate;
	private Date senddate;
}