package com.beetmarket.pointshopbasket.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.beetmarket.pointshop.service.PointShopService;
import com.beetmarket.pointshop.vo.PointShopVO;
import com.beetmarket.pointshopbasket.service.PointShopBasketService;
import com.beetmarket.pointshopbasket.vo.PointShopBasketVO;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/pointShopBasket")
@Log4j
public class PointShopBasketController {
	
	@Autowired
	@Qualifier("PointShopServiceBasketImpl")
	private PointShopBasketService service;	
	
	@GetMapping(value = "/list.do",produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<PointShopBasketVO>> list(String id) {		
		
		return new ResponseEntity<>(service.list(id), HttpStatus.OK);
	}
	
	@GetMapping(value = "/write.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> write(PointShopBasketVO vo) {
		log.info(vo);				
		
		service.write(vo);
		if(vo.getPointShopBasketNo() != 0)
			return new ResponseEntity<String>("해당 상품 장바구니의 수량이 1 증가 되었습니다.", HttpStatus.OK);
		else
			return new ResponseEntity<String>("해당 상품이 장바구니에 등록되었습니다.", HttpStatus.OK);
	}
	
	@PostMapping(value = "/update.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> update(PointShopBasketVO vo) {
		log.info(vo);				
		
		service.update(vo);
		
		return new ResponseEntity<String>("장바구니의 수량이 수정되었습니다.", HttpStatus.OK);
	}
	


	@GetMapping(value = "/delete.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(Long pointShopBasketNo) {
		log.info(pointShopBasketNo);				
		
		
		service.delete(new Long[] {pointShopBasketNo});
		
		return new ResponseEntity<String>("장바구니가 삭제되었습니다.", HttpStatus.OK);
	}

	
	
}
