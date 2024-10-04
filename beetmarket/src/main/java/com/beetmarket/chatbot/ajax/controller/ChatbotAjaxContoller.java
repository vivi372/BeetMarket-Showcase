package com.beetmarket.chatbot.ajax.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.chatbot.service.ChatbotService;
import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.event.service.EventService;
import com.beetmarket.event.vo.EventVO;
import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.beetmarket.order.service.OrderService;
import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/chatajax")
public class ChatbotAjaxContoller {
	@Autowired
	@Qualifier("chatbotserviceimpl")
	public ChatbotService service;
	
	@Autowired
	@Qualifier("OrderServiceImpl")
	private OrderService orderservice;
	
	@Autowired
	@Qualifier("eventServiceImpl")
	private EventService eventservice;
	
	@GetMapping("/roomlist")
	public String roomlist(HttpServletRequest request, Model model) { //채팅방 목록
		HttpSession session=request.getSession();
		LoginVO loginvo=(LoginVO)session.getAttribute("login");
		String id=loginvo.getId();
		
		List<ChatbotVO> roomlist=new ArrayList<>();
		roomlist=service.list(id);
		
		model.addAttribute("roomlist", roomlist);
		model.addAttribute("id", id);
		return "chatbot/roomlistajax";
	}
	
	@GetMapping("/history.do")
	public String history(HttpServletRequest request, Long roomno, String partner, Model model) {
		log.info("ajax 진입");
		List<ChatbotVO> list=new ArrayList<>();
		
		HttpSession session=request.getSession();
		LoginVO loginvo=(LoginVO)session.getAttribute("login");
		String id=loginvo.getId();
		
		list=service.history(roomno, id);
		
		model.addAttribute("partner", partner);
		model.addAttribute("histroylist", list);
		model.addAttribute("id", id);
		
		return "chatbot/historyajax";
	}
	
	@PostMapping("/chating.do")
	public String chating(ChatbotVO vo) {
		service.chating(vo);
		
		return "redirect:history.do?roomno="+vo.getRoomno()+"&partner="+vo.getPartner();
	}
	
	@GetMapping("/delete.do")
	public String delete(Long chatno, Long roomno) {
		service.deletechating(chatno);
		return "redirect:history.do?roomno="+roomno;
	}
	
	@GetMapping("/searchid.do")
	public String searchid(String idinfo, Model model) {
		log.info("검색한 아이디: "+idinfo);
		MemberVO membervo=service.searchid(idinfo);
		
		if(membervo==null) model.addAttribute("isexist", false);
		else {
			model.addAttribute("isexist", true);
			model.addAttribute("membervo", membervo);
		}
		return "chatbot/idresult";
	}
	
	@GetMapping("/starthelp.do")
	public String starthelp() {
		
		return "chatbot/starthelpajax";
	}
	
	@GetMapping(value="getorderlist", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> getorderlist(SearchVO searchVO,HttpServletRequest request,HttpServletResponse response) throws Exception {
		// 날짜 검색에 아무것도 입력 안 됐을때 처리
		if (searchVO.getMaxDate() == null && searchVO.getMinDate() == null) {
			LocalDate today = LocalDate.now();
			LocalDate minDate = today.minusYears(5);

			searchVO.setMaxDate(today);
			searchVO.setMinDate(minDate);
		}

		log.info(searchVO);

		HttpSession session=request.getSession();
		LoginVO login=(LoginVO)session.getAttribute("login");
		String id=login.getId();
		
		//페이지와 검색을 위해 페이지 오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);
		//아이디를 페이지 오브젝트에 넣기
		pageObject.setAccepter(id);
		//DB에서 데이터 가져와 담기
		List<OrderVO> list = orderservice.orderList(pageObject,searchVO);
		
		
		// JSON으로 변환
	    Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("list", list);
	    responseMap.put("pageObject", pageObject);
	    responseMap.put("searchVO", searchVO);

	    return new ResponseEntity<>(responseMap, HttpStatus.OK);
	}
	
	@GetMapping("/dlvyUpdate.do")
	public ResponseEntity<Integer> dlvyUpdate(OrderVO vo,SearchVO searchVO,HttpServletRequest request,RedirectAttributes rttr) throws Exception {
		
		return new ResponseEntity<>(orderservice.dlvyUpdate(vo), HttpStatus.OK);
	}	
	
	@GetMapping("/stateUpdate.do")
	public ResponseEntity<Integer> stateUpdate(OrderVO vo,Long[] orderNos,String orderStateInput,SearchVO searchVO,String before,Double scroll,HttpServletRequest request,RedirectAttributes rttr) throws Exception {
		
		vo.setOrderState(orderStateInput);
		//주문 상태를 변경
		
		HttpSession session=request.getSession();
		LoginVO login=(LoginVO)session.getAttribute("login");
		String id=login.getId();
		
		//배송지를 변경
		return new ResponseEntity<>(orderservice.stateUpdate(vo,orderNos,id), HttpStatus.OK);
	}
	
	@GetMapping(value="/eventlist.do", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> eventlist(Long perPageNum, HttpServletRequest request) throws Exception {
		PageObject pageObject = PageObject.getInstance(request);
		List<EventVO> list = eventservice.list(pageObject);
		
		// JSON으로 변환
	    Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("list", list);
	    responseMap.put("pageObject", pageObject);
		
		return new ResponseEntity<>(responseMap, HttpStatus.OK);
	}
}