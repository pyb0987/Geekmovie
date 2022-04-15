package com.geekmovie.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.vo.MovieVo;

@Service
public class MovieServiceImpl implements MovieService{
	
	@Autowired
	MovieDao movieDao;						//외부 DB 작업 Dao
	
	@Override
	public int index() {					//home(index) 표시
		// TODO Auto-generated method stu
		return 0;
	}
	
	
	
	@Override
	public int create(MovieVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MovieVo> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MovieVo detail(MovieVo vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(MovieVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(MovieVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
