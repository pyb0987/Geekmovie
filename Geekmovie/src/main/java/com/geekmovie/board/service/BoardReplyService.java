package com.geekmovie.board.service;

import java.util.List;

import com.geekmovie.board.vo.ReplyVo;

public interface BoardReplyService {
	
	public List<ReplyVo> rList(int seq);
	
	public int rCreate(ReplyVo replyVo);
	
	public int rUpdate(ReplyVo replyVo);
	
	public int rDelete(int rno);
	
	
	
}
