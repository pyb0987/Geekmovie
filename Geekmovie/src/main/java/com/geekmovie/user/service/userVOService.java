package com.geekmovie.user.service;

import com.geekmovie.user.vo.userVO;

public interface userVOService {
	
	public int create(userVO userVO);
	
	//아이디 중복 확인
	public int idCheck(String id);
	
}
