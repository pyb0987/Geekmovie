package com.geekmovie.board.service;

import java.util.List;

import com.geekmovie.board.vo.BoardVo;

public interface BoardService {
	
	public List<BoardVo> bList(BoardVo boardVo);
	
	public int bCreate(BoardVo boardvo);
	
}
