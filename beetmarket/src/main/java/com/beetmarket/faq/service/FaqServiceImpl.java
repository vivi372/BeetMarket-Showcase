package com.beetmarket.faq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.faq.mapper.FaqMapper;
import com.beetmarket.faq.vo.FaqCateVO;
import com.beetmarket.faq.vo.FaqSearchVO;
import com.beetmarket.faq.vo.FaqVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
@Qualifier("faqserviceimpl")
public class FaqServiceImpl implements FaqService {
	@Autowired
	private FaqMapper mapper;
	
	@Override
	public List<FaqVO> list(PageObject po, FaqSearchVO searchvo) {
		po.setTotalRow(mapper.getTotalRow(po, searchvo));
		return mapper.list(po, searchvo);
	}

	@Override
	@Transactional
	public FaqVO view(Long faqno, Long hit) {
		if(hit==1L) mapper.updatehit(faqno);
		return mapper.view(faqno);
	}

	@Override
	public List<FaqCateVO> getcate() {
		return mapper.getcate();
	}

	@Override
	public Integer write(FaqVO vo) {
		return mapper.write(vo);
	}

	@Override
	public Integer update(FaqVO vo) {
		return mapper.update(vo);
	}

	@Override
	public Integer delete(Long faqno) {
		return mapper.delete(faqno);
	}
}