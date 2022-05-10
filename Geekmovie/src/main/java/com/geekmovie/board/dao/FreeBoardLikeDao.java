package com.geekmovie.board.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardLikeDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	
	public int likeCheck(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("FreeLikeVo.Check",map);
	}		//#{userId} #{freeId} #{mode}
	
	public int likeAdd(Map<String, Object> map) {
		return sqlSessionTemplate.insert("FreeLikeVo.Add",map);
	}		//#{userId}, #{freeId}, #{mode}}
	
	public int CountfreeLike(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("FreeLikeVo.CountfreeLike",map);
	}		//#{freeId} #{mode}
	
	public int CountUserLike(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("FreeLikeVo.CountUserLike",map);
	}		//#{userId} #{mode}
}
