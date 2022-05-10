package com.geekmovie.board.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.FreeBoardLikeDao;

@Service
public class FreeBoardLikeServiceImpl implements FreeBoardLikeService{

	@Autowired
	FreeBoardLikeDao freeBoardLikeDao;
	
	public int likeCheck(Map<String, Object> map) {
		return freeBoardLikeDao.likeCheck(map);
	}
	
	public int likeAdd(Map<String, Object> map) {
		return freeBoardLikeDao.likeAdd(map);
	}
	
	public int CountfreeLike(Map<String, Object> map) {
		return freeBoardLikeDao.CountfreeLike(map);
	}
	
	public int CountUserLike(Map<String, Object> map) {
		return freeBoardLikeDao.CountUserLike(map);
	}
}
