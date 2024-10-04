package com.beetmarket.reviewlike.mapper;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.reviewlike.vo.ReviewLikeVO;

public interface ReviewLikeMapper {

    // 좋아요 추가
    public void addLike(ReviewLikeVO likeVO);

    
    
    // 특정 리뷰의 좋아요 개수를 조회하는 메서드
    public int countLikes(@Param("reviewNo") Long reviewNo);

    
    
    // 특정 리뷰의 좋아요를 삭제하는 메서드
    public void removeLike(ReviewLikeVO likeVO);

    
    
    // 특정 사용자가 해당 리뷰에 좋아요를 눌렀는지 확인하는 메서드
    public int userHasLiked(ReviewLikeVO likeVO);  // 반환 타입을 boolean에서 int로 변경
}
