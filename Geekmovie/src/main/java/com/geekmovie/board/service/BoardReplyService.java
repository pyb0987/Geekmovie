package com.geekmovie.board.service;

import java.util.List;

import com.geekmovie.board.vo.ReplyVo;

public interface BoardReplyService {
	
	List<ReplyVo> rList(int seq);
	
	void rCreate(ReplyVo replyVo);
	
	void rUpdate(ReplyVo replyVo);
	
	void rDelete(int reply_seq);
	
	
	
}
