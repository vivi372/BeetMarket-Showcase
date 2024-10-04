package com.beetmarket.notice.service;

import java.util.List;

import com.beetmarket.notice.vo.NoticeVO;

import com.webjjang.util.page.PageObject;

public interface NoticeService {
	// 공지사항 리스트
	public List<NoticeVO> list(PageObject pageObject);
	// 공지사항 상세 보기
	public NoticeVO view(Long[] in);
	// 공지사항 등록
	public Integer write(NoticeVO vo);
	// 공지사항 수정
	public Integer update(NoticeVO vo);
	// 공지사항 삭제
	public Integer delete(NoticeVO vo);
}
