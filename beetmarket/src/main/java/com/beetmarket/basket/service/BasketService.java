package com.beetmarket.basket.service;

import java.util.List;

import com.beetmarket.basket.vo.AjaxOptVO;
import com.beetmarket.basket.vo.BasketList;
import com.beetmarket.basket.vo.BasketOptVO;
import com.beetmarket.basket.vo.BasketVO;
import com.beetmarket.basketopt.list.OptList;

public interface BasketService {
	
	
	public BasketList basketList(String id);	
	
	public OptList optList(long goodsNo);
	
	public int basketWrite(BasketList list);
	
	public int basketUpdate(BasketList list);
	
	public int basketDelete(List<BasketVO> list);

}
