package com.beetmarket.review.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.review.mapper.ReviewMapper;
import com.beetmarket.review.service.ReviewService;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review")
@Log4j
public class ReviewController {

	@Autowired
	@Qualifier("ReviewServiceImpl")
	private ReviewService service;
	
	
    @Autowired
    private ReviewMapper mapper;
	
	
	String path = "/upload/review";
	
	
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request, Long goodsNo,Double scroll) throws Exception {
	    log.info("list.do");
	    
	    log.info("list.do");
	    // 페이지 객체 생성 및 초기화
	    PageObject pageObject = PageObject.getInstance(request);

	    // 리뷰 리스트 가져오기
	    List<ReviewVO> reviews = service.list(pageObject, goodsNo);

	    // 총 리뷰 개수 가져오기
	    Long totalReviewCount = service.getTotalRow(pageObject, goodsNo); 
	    
	    
	    // 평균 평점 계산
	    // 별점 / 리뷰개수 = 평점
	    Double averageRating = reviews.stream()
	      .mapToDouble(ReviewVO::getStarscore) // starscore를 double로 매핑
	      .average() // 별점의 총합을 구한 후, 전체 리뷰 개수로 나누어 평균을 계산
	      .orElse(0.0); // 리뷰가 없는 경우 0.0

	    // 모델에 리뷰 리스트, 총 리뷰 개수 및 평균 평점 추가
	    model.addAttribute("list", reviews);
	    model.addAttribute("totalReviewCount", totalReviewCount);  // 리뷰 총 개수
	    model.addAttribute("averageRating", averageRating);        // 평균 평점
	    log.info(pageObject);
	    model.addAttribute("pageObject", pageObject);
	    model.addAttribute("scroll", scroll);

	    return "review/list";
	}
	


	// 리뷰 등록 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "review/writeForm";
	}
	
	
	
	// 리뷰답변 등록 폼
	@GetMapping("/replywriteForm.do")
	public String replywriteForm() {
		log.info("replywriteForm.do");
		return "review/replywriteForm";
	}
	
	
	
	// 리뷰 등록처리
	@PostMapping("/write.do")
	public String write(ReviewVO vo, HttpServletRequest request, 
			RedirectAttributes rttr, MultipartFile reviewFile ,HttpSession session) throws Exception {
		String id = LoginUtil.getId(session);
		vo.setId(id);
		log.info("<<<----- 이미지 처리 ----------------->>");
		// 대표 이미지 처리
		vo.setReviewImage(FileUtil.upload(path, reviewFile, request));
		
	    Long goodsNo = service.getGoodsNoByOrderNo(vo.getOrderNo()); // orderNo로 goodsNo 조회하는 메서드 필요
	    vo.setGoodsNo(goodsNo); // goodsNo 설정
		
		log.info("write.do");
		log.info(vo);
		service.write(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("리뷰가 등록되었습니다");
		
		 return "redirect:/goods/view.do?goodsNo=" + vo.getGoodsNo() + "&inc=1";
	}
	
	
	
	// 리뷰답변 등록처리
	@PostMapping("/replywrite.do")
	public String replywrite(ReviewVO vo, HttpServletRequest request, 
			RedirectAttributes rttr, HttpSession session) throws Exception {
		log.info("<<<----- 이미지 처리 ----------------->>");
		// 대표 이미지 처리
		
		vo.setReplyId(LoginUtil.getId(session));
		
		log.info("replywrite.do");
		log.info(vo);
		service.replywrite(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("리뷰가 등록되었습니다");
		return "redirect:/goods/view.do?goodsNo=" + vo.getGoodsNo() + "&inc=1";
	}
	
	
	
	// 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Long reviewNo, Model model) {
		log.info("updateForm.do");
		return "review/updateForm";
	}
	
	
	
	// 리뷰 답변 수정 폼
	@GetMapping("/replyupdateForm.do")
	public String replyupdateForm(Long reviewNo, Model model) {
		log.info("replyupdateForm.do");
		return "review/replyupdateForm";
	}
	
	
	
	// 수정 처리
	@PostMapping("/update.do")
	public String update(ReviewVO vo, RedirectAttributes rttr,Double scroll) {
		log.info("update.do");
		log.info(vo);
		if(service.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("수정 되었습니다.");
		else
			rttr.addFlashAttribute("업데이트가 되지 않았습니다");
		
		return "redirect:/goods/view.do?goodsNo=" + vo.getGoodsNo() + "&inc=1&scroll="+scroll;
	}
	
	
	
	// 답변 수정 처리
	@PostMapping("/replyupdate.do")
	public String replyupdate(ReviewVO vo, RedirectAttributes rttr,Double scroll) {
		log.info("replyupdate.do");
		log.info(vo);
		if(service.replyupdate(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("수정 되었습니다.");
		else
			rttr.addFlashAttribute("업데이트가 되지 않았습니다");
		
		return "redirect:/goods/view.do?goodsNo=" + vo.getGoodsNo() + "&inc=1&scroll="+scroll;
	}
	
	
	
	//삭제
	@GetMapping("/delete.do")
	public String delete(ReviewVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		// 처리 결과에 대한 메시지 처리
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", "리뷰가 삭제가 되었습니다.");
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg", "삭제가 되지 않았습니다.");
			return "redirect:list.do?reviewNo=" + vo.getReviewNo();
		}
	}
	
	
	
	// 답변 삭제
	@GetMapping("/replydelete.do")
	public String replydelete(ReviewVO vo, RedirectAttributes rttr) {
		log.info("replydelete.do");
		// 처리 결과에 대한 메시지 처리
		if(service.replydelete(vo) == 1) {
			rttr.addFlashAttribute("msg", "답변이 삭제가 되었습니다.");
			return "redirect:/goods/view.do?goodsNo=" + vo.getGoodsNo() + "&inc=1";
		}
		else {
			rttr.addFlashAttribute("msg",
					"답변 삭제가 되지 않았습니다.");
			return "redirect:/goods/view.do?goodsNo=" + vo.getGoodsNo() + "&inc=1";
		}
	}
}