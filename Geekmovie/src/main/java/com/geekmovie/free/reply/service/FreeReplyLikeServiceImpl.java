package com.geekmovie.free.reply.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.FreeBoardLikeDao;
import com.geekmovie.free.reply.dao.FreeReplyLikeDao;

@Service
public class FreeReplyLikeServiceImpl implements FreeReplyLikeService{

	@Autowired
	FreeReplyLikeDao freeReplyLikeDao;
	
	public int likeCheck(Map<String, Object> map) {
		return freeReplyLikeDao.likeCheck(map);
	}
	
	public int likeAdd(Map<String, Object> map) {
		return freeReplyLikeDao.likeAdd(map);
	}
	
	public int CountfreeLike(Map<String, Object> map) {
		return freeReplyLikeDao.CountfreeLike(map);
	}
	
	public int CountUserLike(Map<String, Object> map) {
		return freeReplyLikeDao.CountUserLike(map);
	}
}
