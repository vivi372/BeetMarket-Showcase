package com.beetmarket.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.category.service.CategoryService;
import com.beetmarket.goods.service.GoodsService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ajax")
@Log4j
public class GoodsAjaxController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;

	@Autowired
	@Qualifier("goodsServiceImpl")
	private GoodsService goodsService;

	// --- 상품 중분류 가져오기 ------------------------------------
	@GetMapping("/getMidList.do")
	public String getMidList(Model model, Integer cateHighNo) {
		log.info("getMidList.do");
		// 중분류를 가져와서 JSP로 넘기기.
		model.addAttribute("midList", categoryService.list(cateHighNo));
		// midList.jsp에 select tag 작성.
		return "goods/midList";
	}

	// --- 상품 소분류 가져오기 ------------------------------------
	@GetMapping("/getLowList.do")
	public String getLowList(Model model, Integer cateHighNo, Integer cateMidNo) {
		log.info("getLowList.do");
		// 소분류를 가져와서 JSP로 넘기기.
		model.addAttribute("lowList", categoryService.list2(cateHighNo, cateMidNo));
		// lowList.jsp에 select tag 작성.
		return "goods/lowList";
	}

	// --- 좋아요 처리 ------------------------------------
	@GetMapping("/getLike.do")
	public String getLike(Model model, Long goodsNo, String id, RedirectAttributes rttr) {
		log.info("getLike.do - 좋아요 기능 실행");
		goodsService.like(goodsNo, id);
		rttr.addFlashAttribute("msg", "좋아요 처리되었습니다.");
		return "redirect:/goods/view.do?goodsNo=" + goodsNo + "&inc=" + 0;
	}

	// --- 좋아요 해제 처리 ------------------------------------
	@GetMapping("/getUnLike.do")
	public String getUnLike(Model model, Long goodsNo, String id, RedirectAttributes rttr) {
		log.info("getUnLike.do - 좋아요 해제기능 실행");
		goodsService.unLike(goodsNo, id);
		rttr.addFlashAttribute("msg", "좋아요 해제되었습니다.");
		return "redirect:/goods/view.do?goodsNo=" + goodsNo + "&inc=" + 0;
	}

	@PostMapping("/getStatusUpdate")
	public ResponseEntity<String> getStatusUpdate(@RequestParam String goodsNos, @RequestParam String goodsStatusNo,
			RedirectAttributes rttr) {
		log.info("getStatusUpdate - 상태변경 실행");
		String[] goodsNoArray = goodsNos.split(",");
		for (String goodsNo : goodsNoArray) {
			// 각 goodsNo에 대해 상태(status) 업데이트 로직 실행
			goodsService.statusUpdate(goodsNo, goodsStatusNo);
		}
		rttr.addFlashAttribute("msg", "상태가 성공적으로 변경되었습니다.");
		return ResponseEntity.ok("Success");
	}

}
