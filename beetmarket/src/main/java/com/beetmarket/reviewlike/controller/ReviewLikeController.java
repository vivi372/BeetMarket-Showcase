package com.beetmarket.reviewlike.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beetmarket.reviewlike.service.ReviewLikeService;
import com.beetmarket.reviewlike.vo.ReviewLikeVO;

import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/reviewlike")
@Log4j
public class ReviewLikeController {

    @Autowired
    @Qualifier("ReviewLikeServiceImpl")
    private ReviewLikeService reviewLikeService;

    /**
     * 특정 리뷰의 좋아요 상태를 확인하고, 좋아요 개수를 반환하는 메서드.
     * @param reviewNo 리뷰 번호
     * @param model 모델 객체
     * @return 좋아요 리스트 페이지
     */
    @GetMapping("/list")
    public String list(@RequestParam Long reviewNo, Model model) {
        int likeCount = reviewLikeService.getLikeCount(reviewNo);
        model.addAttribute("likeCount", likeCount);
        return "review/list.do"; // 좋아요 리스트를 보여줄 뷰 페이지
    }

    /**
     * 특정 리뷰에 좋아요를 추가하는 메서드.
     * @param reviewNo 리뷰 번호
     * @param id 사용자 ID
     * @return 리뷰 목록 페이지로 리다이렉트
     */
    @PostMapping("/write")
    public @ResponseBody Integer write(@RequestBody ReviewLikeVO likeVO) {
    	log.info(likeVO);

        // 이미 좋아요를 눌렀는지 확인 후 추가
        if (!reviewLikeService.userHasLiked(likeVO)) {
            reviewLikeService.addLike(likeVO);
        }
        
        //좋아요 갯수 가져오기
        Integer cnt = 1;

        return cnt; // 리뷰 리스트 페이지로 리다이렉트
    }

    /**
     * 특정 리뷰의 좋아요를 삭제하는 메서드.
     * @param reviewNo 리뷰 번호
     * @param id 사용자 ID
     * @return 리뷰 목록 페이지로 리다이렉트
     */
    @PostMapping("/delete")
    public String delete(@RequestParam Long reviewNo, @RequestParam String id) {
        ReviewLikeVO likeVO = new ReviewLikeVO();
        likeVO.setReviewNo(reviewNo);
        likeVO.setId(id);

        // 이미 좋아요가 눌렸는지 확인 후 삭제
        if (reviewLikeService.userHasLiked(likeVO)) {
            reviewLikeService.removeLike(likeVO);
        }

        return "redirect:/review/list.do"; // 리뷰 리스트 페이지로 리다이렉트
    }
    
    
    
    @PostMapping("/toggle")
    public @ResponseBody Integer toggleLike(@RequestBody ReviewLikeVO likeVO) {
        log.info("토글 좋아요 요청: " + likeVO);
        
        // 사용자의 좋아요 상태를 확인
        boolean hasLiked = reviewLikeService.userHasLiked(likeVO);
        
        if (hasLiked) {
            // 좋아요를 누른 상태면 좋아요 삭제
            reviewLikeService.removeLike(likeVO);
        } else {
            // 좋아요를 누르지 않은 상태면 좋아요 추가
            reviewLikeService.addLike(likeVO);
        }

        // 변경된 좋아요 개수 반환
        int likeCount = reviewLikeService.getLikeCount(likeVO.getReviewNo());
        return likeCount;
    }
}
