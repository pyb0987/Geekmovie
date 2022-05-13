package com.geekmovie.board.service;

import java.util.Map;

public interface FreeBoardLikeService {
	public int likeCheck(Map<String, Object> map);
	
	public int likeAdd(Map<String, Object> map);
	
	public int CountfreeLike(Map<String, Object> map);
	
	public int CountUserLike(Map<String, Object> map);
}
