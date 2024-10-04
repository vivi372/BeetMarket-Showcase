package com.beetmarket.showdown.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.showdown.mapper.ShowdownMapper;
import com.beetmarket.showdown.vo.ShowdownVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;
@Service
@Qualifier("showdownServiceImpl")
@Log4j
public class ShowdownServiceImpl implements ShowdownService {
	@Inject
	public ShowdownMapper mapper;
	// 이벤트 발표 리스트
	public List<ShowdownVO> list(PageObject pageObject){
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	// 이벤트 발표 상세 보기
	public ShowdownVO view(Long[] hi){
		Long no = hi[0];
		return mapper.view(no);
	}
	// 이벤트 발표 등록
	public Integer write(ShowdownVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}
	// 이벤트 발표 수정
	public Integer update(ShowdownVO vo) {
		return mapper.update(vo);
	}
	// 이벤트 발표 삭제
	public Integer delete(ShowdownVO vo) {
		return mapper.delete(vo);
	}
}
