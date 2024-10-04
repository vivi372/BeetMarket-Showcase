package com.beetmarket.order.service;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.beetmarket.pointshop.vo.PointShopVO;
import com.webjjang.util.page.PageObject;

public interface OrderService {
	
	//주문 리스트
	public List<OrderVO> orderList(PageObject pageObject,SearchVO searchVO);
	//주문관리 리스트
	public Map<String , List<OrderVO>> adminList(PageObject pageObject,String id,SearchVO searchVO);
	//주문 상세 보기
	public OrderVO view(Long orderNo);
	//주문 등록 폼
	public Map<String, Object> writeFrom(Long[] goodsNos,Long[] optNos);
	//쿠폰 정보 가져오기
	public List<PointShopVO> getCouponList(String id);
	//멤버쉽 적립율 가져오기
	public Integer getSale_rate(String id);
	
	//주문 등록
	public Integer write(List<OrderVO> list);
	//배송지 변경
	public Integer dlvyUpdate(OrderVO vo);
	//주문 상태 변경
	public Integer stateUpdate(OrderVO vo,Long[] orderNos,String id);
	//주문 삭제
	public Integer delete(Long orderNo);

}
