package com.beetmarket.showdown.mapper;

import java.util.List;

import com.beetmarket.showdown.vo.ShowdownVO;
import com.webjjang.util.page.PageObject;

public interface ShowdownMapper {
	// 이벤트 발표 리스트
	public List<ShowdownVO> list(PageObject pageObject);
	// 
	public Long getTotalRow(PageObject pageObject);
	// 이벤트 발표 상세 보기
	public ShowdownVO view(Long no);
	// 이벤트 발표 등록
	public Integer write(ShowdownVO vo);
	// 이벤트 발표 수정
	public Integer update(ShowdownVO vo);
	// 이벤트 발표 삭제
	public Integer delete(ShowdownVO vo);
}