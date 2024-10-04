package com.beetmarket.basket.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beetmarket.basket.vo.AjaxOptVO;
import com.beetmarket.basket.vo.BasketOptVO;
import com.beetmarket.basket.vo.BasketVO;
import com.beetmarket.basketopt.list.OptList;

@Repository
public interface BasketMapper {
	
	public List<BasketVO> basketList(String id);
	
	public int unsoldBasket(String id);

	public List<AjaxOptVO> optList(long goodsNo);
	
	public int basketWrite(BasketVO vo);
	
	public int optWrite(List<BasketOptVO> list);
	
	public int optUpdate1(List<BasketOptVO> list);
	
	public int optUpdate2(List<BasketOptVO> list);
	
	public int basketDelete(List<BasketVO> list);

}
