package com.beetmarket.basketopt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.basket.service.BasketService;
import com.beetmarket.basket.vo.AjaxOptVO;
import com.beetmarket.basketopt.list.OptList;
import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/opt")
@Log4j
public class BasketOptController {
	
	@Autowired
	@Qualifier("BasketServiceImpl")
	BasketService service;
	
	@GetMapping("/list.do")
	public String optList(long goodsNo,Model model) {
		OptList list = service.optList(goodsNo);
		
		for(AjaxOptVO vo:list) {
			if(vo.getOptNo() == null) break;
			vo.splitName();
		}
		
		list.calMaxOptSize();
		
		Gson gson = new Gson();
		String jsonList = gson.toJson(list);
		
		model.addAttribute("list", list);
		model.addAttribute("jsonList", jsonList);
		
		return "basket/optList";
	}
	
}
