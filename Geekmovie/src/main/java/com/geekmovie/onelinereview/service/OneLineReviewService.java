package com.geekmovie.onelinereview.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Service
public interface OneLineReviewService {


	public List<OneLineReviewVo> Select(String SearchMode,String query, int nowPageStart, int onePage);
		
	public int Count(String SearchMode,String query);
}
