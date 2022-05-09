package com.geekmovie.board.service;

import java.util.List;

import com.geekmovie.board.vo.BoardVo;

public interface BoardService {
	
	public List<BoardVo> bList(BoardVo boardVo);
	
	public int boardListCnt(BoardVo boardvo);
	
	public int bCreate(BoardVo boardvo);
	
	public BoardVo bDetail(BoardVo boardVo);
	
	public int bUpdate(BoardVo boardVo);
	
	public int bCnt(BoardVo boardVo);
	
	public int bDelete(BoardVo boardVo);
	
	public List<BoardVo> boardRecommend(BoardVo boardVo);
	
	public int boardRecommendCnt(BoardVo boardvo);
	}
