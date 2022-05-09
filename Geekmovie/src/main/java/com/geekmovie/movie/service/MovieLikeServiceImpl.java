package com.geekmovie.movie.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.movie.dao.MovieLikeDao;


@Service
public class MovieLikeServiceImpl implements MovieLikeService{
	
	@Autowired
	MovieLikeDao movieLikeDao;						//외부 DB 작업 Dao
	
	public int Check(Map<String, Object> map) {	//#{userId}, #{movieId}, #{mode}
		return movieLikeDao.Check(map);
	}
	
	public int Add(Map<String, Object> map) {
		return movieLikeDao.Add(map);
	}
	
	public List<Map<String, Object>> UserMovieLike(Map<String, Object> map){
		return movieLikeDao.UserMovieLike(map);
	}
}
