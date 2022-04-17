package com.geekmovie.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.vo.MovieDetailVo;

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
	public int create(MovieDetailVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MovieDetailVo> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MovieDetailVo detail(MovieDetailVo vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(MovieDetailVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(MovieDetailVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
