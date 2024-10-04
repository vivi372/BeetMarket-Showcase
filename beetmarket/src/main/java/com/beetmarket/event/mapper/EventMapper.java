package com.beetmarket.event.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beetmarket.event.vo.EventVO;
import com.beetmarket.event.vo.SubscriberVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface EventMapper {
	// 이벤트 리스트
	public List<EventVO> list(PageObject pageObject);
	// 이벤트 리스트 페이지 처리를 위한 젠체 데이터 개수
	public Long getTotalRow(PageObject pageObject);
	// 이벤트 상세보기
	public EventVO view(Long no);
	// 이벤트 등록
	public Integer write(EventVO vo);
	// 이벤트 수정
	public Integer update(EventVO vo);
	// 이벤트 삭제
	public Integer delete(EventVO vo);
	// 이벤트 참여 리스트
	public List<SubscriberVO> subscriber();
	// 이벤트 당첨자
	public String drowWinner(Long event_no);
	  // 참여자 등록 메서드 정의
    public Integer apply(SubscriberVO vo);
    // 이벤트에 참여한 참여자 리스트 조회 메서드 정의
    public List<SubscriberVO> getSubscriberList(Long event_no) throws Exception;
    // 메서드 정의
    List<SubscriberVO> subscriber(Long event_no);
    // 중복 이벤트 참여 체크
	public Integer checkExistingRegistration(SubscriberVO vo); 
}