package com.geekmovie.onelinereview;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.onelinereview.service.OneLineReviewService;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;



@RestController
public class OneLineReviewControllerApi {

	@Autowired
	OneLineReviewService oneLineReviewService;
	
	
	@RequestMapping(value="/api/oneLineReview", method= RequestMethod.GET)
	public List<OneLineReviewVo> findallreivews(HttpServletRequest request) throws Exception{						//1개영화의 디테일 반환
		return oneLineReviewService.SelectAll();

	}
	
}
