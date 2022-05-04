package com.geekmovie.onelinereview.service;



import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.dao.OneLineReviewDao;
import com.geekmovie.onelinereview.dao.OneLineReviewLikeDao;

@Repository
public class OneLineReviewLikeServiceImpl implements OneLineReviewLikeService{
	
	@Autowired
	OneLineReviewLikeDao oneLineReviewLikeDao;
	
	
	@Override
	public int Check(Map<String, Object> map) {
		return oneLineReviewLikeDao.Check(map);
	}
	
	public int Add(Map<String, Object> map) {
		return oneLineReviewLikeDao.Add(map);
	}
	


}
