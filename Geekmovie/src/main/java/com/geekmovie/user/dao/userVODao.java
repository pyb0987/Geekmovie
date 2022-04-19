package com.geekmovie.user.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.user.vo.userVO;

@Repository
public class userVODao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public userVODao() {
	
	}
	
	public int insert(userVO userVO) {
		return sqlSessionTemplate.insert("",userVO);
	}
	
}
