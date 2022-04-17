package com.geekmovie.movie.service;

import java.util.List;

import com.geekmovie.movie.vo.MovieDetailVo;


public interface MovieService {
	
	public int index();
	
	public int create(MovieDetailVo vo);

	public List<MovieDetailVo> list();

	public MovieDetailVo detail(MovieDetailVo vo);
	
	public int update(MovieDetailVo vo);
	
	public int delete(MovieDetailVo vo);




	
}
