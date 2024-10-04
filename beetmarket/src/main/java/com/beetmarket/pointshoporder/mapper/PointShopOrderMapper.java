package com.beetmarket.pointshoporder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.pointshoporder.vo.PointShopOrderVO;
import com.beetmarket.pointshoporder.vo.SearchVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface PointShopOrderMapper {
	
	//총 주문 수 가져오기
	public Long totalRow(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO,@Param("admin") Integer admin);
	//주문 리스트 가져오기
	public List<PointShopOrderVO> list(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO,@Param("admin") Integer admin);
	//포인트샵 주문 전 재고 번호 가져오기
	public List<PointShopOrderVO> getStockNo(List<PointShopOrderVO> list);
	//포인트샵 주문 등록
	public Integer write(@Param("values") List<PointShopOrderVO> values,@Param("id") String id);
	//해당 재고 상태 수정
	public Integer stockStateUpdate(@Param("array") Long[] stockNos,@Param("stockState") String stockState);
	
	//구매 상품 삭제
	public Integer delete(Long stockNo);
	//주문 삭제
	public Integer refundDelete(Long pointShopOrderNo);
	//상품 환불
	public Integer refund(Long pointShopOrderNo);
}

