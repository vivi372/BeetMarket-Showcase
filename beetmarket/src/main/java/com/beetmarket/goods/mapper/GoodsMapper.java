package com.beetmarket.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.beetmarket.goods.vo.GoodsImageVO;
import com.beetmarket.goods.vo.GoodsInfoVO;
import com.beetmarket.goods.vo.GoodsOptionVO;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface GoodsMapper {

	// 상품 리스트
	public List<GoodsVO> list(@Param("pageObject") PageObject pageObject, @Param("searchVO") GoodsSearchVO searchVO);

	// 판매자 상품 리스트
	public List<GoodsVO> sellList(@Param("pageObject") PageObject pageObject, @Param("searchVO") GoodsSearchVO searchVO,
			@Param("sell_no") Long sell_no);

	// 관리자 상품 리스트
	public List<GoodsVO> adminList(@Param("pageObject") PageObject pageObject,
			@Param("searchVO") GoodsSearchVO searchVO);

	// 좋아요한 상품 리스트
	public List<GoodsVO> likeList(@Param("id") String id);

	// 상품 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(@Param("searchVO") GoodsSearchVO searchVO);

	// 보기 조회수 1 증가
	public Integer increase(@Param("goodsNo") Long goodsNo, @Param("increase") Long increase);

	// 보기
	public GoodsVO view(@Param("goodsNo") Long goodsNo);

	public List<GoodsImageVO> imageList(@Param("goodsNo") Long goodsNo);

	public List<GoodsOptionVO> optionList(@Param("goodsNo") Long goodsNo);

	public List<GoodsInfoVO> infoList(@Param("goodsNo") Long goodsNo);

	// ---- 상품 등록 - transactional 처리한다.
	// 1. 상품 정보 등록
	public Integer write(GoodsVO vo);

	// 2. 상품 추가 이미지 등록
	public Integer writeImage(List<GoodsImageVO> goodsImageList);

	// 3. 상품 옵션 등록
	public Integer writeOption(List<GoodsOptionVO> goodsOptionList);

	// 4. 상품 정보 등록
	public Integer writeInfo(List<GoodsInfoVO> goodsInfoList);

	// ---- 상품 수정
	// 1. 상품 수정
	public Integer update(GoodsVO vo);

	// 2. 상품 옵션 수정
	public Integer optionUpdate(@Param("goodsOptNo") Long goodsOptNo);

	// 3. 상품 정보 수정
	public Integer infoUpdate(@Param("goodsInfoNo") Long goodsInfoNo);

	// 4. 상품 상태 수정
	public Integer statusUpdate(@Param("goodsNo") String goodsNo, @Param("goodsStatusNo") String goodsStatusNo);

	// 5. 상품 상태 수정 - 판매중지신청
	public Integer delete(@Param("goodsNo") Long goodsNo);

	// 좋아요
	// 1. 좋아요 기능
	public Integer like(@Param("goodsNo") Long goodsNo, @Param("id") String id);

	public String likeCheck(@Param("goodsNo") Long goodsNo, @Param("id") String id);

	// 2. 좋아요 해제
	public Integer unLike(@Param("goodsNo") Long goodsNo, @Param("id") String id);

}
