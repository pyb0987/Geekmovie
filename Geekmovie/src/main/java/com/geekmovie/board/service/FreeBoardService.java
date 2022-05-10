package com.geekmovie.board.service;

import java.util.List;
import java.util.Map;

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
	
	public List<FreeVo> freeRecommend(FreeVo freeVo);
	
	public int freeRecommendCnt(FreeVo freeVo);

	public int likeUpdate(Map<String, Object> map);
	
	
	public int replyUpdate(Map<String, Object> map);
	
	public List<FreeVo> UserLike(Map<String, Object> map);
	}
