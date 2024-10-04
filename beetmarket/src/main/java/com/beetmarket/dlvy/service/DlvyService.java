package com.beetmarket.dlvy.service;



import java.util.List;




import com.beetmarket.dlvy.vo.DlvyVO;


public interface DlvyService {
	
	//1.배송지 리스트		
	public List<DlvyVO> list(String id);
	//2. 배송지 등록
	public int write(DlvyVO vo);	
	//3. 수정 폼
	public DlvyVO updateForm(Long dlvyAddrNo);
	//3. 수정 
	public int update(DlvyVO vo);
	//4.배송지 삭제
	public int delete(DlvyVO vo);

}
