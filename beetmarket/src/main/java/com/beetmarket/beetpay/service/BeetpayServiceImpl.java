package com.beetmarket.beetpay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.beetpay.mapper.BeetpayMapper;
import com.beetmarket.beetpay.vo.BeetpayVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("BeetpayServiceImpl")
public class BeetpayServiceImpl implements BeetpayService {
	
	@Setter(onMethod_ = @Autowired)
	BeetpayMapper mapper;
	
	@Override
	public List<BeetpayVO> list(String id) {
		
		return mapper.list(id);
	}

	@Override
	public Integer write(BeetpayVO vo) {
		
		return mapper.write(vo);
	}
	@Override
	//비트페이 비밀번호 등록
	public Integer payPasswordWrite(BeetpayVO vo) {
		return mapper.payPasswordWrite(vo);
	}

	@Override
	public Integer delete(Long beetpayNo) {
		
		return mapper.delete(beetpayNo);
	}
	
	//비밀번호 비교
	public Integer passwordCheck(Integer payPassword) {
		return mapper.passwordCheck(payPassword);
	}

}
