package com.beetmarket.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.beetmarket.member.vo.PointVO;
import com.beetmarket.member.vo.SellerVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface MemberMapper {

	public LoginVO login(LoginVO vo);
	// 회원관리 리스트
	public List<MemberVO> list(@Param("pageObject") PageObject pageObject,@Param("id")String id);
	public List<PointVO> pointList(@Param("pageObject") PageObject pageObject,@Param("id")String id);
	// 판매자 신청 리스트
	public List<SellerVO> sellerList(@Param("pageObject") PageObject pageObject);
	
	// 회원관리 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(@Param("pageObject") PageObject pageObject);
	// 포인트 리스트 갯수
	public Long PointGetTotalRow(@Param("pageObject") PageObject pageObject ,@Param("id")String id);
	// 판매자 등록 리스트총 갯수
	public Long SellerGetTotalRow(@Param("pageObject") PageObject pageObject);
	// 등급 변경
	public Integer changeGrade(MemberVO vo);
	// 맴버쉽 변경
	public Integer changeMemeberShip(MemberVO vo);
	// 상태 변경
	public Integer changeStatus(MemberVO vo);
	// 최근접속일 업데이트
	public Integer ConDateUpdate(LoginVO vo);
	// 회원 정보 수정
	public Integer update(MemberVO vo);
	// 회원 가입 
	public Integer write(MemberVO vo);
	// 정보 보기
	public MemberVO view(String id);
	// 마이홈
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
	
	
	// 중복 체크 
	public int idCheck(String id);
	public int emailCheck(String email);
	public int telCheck(String tel);
}
