package com.beetmarket.chatbot.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.member.vo.MemberVO;

public interface ChatbotService {
	public List<ChatbotVO> list(String id);
	public List<ChatbotVO> history(Long roomno, String id);
	public Long chating(ChatbotVO vo);
	public Long deletechating(Long chatno);
	public MemberVO searchid(String idinfo);
	public Long deleteroom(@Param("roomno") Long roomno, @Param("id") String id);
	public Long createroom(ChatbotVO vo);
}