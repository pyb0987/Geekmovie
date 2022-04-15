package com.geekmovie.movie.service;

import java.util.List;

import com.geekmovie.movie.vo.MovieVo;


public interface MovieService {
	
	public int index();
	
	public int create(MovieVo vo);

	public List<MovieVo> list();

	public MovieVo detail(MovieVo vo);
	
	public int update(MovieVo vo);
	
	public int delete(MovieVo vo);




	
}
