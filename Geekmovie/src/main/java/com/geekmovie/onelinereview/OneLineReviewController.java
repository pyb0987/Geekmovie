package com.geekmovie.onelinereview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.onelinereview.service.OneLineReviewLikeService;
import com.geekmovie.onelinereview.service.OneLineReviewService;
import com.geekmovie.onelinereview.vo.OneLineReviewPageVo;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;




@Controller
public class OneLineReviewController {

	@Autowired
	OneLineReviewService oneLineReviewService;
	@Autowired
	OneLineReviewPageVo olrpv;
	@Autowired
	OneLineReviewLikeService oneLineReviewLikeService;
	
	
	@GetMapping("/oneLineReview")    
	public ModelAndView oneLineReview(@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "ko-KR") String language, 
			@RequestParam(required = false, defaultValue = "movie") String SearchMode,
			@RequestParam(required = false, defaultValue = "") String focus,
			@RequestParam(required = false, defaultValue = "") String query) {
		ModelAndView mav = new ModelAndView();
		int cnt = oneLineReviewService.Count(SearchMode, query);	//나중에 여기에 변수들어감
		olrpv.PageInfo(cnt, page);
		int nowPageStart = olrpv.getNowPageStart();
		int onePage = olrpv.getOnePage();
		List<OneLineReviewVo> oneLineReviewList = oneLineReviewService.Select(SearchMode, query, nowPageStart, onePage);//나중에 여기에 변수들어감
		
		
		
		mav.addObject("page", olrpv);
		mav.addObject("SearchMode", SearchMode);
		mav.addObject("query", query);
		mav.addObject("language", language);
		mav.addObject("focus", focus);
		
		mav.addObject("data", oneLineReviewList);

		mav.setViewName("oneLineReview");
		return mav;
	}
	@RequestMapping(value = "/oneLineReview/like", method = RequestMethod.GET)//특정 유저가 좋아하는 한줄평
	public ModelAndView oneLineReview(HttpSession session,
			@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = true) String userId, 
			@RequestParam(required = false, defaultValue = "ko-KR") String language) {
		String sessionId = (String)session.getAttribute("id");

		ModelAndView mav = new ModelAndView();
		if(!sessionId.equals(userId)) {
			mav.setViewName("redirect:/");
			return mav;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("mode", 1);
		int cnt = oneLineReviewLikeService.CountUserLike(map);	
		olrpv.PageInfo(cnt, page);
		int nowPageStart = olrpv.getNowPageStart();
		int onePage = olrpv.getOnePage();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("userId", userId);
		map2.put("nowPageStart", nowPageStart);
		map2.put("Size", onePage);
		List<OneLineReviewVo> oneLineReviewLikeList = oneLineReviewService.UserLike(map2);

		mav.addObject("page", olrpv);
		mav.addObject("language", language);
		
		mav.addObject("data", oneLineReviewLikeList);

		mav.setViewName("oneLineReviewlike");
		return mav;
	}
	
	
}
