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

	public int idCheck(String id) {
		return sqlSessionTemplate.selectOne("userVO.idCheck",id);
	}
	
	public boolean loginCheck(userVO userVO) {
		String name = sqlSessionTemplate.selectOne("userVO.loginCheck",userVO);
		return (name == null) ? false : true;
	}
	
	public userVO viewMember(userVO userVO) {
		return sqlSessionTemplate.selectOne("userVO.viewMember",userVO);
	}
	
	public int update_mypage(userVO userVO) {
		return sqlSessionTemplate.update("userVO.update_mypage",userVO);
	}
}
