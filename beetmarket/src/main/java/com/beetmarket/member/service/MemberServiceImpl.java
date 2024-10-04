package com.beetmarket.member.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.member.mapper.MemberMapper;
import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.beetmarket.member.vo.PointVO;
import com.beetmarket.member.vo.SellerVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberMapper mapper;
	
	@Override
	public LoginVO login(LoginVO vo) {
		// TODO Auto-generated method stub
		return mapper.login(vo);
	}
	// 회원 리스트
	@Override
	public List<MemberVO> list(PageObject pageObject ,String id) {
		log.info("list() 실행");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject , id);
	}
	// 포인트 리스트
	@Override
	public List<PointVO> pointList(PageObject pageObject, String id) {
		log.info("list() 실행asdasd");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.PointGetTotalRow(pageObject,id));
		return mapper.pointList(pageObject,id);
	}
	// 판매자 리스트
	@Override
	public List<SellerVO> sellerList(PageObject pageObject) {
		log.info("list() 실행asdasd");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.SellerGetTotalRow(pageObject));
		return mapper.sellerList(pageObject);
	}
	// 회원 등급변경
	@Override
	public Integer changeGrade(MemberVO vo) {
		log.info(vo);
		return mapper.changeGrade(vo);
	}
	// 회원 맴버쉽변경
	@Override
	public Integer changeMemeberShip(MemberVO vo) {
		log.info(vo);
		return mapper.changeMemeberShip(vo);
	}
	// 회원 상태변경
	@Override
	public Integer changeStatus(MemberVO vo) {
		log.info(vo);
		return mapper.changeStatus(vo);
	}
	// 회원 최근 접속일 업데이트
	@Override
	public Integer ConDateUpdate(LoginVO vo) {
		log.info(vo);
		return mapper.ConDateUpdate(vo);
	}
	
	// 회원관리 글보기
	@Override
	public MemberVO view(String id) {
		log.info("view() 실행");
		return mapper.view(id);
	}
	
	// 회원관리 마이홈
	@Override
	public MemberVO myView(String id) {
		log.info("view() 실행");
		return mapper.myView(id);
	}
	// 포인트 추가
	@Override
	public Integer pointWrite(PointVO vo) {
		// TODO Auto-generated method stub
		return mapper.pointWrite(vo);
	}
	// 정보 수정
	@Override
	public Integer update(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}
	//  회원 가입
	@Override
	public Integer write(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}
	
	// 회원 아이디 찾기
	@Override
	public MemberVO idSearch(String name, String tel) {
		// TODO Auto-generated method stub
		return mapper.idSearch(name, tel);
	}
	
	public MemberVO pwSearch(@Param("email")String email ,@Param("tel") String tel ,@Param("id") String id ) {
	
		return mapper.pwSearch(email, tel, id);
	}
	
	// 회원 비밀번호 변경
	@Override
	public Integer pwUpdate(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.pwUpdate(vo);
	}		
	
	//  판매자 가입
	@Override
	public Integer seller(SellerVO vo) {
		// TODO Auto-generated method stub
		return mapper.seller(vo);
	}
	// 판매자 승인대기 변경
	@Override
	public Integer is_pendingUpdate(SellerVO vo) {
		// TODO Auto-generated method stub
		return mapper.is_pendingUpdate(vo);
		
	}
	
	
	//중복체크 mapper 접근
	@Override
	public int idCheck(String id) {
		int cnt = mapper.idCheck(id);
		System.out.println("cnt: " + cnt);
		return cnt;
	}		
	@Override
	public int emailCheck(String email) {
		int cnt1 = mapper.emailCheck(email);
		System.out.println("cnt: " + cnt1);
		return cnt1;
	}		
	@Override
	public int telCheck(String tel) {
		int cnt2 = mapper.telCheck(tel);
		System.out.println("cnt: " + cnt2);
		return cnt2;
	}

}
