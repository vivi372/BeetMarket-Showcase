package com.beetmarket.pointshoporder.service;

import java.util.List;
import java.util.Map;

import com.beetmarket.pointshoporder.vo.PointShopOrderVO;
import com.beetmarket.pointshoporder.vo.SearchVO;
import com.webjjang.util.page.PageObject;

public interface PointShopOrderService {
	
	//주문 리스트 가져오기
	public List<PointShopOrderVO> list(PageObject pageObject,SearchVO searchVO,Integer admin);	
	//포인트샵 주문 등록
	public boolean write(List<PointShopOrderVO> list,String id);
	
	//구매 상품 삭제
	public Integer delete(Long stockNo);
	//상품 환불
	public Integer refund(PointShopOrderVO vo);

}
