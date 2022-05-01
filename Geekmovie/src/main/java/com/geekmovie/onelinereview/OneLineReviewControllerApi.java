package com.geekmovie.onelinereview;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.onelinereview.service.OneLineReviewService;
import com.geekmovie.onelinereview.vo.OneLineReviewPageVo;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;



@RestController
public class OneLineReviewControllerApi {

	@Autowired
	OneLineReviewService oneLineReviewService;
	@Autowired
	OneLineReviewPageVo olrpv;
	
	
	
	@RequestMapping(value = "/oneLineReview/{olrid}", method = RequestMethod.DELETE)
	public int oneLineReview(@PathVariable("olrid") int olrid) {
		System.out.println("oneLineReview Delete");
		int rs = oneLineReviewService.Delete(olrid);			//rest api
		return 	rs;
	}

	
	

	
}
