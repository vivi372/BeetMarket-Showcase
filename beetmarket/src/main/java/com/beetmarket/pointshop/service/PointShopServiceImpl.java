package com.beetmarket.pointshop.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.pointshop.mapper.PointShopMapper;
import com.beetmarket.pointshop.vo.PointShopVO;

import lombok.Setter;

@Service
@Qualifier("PointShopServiceImpl")
public class PointShopServiceImpl implements PointShopService {

	@Setter(onMethod_ = @Autowired)
	private PointShopMapper mapper;
	
	//포인트샵 상품 리스트
	@Override
	public Map<String, Object> list(PointShopVO vo,String id,Integer gradeNo) {
		//포인트 가져오기
		Long point = mapper.getPoint(id);
		//상품 리스트 가져오기
		List<PointShopVO> list = mapper.list(vo,gradeNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("point", point);
		
		return map;
	}
	//포인트샵 상품 등록
	@Override
	@Transactional
	public Integer write(List<PointShopVO> list) {
		Integer result = mapper.goodsWrite(list.get(0));
		//재고가 0이면 stockWrite 는 실행하지 않는다.
		if(list.get(0).getGoodsStock() > 0) {
			for(PointShopVO vo:list) {
				vo.setGoodsId(list.get(0).getGoodsId());
			}
			result = mapper.stockWrite(list,null);
		}
		return result;
	}
	//포인트샵 상품 수정
	@Override
	public Integer update(PointShopVO vo) {
		
		return mapper.update(vo);
	}
	//포인트샵 재고 수정
	@Override
	public Integer updateStock(PointShopVO vo, Long currentStock) {
		Integer result = null; 
		
		long goodsStock = vo.getGoodsStock();
		//입력된 재고보다 현재 재고가 적으면 재고를 입력
		if(goodsStock > currentStock) {
			List<PointShopVO> list = null;
			//입력을 위해 데이터 준비
			for(int i=0;i<goodsStock-currentStock;i++) {
				if(list == null) list = new ArrayList<PointShopVO>();
				list.add(vo);
			}
			//재고 입력
			result = mapper.stockWrite(list, null);
		} else if(goodsStock < currentStock) {
			//입력된 재고보다 현재 재고가 많으면 재고 삭제
			//입력을 위해 데이터 준비
			vo.setGoodsStock(currentStock-goodsStock);
			//재고 삭제
			result = mapper.deleteStock(vo);
		}
		
		return result;
		
	}
	//포인트샵 판매 중지
	@Override
	public Integer delete(PointShopVO vo) {
		
		return mapper.delete(vo);
	}
	@Override
	public Integer realDelete(Long goodsId) {
		
		return mapper.realDelete(goodsId);
	}
	
	

}
