package com.beetmarket.order.controller;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.basket.service.BasketService;
import com.beetmarket.basket.vo.BasketVO;
import com.beetmarket.order.service.OrderService;

import com.beetmarket.order.vo.OrderOptVO;
import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order")
@Log4j
public class OrderController {
	
	@Autowired
	@Qualifier("OrderServiceImpl")
	OrderService service;
	
	@Autowired
	@Qualifier("BasketServiceImpl")
	BasketService basketService;
	
	
	
	String id = null;
	
	@GetMapping("/list.do")
	public String list(SearchVO searchVO,HttpServletRequest request,Model model,HttpSession session) throws Exception {
		
		id = LoginUtil.getId(session);
		
		//날짜 검색에 아무것도 입력 안 됐을때 처리
		if(searchVO.getMaxDate() == null && searchVO.getMinDate() == null) {
			LocalDate today = LocalDate.now();			
			LocalDate minDate = today.minusYears(5);
			
			searchVO.setMaxDate(today);
			searchVO.setMinDate(minDate);
		}
		
		log.info(searchVO);
		
		//페이지와 검색을 위해 페이지 오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);
		//아이디를 페이지 오브젝트에 넣기
		pageObject.setAccepter(id);
		//DB에서 데이터 가져와 담기
		List<OrderVO> list = service.orderList(pageObject,searchVO);
		
		
		//데이터 담기
		model.addAttribute("list", list);		
		model.addAttribute("pageObject", pageObject);
		model.addAttribute("searchVO", searchVO);
		
		return "order/list";
	}
	
	@GetMapping("/adminList.do")
	public String adminList(HttpServletRequest request,Model model,SearchVO searchVO,HttpSession session) throws Exception {
				
		//날짜 검색에 아무것도 입력 안 됐을때 처리
		if(searchVO.getMaxDate() == null && searchVO.getMinDate() == null) {
			LocalDate today = LocalDate.now();			
			LocalDate minDate = today.minusYears(5);
			
			searchVO.setMaxDate(today);
			searchVO.setMinDate(minDate);
		}
		//'/'를 통해 상세 검색을 했을때 처리
		if(searchVO.getSearchKey() != null && searchVO.getSearchKey().length()==2 && searchVO.getSearchWord() != null && searchVO.getSearchWord().indexOf('/')>0) {
			String word = searchVO.getSearchWord();
			searchVO.setName(word.substring(0,word.indexOf('/')));			
			searchVO.setGoodsName(word.substring(word.indexOf('/')+1));
		}
		
		log.info(searchVO);
		
		
		String sellerId = null;
		//sell_no가 null이 아니면 판매자이기때문에 id를 가져온다. 
		if(LoginUtil.getSell_no(session) != null) {
			sellerId = LoginUtil.getId(session);
		}
		
		//페이지와 검색을 위해 페이지 오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);	
		
		Map<String , List<OrderVO>> map = service.adminList(pageObject,sellerId,searchVO);
		
		//데이터 담기
		model.addAttribute("list", map.get("list"));	
		if(sellerId != null)
			model.addAttribute("goodsList", map.get("goodsList"));		
		model.addAttribute("pageObject", pageObject);
		model.addAttribute("searchVO", searchVO);
		
		
		return "order/adminList";
	}
	
	@GetMapping("/view.do")
	public String view(@ModelAttribute SearchVO searchVO,Long orderNo,HttpServletRequest request,Model model) throws Exception {
				
		
		//페이지 데이터를 위해 페이지 오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);	
		
		//데이터 담기
		model.addAttribute("vo", service.view(orderNo));		
		model.addAttribute("pageObject", pageObject);		
		
		return "order/view";
	}
	
	@PostMapping("/writeForm.do")
	public String writeForm(Long[] goodsNo, Long[] optNo,Long[] amount,Long[] basketNo,Model model,HttpSession session) {
		log.info("goodsNo : "+ Arrays.toString(goodsNo));
		log.info("optNo : "+Arrays.toString(optNo));
		log.info("amount : "+Arrays.toString(amount));
		
		id=LoginUtil.getId(session);
		
		Map<String, Object> map = service.writeFrom(goodsNo, optNo);
		
		@SuppressWarnings("unchecked")
		List<OrderOptVO> optList = (List<OrderOptVO>) map.get("optList");
		

		
		for(int i=0;i<optNo.length;i++) {
			OrderOptVO optVO = null;
			
			//optNo가 0보다 크면 옵션이 있는 상품
			if(optNo[i] > 0) {				
				
				optVO = optList.get(i);					
				
				optVO.setAmount(amount[i]);
			} else {
				optVO = new OrderOptVO();
				//optNo가 0보다 작으면 옵션이 없는 상품
				//새로 추가한다.
				optVO.setAmount(amount[i]);
				optVO.setGoodsNo(goodsNo[i]);
				optList.add(i,optVO);
			}
		}
		
		
		log.info(map.get("goodsList"));
		log.info(optList);
		
		model.addAttribute("goodsList", map.get("goodsList"));
		model.addAttribute("optList", optList);
		model.addAttribute("basketNo", basketNo);
		//쿠폰 정보 가져오기
		model.addAttribute("couponList", service.getCouponList(id));
		//멤버쉽 적립율 가져오기
		model.addAttribute("sale_rate", service.getSale_rate(id));
		

		
		return "order/writeForm";
	}
	
