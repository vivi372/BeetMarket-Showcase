package com.webjjang.util.login;

import javax.servlet.http.HttpSession;

import com.beetmarket.member.vo.LoginVO;

public class LoginUtil {
	/**
	 * session에서 아이디를 꺼내는 메서드
	 * 로그인시에는 로그인된 아이디가 비 로그인시에는 null이 리턴
	 */
	public static String getId(HttpSession session) {
		LoginVO login = (LoginVO) session.getAttribute("login");
		String id = null;
		if(login != null) id = login.getId();
		return id;
	}
	/**
	 * session에서 판매자 번호를 꺼내는 메서드
	 * 판매자면 null인 아닌값이 나온다.
	 */
	public static Integer getSell_no(HttpSession session) {
		LoginVO login = (LoginVO) session.getAttribute("login");
		Integer sell_no = null;
		if(login != null) sell_no = login.getSell_no();
		return sell_no;
	}
	
	/**
	 * session에서 등급 번호를 꺼내는 메서드
	 * 판매자면 null인 아닌값이 나온다.
	 */
	public static Integer getGradeno(HttpSession session) {
		LoginVO login = (LoginVO) session.getAttribute("login");
		Integer gradeNo = null;
		if(login != null) gradeNo = login.getGradeNo();
		return gradeNo;
	}
}
