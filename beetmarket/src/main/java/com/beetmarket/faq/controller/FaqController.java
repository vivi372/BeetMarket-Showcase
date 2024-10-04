package com.beetmarket.faq.controller;

import java.util.ArrayList;
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

import com.beetmarket.faq.service.FaqService;
import com.beetmarket.faq.vo.FaqCateVO;
import com.beetmarket.faq.vo.FaqSearchVO;
import com.beetmarket.faq.vo.FaqVO;
import com.beetmarket.member.vo.LoginVO;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Autowired
	@Qualifier("faqserviceimpl")
	private FaqService service;
	
	@GetMapping("/list.do")
	public String list(Model model, PageObject po, FaqSearchVO searchvo, HttpSession session) {
		List<FaqVO> list=new ArrayList<>();
		
		list=service.list(po, searchvo);
		model.addAttribute("list", list);
		
		LoginVO login=(LoginVO)session.getAttribute("login");
		
		model.addAttribute("login", login);
		
		return "faq/mainlist";
	}
	
	@GetMapping("/faqlist.do")
	public String faqlist(Model model, PageObject po, FaqSearchVO searchvo, HttpSession session) {
		List<FaqVO> list=new ArrayList<>();
		
		list=service.list(po, searchvo);
		model.addAttribute("list", list);
		model.addAttribute("po", po);
		
		LoginVO login=(LoginVO)session.getAttribute("login");
		model.addAttribute("login", login);
		
		return "faq/faqlist";
	}
	
	@GetMapping("/view.do")
	public String view(Model model, Long faqno, Long hit, HttpSession session) {
		FaqVO vo=new FaqVO();
		vo=service.view(faqno, hit);
		
		model.addAttribute("vo", vo);
		
		LoginVO login=(LoginVO)session.getAttribute("login");
		model.addAttribute("login", login);
		
		return "faq/view";
	}
	
	@GetMapping("/writeform.do")
	public String writeform(Model model) {
		//faq 카테고리 고르기
		List<FaqCateVO> catelist=new ArrayList<>();
		catelist=service.getcate();
		
		model.addAttribute("catelist", catelist);
		
		return "faq/writeform";
	}
	@PostMapping("/write.do")
	public String write(FaqVO vo) {
		service.write(vo);
		return "redirect:list.do";
	}
	
	@GetMapping("/updateform.do")
	public String updateform(Model model, Long faqno) {
		//faq 카테고리 고르기
		List<FaqCateVO> catelist=new ArrayList<>();
		catelist=service.getcate();
		
		model.addAttribute("catelist", catelist);
		
		FaqVO vo=service.view(faqno, 0L);
		model.addAttribute("vo", vo);
		//카테고리 번호, 카테고리명도 전달함
		
		return "faq/updateform";
	}
	@PostMapping("/update.do")
	public String update(FaqVO vo) {
		service.update(vo);
		return "redirect:view.do?faqno="+vo.getFaqno()+"&hit=0";
	}
	
	@GetMapping("/delete.do")
	public String delete(Long faqno, Long cateno) {
		service.delete(faqno);
		return "redirect:faqlist.do?cateno="+cateno;
	}
	
	@GetMapping("/searchlist.do")
	public String mainsearchlist(FaqSearchVO searchvo, Model model, PageObject po) {
		List<FaqVO> list=new ArrayList<>();
		list=service.list(po, searchvo);
		
		model.addAttribute("searchvo", searchvo);
		model.addAttribute("list", list);
		model.addAttribute("po", po);
		
		return "faq/searchlist";
	}
}