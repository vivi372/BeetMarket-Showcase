package com.beetmarket.faq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.faq.vo.FaqCateVO;
import com.beetmarket.faq.vo.FaqSearchVO;
import com.beetmarket.faq.vo.FaqVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface FaqMapper {
	public List<FaqVO> list(@Param("po") PageObject po, @Param("searchvo") FaqSearchVO searchvo);
	public Long getTotalRow(@Param("po") PageObject po, @Param("searchvo") FaqSearchVO searchvo);
	
	public FaqVO view(Long faqno);
	public Long updatehit(Long faqno);
	
	public List<FaqCateVO> getcate();
	public Integer write(FaqVO vo);
	
	public Integer update(FaqVO vo);
	
	public Integer delete(Long faqno);
}