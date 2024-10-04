package com.beetmarket.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.review.mapper.ReviewMapper;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("ReviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;
	
	
	// 리스트
	@Override
	public List<ReviewVO> list(PageObject pageObject, Long goodsNo){
		log.info(goodsNo);
		log.info(pageObject);
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, goodsNo));
		
		return mapper.list(pageObject,goodsNo);
	}
    
    
    
	// 리뷰수 & 평점
	@Override
    public Long getTotalRow(PageObject pageObject, Long goodsNo) {
        return mapper.getTotalRow(pageObject, goodsNo);
    }


	
	// 등록
	@Override
	@Transactional
	public Integer write(ReviewVO vo) {
		Integer result = mapper.write(vo);
		mapper.reviewExist(1, vo.getOrderNo());
		return result;
	}
	
	
	
	// 답변 등록
	@Override
	@Transactional
	public Integer replywrite(ReviewVO vo) {
		Integer result = mapper.replywrite(vo);
		return result;
	}
	
	
	
	@Override
	public Long getGoodsNoByOrderNo(Long orderNo) {
	    return mapper.getGoodsNoByOrderNo(orderNo);
	}
	
	
	
	// 수정
	@Override
	public Integer update(ReviewVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	
	
	// 리뷰 답변 수정
	@Override
	public Integer replyupdate(ReviewVO vo) {
		log.info(vo);
		return mapper.replyupdate(vo);
	}
	
	
	// 삭제
	@Override
	@Transactional
	public Integer delete(ReviewVO vo) {
		log.info(vo);
		mapper.reviewExist(0, vo.getOrderNo());
		return mapper.delete(vo);
	}
	
	
	
	// 답변 삭제
	@Override
	@Transactional
	public Integer replydelete(ReviewVO vo) {
		log.info(vo);
		return mapper.replydelete(vo);
	}
    
}