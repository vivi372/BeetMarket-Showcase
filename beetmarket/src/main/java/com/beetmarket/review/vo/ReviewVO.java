package com.beetmarket.review.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReviewVO {

	private Long reviewNo; 			//리뷰번호
	private Long orderNo;  			//주문번호
	private Long goodsNo;  			//상품번혼
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date WriteDate;			//작성일
	private Long  starscore;		//별점
	private String reviewImage;		//리뷰이미지
	private String reviewContent;	//리뷰내용
	private String id; 				//작성자 id
	private Long likeCount = 0L;			//좋아요 개수 (기본값 0으로 설정)
	private String replyId; 				//판매자 id
	private String replyContent; 				//답글 내용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date replyWriteDate;			//작성일
	private Long reviewReplyNo;		//답변번호
}