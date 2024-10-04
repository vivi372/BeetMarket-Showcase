package com.beetmarket.beetpay.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beetmarket.beetpay.vo.BeetpayVO;

@Repository
public interface BeetpayMapper {
	//비트페이 리스트
	public List<BeetpayVO> list(String id);
	//비트페이 등록
	public Integer write(BeetpayVO vo);
	public Integer payPasswordWrite(BeetpayVO vo);
	//비트페이 삭제
	public Integer delete(Long beetpayNo);
	//비밀번호 비교
	public Integer passwordCheck(Integer payPassword);
}
