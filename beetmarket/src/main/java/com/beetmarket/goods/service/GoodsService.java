package com.beetmarket.goods.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.beetmarket.goods.vo.GoodsImageVO;
import com.beetmarket.goods.vo.GoodsInfoVO;
import com.beetmarket.goods.vo.GoodsOptionVO;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

public interface GoodsService {

	// 상품 리스트
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO searchVO);
	// 판매자 상품 리스트
	public List<GoodsVO> sellList(PageObject pageObject, GoodsSearchVO searchVO, Long sell_no);
	// 관리자 상품 리스트
	public List<GoodsVO> adminList(PageObject pageObject, GoodsSearchVO searchVO);
	// 좋아요 상품 리스트
	public List<GoodsVO> likeList(String id);

	// 상품 보기
	public GoodsVO view(Long goodsNo, int inc);

	public List<GoodsImageVO> viewImageList(Long goodsNo);

	public List<GoodsOptionVO> OptionList(Long goodsNo);

	public List<GoodsInfoVO> InfoList(Long goodsNo);

	// 상품 등록
	public Integer write(GoodsVO vo, List<GoodsImageVO> goodsImageList, List<GoodsOptionVO> goodsOptionList,
			List<GoodsInfoVO> goodsInfoList);
	
	// 상품 수정
	public Integer update(GoodsVO vo);
	// 상품 옵션 수정
	public Integer optionUpdate(Long goodsOptNo);
	// 상품 정보 수정
	public Integer infoUpdate(Long goodsInfoNo);
	// 상품 상태 수정
	public Integer statusUpdate(String goodsNo, String goodsStatusNo);
	
	
	// 상품 상태 수정 - 판매중지신청
	public Integer delete(Long goodsNo);
	
	// 좋아요 기능
	public Integer like(Long goodsNo, String id);
	// 좋아요 해제 기능
	public Integer unLike(Long goodsNo, String id);
	// 좋아요 체크
	public String likeCheck(Long goodsNo, String id);
	
	

}
