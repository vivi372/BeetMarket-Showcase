package com.beetmarket.review.service;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewService {

	// 1-1. 리스트
	public List<ReviewVO> list(PageObject pageObject, Long goodsNo);
	
	
	
	// 1-2. 리뷰 수 & 평점
	Long getTotalRow(PageObject pageObject, Long goodsNo);

	
	
	// 2. 등록
	public Integer write(ReviewVO vo);
	
	
	
	// 2-1 답변 등록
	public Integer replywrite(ReviewVO vo);
	
	
	
	public Long getGoodsNoByOrderNo(Long orderNo);

	
	
	// 3. 수정
	public Integer update(ReviewVO vo);
	
	
	
	// 3-1 답변수정
	public Integer replyupdate(ReviewVO vo);
	
	
	
	// 4.삭제
	public Integer delete(ReviewVO vo);
	
	
	
	// 4-1. 답변 삭제
	public Integer replydelete(ReviewVO vo);


}