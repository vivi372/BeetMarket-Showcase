package com.beetmarket.event.service;

import java.util.List;

import com.beetmarket.event.vo.EventVO;
import com.beetmarket.event.vo.SubscriberVO;
import com.webjjang.util.page.PageObject;

public interface EventService {
	// 이벤트 리스트
	public List<EventVO> list(PageObject pageObject);
	// 이벤트 상세보기
	public EventVO view(Long[] in);
	// 이벤트 등록
	public Integer write(EventVO vo);
	// 이벤트 수정
	public Integer update(EventVO vo);
	// 이벤트 삭제
	public Integer delete(EventVO vo);
	// 이벤트 참여 리스트
	public List<SubscriberVO> getSubscriberList(Long event_no) throws Exception;
	// 이벤트 참여 등록
	public Integer Apply(SubscriberVO vo) throws Exception;
	// 
	public List<SubscriberVO> subscriber(Long event_no);
	// 이벤트 당첨자
	public List<String> drowWinner(Long event_no, Integer numWinners) throws Exception;	
}