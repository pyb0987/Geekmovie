package com.geekmovie.onelinereview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.dao.OneLineReviewDao;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Repository
public class OneLineReviewServiceImpl implements OneLineReviewService{
	
	@Autowired
	OneLineReviewDao oneLineReviewDao;

	@Override
	public List<OneLineReviewVo> SelectAll(int nowPageStart, int nowPageEnd) {
		return oneLineReviewDao.SelectAll(nowPageStart, nowPageEnd);

	}
	
	public int Count() {
		return oneLineReviewDao.Count();

	}
	
	
	
}
