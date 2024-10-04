package com.beetmarket.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {
	
	
	
	// 1-1 리스트
	public List<ReviewVO> list(@Param("pageObject") PageObject pageObject,@Param("goodsNo") Long goodsNo);
	
	
	
	// 1-2. 리스트 전체 개수 & 평점
	public Long getTotalRow(@Param("pageObject")PageObject pageObject,@Param("goodsNo") Long goodsNo);

	
	
	// 2. 등록
	public Integer write(ReviewVO vo);
	
	
	
	// 2-1 답변 등록
	public Integer replywrite(ReviewVO vo);
	
	
	
	// 3.글수정
	public Integer update(ReviewVO vo);
	
	
	
	// 3-2. 답변 수정
	public Integer replyupdate(ReviewVO vo);
	
	
	
	// 4.삭제
	public Integer delete(ReviewVO vo);
	
	
	// 4-1.삭제
	public Integer replydelete(ReviewVO vo);
	
	
	
	// 5
	public Long getGoodsNoByOrderNo(Long orderNo);

	
	
	// 6
	public Integer reviewExist(@Param("reviewExist") int reviewExist,@Param("orderNo") Long orderNo);


}