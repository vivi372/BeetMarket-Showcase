package com.beetmarket.member.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.beetmarket.member.vo.PointVO;
import com.beetmarket.member.vo.SellerVO;
import com.webjjang.util.page.PageObject;

public interface MemberService {
	public LoginVO login(LoginVO vo);
	// 회원관리 리스트
	public List<MemberVO> list(PageObject pageObject , String id);
	public List<PointVO> pointList(PageObject pageObject, String id);
	// 판매자 신청 리스트 
	public List<SellerVO> sellerList(PageObject pageObject);
	// 회원등급변경
	public Integer changeGrade(MemberVO vo);
	// 회원 맴버쉽 변경
	public Integer changeMemeberShip(MemberVO vo);
	// 회원 상태변경
	public Integer changeStatus(MemberVO vo);
	// 최근 접속일 업데이트
	public Integer ConDateUpdate(LoginVO vo);
	// 회원 정보 변경
	public Integer update(MemberVO vo);
	// 회원 가입
	public Integer write(MemberVO vo);
	// 회원관리 글보기
	public MemberVO view(String id);
	// My 홈
	public MemberVO myView(String id);
	// 포인트 증감값
	public Integer pointWrite(PointVO vo);
	// 아이디 찾기
	public MemberVO idSearch(@Param("name")String name ,@Param("tel") String tel);
	// 비밀번호 찾기
	public MemberVO pwSearch(@Param("email")String email ,@Param("tel") String tel ,@Param("id") String id );
	// 회원 비밀번호 수정
	public Integer pwUpdate(MemberVO vo);
	// 판매자 가입
	public Integer seller(SellerVO vo);
	// 판매자 승인대기 변경
	public Integer is_pendingUpdate(SellerVO vo);
	
	
	
	
	
	
	
	// 중복체크 
	public int idCheck(String id);
	public int emailCheck(String email);
	public int telCheck(String tel);
	
	
}
