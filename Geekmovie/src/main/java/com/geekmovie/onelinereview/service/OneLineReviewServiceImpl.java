package com.geekmovie.onelinereview.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.dao.OneLineReviewDao;
import com.geekmovie.onelinereview.dao.OneLineReviewLikeDao;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Repository
public class OneLineReviewServiceImpl implements OneLineReviewService{
	
	@Autowired
	OneLineReviewDao oneLineReviewDao;
	@Autowired
	OneLineReviewLikeDao oneLineReviewLikeDao;

	@Override
	public List<OneLineReviewVo> Select(String SearchMode,String query, int nowPageStart, int onePage) {
		return oneLineReviewDao.Select(SearchMode, query, nowPageStart, onePage);

	}
	
	public int Count(String SearchMode,String query) {
		return oneLineReviewDao.Count(SearchMode, query);

	}
	
	
	public int Delete(int oneLineReviewId) {
		return oneLineReviewDao.Delete(oneLineReviewId);
	};
	
	public int Create(Map<String, Object> map) {
		return oneLineReviewDao.Create(map);
	};
	
	public int Update(Map<String, Object> map) {
		return oneLineReviewDao.Update(map);
	};
	
	public int UpdateLike(Map<String, Object> map) { //input #{oneLineReviewId}
		if(map.containsKey("mode")) {
			map.put("mode", 1);
		}else {
			map.replace("mode", 1);
		}
		int likeNum = oneLineReviewLikeDao.CountOrlLike(map);
		map.replace("mode", 0);
		int dislikeNum = oneLineReviewLikeDao.CountOrlLike(map);
		map.put("likeNum", likeNum);
		map.put("dislikeNum", dislikeNum);
		return oneLineReviewDao.UpdateLike(map);
	};
	
	public String SelectAny(Map<String, Object> map) { //input #{oneLineReviewId} #{query}
		return oneLineReviewDao.SelectAny(map);
	};
}
