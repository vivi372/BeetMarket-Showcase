package com.beetmarket.notice.mapper;

import java.util.List;

import com.beetmarket.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

public interface NoticeMapper {
	// 이벤트 리스트
		public List<NoticeVO> list(PageObject pageObject);
		// 이벤트 리스트 페이지 처리를 위한 젠체 데이터 개수
		public Long getTotalRow(PageObject pageObject);
		// 이벤트 상세보기
		public NoticeVO view(Long no);
		// 이벤트 등록
		public Integer write(NoticeVO vo);
		// 이벤트 수정
		public Integer update(NoticeVO vo);
		// 이벤트 삭제
		public Integer delete(NoticeVO vo);
}
