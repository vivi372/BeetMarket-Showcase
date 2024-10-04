package com.beetmarket.goodsqna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.goodsqna.service.Goods_QnaService;
import com.beetmarket.goodsqna.vo.Goods_QnaVO;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/goods_qna")
@Log4j
public class Goods_QnaController {

	@Autowired
	@Qualifier("Goods_QnaServiceImpl")
	private Goods_QnaService service;
	
	
	// qna리스트
	// 1. list - get
	@GetMapping("/list.do")
	public String
		list(PageObject pageObject, Long goodsNo, Model model) {
		log.info("list - page : " + pageObject.getPage() + ", goodsNO : " + goodsNo);
		// DB에서 데이터를 가져와서 넘겨 준다.
		List<Goods_QnaVO> list = service.list(pageObject, goodsNo);
		// list와 PageObject를 넘겨야 한다.
		model.addAttribute("list", list );
		model.addAttribute("pageObject", pageObject );
		
		return "goodsqna/list";
	}
	
	
	
	//질문등록
	@PostMapping("/write.do")
    public @ResponseBody Map<String, Object> write(@RequestBody Goods_QnaVO vo, HttpSession session) {
        
		vo.setId(LoginUtil.getId(session));
		
		// 등록 처리
		
        service.write(vo);
        log.info(vo);
        
        // JSON 응답 생성
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "Q&A successfully added.");
        response.put("goodsNo", vo.getGoodsNo());
        
        return response;
    }
	
	
	
	//질문수정
	// 3. update - post
	@PostMapping(value = "/update.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> update(@RequestBody Goods_QnaVO vo, HttpSession session) {
		
		
		vo.setId(LoginUtil.getId(session));
		
		// 수정 처리
		Integer result = service.update(vo);
		
		
		if(result == 1)
			return new ResponseEntity<>("수정이 되었네요", HttpStatus.OK);
		else
			return new ResponseEntity<>("수정이 실패했네요", HttpStatus.BAD_REQUEST);
	}	
	
	
	
	//답변 등록
	// 5. answeranupdate - post
	@PostMapping(value = "/answeranupdate.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> answeranupdate(@RequestBody Goods_QnaVO vo, HttpSession session) {
		
		
		log.info(vo);
		
		vo.setId(LoginUtil.getId(session));
		
		// 수정 처리
		Integer result = service.answeranupdate(vo);
		
		
		if(result == 1)
			return new ResponseEntity<>("답변등록 되었습니다", HttpStatus.OK);
		else
			return new ResponseEntity<>("답변등록이 실패했네요", HttpStatus.BAD_REQUEST);
	}	
	
	
	
	// 답변삭제
	// 5. answerdelete - post
	@PostMapping(value = "/answerdelete.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> answerdelete(@RequestBody Goods_QnaVO vo, HttpSession session) {
		
		
		log.info(vo);
		
		vo.setId(LoginUtil.getId(session));
		
		// 수정 처리
		Integer result = service.answerdelete(vo);
		
		
		if(result == 1)
			return new ResponseEntity<>("답변이 삭제 되었습니다", HttpStatus.OK);
		else
			return new ResponseEntity<>("답변 삭제 실패했습니다.", HttpStatus.BAD_REQUEST);
	}	
	
	
	
	//질문삭제
	// 6. delete - get
	@PostMapping(value = "/delete.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> delete(Goods_QnaVO vo, HttpSession session, RedirectAttributes rttr) {
		
		
		Integer result = service.delete(vo);
		
		if(result == 1)
			return new ResponseEntity<String>("삭제되었습니다.",  HttpStatus.OK);
		else
			return new ResponseEntity<String>("삭제되었습니다",  HttpStatus.BAD_REQUEST);
	}
}