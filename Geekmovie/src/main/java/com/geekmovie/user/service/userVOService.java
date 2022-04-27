package com.geekmovie.user.service;

import javax.servlet.http.HttpSession;

import com.geekmovie.user.vo.userVO;

public interface userVOService {
	// 회원가입
	public int create(userVO userVO);
	
	// 아이디 중복 확인
	public int idCheck(String id);
	
	// 회원 로그인 체크
	public boolean loginCheck(userVO userVO, HttpSession session);
	
	// 회원 로그인 정보
	public userVO viewMember(userVO userVO);
	
}
