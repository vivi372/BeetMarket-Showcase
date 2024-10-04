package com.beetmarket.faq.service;

import java.util.List;

import com.beetmarket.faq.vo.FaqCateVO;
import com.beetmarket.faq.vo.FaqSearchVO;
import com.beetmarket.faq.vo.FaqVO;
import com.webjjang.util.page.PageObject;

public interface FaqService {
	public List<FaqVO> list(PageObject po, FaqSearchVO searchvo);
	
	public FaqVO view(Long faqno, Long hit);
	
	public List<FaqCateVO> getcate();
	public Integer write(FaqVO vo);

	public Integer update(FaqVO vo);
	
	public Integer delete(Long faqno);
}