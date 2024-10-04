package com.beetmarket.basket.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.basket.service.BasketService;
import com.beetmarket.basket.vo.BasketList;
import com.beetmarket.basket.vo.BasketOptVO;
import com.beetmarket.basket.vo.BasketVO;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;


import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/basket")
@Log4j
public class BasketController {
	
	@Autowired
	@Qualifier("BasketServiceImpl")
	BasketService service;
	
	String id = null;
	
	@GetMapping("/list.do")
	public String basketList(Model model,RedirectAttributes rttr,HttpSession session) {
		
		id = LoginUtil.getId(session);
		
		BasketList list = service.basketList(id);		
		
		//DB에서 아무런 데이터를 가져오지 못 했다면 담지 않는다.
		if(list != null && list.size()>0) {
			List<BasketOptVO> optList = list.splitList();
			model.addAttribute("list", list);	
			model.addAttribute("optList", optList);	
		}		
		
		return "basket/list";
	}
	
	
	@PostMapping("/write.do")
	public String basketWrite(HttpServletRequest request,Long goodsNo,GoodsSearchVO searchVO
			,Long[] optNo,Long[] amount, RedirectAttributes rttr,HttpSession session) throws Exception {		
		
		id = LoginUtil.getId(session);
		
		BasketList list = new BasketList();
		
		//가져온 데이터를 BasketList에 담는다.
		
		for(int i=0;i<amount.length;i++) {
			BasketVO vo = new BasketVO();
			vo.setId(id);
			vo.setGoodsNo(goodsNo);
			//옵션이 없을 경우 optNo는 길이가 0인 배열이라 optNo[i]에서 에러가 나옴
			//직접 null을 넣어준다.
			try {
				vo.setOptNo(optNo[i]);				
			} catch (Exception e) {
				vo.setOptNo(null);
			}
			vo.setAmount(amount[i]);			
			list.add(vo);
		}			
		
		log.info(list);
		service.basketWrite(list);
		
		PageObject pageObject = PageObject.getInstance(request); 
		
		rttr.addFlashAttribute("basketWriteComplete", true);
		//장바구니에 등록된 상품의 상세보기로 보낸다.		
			
		return "redirect:/goods/view.do?goodsNo="+goodsNo+"&inc=0&"+pageObject.getPageQuery()+"&"+searchVO.getQuery();
		
	}
	
	@PostMapping("/update.do")
	public String basketUpdate(long basketNo,long[] optNo,long[] amount,RedirectAttributes rttr,HttpSession session) {
		
		BasketList list = new BasketList();
		
		id = LoginUtil.getId(session);
		
		//가져온 데이터를 BasketList에 담는다.
		for(int i=0;i<amount.length;i++) {
			BasketVO vo = new BasketVO();
			vo.setId(id);
			vo.setBasketNo(basketNo);					
			//직접 null을 넣어준다.
			try {
				vo.setOptNo(optNo[i]);				
			} catch (Exception e) {
				vo.setOptNo(null);
			}
			vo.setAmount(amount[i]);
			list.add(vo);
		}
		
		service.basketUpdate(list);
		
		rttr.addFlashAttribute("msg", "장바구니가 성공적으로 수정되었습니다.");
		
		return "redirect:/basket/list.do";
	}
	
	@GetMapping("/delete.do")
	public String basketDelete(long[] basketNo,RedirectAttributes rttr) {
		
		BasketList list = new BasketList();
		
		//여러 번호를 보내기위해 long 타입으로 변환후 리스트에 담는다.
		for(int i=0;i<basketNo.length;i++) {
			BasketVO vo = new BasketVO();
			vo.setBasketNo(basketNo[i]);
			list.add(vo);
		}
		
		service.basketDelete(list);
		
		rttr.addFlashAttribute("msg", basketNo.length+"건의 상품을 장바구니에서 삭제했습니다.");
		
		return "redirect:/basket/list.do";
	}
	
	
}
