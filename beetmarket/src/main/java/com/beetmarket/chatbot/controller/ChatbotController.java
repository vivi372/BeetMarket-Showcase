package com.beetmarket.chatbot.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

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

import com.beetmarket.chatbot.service.ChatbotService;
import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.faq.vo.FaqSearchVO;
import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.order.service.OrderService;
import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/chatbot")
public class ChatbotController {
	@Autowired
	@Qualifier("chatbotserviceimpl")
	private ChatbotService service;
	
	@Autowired
	@Qualifier("OrderServiceImpl")
	private OrderService orderservice;
	
	@GetMapping("/roomlist")
	public String roomlist(HttpServletRequest request, Model model) { //채팅방 목록
//		HttpSession session=request.getSession();
//		LoginVO loginvo=(LoginVO)session.getAttribute("login");
//		String id=loginvo.getId();
//		
//		List<ChatbotVO> roomlist=new ArrayList<>();
//		roomlist=service.list(id);
//		
//		model.addAttribute("roomlist", roomlist);
//		model.addAttribute("id", id);
		return "chatbot/roomlist";
	}
	
	@GetMapping("/history")
	public String history(HttpServletRequest request, Model model) { //채팅창
		HttpSession session=request.getSession();
		LoginVO loginvo=(LoginVO)session.getAttribute("login");
		String id=loginvo.getId();
		
//		List<ChatbotVO> historylist=new ArrayList<>();
//		historylist=service.history(roomno, id);
		
//		ChatbotVO vo=historylist.get(0);
//		if(!vo.getSender().equals(id)) model.addAttribute("partner", vo.getSender());
//		if(!vo.getAccepter().equals(id)) model.addAttribute("partner", vo.getAccepter());
		
		
		//model.addAttribute("historylist", historylist);
		model.addAttribute("id", id);
		
		return "chatbot/history";
	}
	

	@GetMapping("/addroom")
	public String addroom(ChatbotVO vo, HttpServletRequest request) {
		HttpSession session=request.getSession();
		LoginVO login=(LoginVO)session.getAttribute("login");
		String sender=login.getId();
		
		vo.setSender(sender);
		
		Long roomno=service.createroom(vo);
		
		return "redirect:history.do?roomno="+roomno+"&partner="+vo.getPartner();
	}
	
	@GetMapping("/roomdelete")
	public String roomdelete(HttpServletRequest request, Long roomno) {
		HttpSession session=request.getSession();
		LoginVO login=(LoginVO)session.getAttribute("login");
		String id=login.getId();
		
		service.deleteroom(roomno, id);
		
		return "redirect:roomlist.do";
	}
	
	@GetMapping("/starthelp")
	public String starthelp(HttpServletRequest request, Model model) {
		HttpSession session=request.getSession();
		LoginVO login=(LoginVO)session.getAttribute("login");
		String id=login.getId();
		
		model.addAttribute("id", id);
		
		return "chatbot/starthelp";
	}
}