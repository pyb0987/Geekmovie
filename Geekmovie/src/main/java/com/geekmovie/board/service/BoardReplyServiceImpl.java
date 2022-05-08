package com.geekmovie.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.BoardReplyDao;
import com.geekmovie.board.vo.ReplyVo;

@Service
public class BoardReplyServiceImpl implements BoardReplyService{
	
	@Autowired
	BoardReplyDao dao;
	
	@Override
	public List<ReplyVo> rList(int seq) {
		return dao.replyList(seq);
	}
	
	@Override
	public void rCreate(ReplyVo replyVo) {
		dao.replyCreate(replyVo);
	}
	
	@Override
	public void rUpdate(ReplyVo replyVo) {
		dao.replyUpdate(replyVo);
	}
	
	@Override
	public void rDelete(int reply_seq) {
		dao.replyDelete(reply_seq);
	}
	
}
