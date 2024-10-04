package com.beetmarket.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.beetmarket.goods.service.GoodsService;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;
import com.beetmarket.main.service.MainService;
import com.beetmarket.notice.service.NoticeService;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@Autowired
	@Qualifier("mainServiceImpl")
	private MainService service;
	
	
	@Autowired
	@Qualifier("goodsServiceImpl")
	private GoodsService service1;
	
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
	
	
	
	@GetMapping(value = {"/", "/main.do"})
	public String goMain() {
		log.info("redirect main......................");
		return "redirect:/main/main.do";
	}
	
	
	
	@GetMapping(value = {"/main/main.do"})
	public String main(Model model) {
	    log.info("/main/main.do ......................");
	    
	    // 상품 리스트를 가져오기 위해 pageObject만 설정
	    PageObject pageObject = new PageObject(1, 10); // 페이지 번호와 사이즈 설정
	    
	    
	    GoodsVO goodsVO = new GoodsVO();
	    GoodsSearchVO searchVO = new GoodsSearchVO();
	    
	    // 서비스 메서드 호출 시 두 개의 매개변수를 모두 전달
	    List<GoodsVO> goodsList = service1.list(pageObject,searchVO);
	    // 상품 리스트를 가져오기 위해 pageObject만 설정
	    PageObject noticePageObject = new PageObject(1, 10); // 페이지 번호와 사이즈 설정
	    model.addAttribute("goodsList", goodsList);
	    model.addAttribute("noticelist", noticeService.list(noticePageObject));
	    return "main/main";
	}
	
	
	
	@GetMapping(value = {"/main/searchList.do"})
	public String searchList(Model model, HttpServletRequest request) throws Exception {
		log.info("/member/searchList.do ......................");
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject",pageObject);
		return "main/searchList";
	}
	
}
