package com.beetmarket.main.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beetmarket.goods.vo.GoodsVO;
import com.beetmarket.main.vo.MainSearchVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface MainMapper {

	public Long getTotalRow(PageObject pageObject);
	
	public List<MainSearchVO> list(PageObject pageObject);
	public List<GoodsVO> list1(PageObject pageObject);
	
}