	@GetMapping("/write.do")
	public String write(String query,String payQuery,String orderId,String amount,String paymentKey,RedirectAttributes rttr,HttpSession session) throws Exception  {
		JSONObject toss = null;
		//payQuery는 카드 간편 결제일때만 들어온다.
		//카드 간편 결제이면 토스 데이터를 안 가져온다.
		if(payQuery == null) {
			toss = tossPayment(orderId,amount,paymentKey);
			log.info(toss);					
		}
		
		id=LoginUtil.getId(session);
		
		JSONParser parser = new JSONParser();
		JSONObject queryObj = (JSONObject) parser.parse(query);
		
		log.info(queryObj);
		
		List<OrderVO> list = null;
		JSONArray jsonArray = (JSONArray) queryObj.get("items");		
		for(int i=0;i<jsonArray.size();i++ ) {
			if(list == null) list = new ArrayList<OrderVO>();
			OrderVO vo = new OrderVO();
			JSONObject json = (JSONObject) jsonArray.get(i);
			
			vo.setDlvyAddrNo(Long.parseLong((String) queryObj.get("dlvyAddrNo")));
			vo.setGoodsId(Long.parseLong((String) queryObj.get("goodsId")));
					
			
			String dlvyMemo = (String) json.get("dlvyMemo");
			if(dlvyMemo.equals("")) dlvyMemo = null;
			vo.setDlvyMemo(dlvyMemo);
			vo.setOrderPrice(Long.parseLong((String) json.get("orderPrice")));
			vo.setDlvyCharge(Long.parseLong((String) json.get("dlvyCharge")));
			vo.setGoodsNo(Long.parseLong((String) json.get("goodsNo")));
			try {
				vo.setOptNo(Long.parseLong((String) json.get("optNo")));				
			} catch (Exception e) {
				vo.setOptNo(null);
			}
			vo.setAmount(Long.parseLong((String) json.get("amount")));
			if(payQuery == null) {
				vo.setPayWay((String) toss.get("method"));
				try {
					vo.setPayDetail((String) ((JSONObject)toss.get("card")).get("number"));					
				} catch (Exception e) {
					vo.setPayDetail("");
				}
				vo.setPaymentKey(paymentKey);
			} else {
				vo.setPayWay("카드간편결제");
				vo.setPayDetail(payQuery);
			}
			
			vo.setId(id);
			
			list.add(vo);
		}
		
		log.info(list);		
		
		int result = service.write(list);
		
		JSONArray basketNos = (JSONArray) queryObj.get("basketNo");
		List<BasketVO> basketNoList = null;
		if(basketNos != null && basketNos.size()>0) {
			basketNoList = new ArrayList<BasketVO>();
			for(int i=0;i<basketNos.size();i++) {
				BasketVO vo = new BasketVO();
				vo.setBasketNo(Long.parseLong((String) basketNos.get(i)));
				basketNoList.add(vo);
			}			
			basketService.basketDelete(basketNoList);
		}
		
		
		rttr.addFlashAttribute("msg", "주문 "+result+"건이 정상적으로 결제되었습니다.");
		
		return "redirect:/order/list.do";
	}
	
	@PostMapping("/dlvyUpdate.do")
	public String dlvyUpdate(OrderVO vo,SearchVO searchVO,HttpServletRequest request,RedirectAttributes rttr) throws Exception {
		
		//배송지를 변경
		service.dlvyUpdate(vo);
		
		rttr.addFlashAttribute("msg", vo.getOrderNo()+"번 주문의 배송지가 정상적으로 변경 되었습니다.");
		return "redirect:/order/view.do?orderNo="+vo.getOrderNo()+"&"+PageObject.getInstance(request).getPageQuery()+"&"+searchVO.getQuery();
	}
	
	@PostMapping("/stateUpdate.do")
	public String stateUpdate(OrderVO vo,Long[] orderNos,SearchVO searchVO,String before,Double scroll,HttpServletRequest request,RedirectAttributes rttr,HttpSession session) throws Exception {
		id = LoginUtil.getId(session);
		
		log.info(before);
		
		//주문 상태를 변경
		service.stateUpdate(vo,orderNos,id);
		
		rttr.addFlashAttribute("msg", "주문의 상태가 정상적으로 변경 되었습니다.");
		return "redirect:/order/"+before+"&scroll="+scroll;
	}
	
	@GetMapping("/delete.do")
	public String stateUpdate(Long orderNo,SearchVO searchVO,Double scroll,HttpServletRequest request,RedirectAttributes rttr) throws Exception {
		
		//주문 상태를 변경
		service.delete(orderNo);
		
		rttr.addFlashAttribute("msg", orderNo+"번 주문이 정상적으로 삭제 되었습니다.");
		return "redirect:/order/adminList.do?"+PageObject.getInstance(request).getPageQuery()+"&"+searchVO.getFullQuery()+"&scroll="+scroll;
	}
	
	
	@SuppressWarnings("unchecked")
	private JSONObject tossPayment(String orderId,String amount,String paymentKey) throws Exception {
		
		JSONParser parser = new JSONParser();
		
		JSONObject json = new JSONObject();
		json.put("orderId",orderId);
		json.put("amount",amount);
		json.put("paymentKey",paymentKey);
		
		// 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);
        
        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        
        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(json.toString().getBytes("UTF-8"));

        int code = connection.getResponseCode();
        boolean isSuccess = code == 200;
        

        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

        // 결제 성공 및 실패 비즈니스 로직을 구현하세요.
        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
        JSONObject toss = (JSONObject) parser.parse(reader);
        responseStream.close();
        
        
		return toss;
	}

}
