package com.beetmarket.pointshoporder.controller;

import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.member.service.MemberService;
import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.PointVO;
import com.beetmarket.pointshopbasket.service.PointShopBasketService;
import com.beetmarket.pointshoporder.service.PointShopOrderService;
import com.beetmarket.pointshoporder.vo.PointShopOrderVO;
import com.beetmarket.pointshoporder.vo.SearchVO;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/pointShopOrder")
@Log4j
public class PointShopOrderController {
	
	@Autowired
	@Qualifier("PointShopOrderServiceImpl")
	PointShopOrderService service;
	@Autowired
	@Qualifier("PointShopServiceBasketImpl")
	PointShopBasketService basketService;
	
	
	@GetMapping("/list.do")
	public String list(HttpServletRequest request,Model model,HttpSession session,SearchVO searchVO,@RequestParam(defaultValue = "0") Integer admin,RedirectAttributes rttr) throws Exception {
		
		
		String id=LoginUtil.getId(session);
		Integer gradeNo = LoginUtil.getGradeno(session);
		
		if(admin==1 && gradeNo < 9) {
			rttr.addFlashAttribute("msg", "접근하실 권한이 없는 페이지입니다.");
			return "redirect:/main/main.do";
		}
		
		//날짜 검색에 아무것도 입력 안 됐을때 처리
		if(searchVO.getMaxDate() == null && searchVO.getMinDate() == null) {
			LocalDate today = LocalDate.now();			
			LocalDate minDate = today.minusYears(5);
			
			searchVO.setMaxDate(today);
			searchVO.setMinDate(minDate);
		}
		
		//'/'를 통해 상세 검색을 했을때 처리
		if(searchVO.getKey() != null && searchVO.getKey().length()==2 && searchVO.getWord() != null && searchVO.getWord().indexOf('/')>0) {
			String word = searchVO.getWord();
			searchVO.setId(word.substring(0,word.indexOf('/')));			
			searchVO.setGoodsName(word.substring(word.indexOf('/')+1));
		}
		
		//페이지 정보를 위해 페이지오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);
		if(admin == 0) {		
			//기본 perPageNum 설정
			pageObject.setPerPageNum(15);
			//페이지 오브젝트에 아이디 넣기
			pageObject.setAccepter(id);
		}
		
		//db에서 데이터 가져온후 model에 담아 보내기
		model.addAttribute("list", service.list(pageObject,searchVO,admin));
		model.addAttribute("pageObject", pageObject);
		model.addAttribute("searchVO", searchVO);
		if(admin == 0)
			return "pointShopOrder/list";
		else
			return "pointShopOrder/adminList";
	}
	
	//아작스로 데이터를 받고 보내기 위해 @ResponseBody 사용
	@PostMapping(value = "/write.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> write(@ModelAttribute PointShopOrderVO vo,String id) {
		List<PointShopOrderVO> list = vo.getList();
		log.info(list);
		//주문 등록(재고가 부족하면 write true 리턴 => 결제 하지 않고 리턴 시킨다.)
		if(service.write(list, id)) {
			return new ResponseEntity<>("죄송합니다. 현재 해당 상품의 재고가 부족하여 주문이 불가능합니다.",HttpStatus.OK);
		} 		
		
		//장바구니 삭제
		//삭제를 위한 데이터 세팅
		Long[] pointShopBasketNos = new Long[list.size()];
		int i=0;
		for(PointShopOrderVO item:list) {
			pointShopBasketNos[i++] = item.getPointShopBasketNo();
		}
		//db에서 장바구니 삭제
		basketService.delete(pointShopBasketNos);
		
		
		return new ResponseEntity<>("주문이 정상적으로 진행되었습니다.",HttpStatus.OK);
	}
	
	//구매 상품 삭제
	@GetMapping("/delete.do")
	public String delete(@ModelAttribute SearchVO searchVO,Long stockNo,RedirectAttributes rttr) throws UnsupportedEncodingException {
		//db에서 상품 삭제
		service.delete(stockNo);
		//삭제 후 문구 출력
		rttr.addFlashAttribute("msg", "정상적으로 삭제되었습니다.");
		
		return "redirect:list.do?"+searchVO.getQuery();
	}
	
	//상품 환불
	@GetMapping("/refund.do")
	public String refund(SearchVO searchVO,Long page,Integer perPageNum,PointShopOrderVO vo,RedirectAttributes rttr,HttpSession session) throws Exception {
		//상품 이름,상품 가격, 주문 번호 ,아이디 입력
		service.refund(vo);
		
		rttr.addFlashAttribute("msg", vo.getPointShopOrderNo()+"번 주문이 정상적으로 환불되었습니다.");
		
		return "redirect:list.do?admin=1&"+searchVO.getQuery()+"&page="+page+"&perPageNum="+perPageNum;
	}

}
