package com.geekmovie.onelinereview.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Service
public interface OneLineReviewService {


	public List<OneLineReviewVo> SelectAll();
		

}
