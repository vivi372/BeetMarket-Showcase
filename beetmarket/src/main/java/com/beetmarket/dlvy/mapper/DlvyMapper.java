package com.beetmarket.dlvy.mapper;

import java.util.List;


import org.springframework.stereotype.Repository;


import com.beetmarket.dlvy.vo.DlvyVO;


@Repository
public interface DlvyMapper {
	
	//1.배송지 리스트		
	public List<DlvyVO> list(String id);
	//2-1. 배송지 등록
	public int write(DlvyVO vo);
	//2-2. 기본 배송지 변경
	public int change_basic(String id);
	//3-1. 수정 전 정보 가져오기
	public DlvyVO view(Long dlvyAddrNo);
	//3-2. 수정 
	public int update(DlvyVO vo);
	//4.배송지 삭제
	public int delete(DlvyVO vo);
}
