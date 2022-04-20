package com.geekmovie.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.vo.MovieDetailVo;
import com.geekmovie.user.vo.userVO;

@Service
public class MovieServiceImpl implements MovieService{
	
	@Autowired
	MovieDao movieDao;						//외부 DB 작업 Dao
	
	@Override
	public int index() {					//home(index) 표시
		
		return 0;
	}
}
