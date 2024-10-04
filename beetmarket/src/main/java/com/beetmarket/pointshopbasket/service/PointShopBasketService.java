package com.beetmarket.pointshopbasket.service;


import java.util.List;

import com.beetmarket.pointshopbasket.vo.PointShopBasketVO;

public interface PointShopBasketService {
	
	
	//장바구니 리스트
	public List<PointShopBasketVO> list(String id);
	//장바구니 등록
	public Integer write(PointShopBasketVO vo);
	//장바구니 수정
	public Integer update(PointShopBasketVO vo);
	//장바구니 삭제
	public Integer delete(Long[] pointShopBasketNos);


}