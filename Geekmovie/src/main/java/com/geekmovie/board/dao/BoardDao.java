package com.geekmovie.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.board.vo.BoardVo;

@Repository
public class BoardDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public BoardDao() {
		System.out.println("@Repository 스프링 자동 생성");
	}
	
	public int insert(BoardVo boardvo) {
		return sqlSessionTemplate.insert("boardvo.insert", boardvo);
	}

}
