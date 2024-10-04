package com.beetmarket.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.goods.vo.GoodsVO;
import com.beetmarket.order.vo.OrderOptVO;
import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.beetmarket.pointshop.vo.PointShopVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface OrderMapper {
	
	//주문 리스트
	public List<OrderVO> orderList(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO);
	//주문 전체 수 구하기
	public Long totalRow(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO);
	//주문관리 리스트
	public List<OrderVO> adminList(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO);
	//주문관리 전체 수 구하기
	public Long adminTotalRow(@Param("searchVO") SearchVO searchVO);
	public List<OrderVO> getGoods(String id);
	//주문 상세 보기
	public OrderVO view(Long orderNo);
	//writeForm 상품의 데이터 가져오는 쿼리 

	public List<OrderVO> getGoodsList(@Param("goodsNos") Long[] goodsNos);

	//writeForm 옵션의 데이터 가져오는 쿼리 
	public List<OrderOptVO> getOptList(@Param("optNos") Long[] optNos);
	public List<PointShopVO> getCouponList(String id);
	public Integer getSale_rate(String id);
	//주문 등록
	public Integer write(@Param("list") List<OrderVO> list);
	//배송지 변경
	public Integer dlvyUpdate(OrderVO vo);
	//주문 상태 변경
	public Integer stateUpdate(@Param("vo") OrderVO vo,@Param("orderNos") Long[] orderNos);
	//해당 주문의 적립금 가져오기
	public Long getSavings(Long orderNo);
	//요청 처리시 쿠폰 상태 변경
	public Integer refundCoupon(@Param("orderNo") Long orderNo,@Param("couponNo") Long couponNo);
	public Integer refundCoupon2(@Param("orderNo") Long orderNo,@Param("couponNo") Long couponNo);
	//주문 삭제
	public Integer delete(Long orderNo);


}
