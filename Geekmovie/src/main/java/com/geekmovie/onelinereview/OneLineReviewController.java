package com.geekmovie.onelinereview;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OneLineReviewController {


	
	@GetMapping("/oneLineReview")    
	public ModelAndView movieDetail() {
		ModelAndView mav = new ModelAndView();	
		mav.setViewName("oneLineReview");
		return mav;
	}
}
