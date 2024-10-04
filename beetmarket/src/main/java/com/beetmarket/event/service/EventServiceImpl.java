package com.beetmarket.event.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.beetmarket.event.mapper.EventMapper;
import com.beetmarket.event.vo.EventVO;
import com.beetmarket.event.vo.SubscriberVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;
@Service
@Log4j
@Qualifier("EventServiceImpl")
public class EventServiceImpl implements EventService{
	@Inject
	public EventMapper mapper;
	public List<EventVO> list(PageObject pageObject){
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	public EventVO view(Long[] in) {
		Long no=in[0];
		return mapper.view(no);
	}
	public Integer write(EventVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}
	public Integer update(EventVO vo) {
		return mapper.update(vo);
	}
	public Integer delete(EventVO vo) {
		return mapper.delete(vo);
	}
	@Override
	public List<SubscriberVO> subscriber(Long event_no) {
		// TODO Auto-generated method stub
		return mapper.subscriber(event_no);
	}
	@Override
	public List<String> drowWinner(Long event_no, Integer numWinners) throws Exception {
	    // 이벤트 참여자 리스트 조회
	    List<SubscriberVO> subscribers = getSubscriberList(event_no);
	    List<String> winners = new ArrayList<>();

	    if (subscribers.isEmpty()) {
	        return winners; // 참여자가 없으면 빈 리스트 반환
	    }

	    // 참여자 ID를 winners 리스트에 추가
	    for (SubscriberVO subscriber : subscribers) {
	        winners.add(subscriber.getId());
	    }

	    // 랜덤으로 섞기
	    Collections.shuffle(winners);

	    // 당첨자 수를 넘지 않도록 조정
	    return winners.subList(0, Math.min(numWinners, winners.size()));
	}
	
	public Integer Apply(SubscriberVO vo){
		Integer result = mapper.apply(vo);
		return result;
	}
	@Override
	public List<SubscriberVO> getSubscriberList(Long event_no) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getSubscriberList(event_no);
	}
}