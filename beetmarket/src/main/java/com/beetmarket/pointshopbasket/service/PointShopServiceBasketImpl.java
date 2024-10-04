package com.beetmarket.pointshopbasket.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.pointshopbasket.mapper.PointShopBasketMapper;
import com.beetmarket.pointshopbasket.vo.PointShopBasketVO;

import lombok.Setter;

@Service
@Qualifier("PointShopServiceBasketImpl")
public class PointShopServiceBasketImpl implements PointShopBasketService {

	@Setter(onMethod_ = @Autowired)
	private PointShopBasketMapper mapper;
	
	
	@Override
	public List<PointShopBasketVO> list(String id) {
		
		return mapper.list(id);
	}
	
	//장바구니 등록
	@Override
	public Integer write(PointShopBasketVO vo) {
		
		return mapper.write(vo);
	}
	
	//장바구니 수정
	@Override
	public Integer update(PointShopBasketVO vo) {
		
		return mapper.update(vo);


	}
	
	//장바구니 삭제
	@Override
	public Integer delete(Long[] pointShopBasketNos) {
		
		return mapper.delete(pointShopBasketNos);


	}	
	
	
	

}
