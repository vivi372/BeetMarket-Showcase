package com.beetmarket.dlvy.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;



import com.beetmarket.dlvy.service.DlvyService;
import com.beetmarket.dlvy.vo.DlvyVO;
import com.webjjang.util.login.LoginUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/dlvy")
@Log4j
public class DlvyController {
	
	@Autowired
	@Qualifier("DlvyServiceImpl")
	DlvyService service;
	
	String id = null;
	
	@GetMapping("/list.do")
	public String list(Model model,HttpSession session) throws Exception {
		id = LoginUtil.getId(session);
		
		//데이터 담기
		model.addAttribute("list", service.list(id));
		
		
		return "dlvy/list";
	}
	
	@GetMapping("/writeForm")
	public String writeForm() {		
		
		return "dlvy/writeForm";
	}
	
	@PostMapping("/write")
	public String write(DlvyVO vo,HttpSession session) {		
		vo.setId(LoginUtil.getId(session));
		
		service.write(vo);
		
		return "redirect:/dlvy/list.do";
	}
	
	@GetMapping("/updateForm")
	public String updateForm(Long dlvyAddrNo,Model model) {		
		
		model.addAttribute("vo", service.updateForm(dlvyAddrNo));
		
		return "dlvy/updateForm";
	}
	
	@PostMapping("/update")
	public String update(DlvyVO vo,HttpSession session) {		
		
		vo.setId(LoginUtil.getId(session));
		service.update(vo);
		
		return "redirect:/dlvy/list.do";
	}
	
	@GetMapping("/delete")
	public String update(Long dlvyAddrNo,HttpSession session) {		
		
		DlvyVO vo = new DlvyVO();
		
		vo.setDlvyAddrNo(dlvyAddrNo);
		vo.setId(LoginUtil.getId(session));
		
		service.delete(vo);
		
		return "redirect:/dlvy/list.do";
	}

}
