package com.geekmovie.board.service;

import java.util.List;

import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.board.vo.FreeVo;

public interface FreeBoardService {
	
	public List<FreeVo> fList(FreeVo freeVo);
	
	public int fListCnt(FreeVo freeVo);
	
	public FreeVo fDetail(FreeVo freeVo);
	
	public int fCreate(FreeVo freeVo);
	
	public int fUpdate(FreeVo freeVo);
	
	public int fDelete(FreeVo freeVo);
	
	public int fCnt(FreeVo freeVo);

}
