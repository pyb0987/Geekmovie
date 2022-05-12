package com.geekmovie.free.reply.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.FreeBoardLikeDao;
import com.geekmovie.board.vo.FreeVo;
import com.geekmovie.free.reply.dao.FreeReplyDao;
import com.geekmovie.free.reply.vo.FreeReplyVo;

@Service
public class FreeReplyServiceImpl implements FreeReplyService{

	@Autowired
	FreeReplyDao freeReplyDao;
	
	public int insert(FreeReplyVo freeReplyVo) {
		return freeReplyDao.insert(freeReplyVo);  //boardId, parentId,content,writer,depth, orderSerial
	}
	
	public List<FreeReplyVo> boardShow(Map<String, Object> map){	//boardId, start, size
		return freeReplyDao.boardShow(map);
	}
	
	public int boardCount(int boardId){	
		return freeReplyDao.boardCount(boardId);
	}
	
	public int boardAncestorCount(int boardId){	
		return freeReplyDao.boardAncestorCount(boardId);
	}
	
	public String boardOrderserialfind(FreeReplyVo freeReplyVo){	
		return freeReplyDao.boardOrderserialfind(freeReplyVo);
	}
	
	public int likeUpdate(Map<String, Object> map) {
		return freeReplyDao.likeUpdate(map);
	}
	
	public int delete(int replyId) {
		return freeReplyDao.delete(replyId);
	}
	
	public int update(FreeReplyVo freeReplyVo) {
		return freeReplyDao.update(freeReplyVo);
	}
	
	public List<FreeReplyVo> UserReplyLike(Map<String, Object> map) {
		return freeReplyDao.UserReplyLike(map);
	}
	
	public List<FreeReplyVo> UserReply(Map<String, Object> map) {
		return freeReplyDao.UserReply(map);
	}
	
	public int ReplyShow(Map<String, Object> map) {
		return freeReplyDao.ReplyShow(map);
	}
}
