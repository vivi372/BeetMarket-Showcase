package com.beetmarket.pointshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.pointshop.vo.PointShopVO;

@Repository
public interface PointShopMapper {
	
	//포인트샵 상품 리스트
	public List<PointShopVO> list(@Param("vo") PointShopVO vo,@Param("gradeNo") Integer gradeNo);
	//현재 계정 포인트 가져오기
	public Long getPoint(String id);
	//포인트샵 상품 등록
	public Integer goodsWrite(PointShopVO vo);
	//포인트샵 재고 등록
	public Integer stockWrite(@Param("list") List<PointShopVO> list,@Param("category") String category);
	//포인트샵 상품 수정
	public Integer update(PointShopVO vo);
	//포인트샵 재고 삭제
	public Integer deleteStock(PointShopVO vo);
	//포인트샵 판매 중지
	public Integer delete(PointShopVO vo);
	//포인트샵 판매 중지
	public Integer realDelete(Long goodsId);
	

}
