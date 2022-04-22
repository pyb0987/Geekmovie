package com.geekmovie.user.service;

import com.geekmovie.user.vo.userVO;

public interface userVOService {
	
	public int create(userVO userVO);
	
	public int idCheck(String id);

}
