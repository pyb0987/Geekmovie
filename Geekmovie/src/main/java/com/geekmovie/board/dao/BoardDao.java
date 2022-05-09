package com.geekmovie.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.board.vo.BoardVo;

@Repository
public class BoardDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public BoardDao() {
		System.out.println("@Repository BoardDAO 스프링 자동 생성");
	}
	
	public List<BoardVo> boardList(BoardVo boardvo) {
		return sqlSessionTemplate.selectList("boardVo.board_list", boardvo);
	}
	
	public int boardListCnt(BoardVo boardvo) {
		return sqlSessionTemplate.selectOne("boardVo.boardListCnt", boardvo);
	}
	
	public int boardInsert(BoardVo boardvo) {
		return sqlSessionTemplate.insert("boardVo.board_insert", boardvo);
	}
	
	public BoardVo boardDetail(BoardVo boardvo) {
		return sqlSessionTemplate.selectOne("boardVo.board_detail", boardvo);
	}
	
	public int boardUpdate(BoardVo boardvo) {
		return sqlSessionTemplate.update("boardVo.board_update", boardvo);
	}
	
	public int boardCnt(BoardVo boardvo) {
		return sqlSessionTemplate.update("boardVo.board_cntIncrease", boardvo);
	}
	
	public int boardDelete(BoardVo boardvo) {
		return sqlSessionTemplate.delete("boardVo.board_delete", boardvo);
	}

	public List<BoardVo> boardRecommend(BoardVo boardvo) {
		return sqlSessionTemplate.selectList("boardVo.board_recommend", boardvo);
	}
	public int boardRecommendCnt(BoardVo boardvo) {
		return sqlSessionTemplate.selectOne("boardVo.boardrecommendCnt", boardvo);
	}
}
