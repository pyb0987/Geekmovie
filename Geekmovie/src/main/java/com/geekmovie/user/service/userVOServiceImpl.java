package com.geekmovie.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.user.dao.userVODao;
import com.geekmovie.user.vo.userVO;

@Service
public class userVOServiceImpl implements userVOService {

	@Autowired
	userVODao dao;
	
	@Override
	public int create(userVO userVO) {
		return dao.insert(userVO);
	}
	
	
	// 아이디 중복체크
	// 04-22 수정구문
	@Override
	public int idCheck(String id) {
		int cnt = dao.idCheck(id);
		return cnt;
	}
	
	
	
}
