package com.beetmarket.goodsqna.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.goodsqna.vo.Goods_QnaVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface Goods_QnaMapper {

	
	// 1-1. 전체 데이터 개수
	public Long getTotalRow(
			@Param("pageObject") PageObject pageObject,
			@Param("goodsNo") Long goodsNo);
	
	// 1-2 리스트 
	public List<Goods_QnaVO> list(
			@Param("pageObject") PageObject pageObject,
			@Param("goodsNo") Long goodsNo);
	
	
	
	// 2. write
	public Integer write(Goods_QnaVO vo);
	
	
	
	// 3. update
	public Integer update(Goods_QnaVO vo);
	
	
	
	// 4. answeranupdate
	public Integer answeranupdate(Goods_QnaVO vo);
	
	
	
	// 5. delete
	public Integer delete(Goods_QnaVO vo);
	
	
	
	// 6. answerdelete
	public Integer answerdelete(Goods_QnaVO vo);
	
}