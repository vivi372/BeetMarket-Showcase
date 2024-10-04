package com.beetmarket.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.goods.vo.GoodsVO;
import com.beetmarket.main.mapper.MainMapper;
import com.beetmarket.main.vo.MainSearchVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;


@Service
@Qualifier("mainServiceImpl")
public class MainServiceImpl implements MainService{

	@Setter(onMethod_ = @Autowired)
	private MainMapper mapper;
	
	@Override
	public List<MainSearchVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	
	@Override
	public List<GoodsVO> list1(PageObject pageObject) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list1(pageObject);
	}
	
}
