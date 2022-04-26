package com.geekmovie.board.service;

import java.util.List;
import java.util.Map;

import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.board.vo.PageVo;

public interface BoardService {
	
	public List<BoardVo> bList(BoardVo boardVo);
	
	public int boardListCnt();
	
	public int bCreate(BoardVo boardvo);
	
	public BoardVo bDetail(BoardVo boardVo);
	
	public int bUpdate(BoardVo boardVo);
	
	public int bDelete(BoardVo boardVo);
}
