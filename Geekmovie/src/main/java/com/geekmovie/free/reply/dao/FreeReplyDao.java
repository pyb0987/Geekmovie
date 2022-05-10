package com.geekmovie.free.reply.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.free.reply.vo.FreeReplyVo;

@Repository
public class FreeReplyDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	
	public int insert(FreeReplyVo freeReplyVo) {
		return sqlSessionTemplate.insert("freeReplyVo.insert", freeReplyVo);
	}
	
	public List<FreeReplyVo> boardShow(Map<String, Object> map){
		return sqlSessionTemplate.selectList("freeReplyVo.boardShow", map);
	}
	
	public int boardCount(int boardId){
		return sqlSessionTemplate.selectOne("freeReplyVo.boardCount", boardId);
	}

	public int boardAncestorCount(int boardId){
		return sqlSessionTemplate.selectOne("freeReplyVo.boardAncestorSet", boardId);
	}
	
	public String boardOrderserialfind(FreeReplyVo freeReplyVo){
		return sqlSessionTemplate.selectOne("freeReplyVo.boardOrderserialfind", freeReplyVo);
	}
	
	public int likeUpdate(Map<String, Object> map) {
		return sqlSessionTemplate.update("freeReplyVo.like_update", map);
	}
	
	public int delete(int replyId) {
		return sqlSessionTemplate.update("freeReplyVo.delete", replyId);
	}
	
	public int update(FreeReplyVo freeReplyVo) {
		return sqlSessionTemplate.update("freeReplyVo.update", freeReplyVo);
	}
}
