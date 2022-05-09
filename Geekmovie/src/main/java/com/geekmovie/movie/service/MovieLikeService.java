package com.geekmovie.movie.service;

import java.util.List;
import java.util.Map;

public interface MovieLikeService {
	
	public int Check(Map<String, Object> map);
	
	public int Add(Map<String, Object> map);

	public List<Map<String, Object>> UserMovieLike(Map<String, Object> map);
}
