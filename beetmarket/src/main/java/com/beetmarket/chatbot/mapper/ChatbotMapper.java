package com.beetmarket.chatbot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.member.vo.MemberVO;

public interface ChatbotMapper {
	public List<ChatbotVO> list(String id);
	public List<ChatbotVO> history(@Param("roomno") Long roomno, @Param("id") String id);
	public Long updateacceptdate(@Param("roomno") Long roomno, @Param("id") String id);
	public Long chating(ChatbotVO vo);
	public Long deletechating(Long chatno);
	public MemberVO searchid(String idinfo);
	public Long deleteroom(@Param("roomno") Long roomno, @Param("id") String id);
	public Long addroom(ChatbotVO vo);
	public Long createroom(@Param("roomno") Long roomno, @Param("user_id") String user_id);
}