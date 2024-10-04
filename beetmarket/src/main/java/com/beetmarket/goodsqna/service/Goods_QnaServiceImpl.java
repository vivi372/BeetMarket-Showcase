package com.beetmarket.goodsqna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.goodsqna.mapper.Goods_QnaMapper;
import com.beetmarket.goodsqna.vo.Goods_QnaVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("Goods_QnaServiceImpl")
public class Goods_QnaServiceImpl implements Goods_QnaService{

	
	@Setter(onMethod_ = @Autowired)
	private Goods_QnaMapper mapper;
	
	
	@Override
	public List<Goods_QnaVO> list(PageObject pageObject, Long goodsNo) {
		// 전체 데이터 세팅
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, goodsNo)); // 페이지 처리를 위해서
		return mapper.list(pageObject, goodsNo);
	}
	
	
	
	@Override
	public Integer write(Goods_QnaVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	
	
	@Override
	public Integer update(Goods_QnaVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}
	
	
	
	@Override
	public Integer answeranupdate(Goods_QnaVO vo) {
		return mapper.answeranupdate(vo);
	}

	
	
	@Override
	public Integer delete(Goods_QnaVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}
	
	
	
	@Override
	public Integer answerdelete(Goods_QnaVO vo) {
		return mapper.answerdelete(vo);
	}
}