package com.beetmarket.notice.service;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.beetmarket.notice.mapper.NoticeMapper;
import com.beetmarket.notice.vo.NoticeVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;


@Service
@Log4j
@Qualifier("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService{
	@Inject
	public NoticeMapper mapper;
	public List<NoticeVO>list(PageObject pageObject){
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
		
	}
	public NoticeVO view(Long[] in) {
		Long no=in[0];
		return mapper.view(no);
	}
	public Integer write(NoticeVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}
	public Integer update(NoticeVO vo) {
		return mapper.update(vo);
	}
	public Integer delete(NoticeVO vo) {
		return mapper.delete(vo);
	}
}