package com.geekmovie.onelinereview.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Service
public interface OneLineReviewService {


	public List<OneLineReviewVo> Select(String SearchMode,String query, int nowPageStart, int onePage);
		
	public int Count(String SearchMode,String query);

	public int Delete(int oneLineReviewId);
	
	public int Create(Map<String, Object> map);
	
	public int Update(Map<String, Object> map);
	
	public int UpdateLike(Map<String, Object> map);
	
	public String SelectAny(Map<String, Object> map);

	public List<OneLineReviewVo> SelectUser(String userId);
	
	public int GetPage(int olrId);
	
	public List<OneLineReviewVo> UserLike(Map<String, Object> map);
	
	public List<OneLineReviewVo> SelectMovie(Map<String, Object> map);
}
