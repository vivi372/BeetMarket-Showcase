package com.beetmarket.faq.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class FaqVO {
	private Long faqno;
	private Long hit; //자주 찾는 질문 리스트로 올리기 위함
	private Long cateno;
	private String catename;
	private String question;
	private String answerline;
	private String answer;
	private Long imgno;
	private String imgname;
	private Date writedate;
}