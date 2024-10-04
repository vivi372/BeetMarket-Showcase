package com.beetmarket.pointshopbasket.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beetmarket.pointshopbasket.vo.PointShopBasketVO;

@Repository
public interface PointShopBasketMapper {
	//장바구니 리스트
	public List<PointShopBasketVO> list(String id);
	
	//장바구니 등록
	public Integer write(PointShopBasketVO vo);
	
	//장바구니 수정
	public Integer update(PointShopBasketVO vo);
	
	//장바구니 삭제
	public Integer delete(Long[] pointShopBasketNos);

}
