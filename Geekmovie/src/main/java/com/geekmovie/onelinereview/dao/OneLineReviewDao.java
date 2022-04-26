package com.geekmovie.onelinereview.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Repository
public class OneLineReviewDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<OneLineReviewVo> SelectAll() {
		return sqlSessionTemplate.selectList("oneLineReviewVo.SelectAll");
	}
	
}
