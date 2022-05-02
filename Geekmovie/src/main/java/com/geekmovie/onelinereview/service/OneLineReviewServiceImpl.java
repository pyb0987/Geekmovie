package com.geekmovie.onelinereview.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.dao.OneLineReviewDao;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Repository
public class OneLineReviewServiceImpl implements OneLineReviewService{
	
	@Autowired
	OneLineReviewDao oneLineReviewDao;

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
}
