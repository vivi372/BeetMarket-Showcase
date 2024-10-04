package com.beetmarket.chatbot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.chatbot.mapper.ChatbotMapper;
import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.member.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
@Qualifier("chatbotserviceimpl")
public class ChatbotServiceImpl implements ChatbotService {
	@Autowired
	private ChatbotMapper mapper;

	@Override
	public List<ChatbotVO> list(String id) {
		return mapper.list(id);
	}

	@Override
	@Transactional
	public List<ChatbotVO> history(Long roomno, String id) {
		mapper.updateacceptdate(roomno, id);
		return mapper.history(roomno, id);
	}

	@Override
	public Long chating(ChatbotVO vo) {
		
		return mapper.chating(vo);
	}

	@Override
	public Long deletechating(Long chatno) {
		return mapper.deletechating(chatno);
	}

	@Override
	public MemberVO searchid(String idinfo) {
		return mapper.searchid(idinfo);
	}

	@Override
	public Long createroom(ChatbotVO vo) {
		mapper.addroom(vo);
		
		Long roomno=vo.getRoomno();
		
		Long result=0L;
		
		String user_id=vo.getSender();
		result+=mapper.createroom(roomno, user_id);
		
		user_id=vo.getPartner();
		result=mapper.createroom(roomno, user_id);
		
		log.info("createroom 결과: "+result);
		
		return roomno;
	}

	@Override
	public Long deleteroom(Long roomno, String id) {
		return mapper.deleteroom(roomno, id);
	}
}