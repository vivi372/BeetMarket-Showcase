package com.beetmarket.reviewlike.service;

import com.beetmarket.reviewlike.vo.ReviewLikeVO;

public interface ReviewLikeService {

	
    /**
     * 특정 리뷰의 좋아요 개수를 조회하는 메서드.
     * @param reviewNo 리뷰 번호
     * @return 좋아요 개수
     */
    int getLikeCount(Long reviewNo);

    /**
     * 특정 리뷰에 좋아요를 추가하는 메서드.
     * @param likeVO 좋아요 정보
     */
    void addLike(ReviewLikeVO likeVO);

    /**
     * 특정 리뷰의 좋아요를 삭제하는 메서드.
     * @param likeVO 좋아요 정보
     */
    void removeLike(ReviewLikeVO likeVO);

    /**
     * 특정 사용자가 해당 리뷰에 좋아요를 눌렀는지 확인하는 메서드.
     * @param likeVO 좋아요 정보
     * @return 사용자가 좋아요를 눌렀는지 여부
     */
    boolean userHasLiked(ReviewLikeVO likeVO);

    
}