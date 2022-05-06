package com.geekmovie.onelinereview.service;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


@Service
public interface OneLineReviewLikeService {
		
	public int Check(Map<String, Object> map);

	public int Add(Map<String, Object> map);
	
}
