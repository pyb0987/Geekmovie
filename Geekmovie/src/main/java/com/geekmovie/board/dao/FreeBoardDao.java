package com.geekmovie.board.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.board.vo.FreeVo;

@Repository
public class FreeBoardDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public FreeBoardDao() {
		System.out.println("@Repository FreeBoardDAO 스프링 자동 생성");
	}
	
	public List<FreeVo> freeList(FreeVo freeVo) {
		return sqlSessionTemplate.selectList("freeVo.free_list", freeVo);
	}
	
	public int freeListCnt(FreeVo freeVo) {
		return sqlSessionTemplate.selectOne("freeVo.freeListCnt", freeVo);
	}
	
	public FreeVo freeboardDetail(FreeVo freeVo) {
		return sqlSessionTemplate.selectOne("freeVo.free_detail", freeVo);
	}
	
	public int freeInsert(FreeVo freeVo) {
		return sqlSessionTemplate.insert("freeVo.free_insert", freeVo);
	}
	
	public int freeUpdate(FreeVo freeVo) {
		return sqlSessionTemplate.update("freeVo.free_update", freeVo);
	}
	
	public int freeDelete(FreeVo freeVo) {
		return sqlSessionTemplate.delete("freeVo.free_delete", freeVo);
	}
	
	public int freeCnt(FreeVo freeVo) {
		return sqlSessionTemplate.update("freeVo.free_cntIncrease", freeVo);
	}

	public List<FreeVo> freeRecommend(FreeVo freeVo) {
		return sqlSessionTemplate.selectList("freeVo.free_recommend", freeVo);
	}
	public int freeRecommendCnt(FreeVo freeVo) {
		return sqlSessionTemplate.selectOne("freeVo.freerecommendCnt", freeVo);
	}
	public int likeUpdate(Map<String, Object> map) {
		return sqlSessionTemplate.update("freeVo.like_update", map);
	}
	
	public int replyUpdate(Map<String, Object> map) {
		return sqlSessionTemplate.update("freeVo.reply_update", map);
	}

	public List<FreeVo> UserLike(Map<String, Object> map) {
		return 	sqlSessionTemplate.selectList("freeVo.UserLike", map);	
	}
}
