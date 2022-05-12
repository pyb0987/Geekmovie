package com.geekmovie.free.reply.service;

import java.util.Map;

public interface FreeReplyLikeService {
	public int likeCheck(Map<String, Object> map);
	
	public int likeAdd(Map<String, Object> map);
	
	public int CountfreeLike(Map<String, Object> map);
	
	public int CountUserLike(Map<String, Object> map);
			
	public int delete(int freereplyId);
}
