package com.geekmovie.movie.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MovieLikeDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int Check(Map<String, Object> map) {	
		return sqlSessionTemplate.selectOne("MovieLikeVo.Check", map); //#{userId}, #{movieId}, #{mode}
	}
	
	public int Add(Map<String, Object> map) {	
		int rs = sqlSessionTemplate.insert("MovieLikeVo.Add", map);
		sqlSessionTemplate.delete("MovieLikeVo.DeleteDuple");
		return rs;
	}
	
	public int CountMovieLike(Map<String, Object> map){
		return sqlSessionTemplate.selectOne("MovieLikeVo.CountMovieLike", map);
	}
	
	public List<Map<String, Object>> UserMovieLike(Map<String, Object> map){
		return sqlSessionTemplate.selectList("MovieLikeVo.UserMovieLike", map);
	}
	

}
