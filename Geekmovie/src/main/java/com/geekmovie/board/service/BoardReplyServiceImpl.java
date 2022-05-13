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
	public int rCreate(ReplyVo replyVo) {
		return dao.replyCreate(replyVo);
	}
	
	@Override
	public int rUpdate(ReplyVo replyVo) {
		return dao.replyUpdate(replyVo);
	}
	
	@Override
	public int rDelete(int rno) {
		System.out.println("삭제 서비스");
		return dao.replyDelete(rno);
	}
	
}
