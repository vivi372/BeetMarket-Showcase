package com.beetmarket.category.service;

import java.util.List;

import com.beetmarket.category.vo.CategoryVO;

public interface CategoryService {

	// 카테고리 리스트
	public List<CategoryVO> list(Integer cateHighNo);
	
	public List<CategoryVO> list2(Integer cateHighNo, Integer cateMidNo);
	
}
