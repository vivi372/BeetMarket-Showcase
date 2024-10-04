package com.beetmarket.goodsqna.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Goods_QnaVO {

	private Long goodsQNA;  					//상품 질문답변번호
	private Long goodsNo;						//상품 질문답변번호
	private String id;							//작성자
	private String question;					//질문내용
	private String answer;						//답변내용
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")		
	private Date writeDate;						//질문일
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")	
	private Date answerDate;					//답변일
	private String status;						//질문상택 (답변대기중, 답변완료)
}