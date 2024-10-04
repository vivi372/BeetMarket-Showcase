package com.beetmarket.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.category.vo.CategoryVO;

@Repository
public interface CategoryMapper {

	// 카테고리 리스트
	public List<CategoryVO> list(@Param("cateHighNo") Integer cateHighNo);
	
	public List<CategoryVO> list2(@Param("cateHighNo") Integer cateHighNo, @Param("cateMidNo") Integer cateMidNo);
	
}
