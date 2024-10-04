package com.beetmarket.dlvy.service;




import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.beetmarket.dlvy.mapper.DlvyMapper;
import com.beetmarket.dlvy.vo.DlvyVO;


import lombok.Setter;

@Service
@Qualifier("DlvyServiceImpl")
public class DlvyServiceImpl implements DlvyService {
	
	@Setter(onMethod_ = @Autowired)
	DlvyMapper mapper;

	@Override
	public List<DlvyVO> list(String id) {
		
		return mapper.list(id);
	}

	@Override
	@Transactional
	public int write(DlvyVO vo) {
		if(vo.getBasic()==1) mapper.change_basic(vo.getId());
		return mapper.write(vo);
	}

	@Override
	public DlvyVO updateForm(Long dlvyAddrNo) {
		
		return mapper.view(dlvyAddrNo);
	}
	
	@Override
	@Transactional
	public int update(DlvyVO vo) {
		if(vo.getBasic()==1) mapper.change_basic(vo.getId());
		return mapper.update(vo);
	}

	@Override
	public int delete(DlvyVO vo) {
		
		return mapper.delete(vo);
	}


	
	
	

}
