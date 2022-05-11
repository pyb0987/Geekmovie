package com.geekmovie.board.service;

import java.util.List;

import com.geekmovie.board.vo.ReplyVo;

public interface BoardReplyService {
	
	public List<ReplyVo> rList(int seq);
	
	public void rCreate(ReplyVo replyVo);
	
	public void rUpdate(ReplyVo replyVo);
	
	public void rDelete(int reply_seq);
	
	
	
}
