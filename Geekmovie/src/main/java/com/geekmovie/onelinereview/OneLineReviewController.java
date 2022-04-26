package com.geekmovie.onelinereview;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.onelinereview.service.OneLineReviewService;
import com.geekmovie.onelinereview.vo.OneLineReviewPageVo;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;




@Controller
public class OneLineReviewController {

	@Autowired
	OneLineReviewService oneLineReviewService;
	@Autowired
	OneLineReviewPageVo olrpv;
	
	
	@GetMapping("/oneLineReview")    
	public ModelAndView movieDetail(@RequestParam(required = false, defaultValue = "1") int Page) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = oneLineReviewService.Count();	//나중에 여기에 변수들어감
		olrpv.PageInfo(cnt, Page);
		int nowPageStart = olrpv.getNowPageStart();
		int nowPageEnd = olrpv.getNowPageEnd();
		List<OneLineReviewVo> oneLineReviewList = oneLineReviewService.SelectAll(nowPageStart, nowPageEnd);//나중에 여기에 변수들어감
		
		
		
		mav.addObject("page", olrpv);
		mav.addObject("data", oneLineReviewList);

		mav.setViewName("oneLineReview");
		return mav;
	}
}
