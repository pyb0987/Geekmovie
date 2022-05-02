package com.geekmovie.onelinereview;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		int rs = oneLineReviewService.Delete(olrid);			//rest api
		return 	rs;
	}

	@RequestMapping(value = "/oneLineReview", method = RequestMethod.POST)
	@ResponseBody
	public int oneLineReview(@RequestBody Map<String, Object> map) {
		return 	oneLineReviewService.Create(map);
	}
	

	
}
