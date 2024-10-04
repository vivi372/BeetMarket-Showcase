package com.beetmarket.goodsqna.service;

import java.util.List;

import com.beetmarket.goodsqna.vo.Goods_QnaVO;
import com.webjjang.util.page.PageObject;

public interface Goods_QnaService {

	// 1. 리스트
	public List<Goods_QnaVO> list(PageObject pageObject, Long goodsNo);
	
	
	
	// 2. 등록
	public Integer write(Goods_QnaVO vo);
	
	
	
	// 3. update
	public Integer update(Goods_QnaVO vo);
	
	
	
	public Integer answeranupdate(Goods_QnaVO vo);
	
	
	
	// 4. delete
	public Integer delete(Goods_QnaVO vo);
	
	
	
	public Integer answerdelete(Goods_QnaVO vo);
}