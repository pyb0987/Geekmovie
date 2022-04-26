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
		System.out.println("@Repository UserVODaa 스프링 자동 생성");
	}
	
	public int insert(userVO userVO) {
		return sqlSessionTemplate.insert("userVO.insertVO",userVO);
	}
	
	//04-22 수정 구문
	public int idCheck(String id) {
		int cnt = sqlSessionTemplate.selectOne("userVO.idCheck",id);
		return cnt;
	}
	
}
