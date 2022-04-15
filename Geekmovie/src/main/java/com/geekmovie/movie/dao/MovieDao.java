package com.geekmovie.movie.dao;

import java.net.URL;

import org.springframework.stereotype.Repository;

@Repository
public class MovieDao {
	// 실제로는 내부 DB에 접근하지 않고 외부 DB와 연결함
	

	public String getMovieDataFromId(int id) {
		String url = "https://api.themoviedb.org/3/movie/";
		url += id;
		url += "?api_key=6d6ae24db915704490db7ae6eaa554ce";
		return url;
	}
	
	public String getPopularMovieInfo(int page, String language) {				//langauge='ko-KR'
		String url = "https://api.themoviedb.org/3/movie/popular?api_key=6d6ae24db915704490db7ae6eaa554ce&language=";
		url += language;
		url += "&page=";
		url += page;
		return url;
	}
	
	
	
	
	
	
}
