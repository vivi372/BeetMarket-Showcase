package com.beetmarket.reviewlike.vo;

import lombok.Data;

@Data
public class ReviewLikeVO {

	 private Long reviewLike_No; // 좋아요 고유 식별자
	 private Long reviewNo;      // 좋아요가 눌린 리뷰 번호
	 private String id;          // 좋아요를 누른 사용자 ID
}