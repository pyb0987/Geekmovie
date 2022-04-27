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
	public ModelAndView movieDetail(@RequestParam(required = false, defaultValue = "1") int Page, 
			@RequestParam(required = false, defaultValue = "ko-KR") String language, 
			@RequestParam(required = false) String SearchMode,
			@RequestParam(required = false, defaultValue = "") String query) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = oneLineReviewService.Count(SearchMode, query);	//나중에 여기에 변수들어감
		System.out.println("cnt");
		System.out.println(cnt);
		olrpv.PageInfo(cnt, Page);
		int nowPageStart = olrpv.getNowPageStart();
		int onePage = olrpv.getOnePage();
		List<OneLineReviewVo> oneLineReviewList = oneLineReviewService.Select(SearchMode, query, nowPageStart, onePage);//나중에 여기에 변수들어감
		
		
		
		mav.addObject("page", olrpv);
		mav.addObject("language", language);
		mav.addObject("data", oneLineReviewList);

		mav.setViewName("oneLineReview");
		return mav;
	}
}
