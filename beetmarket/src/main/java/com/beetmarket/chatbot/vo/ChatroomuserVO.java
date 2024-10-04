package com.beetmarket.chatbot.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatroomuserVO {
	private Long roomno;
	private String user_id;
	private Date deleted;
}