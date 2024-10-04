package com.beetmarket.category.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.beetmarket.category.service.CategoryService;
import com.beetmarket.category.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/category")
@Log4j
public class CategoryController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService service;
	
	//--- 카테고리 리스트 ------------------------------------
	@GetMapping("/list.do")
	// public ModelAndView list(Model model) {
	public String list(@RequestParam(defaultValue = "0") Integer cateHighNo,
			Model model){
		// 대분류 가져오기.
		List<CategoryVO> bigList = service.list(0);
		
		// cateHighNo이 없으면 cateHighNo 중에서 제일 작은것 가져와서 처리
		if(cateHighNo == 0 && (bigList != null && bigList.size() != 0))
			cateHighNo = bigList.get(0).getCateHighNo();
		
		// 중분류 가져오기
		List<CategoryVO> midList = service.list(cateHighNo);
		
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("bigList", bigList);
		model.addAttribute("midList", midList);
		
		return "category/list";
	}
	
	
}
