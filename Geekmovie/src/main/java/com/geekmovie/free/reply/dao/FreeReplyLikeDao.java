package com.geekmovie.free.reply.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeReplyLikeDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	
	public int likeCheck(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("FreeReplyLikeVo.Check",map);
	}		//#{userId} #{freereplyId} #{mode}
	
	public int likeAdd(Map<String, Object> map) {
		return sqlSessionTemplate.insert("FreeReplyLikeVo.Add",map);
	}		//#{userId}, #{freereplyId}, #{mode}}
	
	public int CountfreeLike(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("FreeReplyLikeVo.CountfreeLike",map);
	}		//#{freeId} #{mode}
	
	public int CountUserLike(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("FreeReplyLikeVo.CountUserLike",map);
	}		//#{userId} #{mode}
}
