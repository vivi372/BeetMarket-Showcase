package com.beetmarket.basket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.basket.mapper.BasketMapper;
import com.beetmarket.basket.vo.AjaxOptVO;
import com.beetmarket.basket.vo.BasketList;
import com.beetmarket.basket.vo.BasketOptVO;
import com.beetmarket.basket.vo.BasketVO;
import com.beetmarket.basketopt.list.OptList;

import lombok.Setter;

@Service
@Qualifier("BasketServiceImpl")
public class BasketServiceImpl implements BasketService {

	@Setter(onMethod_ = @Autowired)
	BasketMapper mapper;
	
	@Override
	public BasketList basketList(String id) {
		mapper.unsoldBasket(id);
		//BasketList list = (BasketList) mapper.basketList(id);
		BasketList list = new BasketList();
		list.addAll(mapper.basketList(id));
		return list;
	}

	@Override
	public OptList optList(long goodsNo) {	
		OptList list = new OptList();
		list.addAll(mapper.optList(goodsNo));
		return list;
	}

	@Override
	@Transactional
	public int basketWrite(BasketList list) {
		List<BasketOptVO> optList = list.splitList();
		
		int result = mapper.basketWrite(list.get(0));
		
		mapper.optWrite(optList);
		return result;
	}

	@Override
	@Transactional
	public int basketUpdate(BasketList list) {
		List<BasketOptVO> optList = list.splitList();
		mapper.optUpdate1(optList);
		return mapper.optUpdate2(optList);
	}

	@Override
	public int basketDelete(List<BasketVO> list) {
		
		return mapper.basketDelete(list);
	}

}
