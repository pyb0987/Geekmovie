package com.geekmovie.movie.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.user.vo.userVO;

@Repository
public class MovieDao {
	// 실제로는 내부 DB에 접근하지 않고 외부 DB와 연결함
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public MovieDao() {
		System.out.println("@Repository 스프링 자동생성");
	}

}
