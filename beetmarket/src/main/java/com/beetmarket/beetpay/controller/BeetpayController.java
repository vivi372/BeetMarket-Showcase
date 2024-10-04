package com.beetmarket.beetpay.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beetmarket.beetpay.service.BeetpayService;
import com.beetmarket.beetpay.vo.BeetpayVO;
import com.webjjang.util.login.LoginUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/beetpay")
@Log4j
public class BeetpayController {
	
	@Autowired
	@Qualifier("BeetpayServiceImpl")
	BeetpayService service;
	
	String id=null;
	
	@GetMapping("/list.do")
	public String list(Model model,HttpSession session) {
		model.addAttribute("list", service.list(LoginUtil.getId(session)));
		
		return "beetpay/list";
	}
	
	@PostMapping(value = "/write.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> write(BeetpayVO vo,HttpSession session) {
		vo.setId(LoginUtil.getId(session));
		try {
			service.write(vo);
			if(vo.getPayPassword()!=null)
				service.payPasswordWrite(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("카드 등록이 실패했습니다. 다시 시도해주세요",HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<String>("카드가 성공적으로 등록되었습니다.",HttpStatus.OK);
	}
	
	@PostMapping(value = "/delete.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> delete(Long beetpayNo) {
		
		try {
			service.delete(beetpayNo);
		} catch (Exception e) {
			return new ResponseEntity<String>("카드 삭제가 실패했습니다. 다시 시도해주세요",HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<String>("카드가 성공적으로 삭제되었습니다.",HttpStatus.OK);
	}
	
	@PostMapping(value = "/passwordCheck.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> passwordCheck(Integer payPassword) {
		
		
		if(service.passwordCheck(payPassword)!=null) {
			return new ResponseEntity<String>("비밀번호가 일치합니다.",HttpStatus.OK);			
		} else {
			return new ResponseEntity<String>("비트페이 비밀번호가 일치하지 않습니다. 다시 입력해주세요",HttpStatus.BAD_REQUEST);			
		}
		
		
	}
	
}
