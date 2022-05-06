package com.geekmovie.onelinereview.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Repository
public class OneLineReviewLikeDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int Check(Map<String, Object> map) {	
		return sqlSessionTemplate.selectOne("oneLineReviewLikeVo.Check", map); //#{userId}, #{oneLineReviewId}, #{mode}
	}
	
	public int Add(Map<String, Object> map) {	
		int rs = sqlSessionTemplate.insert("oneLineReviewLikeVo.Add", map);
		sqlSessionTemplate.delete("oneLineReviewLikeVo.DeleteDuple");
		return rs;
	}
	
	public int CountOrlLike(Map<String, Object> map){
		return sqlSessionTemplate.selectOne("oneLineReviewLikeVo.CountOlrLike", map);
	}
}
