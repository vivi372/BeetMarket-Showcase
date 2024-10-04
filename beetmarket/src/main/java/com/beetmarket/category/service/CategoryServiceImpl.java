package com.beetmarket.category.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.beetmarket.category.mapper.CategoryMapper;
import com.beetmarket.category.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService{

	@Inject
	private CategoryMapper mapper;
	
	// 카테고리 리스트
	@Override
	public List<CategoryVO> list(Integer cateHighNo) {
		return mapper.list(cateHighNo);
	}
	
	// 카테고리 리스트
	@Override
	public List<CategoryVO> list2(Integer cateHighNo, Integer cateMidNo) {
		return mapper.list2(cateHighNo, cateMidNo);
	}
	
	
}
