package com.geekmovie.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.BoardDao;
import com.geekmovie.board.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDao dao;
	
	public BoardServiceImpl() {
		System.out.println("@Service 스프링 자동 생성");
	}
	
	@Override
	public List<BoardVo> bList(BoardVo boardVo) {
		return dao.boardList(boardVo);
	}
	
	@Override
	public int boardListCnt(BoardVo boardvo) {
		return dao.boardListCnt(boardvo);
	}
	
	@Override
	public int bCreate(BoardVo boardVo) {
		return dao.boardInsert(boardVo);
	}
	
	@Override
	public BoardVo bDetail(BoardVo boardvo) {
		return dao.boardDetail(boardvo);
	}
	
	@Override
	public int bUpdate(BoardVo boardvo) {
		return dao.boardUpdate(boardvo);
	}
	
	@Override
	public int bCnt(BoardVo boardvo) {
		return dao.boardCnt(boardvo);
	}
	
	@Override
	public int bDelete(BoardVo boardvo) {
		return dao.boardDelete(boardvo);
	}
	
	public List<BoardVo> boardRecommend(BoardVo boardVo) {
		return dao.boardRecommend(boardVo);
	}
	public int boardRecommendCnt(BoardVo boardvo) {
		return dao.boardRecommendCnt(boardvo);
	}
	
	public Map<String, Object> AverageScore(int movieId){
		return dao.AverageScore(movieId);
	}

	@Override
	public int likeUpdate(Map<String, Object> map) {
		return dao.likeUpdate(map);
	}
}
