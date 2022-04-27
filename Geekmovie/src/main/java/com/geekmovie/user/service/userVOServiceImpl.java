package com.geekmovie.user.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.user.dao.userVODao;
import com.geekmovie.user.vo.userVO;

@Service
public class userVOServiceImpl implements userVOService {

	@Autowired
	userVODao dao;
	
	@Override
	// 회원 가입
	public int create(userVO userVO) {
		return dao.insert(userVO);
	}

	@Override
	// 아이디 중복 체크
	public int idCheck(String id) {
		int cnt = dao.idCheck(id);
		return cnt;
	}

	@Override
	// 회원 로그인 체크
	public boolean loginCheck(userVO userVO, HttpSession session) {
		boolean result = dao.loginCheck(userVO);
		if(result) { // true일 경우 세션에 등록
			userVO vo2 = viewMember(userVO);
			// 세션에 변수 등록
			session.setAttribute("id", vo2.getId());
			session.setAttribute("name", vo2.getName());
		}
		return result;
	}

	@Override
	// 회원 로그인 정보
	public userVO viewMember(userVO userVO) {
		return dao.viewMember(userVO);
	}

	@Override
	//로그아웃 부분
	public void logout(HttpSession session) {
		// 세션을 초기화 시킴.
		session.invalidate();
		
	}
	
	
}
