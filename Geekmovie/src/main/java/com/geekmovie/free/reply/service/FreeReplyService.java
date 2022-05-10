package com.geekmovie.free.reply.service;

import java.util.List;
import java.util.Map;

import com.geekmovie.free.reply.vo.FreeReplyVo;

public interface FreeReplyService {
	
	public int insert(FreeReplyVo freeReplyVo);	
	
	public List<FreeReplyVo> boardShow(Map<String, Object> map);
	
	public int boardCount(int boardId);
	
	public int boardAncestorCount(int boardId);
	
	public String boardOrderserialfind(FreeReplyVo freeReplyVo);
	
	public int likeUpdate(Map<String, Object> map);
	
	public int delete(int replyId);
	
	public int update(FreeReplyVo freeReplyVo);
}
