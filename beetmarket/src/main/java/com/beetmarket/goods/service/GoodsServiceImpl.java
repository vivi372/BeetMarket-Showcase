package com.beetmarket.goods.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.beetmarket.category.vo.CategoryVO;
import com.beetmarket.goods.mapper.GoodsMapper;
import com.beetmarket.goods.vo.GoodsImageVO;
import com.beetmarket.goods.vo.GoodsInfoVO;
import com.beetmarket.goods.vo.GoodsOptionVO;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService {

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private GoodsMapper mapper;

	// 상품 리스트
	@Override
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO searchVO) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(searchVO));
		return mapper.list(pageObject, searchVO);
	}
	// 판매자 상품 리스트
	@Override
	public List<GoodsVO> sellList(PageObject pageObject, GoodsSearchVO searchVO, Long sell_no) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(searchVO));
		return mapper.sellList(pageObject, searchVO, sell_no);
	}
	// 관리자 상품 리스트
	@Override
	public List<GoodsVO> adminList(PageObject pageObject, GoodsSearchVO searchVO) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(searchVO));
		return mapper.adminList(pageObject, searchVO);
	}
	// 좋아요 상품 리스트
	@Override
	public List<GoodsVO> likeList(String id) {
		return mapper.likeList(id);
	}

	// 상품 글보기
	@Override
	@Transactional
	public GoodsVO view(Long goodsNo, int inc) {
		log.info("view() 실행");
		if (inc == 1)
			mapper.increase(goodsNo, 1L);
		
		return mapper.view(goodsNo);
	}

	public List<GoodsImageVO> viewImageList(Long goodsNo) {
		log.info("viewImageList() 실행");
		return mapper.imageList(goodsNo);
	}

	@Override
	public List<GoodsOptionVO> OptionList(Long goodsNo) {
		// TODO Auto-generated method stub
		return mapper.optionList(goodsNo);
	}

	@Override
	public List<GoodsInfoVO> InfoList(Long goodsNo) {
		// TODO Auto-generated method stub
		return mapper.infoList(goodsNo);
	}

	// 상품 글등록
	@Override
	// @Transactional - insert 2번이 성공을 해야 commit 한다. 한개라도 오류가 나면 rollback.
	// 상품, 가격, 이미지, 사이즈컬러, 옵션 -> 등록하다가 하나라고 오류가 나면 다 rollback 시킨다.
	@Transactional
	public Integer write(GoodsVO vo, List<GoodsImageVO> goodsImageList, List<GoodsOptionVO> goodsOptionList,
			List<GoodsInfoVO> goodsInfoList) {
		Integer result = null;
		// 상품 상세 정보 - vo : 필수 - 처리가 끝나면 goodsNo 세팅되서 넘어온다.
		mapper.write(vo);
		// 추가 이미지 - goodsImageList. null이 아닌 경우에만 DB에 추가
		if (goodsImageList != null && goodsImageList.size() > 0) {
			// goodsNo를 세팅해서 넘긴다.
			for (GoodsImageVO imageVO : goodsImageList)
				imageVO.setGoodsNo(vo.getGoodsNo());
			mapper.writeImage(goodsImageList);
		}
		// 옵션 - goodsOptionList. null이 아닌 경우에만 DB에 추가
		if (goodsOptionList != null && goodsOptionList.size() > 0) {
			// goodsNo를 세팅해서 넘긴다.
			for (GoodsOptionVO optionVO : goodsOptionList)
				optionVO.setGoodsNo(vo.getGoodsNo());
			mapper.writeOption(goodsOptionList);
		}
		// 정보 - goodsInfoList. null이 아닌 경우에만 DB에 추가
		if (goodsInfoList != null && goodsInfoList.size() > 0) {
			// goodsNo를 세팅해서 넘긴다.
			for (GoodsInfoVO infoVO : goodsInfoList)
				infoVO.setGoodsNo(vo.getGoodsNo());
			mapper.writeOption(goodsOptionList);
		}
		return result;
	}

	@Override
	public Integer update(GoodsVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer optionUpdate(Long goodsOptNo) {
		// TODO Auto-generated method stub
		return mapper.optionUpdate(goodsOptNo);
	}

	@Override
	public Integer infoUpdate(Long goodsInfoNo) {
		// TODO Auto-generated method stub
		return mapper.infoUpdate(goodsInfoNo);
	}

	@Override
	public Integer statusUpdate(String goodsNo, String goodsStatusNo) {
		// TODO Auto-generated method stub
		return mapper.statusUpdate(goodsNo, goodsStatusNo);
	}
	
	@Override
	public Integer delete(Long goodsNo) {
		// TODO Auto-generated method stub
		return mapper.delete(goodsNo);
	}
	
	@Override
	public Integer like(Long goodsNo, String id) {
		// TODO Auto-generated method stub
		return mapper.like(goodsNo, id);
	}
	@Override
	public Integer unLike(Long goodsNo, String id) {
		// TODO Auto-generated method stub
		return mapper.unLike(goodsNo, id);
	}
	@Override
	public String likeCheck(Long goodsNo, String id) {
		// TODO Auto-generated method stub
		return mapper.likeCheck(goodsNo, id);
	}

}
